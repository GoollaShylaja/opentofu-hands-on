// Variables help us define a value once and reuse it in multiple places, instead of hardcoding the same value everywhere.
// this is a definition of variables that can be used in other files.
variable "greeting" {
  default = "Hi" //default provides the actual value.
  type    = string
  description="How to greet the folks" // description documents the purpose of a variable so developers can understand its usage without affecting its behaviour.
}
// variables we can pass from CLI, tfvars file, as commad as well