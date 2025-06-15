output "ec2_instance_id" {
  value = aws_instance.bastion.id
}

output "bastion_sg_id" {
  value = aws_security_group.bastion_sg.id
}