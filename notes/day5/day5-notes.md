# OpenTofu Day 5 Cheat Sheet: Data, Locals, Functions, State

## Blocks

| Block | Use |
|---|---|
| `data` | Fetch existing info |
| `resource` | Create and manage something |
| `locals` | Store reusable values |
| Functions (not a block) | Built-in helpers used inside blocks to transform values |

## Code

```hcl
# Fetch AWS identity
data "aws_caller_identity" "current" {}

# Write ARN to a file
resource "local_file" "forwards" {
  content  = data.aws_caller_identity.current.arn
  filename = "account.txt"
}

# Reverse the ARN
locals {
  char_list          = split("", local_file.forwards.content)
  reversed_char_list = reverse(local.char_list)
  reversed_string    = join("", local.reversed_char_list)
}

# Save reversed ARN
resource "local_file" "backwards" {
  content  = local.reversed_string
  filename = "arn_backwards.txt"
}
```

## Functions

- `split("", str)`: string to list of characters
- `reverse(list)`: flip the list
- `join("", list)`: list back to string
- `local.name`: read a local

`HELLO` to `["H","E","L","L","O"]` to `["O","L","L","E","H"]` to `OLLEH`

## Rename without replacing

```bash
tofu state mv local_file.forwards local_file.account
```

- Renaming a resource can trigger destroy and create.
- `state mv` avoids that.
- Never hand-edit `terraform.tfstate`.
- Back up the state first.
