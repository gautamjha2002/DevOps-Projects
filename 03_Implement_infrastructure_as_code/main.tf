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

  user_data = <<EOF
#!/bin/bash
sudo apt-get update -y
sudo apt install nginx-core -y
cat >/var/www/html/index* <<EOF2
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>DevOps 3rd Project</title>
</head>
<body>
<h1>Here is the Image we uploaded on S3 and get it using cloudfront</h1>
<img src="https://${aws_cloudfront_distribution.s3-distribution.domain_name}/${aws_s3_object.img-object.key}" alt="Something is wrong" srcset="">
</body>
</html>
EOF2
EOF
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


## Create S3
resource "aws_s3_bucket" "s3-bucket" {
  bucket = "day4-devops-s3"
  tags = {
    Name = "DevOps Project s3"
  }
  
}

resource "aws_s3_bucket_acl" "s3-acl" {
  bucket = aws_s3_bucket.s3-bucket.id
  acl = "private"
}

# resource "aws_s3_bucket_object" "img-object" {
#   bucket = aws_s3_bucket.s3-bucket.bucket
#   key = "FB_BG.png"
# }

resource "aws_s3_object" "img-object" {
  bucket = aws_s3_bucket.s3-bucket.bucket
  key = "FB_BG.png"
  source = "FB_BG.png"
  acl = "public-read"
}

## Create cloudfront

locals {
  s3_origin_id = "tfS3Origin"
}

resource "aws_cloudfront_distribution" "s3-distribution" {

  origin {
    domain_name = aws_s3_bucket.s3-bucket.bucket_regional_domain_name
    origin_id = local.s3_origin_id

  }

  enabled = true
  is_ipv6_enabled = true

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400

  }

    price_class = "PriceClass_All"

    restrictions {
    geo_restriction {
      restriction_type = "none"

    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
  
}

output "dns-name" {
  value = aws_cloudfront_distribution.s3-distribution.domain_name
}

output "lb-dns-name" {
  value = aws_lb.web-server-alb.dns_name
}