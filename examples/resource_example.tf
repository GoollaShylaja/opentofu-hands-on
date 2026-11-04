/*
We are creating a local text file using OpenTofu.

1. resource
   Tells OpenTofu that we want to create and manage something.

2. local_file
   Resource type that tells OpenTofu to create a file on the local machine.

3. main
   Name given to the resource so we can identify and reference it.
   It must be unique within the same resource type.

4. content
   The actual text that will be written inside the file.

5. filename
   Specifies where the file should be created.

   path.module = Directory of the current module.
   example.txt  = Name of the file.
   ${...}       = Interpolation syntax used to insert a value into a string.
*/

resource "local_file" "main" {
  content  = "This is my learning example of file creation using local testing."
  filename = "${path.module}/example.txt"
}