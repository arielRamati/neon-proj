# DevOps Engineer Home Assignment — webapp

This repository contains a minimal end-to-end example demonstrating:

- A simple "Hello, World" Flask web application
- A `Dockerfile` to containerize the app
- A custom Helm chart (`charts/webapp`) to deploy the app to Kubernetes
- Terraform configuration (`terraform/`) to provision AWS infrastructure (VPC + EKS)
- GitHub Actions workflows to build/push the image and deploy via Helm

**Important:** This repo is scaffolded to be functional, but you must provide cloud credentials and a few repository secrets before running the automated workflows.

**High-level flow**

1. Use Terraform to provision AWS infra (VPC and EKS). This creates an EKS cluster and worker nodes.
2. Push container image to GitHub Container Registry (GHCR) using GitHub Actions.
3. GitHub Actions obtains cluster credentials and runs `helm upgrade --install` using the chart in `charts/webapp`.

**What’s included**

- `app/` — Flask app, `Dockerfile`, and `requirements.txt`.
- `charts/webapp/` — Helm chart with Deployment and Service templates.
- `terraform/` — Terraform configuration using `terraform-aws-modules/vpc/aws` and `terraform-aws-modules/eks/aws` modules.
- `.github/workflows/ci-cd.yml` — Build, push to GHCR and Helm deploy to EKS on `main` branch pushes.

Getting started (local)

1. Install prerequisites: `terraform`, `kubectl`, `helm`, `docker`, and AWS CLI with credentials.

2. Provision infra (creates VPC and EKS cluster):

```bash
cd terraform
terraform init
terraform apply -var 'aws_region=us-east-1' -var 'cluster_name=webapp-cluster'
```

After apply finishes, note the cluster name and region to set in GitHub repo secrets.

3. Build and push image locally (optional):

```bash
docker build -t ghcr.io/<OWNER>/webapp:local -f app/Dockerfile app
docker push ghcr.io/<OWNER>/webapp:local
```

CI/CD (GitHub Actions)

Set these repository secrets before pushing to `main`:

- `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` — IAM user with permissions to manage EKS
- `AWS_REGION` — e.g. `us-east-1`
- `EKS_CLUSTER_NAME` — cluster name created by Terraform

The `ci-cd.yml` workflow triggers on pushes to `main`. It:

- Builds and pushes the Docker image to GHCR (using `GITHUB_TOKEN`).
- Configures AWS credentials and updates kubeconfig for the target EKS cluster.
- Runs `helm upgrade --install` with the chart in `charts/webapp`, setting the built image tag.

Notes and next steps

- Replace `charts/webapp/values.yaml` `image.repository` with `ghcr.io/<OWNER>/webapp` or allow the workflow to set image at deploy time.
- You may want to add an ingress (ALB/NGINX) depending on how you want to expose the service.
- For production, secure the GHCR push with an appropriate policy and consider non-root containers, resource limits, and pod security.

If you want, I can:

- Add a `terraform.yml` workflow to automatically run Terraform plan and apply with approvals.
- Add an Ingress and an HTTPS certificate using cert-manager and an ALB.
- Add integration tests or a healthcheck probe to the app.
# neon-proj
# neon-proj
