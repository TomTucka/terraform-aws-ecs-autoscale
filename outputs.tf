output "aws_appautoscaling_policy_up" {
  value = aws_appautoscaling_policy.scale_up
}

output "aws_appautoscaling_policy_down" {
  value = aws_appautoscaling_policy.scale_down
}
output "aws_cloudwatch_alarm_high" {
  value = aws_cloudwatch_metric_alarm.cpu_utilization_high
}

output "aws_cloudwatch_alarm_low" {
  value = aws_cloudwatch_metric_alarm.cpu_utilization_low
}
