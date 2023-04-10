#____________________________________________Bastion_ec2
resource "aws_instance" "bastion" {
  count                       = var.bastion_count
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = var.bastion_instance_type
  subnet_id                   = var.public_subnet_ids[count.index]
  key_name                    = var.external_key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.sg_public_id]
  iam_instance_profile        = aws_iam_instance_profile.bastion_profile.id
  user_data                   = file("${path.module}/template/user_data.sh")
  root_block_device {
    volume_size = var.bastion_volume_size
    volume_type = "gp2"
    encrypted   = true
  }
  tags = {
    Name = "${var.environment}_Bastion_${count.index + 1}"
  }
}

#__________________________________copy_private_internal_key
resource "null_resource" "internal_key_copy" {
  count      = var.bastion_count
  depends_on = [aws_instance.bastion]
  connection {
    host        = aws_instance.bastion[count.index].public_ip
    type        = "ssh"
    user        = var.bastion_user
    private_key = var.external_key_name
  }
  provisioner "file" {
    source      = var.private_internal_key
    destination = var.destination_private_internal_key
  }
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 ${var.destination_private_internal_key}",
    ]
  }
}
