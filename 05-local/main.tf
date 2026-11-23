//Get the details of the AWS identity currently configured in your AWS credentials. 
//ex: AWS Account ID, ARN (Amazon Resource Name), User ID, etc.
//Here we are using a data source, not a resource.
data "aws_caller_identity" "current"{
}

//Create a local file called account.txt and write the ARN of the current AWS identity to it.
resource "local_file" "forwards" {
  content = data.aws_caller_identity.current.arn
  filename = "account.txt"
}

//We use Locals (locals) to store and manipulate values before using them in resources.
locals {
  char_list=split("",local_file.forwards.content)
  reversed_char_list=reverse(local.char_list)
  reversed_string=join("",local.reversed_char_list)
}

//Create a local file called account.txt and write the ARN of the current AWS identity to it.
resource "local_file" "backwards" {
  content = data.aws_caller_identity.current.arn
  filename = "arn_backwards.txt"
}

//We fetch the AWS ARN, save it in a file, use locals to split and reverse the ARN, 
//and then save the reversed ARN in another file.