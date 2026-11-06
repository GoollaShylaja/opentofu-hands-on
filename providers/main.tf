//Get the details of the AWS identity currently configured in your AWS credentials. 
//ex: AWS Account ID, ARN (Amazon Resource Name), User ID, etc.
//Here we are using a data source, not a resource.
data "aws_caller_identity" "current"{
}

//Create a local file called my_user.txt and write the ARN of the current AWS identity to it.
resource "local_file" "forwards" {
  content = data.aws_caller_identity.current.arn
  filename = "account.txt"
}

# #Create an S3 bucket in AWS called shylu-opentofu-practice-bucket
# resource "aws_s3_bucket" "opentofu_practice_bucket" {
#   bucket = "shylu-opentofu-practice-bucket"
# }

# //Take above created account.txt from computer and upload it to the S3 bucket with the same filename.
# resource "aws_s3_object" "object" {
#   bucket = aws_s3_bucket.opentofu_practice_bucket.bucket
#   key = "account.txt"
#   source = local_file.forwards.filename
# }