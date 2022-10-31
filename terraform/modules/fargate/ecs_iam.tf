# IAM assume role policy for ECS Cluster
data "aws_iam_policy_document" "assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

# IAM Execution Role for Fargate
resource "aws_iam_role" "fargate_execution_role" {
  name                 = "${var.name}-execution-role"
  assume_role_policy   = data.aws_iam_policy_document.assume-role-policy.json

}

# IAM Execution Policy Attachments
resource "aws_iam_role_policy_attachment" "task-execution-policy" {
  role       = aws_iam_role.fargate_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "ssm-policy" {
  role       = aws_iam_role.fargate_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
}

# IAM Task Role for Fargate
resource "aws_iam_role" "fargate_task_role" {
  name                 = "${var.name}-task-role"
  assume_role_policy   = data.aws_iam_policy_document.assume-role-policy.json
}

resource "aws_iam_policy" "cw" {
  name   = "${var.name}-cw-write-policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Effect": "Allow",
        "Action": [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
        ],
        "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "fargate_task" {
  role       = aws_iam_role.fargate_execution_role.name
  policy_arn = aws_iam_policy.cw.arn
}
