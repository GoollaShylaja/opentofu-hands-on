// Variables help us define a value once and reuse it in multiple places, instead of hardcoding the same value everywhere.
variable "greeting" {
  default = "Hi" //default provides the actual value.
  type    = string
  description="How to greet the folks" // description documents the purpose of a variable so developers can understand its usage without affecting its behaviour.
}
// variables we can pass from CLI, tfvars file, as commad as well

resource "local_file" "main1" {
  content  = "${var.greeting}, welcome to tofu variable class."
  filename = "${path.module}/output_files/example1.txt"
}

resource "local_file" "main2" {
  content  = "${var.greeting}, welcome to OpenTofu!"
  filename = "${path.module}/output_files/example2.txt"
}
