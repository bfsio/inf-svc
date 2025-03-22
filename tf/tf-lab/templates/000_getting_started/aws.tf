resource "aws_instance" "banana-instance" {
  ami           = "ami-0fb653ca2d3203ac1"
  instance_type = var.instance_type
  tags = {
    name = "banana"
  }
}