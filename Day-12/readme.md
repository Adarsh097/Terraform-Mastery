## Day-12 | AWS Terraform Function - Part2


---

# **Overview**

Welcome to the **Terraform Functions Comprehensive Learning Guide!**
This two-day module covers Terraform’s built-in functions through **12 hands-on assignments**, each designed to teach function usage with real-world examples.

For detailed, step-by-step instructions, refer to **DEMO_GUIDE.md**.

---

# **Learning Objectives**

By the end of this module, you will:

* Master Terraform's built-in functions across all categories
* Understand when and how to use each function type
* Know how to combine multiple functions effectively
* Become proficient with the Terraform console for testing
* Implement proper validation and error handling
* Handle sensitive data securely
* Create dynamic, reusable configurations

---

# **Console Commands**

Practice these in **terraform console** before starting:

```
lower("HELLO WORLD")
max(5, 12, 9)
trim("  hello  ")
chomp("hello\n")
reverse(["a", "b", "c"])
```

---

# **Assignments Overview**

| #  | Assignment            | Functions Used               | Difficulty | AWS Resources   |
| -- | --------------------- | ---------------------------- | ---------- | --------------- |
| 1  | Project Naming        | lower, replace               | ⭐          | Resource Group  |
| 2  | Resource Tagging      | merge                        | ⭐          | VPC             |
| 3  | S3 Bucket Naming      | substr, replace, lower       | ⭐⭐         | S3 Bucket       |
| 4  | Security Group Ports  | split, join, for             | ⭐⭐         | Security Group  |
| 5  | Environment Lookup    | lookup                       | ⭐⭐         | EC2 Instance    |
| 6  | Instance Validation   | length, can, regex           | ⭐⭐⭐        | EC2 Instance    |
| 7  | Backup Configuration  | endswith, sensitive          | ⭐⭐         | None            |
| 8  | File Path Processing  | fileexists, dirname          | ⭐⭐         | None            |
| 9  | Location Management   | toset, concat                | ⭐          | None            |
| 10 | Cost Calculation      | abs, max, sum                | ⭐⭐         | None            |
| 11 | Timestamp Management  | timestamp, formatdate        | ⭐⭐         | S3 Bucket       |
| 12 | File Content Handling | file, jsondecode, jsonencode | ⭐⭐⭐        | Secrets Manager |

---

# **Quick Start**

```bash
cd /home/baivab/repos/Terraform-Full-Course-Aws/lessons/day11-12

terraform init

terraform plan
terraform apply -auto-approve

terraform output

terraform destroy -auto-approve
```

---

# **Function Categories**

### **String Functions**

lower(), upper(), replace(), substr(), trim(), split(), join(), chomp()

### **Numeric Functions**

abs(), max(), min(), ceil(), floor(), sum()

### **Collection Functions**

length(), concat(), merge(), reverse(), toset(), tolist()

### **Type Conversion**

tonumber(), tostring(), tobool(), toset(), tolist()

### **File Functions**

file(), fileexists(), dirname(), basename()

### **Date/Time Functions**

timestamp(), formatdate(), timeadd()

### **Validation Functions**

can(), regex(), contains(), startswith(), endswith()

### **Lookup Functions**

lookup(), element(), index()

---

# **Files Included**

* **README.md** – Main overview
* **DEMO_GUIDE.md** – Step-by-step demo instructions
* **provider.tf** – AWS provider setup
* **backend.tf** – S3 backend (optional)
* **variables.tf** – All assignment variables
* **main.tf** – All 12 assignments (commented blocks)
* **outputs.tf** – All assignment outputs (commented)

---

# **Assignment Summary (6–12 Without Icons)**

### **Assignment 6: Instance Validation**

Validate EC2 instance type format and length using Terraform validation functions.
**Functions:** length(), can(), regex()

---

### **Assignment 7: Backup Configuration**

Verify backup name structure and handle sensitive values properly.
**Functions:** endswith(), sensitive()

---

### **Assignment 8: File Path Processing**

Check whether a file exists and extract directory paths for automation use.
**Functions:** fileexists(), dirname()

---

### **Assignment 9: Location Management**

Merge two region lists and remove duplicates using set operations.
**Functions:** toset(), concat()

---

### **Assignment 10: Cost Calculation**

Calculate resource cost after applying usage credits and ensure non-negative output.
**Functions:** abs(), max(), sum()

---

### **Assignment 11: Timestamp Management**

Generate timestamps and format them for resource names, logging, and tagging.
**Functions:** timestamp(), formatdate()

---

### **Assignment 12: File Content Handling**

Load JSON configuration, decode it, and store into AWS Secrets Manager securely.
**Functions:** file(), jsondecode(), jsonencode()

---

# **Resources**

* Terraform Functions Documentation
* Terraform Console
* AWS Provider Docs
* DEMO_GUIDE.md – Full demo workflow

---

