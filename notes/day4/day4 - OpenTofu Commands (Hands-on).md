# Day 4 - OpenTofu Dependencies and Providers (Hands-on)

## Visualise dependencies

```bash
tofu graph | dot -Tpng > graph.png
```

Generates a diagram of resource dependencies. Useful for understanding creation order and troubleshooting dependency issues.

## Dependencies between resources

* **Implicit dependency:** referencing another resource (an internal reference) makes OpenTofu create that resource first. See `resource_with_variable_example.tf`.
* **Explicit dependency:** use `depends_on` when the order must be forced and there is no direct reference.

```hcl
depends_on = [local_file.main]
```

OpenTofu creates or updates `local_file.main` before the resource that declares this.

## Providers

* A provider is a plugin that lets OpenTofu manage a platform, such as `local`, `http` or `aws`.
* Providers are declared in the `required_providers` block and downloaded by `tofu init`.
* `tofu init -upgrade` updates providers within the allowed version constraints.
* `.terraform.lock.hcl` pins the exact provider versions. Commit it to git. Ignore the `.terraform/` folder.

## Example: AWS provider and S3 bucket

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_s3_bucket" "opentofu_practice_bucket" {
  bucket = "opentofu-practice-bucket-20261105-x7k2"
}
```

* `region` sets where resources are created (`ap-southeast-2` is Sydney).
* Credentials come from the AWS CLI profile (`aws configure`), never from `.tf` files.
* Check access with `aws sts get-caller-identity` before running `tofu plan`.

## Lessons learned

* The `bucket` name must be globally unique and use only lowercase letters, numbers and hyphens (no underscores).
* The resource label (for example `opentofu_practice_bucket`) is only an internal name and does not change the real bucket name.
* `BucketAlreadyExists` means the name is taken by another AWS account, so add a unique suffix.
* `SignatureDoesNotMatch` usually means the secret key was copied incorrectly. Check its length is 40 characters.
