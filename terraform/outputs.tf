output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = aws_subnet.private[*].id
}

output "ec2_instance_id" {
  description = "Application EC2 instance ID"
  value       = aws_instance.app.id
}

output "ec2_public_ip" {
  description = "Application EC2 public IP"
  value       = aws_instance.app.public_ip
}

output "rds_endpoint" {
  description = "RDS PostgreSQL endpoint"
  value       = aws_db_instance.postgres.address
}

output "load_balancer_dns" {
  description = "Application Load Balancer DNS"
  value       = aws_lb.frontend.dns_name
}