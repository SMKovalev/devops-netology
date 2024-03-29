provider "aws" {
        region = "us-east-1"
}

module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.1.2"

  name = "vm-1"

  ami                    = "ami-ebd02392"
  instance_type          = "t2.micro"
  key_name               = "user"
  monitoring             = true
  vpc_security_group_ids = ["sg-12345678"]
  subnet_id              = "subnet-eddcdzz4"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}