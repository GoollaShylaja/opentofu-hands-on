# Day 3 - OpenTofu Commands (Hands-on)

Practised plans, variables, formatting and resource changes.

| Command | What it does |
|---|---|
| `tofu init` | Sets up the project and downloads providers |
| `tofu init -upgrade` | Upgrades providers within version constraints |
| `tofu plan -out=my.plan` | Saves the proposed changes to a plan file |
| `tofu apply my.plan` | Applies a saved plan (one-time use only) |
| `tofu apply` | Creates a plan and asks for approval |
| `tofu apply --auto-approve` | Applies without approval (use carefully) |
| `tofu apply -var="greeting=Hello"` | Passes a variable on the command line |
| `tofu apply -var-file="prod.tfvars"` | Passes variables from a `.tfvars` file |
| `tofu fmt` | Formats `.tf` files consistently |
| `tofu destroy` | Destroys managed infrastructure |
| `echo $?` | Shows the last exit status (`0` means success) |

## Key takeaways

* Always review the plan before applying.
* Replacement can cause downtime or data loss.
* Use variables and `.tfvars` files instead of hardcoding values.
* Be careful with `--auto-approve` and `tofu destroy`.
