# neon-proj

Simple end-to-end DevOps setup using:

- Flask application
- Docker containerization
- Terraform for AWS provisioning
- Kubernetes (EKS) deployment using Helm
- GitHub Actions CI/CD automation

## Project Structure

| Path | Description |
|------|-------------|
| `app/` | Flask API with `/greet` endpoint |
| `charts/app/` | Helm chart for deployment to EKS |
| `terraform/` | AWS VPC and EKS infrastructure |
| `.github/workflows/` | CI/CD workflows |

## CI Pipeline: ci.yml

This workflow runs automatically on every push to the main branch and includes the following steps:

1. Checkout repository code
2. Install Python dependencies using pip
3. Run unit tests with pytest
4. Build a Docker image of the application
5. Tag the image with both the current commit SHA and latest

This guarantees each main branch commit produces a validated and versioned container image for deployment.

## Provision AWS Infrastructure (Optional CD)

### Prerequisites:

- AWS CLI installed and configured 
- Terraform or Tofu CLI installed

### Example:

```bash
cd terraform
tofu init
tofu apply
```

This will provision:

- Networking (VPC)
- EKS cluster
- Worker node group for workloads

## Local Development

### Required tools (macOS example)

```bash
brew install tofu kubectl helm docker

# AWS CLI
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /

```

### Test the application locally

```bash
docker build -t neon-proj:local .
docker run -p 8080:8080 neon-proj:local
```

Open a browser to:

```
http://127.0.0.1:8080
```

## CI Flow Summary

Push to main branch triggers:

1. Code checkout
2. Dependency installation
3. Unit tests
4. Docker image build, tag


## CD Pipeline: deploy.yml

This workflow automates deployment to the existing EKS cluster whenever code is pushed to the main branch.

It performs the following steps:

1. Checkout repository code
2. Authenticate to AWS using credentials stored in GitHub Secrets
3. Authenticate to Docker Hub
4. Build a new Docker image of the application
5. Tag the image with both the commit SHA and latest
6. Push the updated image to Docker Hub
7. Initialize and apply Terraform (Tofu) to ensure infrastructure is up to date
8. Update local kubeconfig to connect to the EKS cluster
9. Deploy the application using Helm (upgrade --install)
10. Run Helm integration tests to validate the deployment

This enables continuous deployment: every push to main results in an updated image being deployed directly to AWS EKS.
