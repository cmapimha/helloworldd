Hello World – Azure Container Apps Deployment
This repository contains a fully containerized Node.js “Hello World” web server deployed to Azure Container Apps using Azure Container Registry (ACR), Bicep Infrastructure‑as‑Code, and Azure DevOps CI/CD pipelines. It is designed as a clean, portfolio‑ready example of modern DevOps practices.

📁 Repository Structure

infra/
  acr.bicep
  loganalytics.bicep
  containerapp-env.bicep
  containerapp.bicep

azure-pipelines/
  aca-infra.yml
  aca-ci.yml

Dockerfile

src/
  index.js
  package.json

🚀 Overview
Node.js Web Server
A simple Express server returning:
Hello World from my Node.js Web Server!

Dockerized Application
The Dockerfile builds a lightweight container image for deployment.
Azure Container Registry (ACR)
Stores the built Docker image so Azure Container Apps can pull it.
Azure Container Apps (ACA)
Runs the container with:
• Public ingress
• Autoscaling
• Managed environment
• Log Analytics integration
Infrastructure as Code (Bicep)
The infra/ folder deploys:
• ACR
• Log Analytics Workspace
• ACA Environment
• Container App
Azure DevOps CI/CD
Two pipelines:
• aca-ci.yml → Builds + pushes Docker image to ACR
• aca-infra.yml → Deploys ACA infrastructure using Bicep
