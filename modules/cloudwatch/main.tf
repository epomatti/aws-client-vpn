resource "aws_cloudwatch_log_group" "vpn" {
  name = "${var.workload}-vpnlogs"
}

# data "aws_iam_policy_document" "vpn" {
#   statement {
#     actions = [
#       "logs:CreateLogStream",
#       "logs:PutLogEvents",
#       "logs:PutLogEventsBatch",
#     ]

#     resources = ["arn:aws:logs:*"]

#     principals {
#       identifiers = ["datasync.amazonaws.com"]
#       type        = "Service"
#     }
#   }
# }
