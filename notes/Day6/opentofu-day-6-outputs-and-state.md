# OpenTofu Day 6: Outputs and State

**What this file is:** Quick revision notes on OpenTofu outputs, the state file, state commands and remote state. Read this before an interview for a fast refresher.

---

## 1. Outputs

- Outputs show useful values after OpenTofu runs (from resources or data sources).
- They make values easy to view or reuse.

```hcl
data "aws_caller_identity" "current" {}

output "current_user_arn" {
  value = data.aws_caller_identity.current.arn
}
```

- Run `tofu output` to view them.
- To rename an output, change the name in the `.tf` file and run `tofu plan`.
- You do not need `tofu state mv` for output names.

---

## 2. State file

- The state file (`terraform.tfstate`) tracks the resources OpenTofu manages and their details.
- OpenTofu compares your configuration with the real infrastructure using this file.
- Do not commit state files to Git. They can contain sensitive data.

---

## 3. Useful state commands

| Command | What it does |
|---|---|
| `tofu state -h` | Shows help for state commands. |
| `tofu state list` | Lists resources tracked in state. Does not list outputs. |
| `tofu state show ADDRESS` | Shows details of one tracked resource. |
| `tofu state mv OLD NEW` | Renames or moves a resource or module address in state. Use full addresses, like `aws_instance.old` and `aws_instance.new`. Does not rename outputs. |
| `tofu state rm ADDRESS` | Stops tracking a resource. The real resource is NOT deleted. |
| `tofu state replace-provider OLD NEW` | Swaps a provider reference in state, for example when a provider source address changes. |

**Watch out for `state rm`:** if the resource block is still in your config, the next plan may try to create it again.

**Backups:** OpenTofu normally backs up state before state-changing operations. Keep those backups safe.

---

## 4. Remote state

State can live remotely, for example in an S3 bucket or HCP Terraform (Terraform Cloud).

**Why use remote state?**

- State may hold sensitive data, so it should not sit in Git.
- The team shares one state instead of separate copies.
- Remote backends can support state locking, which helps stop two people changing things at once.

**Locking note:** some S3 setups use DynamoDB for locking. Always check the current docs for the locking options your backend supports.

**Commands:**

- `tofu state pull` downloads the current state and prints it.
- `tofu state push` uploads a local state file to the backend. Be careful, it can overwrite remote state.

---

## 5. Remember

- Back up state before running state commands.
- Review changes carefully.
- Never edit the state file by hand unless you know exactly what you are doing.

---

## 6. Quick interview answers (about 30 seconds each)

**What is the state file?**
"It is how OpenTofu keeps track of what it manages. It maps my config to the real resources, so it knows what to create, change or delete. I never commit it to Git because it can hold sensitive values."

**Why use remote state?**
"Mainly for teamwork and safety. Everyone shares the same state, secrets stay out of Git, and locking helps prevent two people applying changes at the same time."

**Difference between `state rm` and destroying a resource?**
"`state rm` only removes it from tracking. The real resource stays in the cloud. Destroy actually deletes it."

**How do you rename a resource without recreating it?**
"I use `tofu state mv` with the old and new full addresses, then run a plan to confirm there is no change."
