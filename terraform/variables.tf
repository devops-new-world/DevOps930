variable "instance_type" {
    type = string
    default = "t3.small"
}
variable "ingress_rules" {
  description = "List of ingress rules for the security group."
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]  # Example: SSH access from anywhere
    }
  ]
}
