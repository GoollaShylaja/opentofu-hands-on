# Day 01 - Introduction to OpenTofu

## 1. What is Infrastructure as Code (IaC)?

IaC means creating and managing infrastructure using configuration files instead of doing everything manually.

**Example:** Creating an AWS EC2 server using code instead of the AWS console.

**Benefits:**
- Saves time through automation.
- Reduces manual errors.
- Makes infrastructure reusable.
- Helps manage DEV, QA and PROD environments.

## 2. What is OpenTofu?

OpenTofu is an open-source Infrastructure as Code tool used to create and manage cloud infrastructure.

**Examples:**
- EC2 - Virtual server.
- S3 - File storage.
- RDS - Database.
- Security Group - Network access rules.

## 3. Why are Companies Moving from Terraform to OpenTofu?

In August 2023, HashiCorp changed Terraform's licence from MPL 2.0 to BSL 1.1.

This made some companies look for open-source alternatives.

OpenTofu was created as a community-driven alternative to Terraform.

**Main reasons:**
- **Open-source:** Uses the MPL 2.0 licence.
- **Community-driven:** Developed under the Linux Foundation.
- **Flexibility:** Less dependency on one company's licensing decisions.
- **Compatibility:** Most Terraform configurations can be reused.

### Terraform vs OpenTofu

| Feature | Terraform | OpenTofu |
|---|---|---|
| Maintained by | HashiCorp / IBM | OpenTofu community |
| Licence | BSL 1.1 | MPL 2.0 |
| Configuration | HCL | HCL |
| File extension | `.tf` | `.tf` |
| Purpose | Infrastructure as Code | Infrastructure as Code |

**Note:** Not every company is moving to OpenTofu. Terraform is still widely used.

## 4. Core Concepts

### 4.1 Provider

Connects OpenTofu to an external platform.

Examples: AWS, Azure, Google Cloud.

**Remember:** Provider = Connection.

### 4.2 Resource

An infrastructure component we want to create or manage.

Examples: EC2, S3, RDS.

**Remember:** Resource = Something we create.

### 4.3 Module

A reusable group of infrastructure resources.

**Example:** Grouping EC2 and Security Group configurations into one module.
**Example:** "Database" module might include primary instances, replicas, keys, roles, route tables
**Example:** "Serverless" module might include lambda code, api gateway configuration, and roles

**Remember:** Module = Reusable resources.

### 4.4 Root Module

The main module from which the project starts.

**Example:** The main project folder containing `main.tf`.

**Remember:** Root Module = Main project.

### 4.5 Variable

Used to pass input values into configurations.

Example:

```hcl
variable "instance_type" {
  default = "t2.micro"
}
```

Usage:

```hcl
instance_type = var.instance_type
```

**Remember:** Variable = Input.

### 4.6 Output

Displays useful information after infrastructure operations.

Example:

```hcl
output "server_ip" {
  value = aws_instance.my_server.public_ip
}
```

**Remember:** Output = Result.

### 4.7 State

Keeps track of infrastructure managed by OpenTofu.

**Example:** Tracks the EC2 instance created using OpenTofu.

**Remember:** State = Infrastructure record book.

**Note:** State files may contain sensitive information. Never commit them to a public GitHub repository.

### 4.8 Workspace

Maintains separate states for the same root module configuration.

Examples:
- DEV
- QA
- PROD

**Remember:** Workspace = Separate state for each workspace.

## 5. Real-world Example

Imagine creating an EC2 server in AWS.

| Concept | Example |
|---|---|
| Provider | AWS |
| Resource | EC2 instance |
| Module | Application infrastructure |
| Root Module | Main project |
| Variable | Instance type |
| Output | Public IP |
| State | Tracks EC2 instance |
| Workspace | DEV / QA / PROD |

## 6. Basic OpenTofu Commands

| Command | Purpose |
|---|---|
| `tofu init` | Initialise the project |
| `tofu validate` | Check configuration |
| `tofu fmt` | Format configuration files |
| `tofu plan` | Preview changes |
| `tofu apply` | Create or update infrastructure |
| `tofu destroy` | Delete managed infrastructure |

### Command Flow

```text
tofu init
    ↓
tofu validate
    ↓
tofu plan
    ↓
tofu apply
    ↓
Infrastructure created
```

**Note:** Always review the plan before applying changes. Be careful with `tofu destroy`.

## 7. What to Learn Next

- Install OpenTofu.
- Configure AWS provider.
- Create the first AWS resource.
- Learn variables and outputs.
- Practise basic OpenTofu commands.

## 8. Learning Resources

- [OpenTofu Documentation](https://opentofu.org/docs/)
- [OpenTofu Website](https://opentofu.org/)
- [Terraform Licensing FAQ](https://www.hashicorp.com/en/license-faq)
- [YouTube Tutorial](https://www.youtube.com/watch?v=BZ2TLtf3yFg)

---

## Day 01 - Summary

Today I learned:

- What Infrastructure as Code means.
- What OpenTofu is.
- Why companies consider OpenTofu.
- Basic OpenTofu concepts.
- Important OpenTofu commands.