resource "aws_appautoscaling_target" "main" {
  max_capacity       = var.max_scale_capacity
  min_capacity       = var.min_scale_capacity
  resource_id        = var.resource_id
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "scale_up" {
  name               = "${terraform.workspace}-${var.service_name}-up-policy"
  policy_type        = "StepScaling"
  service_namespace  = aws_appautoscaling_target.main.service_namespace
  scalable_dimension = aws_appautoscaling_target.main.scalable_dimension
  resource_id        = aws_appautoscaling_target.main.resource_id

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = var.scaling_cooldown_up
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = var.scaling_adjustment_up
    }
  }
}

resource "aws_appautoscaling_policy" "scale_down" {
  name               = "${terraform.workspace}-${var.service_name}-down-policy"
  policy_type        = "StepScaling"
  service_namespace  = aws_appautoscaling_target.main.service_namespace
  scalable_dimension = aws_appautoscaling_target.main.scalable_dimension
  resource_id        = aws_appautoscaling_target.main.resource_id

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = var.scaling_cooldown_down
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = var.scaling_adjustment_down
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization_high" {
  alarm_name          = "${terraform.workspace}-${var.service_name}-cpu-high"
  alarm_description   = "${var.service_name} ECS Service CPU Utilization High. Managed By terraform"
  alarm_actions       = [aws_appautoscaling_policy.scale_up.arn]
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 80
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization_low" {
  alarm_name          = "${terraform.workspace}-${var.service_name}-cpu-low"
  alarm_description   = "${var.service_name} ECS Service CPU Utilization Low. Managed By terraform"
  alarm_actions       = [aws_appautoscaling_policy.scale_down.arn]
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 20
}
