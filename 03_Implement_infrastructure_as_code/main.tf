provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web_server" {
  instance_type = "t2.micro"
  ami = "ami-06878d265978313ca"
  key_name = "general"
  security_groups = [aws_security_group.web-server-sg.name]
#   vpc_security_group_ids = [ "aws_security_group.web-server-sg.id" ]
  tags = {
    Name = "Web-Server"
  }
}

resource "aws_security_group" "web-server-sg" {
  name = "Web-Server-SG"
  vpc_id = aws_default_vpc.default-vpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "alb-sg" {
  name = "alb-sg"
  vpc_id = aws_default_vpc.default-vpc.id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_default_vpc" "default-vpc" {
  tags = {
    Name = "default-VPC"
  }
}

resource "aws_lb_target_group" "web-server-tg" {
  name = "Web-Server-TG"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_default_vpc.default-vpc.id
}

resource "aws_lb_target_group_attachment" "attach-instance" {
  target_group_arn = aws_lb_target_group.web-server-tg.arn
  target_id = aws_instance.web_server.id
  port = 80
}

resource "aws_default_subnet" "default_az1" {
  availability_zone = "us-east-1a"

  tags = {
    Name = "Default subnet for us-east-1a"
  }
}

resource "aws_default_subnet" "default_az2" {
  availability_zone = "us-east-1b"

  tags = {
    Name = "Default subnet for us-east-1b"
  }
}

resource "aws_default_subnet" "default_az3" {
  availability_zone = "us-east-1c"

  tags = {
    Name = "Default subnet for us-east-1c"
  }
}

resource "aws_default_subnet" "default_az4" {
  availability_zone = "us-east-1d"

  tags = {
    Name = "Default subnet for us-east-1d"
  }
}

resource "aws_default_subnet" "default_az5" {
  availability_zone = "us-east-1e"

  tags = {
    Name = "Default subnet for us-east-1e"
  }
}

resource "aws_default_subnet" "default_az6" {
  availability_zone = "us-east-1f"

  tags = {
    Name = "Default subnet for us-east-1f"
  }
}

resource "aws_lb" "web-server-alb" {
  name = "Web-Server-ALB"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.alb-sg.id]
  subnets = [ aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id, aws_default_subnet.default_az3.id, aws_default_subnet.default_az4.id, aws_default_subnet.default_az5.id, aws_default_subnet.default_az6.id ]
}

resource "aws_lb_listener" "alb-listener" {
  load_balancer_arn = aws_lb.web-server-alb.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.web-server-tg.arn
  }
}

