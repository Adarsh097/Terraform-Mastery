# Day 7: Type Constraints in Terraform

This document explains how **type constraints** work in Terraform and how they help ensure correctness, maintainability, and predictability in your infrastructure code. It covers basic types, collection types, complex type definitions, validations, and best practices, along with example code for each concept.

---

## Basic Types

Terraform supports three primitive data types:

### 1. string

Represents plain text values.

Example:

```hcl
variable "environment" {
  type = string
  default = "dev"
}
```

### 2. number

Supports both integers and floating-point values.

Example:

```hcl
variable "instance_count" {
  type    = number
  default = 3
}
```

### 3. bool

Represents boolean true or false.

Example:

```hcl
variable "enable_monitoring" {
  type    = bool
  default = true
}
```

---

## Collection Types

Terraform provides higher-level data structures for organizing multiple values.

---

### list(type)

An ordered collection of values where duplicates are allowed.

Example:

```hcl
variable "availability_zones" {
  type = list(string)
  default = ["us-east-1a", "us-east-1b"]
}
```

Usage:

```hcl
az = var.availability_zones[0]
```

---

### set(type)

An unordered collection of unique values.

Example:

```hcl
variable "security_ports" {
  type = set(number)
  default = [22, 80, 443]
}
```

Usage:

```hcl
for port in var.security_ports : port
```

---

### map(type)

A collection of key-value pairs where keys are always strings.

Example:

```hcl
variable "tags" {
  type = map(string)
  default = {
    Environment = "dev"
    Owner       = "cloud-team"
  }
}
```

Usage:

```hcl
name = var.tags["Environment"]
```

---

### tuple([type1, type2, ...])

An ordered list where each element has a specific type.

Example:

```hcl
variable "network_config" {
  type = tuple([string, number, number])
  default = ["tcp", 8080, 443]
}
```

Usage:

```hcl
protocol = var.network_config[0]
port     = var.network_config[1]
```

---

### object({ key = type, ... })

A structured data type with named attributes.

Example:

```hcl
variable "server_config" {
  type = object({
    name     = string
    cpu      = number
    memory   = number
    is_prod  = bool
  })

  default = {
    name    = "web-server"
    cpu     = 2
    memory  = 4
    is_prod = false
  }
}
```

Usage:

```hcl
instance_name = var.server_config.name
```

---

## Type Validation and Constraints

Type validation ensures variable values meet your expected business logic.

### Example with validation

```hcl
variable "instance_count" {
  type = number

  validation {
    condition     = var.instance_count >= 1 && var.instance_count <= 10
    error_message = "Instance count must be between 1 and 10."
  }
}
```

Another example for a list:

```hcl
variable "availability_zones" {
  type = list(string)

  validation {
    condition     = length(var.availability_zones) >= 2
    error_message = "You must provide at least two availability zones."
  }
}
```

---

## Complex Type Definitions

Complex types combine objects, lists, maps, and tuples for structured data modeling.

### Example: Nested object with lists and maps

```hcl
variable "app_config" {
  type = object({
    name       = string
    replicas   = number
    labels     = map(string)
    ports      = list(number)
    deployment = object({
      strategy = string
      max_surge = number
    })
  })

  default = {
    name     = "my-app"
    replicas = 3
    labels = {
      team = "devops"
      app  = "backend"
    }
    ports = [80, 443]
    deployment = {
      strategy  = "RollingUpdate"
      max_surge = 1
    }
  }
}
```

Usage:

```hcl
app_name  = var.app_config.name
strategy  = var.app_config.deployment.strategy
```

---

## Common Type Patterns

These patterns help create cleaner and more maintainable Terraform modules.

### Environment-specific configurations

```hcl
variable "env_settings" {
  type = map(object({
    instance_type = string
    replicas      = number
  }))
}

# tfvars example
env_settings = {
  dev = {
    instance_type = "t2.micro"
    replicas      = 2
  }
  prod = {
    instance_type = "t3.medium"
    replicas      = 5
  }
}
```

---

### Resource sizing based on type

```hcl
variable "instance_size" {
  type = object({
    cpu    = number
    memory = number
  })
}
```

---

### Tag standardization

```hcl
variable "default_tags" {
  type = map(string)
  default = {
    ManagedBy = "Terraform"
    Team      = "CloudOps"
  }
}
```

---

### Network configuration validation

```hcl
variable "vpc_cidr" {
  type = string

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "Invalid CIDR block format."
  }
}
```

---

### Security policy enforcement

```hcl
variable "allowed_ports" {
  type = list(number)

  validation {
    condition     = alltrue([for p in var.allowed_ports : p >= 1 && p <= 65535])
    error_message = "Port numbers must be between 1 and 65535."
  }
}
```

---

## Best Practices

### Always specify types for variables

Makes your configuration predictable and less error-prone.

### Use validation blocks

Ensures business-specific constraints are enforced.

### Provide meaningful error messages

Helps users understand what input they must correct.

### Use appropriate collection types

Use list when order matters, set when uniqueness matters, map for key-value structures.

### Validate complex objects

Use nested validations to ensure structure correctness.

### Use type conversion functions

Useful when transforming inputs:

* tolist()
* tomap()
* tonumber()
* tostring()


