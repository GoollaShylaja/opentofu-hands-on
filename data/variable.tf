// Variables help us define a value once and reuse it in multiple places, instead of hardcoding the same value everywhere.
// this is a definition of variables that can be used in other files.

variable "html_file_name" {
  default = "data_example" //default provides the actual value.
  type    = string
  description="File Name" // we can create file with anyname by passing it.
}
// variables we can pass from CLI, tfvars file, as commad as well