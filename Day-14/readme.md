## Day-14  | Host A Static Website In AWS S3 And Cloudfront (using terraform)

![alt text](image.png)

Here’s a clean, simple, and clear explanation of **why CloudFront + S3** is the ideal combo for serving a **global static website**:

---

# **Importance of Using AWS CloudFront Edge with S3 to Serve a Static Website Globally**

When hosting a static website on **Amazon S3**, the files (HTML, CSS, JS, images, videos) are stored in an S3 bucket located in a **single AWS Region**. While this works, it may not give the best experience for users who are physically far from that region.

This is where **Amazon CloudFront**, AWS’s global Content Delivery Network (CDN), becomes essential.

---

## 🔥 **1. Ultra-Low Latency via Global Edge Locations**

CloudFront has **hundreds of edge locations** across the world.

* When a user visits your website, CloudFront serves the content from the **nearest edge location**, not from your original S3 bucket in (example) Mumbai or Virginia.
* This reduces round-trip time significantly.
* Faster loading = Better user experience and SEO benefits.

**Without CloudFront:**
User in Europe → Request goes directly to your S3 bucket in AP-South-1 → Slow

**With CloudFront:**
User in Europe → Request goes to EU edge location → Served from nearest cache → Very fast

---

## ⚙️ **2. Caching for High Performance & Cost Efficiency**

CloudFront caches your static files in edge locations. Benefits:

* Reduces load on your S3 bucket
* Faster response times
* Lower S3 data transfer cost
* Better handling of high traffic spikes (no S3 overload)

CloudFront is built to serve heavy loads—great for viral traffic.

---

## 🔐 **3. Better Security for Your Website**

CloudFront adds multiple layers of security:

### ✔️ **AWS WAF Integration (Web Application Firewall)**

Protects against:

* SQL Injection
* XSS
* Bot traffic
* DDoS attempts

### ✔️ **DDoS Protection via AWS Shield**

Automatically included. Protects your site at both edge locations and origin (S3).

### ✔️ **Origin Access Control (OAC)**

Ensures S3 bucket is **not publicly accessible**.

Only CloudFront can access your S3 content → prevents unauthorized downloads.

---

## 🌍 **4. Global Scalability & Reliability**

CloudFront is deployed worldwide with AWS’s massive global network.

Even during:

* High traffic
* Spikes from marketing campaigns
* Regional internet disruptions

Your site stays stable, fast, and highly available.

---

## 🔒 **5. HTTPS Everywhere (Free SSL)**

CloudFront provides **free TLS/SSL certificates** via AWS Certificate Manager.

Benefits:

* Secure communication
* Browsers trust your site (no “Not Secure” warning)
* SEO boost
* S3 alone cannot provide HTTPS without CloudFront

---

## 🧭 **6. URL Routing, Custom Domains & Better Control**

CloudFront allows:

* Custom domains ([www.example.com](http://www.example.com))
* URL rewrites / redirects
* Custom error pages
* Cache policies
* Versioning with query parameters

This gives you much more flexibility than serving directly from S3.

---

# 🚀 **Final Summary**

| Feature        | S3 Only                         | S3 + CloudFront              |
| -------------- | ------------------------------- | ---------------------------- |
| Global speed   | ❌ Slow for distant users        | ✅ Fast via edge locations    |
| Caching        | ❌ None                          | ✅ Strong global caching      |
| Security       | ❌ Public bucket, basic security | ✅ WAF, Shield, OAC           |
| Scalability    | ⚠️ Good but limited             | ✅ Global CDN scaling         |
| HTTPS          | ❌ Hard/limited                  | ✅ Free SSL certificates      |
| Domain support | ⚠️ Limited                      | ✅ Full custom domain support |

**➡️ For any production static website, using S3 + CloudFront is the industry best practice.**

---

![alt text](image-1.png)


🎯 Project Overview
This mini project demonstrates how to deploy a static website on AWS using Terraform. We'll create a complete static website hosting solution using S3 for storage and CloudFront for global content delivery.

🏗️ Architecture
Internet → CloudFront Distribution → S3 Bucket (Static Website)
Components:
S3 Bucket: Hosts static website files (HTML, CSS, JS)
CloudFront Distribution: Global CDN for fast content delivery
Public Access Configuration: Allows public reading of website files
📁 Project Structure
day14/
├── main.tf              # Main Terraform configuration
├── variables.tf         # Input variables
├── outputs.tf          # Output values
├── README.md           # This file
└── www/                # Website source files
    ├── index.html      # Main HTML page
    ├── style.css       # Stylesheet
    └── script.js       # JavaScript functionality
🚀 Features
Website Features:
Modern Responsive Design: Works on desktop and mobile
Dark/Light Theme Toggle: Switch between themes (saves preference)
Interactive Elements: Click counter, status updates
AWS Branding: Professional layout showcasing AWS services
Animations: Smooth transitions and loading effects
Infrastructure Features:
S3 Static Website Hosting: Reliable file storage and serving
CloudFront CDN: Global content delivery with HTTPS
Proper MIME Types: Correct content-type headers for all files
Public Access: Secure public read access configuration
🛠️ Prerequisites
AWS CLI configured with appropriate credentials
Terraform installed (version 1.0+)
AWS Account with sufficient permissions for:
S3 bucket creation and management
CloudFront distribution creation
IAM policies for S3 public access
📋 Deployment Steps
1. Initialize Terraform
cd lessons/day14
terraform init
2. Review the Plan
terraform plan
3. Deploy Infrastructure
terraform apply
Type yes when prompted to confirm deployment.

4. Access Your Website
After deployment completes, Terraform will output the CloudFront URL:

website_url = "https://d123xyz.cloudfront.net"
📊 Resources Created
Resource Type	Purpose	Count
S3 Bucket	Website hosting	1
S3 Bucket Policy	Public read access	1
S3 Objects	Website files (HTML, CSS, JS)	3
CloudFront Distribution	Global CDN	1
🔧 Configuration Details
S3 Configuration:
Bucket naming: Auto-generated with prefix my-static-website-
Website hosting: Enabled with index.html as default
Public access: Configured for read-only public access
Content types: Proper MIME types for web files
CloudFront Configuration:
Origin: S3 bucket regional domain
Caching: Standard web caching (1 hour default TTL)
HTTPS: Automatic redirect from HTTP to HTTPS
Global: Available worldwide (PriceClass_100)
🧹 Cleanup
To destroy all resources and avoid charges:

terraform destroy
Type yes when prompted to confirm destruction.

📚 Learning Objectives
After completing this project, you should understand:

✅ How to configure S3 for static website hosting
✅ Setting up CloudFront distributions
✅ Managing S3 bucket policies and public access
✅ Terraform file provisioning with for_each
✅ Proper MIME type configuration for web assets
✅ AWS CDN concepts and caching strategies
🔗 Useful Links
AWS S3 Static Website Hosting Guide
CloudFront Documentation
Terraform AWS Provider
🎉 Next Steps
Consider extending this project with:

Custom domain name with Route 53
SSL certificate with AWS Certificate Manager
CI/CD pipeline for automatic deployments
Multiple environments (dev, staging, prod)
Advanced CloudFront configurations (custom error pages, security headers)