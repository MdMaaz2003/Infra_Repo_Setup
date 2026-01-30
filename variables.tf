variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for EC2"
  type        = string
  default     = "ami-0c02fb55956c7d316" # us-east-1

}

variable "key_name" {
  description = "EC2 Key Pair name"
  type        = string
}
