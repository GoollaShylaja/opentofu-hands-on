# OpenTofu Day 5: Data Sources, Locals, Functions and State

**What this covers:** Fetch the AWS identity, write it to a file, reverse it using locals and functions, then rename a resource safely with `tofu state mv`.

---

## 1. AWS data source

```hcl
data "aws_caller_identity" "current" {}
```

Fetches details of the current AWS identity: account ID, ARN and user ID.

## 2. Write the ARN to a local file

```hcl
resource "local_file" "forwards" {
  content  = data.aws_caller_identity.current.arn
  filename = "account.txt"
}
```

Creates `account.txt` with the ARN inside.

## 3. Locals and functions

`locals` holds reusable values. Functions take inputs and return a result.

```hcl
locals {
  char_list          = split("", local_file.forwards.content)
  reversed_char_list = reverse(local.char_list)
  reversed_string    = join("", local.reversed_char_list)
}
```

| Function / syntax | What it does |
|---|---|
| `split("", value)` | Splits a string into a list of characters |
| `reverse(list)` | Reverses the list order |
| `join("", list)` | Joins list items into one string |
| `local.name` | Reads a local value |

Example: `HELLO` becomes `["H","E","L","L","O"]`, then `["O","L","L","E","H"]`, then `OLLEH`.

## 4. Save the reversed ARN

```hcl
resource "local_file" "backwards" {
  content  = local.reversed_string
  filename = "arn_backwards.txt"
}
```

Creates `arn_backwards.txt` with the reversed ARN.

## 5. Resource names and state

- OpenTofu tracks resources by address, e.g. `local_file.forwards`.
- If you rename it to `local_file.account`, OpenTofu may plan to destroy the old one and create a new one, even though nothing else changed.
- To keep the existing resource, move its address in the state:

```bash
tofu state mv local_file.forwards local_file.account
```

- Use `tofu state mv`, not manual edits to `terraform.tfstate`.
- Back up the state before changing it.

## Rename without replacing

```bash
tofu state mv local_file.forwards local_file.account
```

- Renaming a resource can trigger destroy and create.
- `state mv` avoids that.
- Never hand-edit `terraform.tfstate`.
- Back up the state first.

---

## Quick recap

- `data` fetches existing info. `resource` creates and manages things.
- `locals` stores reusable values.
- `split()` splits, `reverse()` reverses, `join()` combines.
- `tofu state mv` changes a resource address in the state without replacing the resource.
