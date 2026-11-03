# OpenTofu -- Day 2 Notes

## High-Level Architecture

### 1. What is OpenTofu?

OpenTofu is an **Infrastructure as Code (IaC)** tool.

Instead of manually creating infrastructure in a cloud platform, you
describe what you need in configuration files. OpenTofu reads those
files and helps create, update, or delete the infrastructure.

Examples of infrastructure include:

-   Virtual machines (such as AWS EC2 instances)
-   Storage buckets (such as Amazon S3)
-   Databases
-   Networks and security rules

### 2. Main parts of the architecture

#### 2.1 You -- the person running OpenTofu

You write the configuration and run OpenTofu commands from your
terminal.

For example:

``` bash
tofu apply
```

This asks OpenTofu to apply the changes described in your configuration.

#### 2.2 `.tf` files -- configuration files

Files ending in `.tf` contain the instructions that describe the
infrastructure you want.

Example:

``` hcl
resource "aws_instance" "my_server" {
  ami           = "ami-123456"
  instance_type = "t2.micro"
}
```

This example describes an AWS EC2 instance. The AMI value is only an
example; use a valid AMI for your AWS region and account.

In simple terms, a `.tf` file tells OpenTofu **what you want to exist**.

#### 2.3 OpenTofu -- the main engine

OpenTofu reads the `.tf` files and works out what needs to happen.

It compares the desired configuration with the current state, prepares a
plan, and coordinates the requested changes through providers.

For example, it can determine whether an EC2 instance needs to be
created, updated, or deleted.

#### 2.4 State -- OpenTofu's record book

State keeps track of the infrastructure OpenTofu manages.

It records information such as resource identifiers and details needed
to map configuration to real infrastructure.

For example, after creating an EC2 instance, the state records
information about that instance.

State helps OpenTofu understand what it already manages and what changes
are needed next time.

**Important:** State can be stored locally or remotely, depending on the
backend configuration. Protect state files because they can contain
sensitive information.

#### 2.5 Providers -- the connection to platforms

A provider is a plugin that allows OpenTofu to work with an external
platform or service.

Examples include:

-   AWS provider
-   Azure provider
-   Google Cloud provider
-   VMware provider

OpenTofu uses the relevant provider to communicate with that platform.

#### 2.6 Cloud APIs -- where requests are performed

Cloud platforms expose APIs that allow software to manage their
resources.

The provider sends requests to the cloud platform's API. The platform
then performs the requested operation.

For example, the AWS provider can send a request to AWS to create an EC2
instance.

### 3. Example: Creating an EC2 instance in AWS

Imagine that your team needs one EC2 instance.

The basic flow is:

1.  **Write the configuration:** Create a `.tf` file that describes the
    EC2 instance.
2.  **Initialise the project:** Run `tofu init` to initialise the
    working directory and install the required provider.
3.  **Review the changes:** Run `tofu plan` to see what OpenTofu intends
    to create or change.
4.  **Apply the changes:** Run `tofu apply` and confirm when prompted.
5.  **Provider communicates with AWS:** The AWS provider sends the
    required request to AWS APIs.
6.  **AWS creates the instance:** AWS performs the operation.
7.  **State is updated:** OpenTofu records the managed resource details
    in its state.

### 4. Important OpenTofu commands

  -----------------------------------------------------------------------
  Command                             Purpose
  ----------------------------------- -----------------------------------
  `tofu init`                         Initialises the working directory
                                      and downloads required providers
                                      and modules.

  `tofu plan`                         Shows the changes OpenTofu intends
                                      to make.

  `tofu apply`                        Applies the planned changes to the
                                      infrastructure.

  `tofu destroy`                      Destroys the infrastructure managed
                                      by the current configuration.
  -----------------------------------------------------------------------

### 5. Quick summary

  -----------------------------------------------------------------------
  Component                           Simple meaning
  ----------------------------------- -----------------------------------
  You                                 Write configuration and run
                                      commands.

  `.tf` files                         Describe the infrastructure you
                                      want.

  OpenTofu                            Reads the configuration and
                                      coordinates changes.

  State                               Keeps a record of infrastructure
                                      OpenTofu manages.

  Provider                            Connects OpenTofu to a platform
                                      such as AWS.

  Cloud APIs                          Receive requests and perform
                                      operations on the cloud platform.
  -----------------------------------------------------------------------

### 6. Easy way to remember the flow

**You write the instructions → OpenTofu reads them → Provider
communicates with AWS → AWS creates or updates resources → State records
the managed infrastructure.**

### 7. Day 2 knowledge check

1.  **What is the purpose of a `.tf` file?**\
    It describes the infrastructure we want OpenTofu to manage.

2.  **What does a provider do?**\
    It allows OpenTofu to communicate with a platform such as AWS,
    Azure, or Google Cloud.

3.  **Why does OpenTofu maintain state?**\
    To keep track of the infrastructure it manages and the details
    needed to plan future changes.

------------------------------------------------------------------------

**Day 2 key takeaway:** OpenTofu is the main engine. The `.tf` files
describe the desired infrastructure, providers connect to cloud
platforms, cloud APIs perform the operations, and state keeps track of
the managed resources.
