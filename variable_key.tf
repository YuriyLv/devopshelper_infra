#____________________________________________MAIN_KEY_VARIABLE
# for deploy code make key value empty and set variable on terraform cloud
variable "external_key_name" {
  default = "external_key_pub"
}
variable "external_key" {
  default = "-----BEGIN RSA PUBLIC KEY-----MIIBigKCAYEAq3DnhgYgLVJknvDA3clATozPtjI7yauqD4/ZuqgZn4KzzzkQ4BzJar4jRygpzbghlFn0Luk1mdVKzPUgYj0VkbRlHyYfcahbgOHixOOnXkKXrtZW7yWGjXPqy/ZJ/+-----END RSA PUBLIC KEY-----"
  #default = file("/home/dozee/.ssh/external_key.pub")
}
variable "private_internal_key" {
  default = "-----BEGIN RSA PRIVATE KEY-----MIIBigKCAYEAq3DnhgYgLVJknvDA3clATozPtjI7yauqD4/ZuqgZn4KzzzkQ4BzJar4jRygpzbghlFn0Luk1mdVKzPUgYj0VkbRlHyYfcahbgOHixOOnXkKXrtZW7yWGjXPqy/ZJ/+-----END RSA PUBLIC KEY-----"
  #default = file("/home/dozee/.ssh/internal_key")
}
variable "destination_private_internal_key" {
  default = "/home/ec2-user/.ssh/private_internal_key"
}
variable "destination_private_internal_key_ubuntu" {
  default = "/home/ubuntu/private_internal_key.pub"
}
variable "internal_key_name" {
  default = "internal_key_pub"
}
variable "internal_key" {
  default = "-----BEGIN RSA PUBLIC KEY-----MIIBigKCAYEAq3DnhgYgLVJknvDA3clATozPtjI7yauqD4/ZuqgZn4KzzzkQ4BzJar4jRygpzbghlFn0Luk1mdVKzPUgYj0VkbRlHyYfcahbgOHixOOnXkKXrtZW7yWGjXPqy/ZJ/+-----END RSA PUBLIC KEY-----"
  #default = file("/home/dozee/.ssh/internal_key.pub")
}
