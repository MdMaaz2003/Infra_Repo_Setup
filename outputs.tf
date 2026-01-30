output "ec2_public_ips" {
  description = "Public IPs of EC2 instances"
  value       = aws_instance.react_ec2[*].public_ip
}


