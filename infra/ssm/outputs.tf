output "ec2_security_group_id" {
  value = aws_security_group.ec2.id
}

# output "ec2_instance_id" {
#   value = aws_instance.ssm_ec2.id
# }


# output "ssm_vpc_endpoint_id" {
#   value = aws_vpc_endpoint.ssm.id
# }

# output "ssm_messages_vpc_endpoint_id" {
#   value = aws_vpc_endpoint.ssmmessages.id
# }

# output "ec2_messages_vpc_endpoint_id" {
#   value = aws_vpc_endpoint.ec2messages.id
# }
