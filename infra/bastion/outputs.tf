output "bastion_sg_id" {
  value = aws_security_group.bastion.id
}

output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "bastion_iam_instance_profile" {
  value = aws_iam_instance_profile.bastion_instance_profile.name
}

output "bastion_iam_role" {
  value = aws_iam_role.bastion_role.name
}
