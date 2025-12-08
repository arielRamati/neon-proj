data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "github_action_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:sub"
      values   = [
        "repo:${var.github_repository}:ref:refs/heads/main"
      ]
    }
  }
}

data "aws_iam_policy_document" "github_eks_access_policy" {
    statement {
        actions   = ["eks:DescribeCluster"]
        resources = ["*"]
    }
}