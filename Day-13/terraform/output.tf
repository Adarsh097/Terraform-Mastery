output "ec2-one-details" {
  value = {
    instance_id   = aws_instance.ec2-one.id
    instance_type = aws_instance.ec2-one.instance_type
    ami_id        = aws_instance.ec2-one.ami
  }
}