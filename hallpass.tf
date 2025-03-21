
provider "aws" {
    region = "us-east-1"
}

locals {
    prodj_owner = "JohnDixon"
    Env = var.env
    BillingId = 1001

}
data "aws_ami" "aws_ami_web" {
  most_recent = true

  owners = ["self"]
  tags = {
    version   = "latest"
    apptype = "web"
    os = "Linux"
  }
}

resource "aws_instance" "hallpassec2dev"{
    for_each = var.ec2-instance-props
    
    ami = data.aws_ami.aws_ami_web.id
    instance_type = each.value.inst_type
    subnet_id = each.value.subtnet_id
    tags = {

        Name = "Instance-${each.key}"
        Environment = local.Env
        ProjectOwner = local.prodj_owner
        BillingId = local.BillingId
    }
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.s3_bkt_name

  tags = {        
        Environment = local.Env
        ProjectOwner = local.prodj_owner
        BillingId = local.BillingId
    }
}