## Day-16 | AWS IAM User Management with Terraform - Mini Project

![alt text](image-5.png)

![alt text](image-6.png)


## Overview

This project demonstrates how to manage **AWS IAM users, groups, and group memberships using Terraform**, with a **CSV file as the single source of truth**.

The setup is conceptually similar to **Azure AD user management**, where users are centrally defined and dynamically assigned to groups based on attributes such as department and job title.

This approach enables **scalable, repeatable, and auditable IAM user management** using Infrastructure as Code (IaC).

---

## What Gets Created

* **26 IAM Users** with AWS Management Console access
* **3 IAM Groups**

  * Education
  * Managers
  * Engineers
* **Dynamic group memberships** based on CSV attributes
* **User metadata stored as IAM tags**

  * DisplayName
  * Department
  * JobTitle
* **Remote Terraform state** stored securely in S3

---

## Prerequisites

Ensure the following are installed and configured:

* AWS CLI configured with valid credentials
* Terraform **v1.0 or later**
* IAM permissions for:

  * IAM user creation
  * Group management
  * Policy attachments
* An S3 bucket for Terraform remote state

---

## Quick Start

### 1. Create S3 Backend Bucket

```bash
aws s3 mb s3://my-terraform-state-bucket-piyushsachdeva --region us-east-1
aws s3api put-bucket-versioning \
  --bucket my-terraform-state-bucket-piyushsachdeva \
  --versioning-configuration Status=Enabled
```

---

### 2. Initialize Terraform

```bash
terraform init
```

---

### 3. Review Planned Changes

```bash
terraform plan
```

---

### 4. Apply the Configuration

```bash
terraform apply -auto-approve
```

---

### 5. Verify in AWS Console

Navigate to **AWS IAM Console** and verify:

* **Users** → 26 users created
* **User groups** → Education, Managers, Engineers
* **Group memberships** correctly assigned

---

## File Structure

```plaintext
day16/
├── backend.tf          # S3 backend configuration
├── provider.tf         # AWS provider setup
├── versions.tf         # Terraform and provider versions
├── main.tf             # User creation and CSV parsing
├── groups.tf           # Group and membership management
├── users.csv           # User data source
├── DEMO_GUIDE.md       # Detailed demo walkthrough
└── README.md           # Project documentation
```

---

## How It Works

### Step 1: Read CSV File

User data is loaded dynamically from `users.csv`.

```hcl
locals {
  users = csvdecode(file("users.csv"))
}
```

---

### Step 2: Create IAM Users

Usernames follow the format:
`{first_initial}{lastname}` (example: `mscott`)

```hcl
resource "aws_iam_user" "users" {
  for_each = { for user in local.users : user.first_name => user }

  name = lower("${substr(each.value.first_name, 0, 1)}${each.value.last_name}")
  path = "/users/"

  tags = {
    DisplayName = "${each.value.first_name} ${each.value.last_name}"
    Department  = each.value.department
    JobTitle    = each.value.job_title
  }
}
```

---

### Step 3: Enable Console Access

Login profiles are created and users are forced to reset their password on first login.

```hcl
resource "aws_iam_user_login_profile" "users" {
  for_each = aws_iam_user.users

  user                    = each.value.name
  password_reset_required = true
}
```

---

### Step 4: Create Groups and Assign Users

Users are dynamically added to groups based on CSV attributes.

```hcl
resource "aws_iam_group" "education" {
  name = "Education"
  path = "/groups/"
}

resource "aws_iam_group_membership" "education_members" {
  name  = "education-group-membership"
  group = aws_iam_group.education.name

  users = [
    for user in aws_iam_user.users : user.name
    if user.tags.Department == "Education"
  ]
}
```

---

## Outputs

After applying, you can view Terraform outputs:

```bash
terraform output account_id
terraform output user_names
terraform output user_passwords
```

Note: Password outputs are sensitive.

---

## User List (Sample)

| Username | Full Name      | Department | Job Title                         |
| -------- | -------------- | ---------- | --------------------------------- |
| mscott   | Michael Scott  | Education  | Regional Manager                  |
| dschrute | Dwight Schrute | Sales      | Assistant to the Regional Manager |
| jhalpert | Jim Halpert    | Sales      | Sales Representative              |
| pbeesly  | Pam Beesly     | Reception  | Receptionist                      |
| rhoward  | Ryan Howard    | Temps      | Temp                              |
| ...      | ...            | ...        | ...                               |

Total: **26 users**

---

## Groups and Memberships

### Education Group

* Michael Scott (`mscott`)

### Managers Group

Users with **Manager** or **CEO** in their job title:

* Michael Scott
* Robert California
* Darryl Philbin
* David Wallace
* Jo Bennett

### Engineers Group

* Currently empty (no Engineering users in CSV)

---

## Customization

### Add More Users

Update `users.csv`:

```csv
first_name,last_name,department,job_title
Jane,Doe,Engineering,Software Engineer
```

Then apply:

```bash
terraform apply
```

---

### Attach IAM Policies to Groups

```hcl
resource "aws_iam_group_policy_attachment" "education_readonly" {
  group      = aws_iam_group.education.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
```

---

### Change Username Format

```hcl
# Current
name = lower("${substr(each.value.first_name, 0, 1)}${each.value.last_name}")

# Alternative
name = lower("${each.value.first_name}.${each.value.last_name}")
```

---

## Password Management

AWS does not return auto-generated passwords unless encrypted with PGP.

### Option 1: AWS Console

* IAM → User → Security credentials
* Manage console access
* Set password manually

### Option 2: AWS CLI

```bash
aws iam create-login-profile \
  --user-name mscott \
  --password "TempPassword123!" \
  --password-reset-required
```

---

## Cleanup

To destroy all resources:

```bash
terraform destroy
```

Warning: This deletes **all IAM users, groups, and memberships**.

---

## Troubleshooting

### Backend Access Denied

```bash
aws sts get-caller-identity
```

---

### User Already Exists

Import existing user:

```bash
terraform import aws_iam_user.users["Michael"] mscott
```

Or delete manually:

```bash
aws iam delete-login-profile --user-name mscott
aws iam delete-user --user-name mscott
```

---

### View Terraform State

```bash
terraform state list
terraform state show aws_iam_user.users["Michael"]
```

---

## Best Practices

* Use **remote state** with S3 and versioning
* Follow **consistent naming conventions**
* Store metadata as **IAM tags**
* Force password reset on first login
* Use **CSV as single source of truth**
* Ensure Terraform runs are **idempotent**

---

## Security Considerations

* Enforce password reset on first login
* Enable **MFA** for users
* Review IAM policies before attaching
* Never commit `terraform.tfstate` to Git
* Prefer **AWS SSO** for production
* Enable **CloudTrail** for auditing

---
