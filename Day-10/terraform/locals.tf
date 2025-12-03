locals {
  //splat operator to get all instance ids
  all_instance_ids = aws_instance.instance1.*.id
}