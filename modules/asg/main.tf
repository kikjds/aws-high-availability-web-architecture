resource "aws_placement_group" "private_instances_placement_group" {
  name         = "private-instances-placement-group"
  strategy     = "spread"
  spread_level = "rack"
}


//Auto scaling group
resource "aws_autoscaling_group" "asg" {
  name                      = "application-instances-asg"
  max_size                  = 6
  min_size                  = 3
  desired_capacity          = 3
  health_check_grace_period = 360
  health_check_type         = "ELB"
  target_group_arns         = [var.target_group_arn]
  force_delete              = true
  vpc_zone_identifier       = var.private_subnet_ids
  placement_group           = aws_placement_group.private_instances_placement_group.id

  instance_maintenance_policy {
    min_healthy_percentage = 90
    max_healthy_percentage = 120
  }

  launch_template {
    id      = var.private_instances_launch_template_id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "asg - private instance"
    propagate_at_launch = true
  }
}

// Policy based on cpu utilization
resource "aws_autoscaling_policy" "asg_policy" {
  name                      = "cpu-target-tracking"
  autoscaling_group_name    = aws_autoscaling_group.asg.name
  policy_type               = "TargetTrackingScaling"
  estimated_instance_warmup = 300

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value     = 60.0
    disable_scale_in = false
  }
}