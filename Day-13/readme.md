## Day-13 | Terraform Data Source AWS

- When you want to provision the 'EC2' instance, you require AMI-id for that.
- There is a resource in Terraform i.e. Data source.
- AMI has a data source and we can get the AMI-id from this data source by providing the operating system name.

![alt text](image.png)
![alt text](image-1.png)

Here’s a **clear explanation of the diagram** and how **Terraform data sources** are being used in this setup:

---

# 📌 **What the Diagram Shows**

This architecture represents a **Shared VPC** setup in AWS where **multiple teams** (DevOps, Dev Team, QA Team) deploy resources into the **same VPC** but in isolated subnets.

### 🔹 Key parts of the diagram:

### **1️⃣ Shared VPC (Center Box)**

* The VPC is owned/managed centrally (usually by a **network team**).
* It can be **shared with multiple AWS accounts** or teams using AWS RAM.
* Inside the VPC, you have multiple subnets:

  * **Subnet-1**
  * **Subnet-2**

These subnets can be:

* Public or private
* Used for deploying EC2 instances from different teams

---

### **2️⃣ EC2 Instances in Each Subnet**

Each subnet contains **multiple EC2 instances** (orange icons).

These instances:

* Belong to various teams (DevOps, Dev, QA)
* Are placed in different subnets for isolation or architecture needs
* Are using **the same AMI**, which is fetched via a **Terraform data source**

---

### **3️⃣ AWS Linux AMI (Right side)**

The “**aws-linux-ami**” icon represents a **pre-existing Amazon Linux image**.

EC2 instances do **not** create this AMI — they **use** it.

Terraform fetches this AMI using a **data source**, because AMI IDs vary by:

* Region
* OS version
* Virtualization type
* Owner

So instead of hardcoding the AMI ID, Terraform queries AWS dynamically.

---

### **4️⃣ Multiple Teams Using Shared VPC**

On the left side, it shows:

* DevOps Team
* Dev Team
* QA Team

All of them deploy EC2 instances into:

* The same VPC
* Possibly different subnets
* Using the same AMI reference

This avoids duplication and centralizes networking.

---

# 🧠 **Now, What is a Terraform Data Source?**

A **Terraform data source** is used to **read** or **fetch existing information** from AWS.

It does NOT create anything.
It only **retrieves** data.

---

# 🔸 **How data sources apply to the diagram**

### ✔️ **Data Source #1: Fetching AMI**

This is shown on the right of the diagram.

Terraform is using:

```hcl
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
```

This fetches the latest Amazon Linux AMI from AWS → the same one used by EC2 in both subnets.

**Meaning in diagram:**
All EC2s in subnet-1 and subnet-2 use the AMI fetched from this data source.

---

### ✔️ **Data Source #2: VPC/Subnet lookup (optional but common)**

Since the Shared VPC already exists (created by another account/team), your Terraform code will not create it.
You *refer* to it using data sources:

#### Get the shared VPC:

```hcl
data "aws_vpc" "shared" {
  filter {
    name   = "tag:Name"
    values = ["shared-vpc"]
  }
}
```

#### Get the shared subnets:

```hcl
data "aws_subnets" "shared" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.shared.id]
  }
}
```

This matches the blue boxes (subnets) in the diagram.

---

### ✔️ **EC2 Instances referencing data sources**

```hcl
resource "aws_instance" "app" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnets.shared.ids[0]
}
```

So the instance gets:

* Subnet from **VPC data source**
* AMI from **AMI data source**

---

# 📌 **Putting It All Together (Diagram Interpretation)**

### The diagram illustrates that:

* A **shared VPC** already exists → Terraform uses **data sources** to read VPC and subnets.
* A **pre-existing AMI** exists → Terraform fetches it using **AWS AMI data source**.
* **Multiple teams** launch their EC2 instances inside these shared subnets.
* Terraform does NOT create VPC/subnets/AMI — it **reads** them as data.

---
