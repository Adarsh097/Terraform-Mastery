output "resources" {
  value = {
  
    instance_id = local.all_instance_ids
    security_group_id = aws_security_group.ingress_rules.id
  }
}