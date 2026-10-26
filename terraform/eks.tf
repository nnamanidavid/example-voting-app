resource "aws_eks_cluster" "voting-app-cluster" {
  name     = "voting-app-cluster"
  role_arn = aws_iam_role.cluster_role.arn

  vpc_config {
    subnet_ids = data.aws_subnets.default.ids
  }
  
  depends_on = [aws_iam_role_policy_attachment.cluster_policy]
}

resource "aws_eks_node_group" "voting-app-node-group" {
  cluster_name    = aws_eks_cluster.voting-app-cluster.name
  node_group_name = "voting-app-node-group"
  node_role_arn   = aws_iam_role.node_role.arn
  subnet_ids      = data.aws_subnets.default.ids

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }
  
  instance_types = ["t3.medium"]

  depends_on = [
    aws_iam_role_policy_attachment.node_policy_worker,
    aws_iam_role_policy_attachment.node_policy_cni,
    aws_iam_role_policy_attachment.node_policy_registry,
  ]
}