output "sg_id" {
  description = "Security Group ID"
  value       = aws_security_group.this.id
}


output "sg_name"{
    description = "security group name"
    value = aws_security_group.this.name
}
