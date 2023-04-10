#____________________________________________Key_pair
resource "aws_key_pair" "external_key" {
  key_name   = var.external_key_name
  public_key = var.external_key
}
resource "aws_key_pair" "internal_key" {
  key_name   = var.internal_key_name
  public_key = var.internal_key
}
