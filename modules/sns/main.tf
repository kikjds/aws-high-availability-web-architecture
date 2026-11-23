resource "aws_sns_topic" "asg_notifications" {
  name = "asg-notifications"
}

resource "aws_sns_topic_subscription" "asg_email_subscription" {
  topic_arn = aws_sns_topic.asg_notifications.arn
  protocol  = "email"
  endpoint  = var.asg_notification_email
}