#__________________________________App
resource "aws_launch_template" "app" {
  name = local.app_name
  block_device_mappings {
    device_name = var.device_name
    ebs {
      volume_size = var.volume_size
      volume_type = "gp2"
    }
  }
  instance_type = var.instance_type
  key_name      = var.internal_key_name
  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.id
  }
  image_id               = data.aws_ami.latest_amazon_linux.id
  vpc_security_group_ids = [var.sg_private]
  tags = {
    Name        = local.app_name
    Environment = var.environment
    Purpose     = "app"
  }
  user_data = base64encode(data.template_file.app_user_data.rendered)
}
#__________________________________App_data
data "template_file" "app_user_data" {
  template = file("${path.module}/template/user_data.sh")
  vars = {
    token_registry = var.token_registry
    user_registry  = var.user_registry
    ci_registry    = var.ci_registry
    image          = local.app_image
  }
}

