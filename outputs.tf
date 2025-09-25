output "ssh_sg_id" {
  value = module.ssh_sg.sg_id
  description = "ID of the SSH security group"
}

output "s3_bucket_name" {
  value = aws_s3_bucket.tf_state.bucket
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.tf_lock.name
}

output "ecr_repo_url" {
  value = aws_ecr_repository.my_web_app.repository_url
}