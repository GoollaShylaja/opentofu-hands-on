output "instance_url" {
description = "Public IP URL of the instance"
value ="http://${aws_instance.test_instance.public_ip}"

}