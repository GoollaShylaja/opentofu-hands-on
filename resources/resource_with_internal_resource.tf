// referring internal resource means we are using the resource created in this application.
// here we are referring the resource created in the resource_example.tf file.

resource "local_file" "referringinternalresource" {
  depends_on = [local_file.main] //depends_on is used to explicitly tell OpenTofu that one resource must be created or updated (local_file.main) before this current resource (local_file.referringinternalresource) is created or updated.
  content  = local_file.main.content
  filename = "${path.module}/output_files/referringinternalresource_example.txt"
}