resource "aws_iam_openid_connect_provider" "github" {
  url            = "https://token.actions.githubusercontent.com"
  client_id_list = ["sts.amazonaws.com"]
}

resource "aws_iam_role" "github_deployer" {
  name               = "neon-github-deployer"
  assume_role_policy = data.aws_iam_policy_document.github_action_policy.json
}

resource "aws_iam_role_policy" "github_eks_access" {
  name      = "neon-github-eks-access"
  role      = aws_iam_role.github_deployer.id
  policy    = data.aws_iam_policy_document.github_eks_access_policy.json 
}
