#____________________________________________Ci_Cd_ec2
resource "aws_instance" "ci_cd" {
  count                  = var.ci_cd_count
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.ci_cd_instance_type
  key_name               = var.internal_key_name
  iam_instance_profile   = aws_iam_instance_profile.ci_cd_profile.id
  subnet_id              = var.private_subnet_ids[count.index]
  vpc_security_group_ids = [var.sg_private_id]
  user_data              = file("${path.module}/template/user_data.sh")
  root_block_device {
    volume_size = var.ci_cd_volume_size
    volume_type = "gp2"
    encrypted   = true
  }
  tags = {
    Name = "${var.environment}_CI/CD_${count.index + 1}"
  }
}

#__________________________________copy_private_internal_key
resource "null_resource" "internal_key_copy" {
  count      = var.ci_cd_count
  depends_on = [aws_instance.ci_cd]
  connection {
    host        = aws_instance.ci_cd[count.index].private_ip
    type        = "ssh"
    user        = var.ci_cd_user
    private_key = var.internal_key_name
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
