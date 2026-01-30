resource "aws_instance" "react_ec2" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.react_key.key_name
  vpc_security_group_ids = [aws_security_group.react_sg.id]

  tags = {
    Name = "react-app-server"
  }
}

