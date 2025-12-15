// Configuring MFA for all the groups
resource "aws_iam_policy" "require_mfa" {
  name        = "Require-MFA"
  description = "Deny access unless MFA is enabled"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "DenyAllExceptMFA"
        Effect   = "Deny"
        Action   = "*"
        Resource = "*"
        Condition = {
          BoolIfExists = {
            "aws:MultiFactorAuthPresent" = "false"
          }
        }
      }
    ]
  })
}


resource "aws_iam_group_policy_attachment" "mfa_enforcement" {
  for_each = {
    education = aws_iam_group.education.name
    managers  = aws_iam_group.managers.name
    engineers = aws_iam_group.engineers.name
  }

  group      = each.value
  policy_arn = aws_iam_policy.require_mfa.arn
}