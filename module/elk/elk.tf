#____________________________________________Elk_ec2
resource "aws_instance" "elk" {
  count                  = var.elk_count
  ami                    = var.elk_linux == "1" ? data.aws_ami.latest_ubuntu.id : data.aws_ami.latest_amazon_linux.id
  user_data              = var.elk_linux == "1" ? file("${path.module}/template/elk_ubuntu_user_data.sh") : file("${path.module}/template/elk_awslinux_user_data.sh")
  instance_type          = var.elk_instance_type
  key_name               = var.internal_key_name
  iam_instance_profile   = aws_iam_instance_profile.elk_profile.id
  subnet_id              = var.private_subnet_ids[count.index]
  vpc_security_group_ids = [var.sg_private_id]
  root_block_device {
    volume_size = var.elk_volume_size
    volume_type = "gp2"
    encrypted   = true
  }
  tags = {
    Name = "${var.environment}_elk_${count.index + 1}"
  }
}

#__________________________________copy_private_internal_key
resource "null_resource" "internal_key_copy" {
  count      = var.elk_count
  depends_on = [aws_instance.elk]
  connection {
    host        = aws_instance.elk[count.index].private_ip
    type        = "ssh"
    user        = var.elk_linux == "1" ? var.elk_user_ubuntu : var.elk_user_awslinux
    private_key = var.internal_key_name
  }
  provisioner "file" {
    source      = var.private_internal_key
    destination = var.elk_linux == "1" ? var.destination_private_internal_key_ubuntu : var.destination_private_internal_key_awslinux
  }
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 ${var.elk_linux == "1" ? var.destination_private_internal_key_ubuntu : var.destination_private_internal_key_awslinux}",
    ]
  }
}
