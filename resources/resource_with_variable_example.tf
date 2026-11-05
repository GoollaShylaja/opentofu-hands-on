// Variables help us define a value once and reuse it in multiple places, instead of hardcoding the same value everywhere.
//please check variable.tf file for more details

//create a file with the greeting variable value from variable.tf file
resource "local_file" "main1" {
  content  = "${var.greeting}, welcome to tofu variable class."
  filename = "${path.module}/output_files/example1.txt"
}

resource "local_file" "main2" {
  content  = "${var.greeting}, welcome to OpenTofu!"
  filename = "${path.module}/output_files/example2.txt"
}
