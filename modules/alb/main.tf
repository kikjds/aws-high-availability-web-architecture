// Application load balancer security group
resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Allow http traffic to alb"
  vpc_id      = var.vpc_id
  tags = {
    Name = "alb-sg"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

// Target group
resource "aws_lb_target_group" "target_group" {
  name        = "alb-tg"
  port        = 80
  target_type = "instance"
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  tags = {
    Name = "alb-tg"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    path                = "/"
  }
}

resource "aws_lb_target_group_attachment" "attachment" {
  count            = length(var.private_instance_ids)
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = var.private_instance_ids[count.index]
  port             = 80
}

// Application load balancer
resource "aws_lb" "alb" {
  name               = "alb"
  load_balancer_type = "application"
  subnets            = var.public_subnets[*]
  security_groups    = [aws_security_group.alb_sg.id]

  tags = {
    Name = "alb"
  }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  tags = {
    Name = "alb-listener"
  }

  default_action {
    type = "forward"

    forward {
      target_group {
        arn    = aws_lb_target_group.target_group.arn
        weight = 100
      }
    }

  }
}