resource "aws_key_pair" "react_key" {
  key_name   = "react-ec2-key"
  public_key = file("${path.module}/react-ec2-key.pub")
}

# testing ci pipeline


#main
