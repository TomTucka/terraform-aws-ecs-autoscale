# terraform-aws-ecs-autoscale

[![CircleCI](https://circleci.com/gh/TomTucka/terraform-pagerduty-team-members.svg?style=svg)](https://circleci.com/gh/TomTucka/terraform-pagerduty-team-members)

Terraform module for autoscaling and ECS service based on a cloudwatch CPU Utilization alarm.

### Usage

```hcl
module "service-autoscaling" {
  source                = "./modules/ecs_autoscaling"
  service_name          = "service"
  resource_id           = "service/cluster_name/service_name"
  scaling_adjustment_up = 2
}
```
