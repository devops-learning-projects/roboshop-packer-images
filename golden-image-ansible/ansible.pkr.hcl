packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "rhel9_ansible" {
  region        = "us-east-1"
  source_ami    = "ami-09c813fb71547fc4f"
  instance_type = "t3.small"
  ssh_username  = "ec2-user"
  ssh_password  = "DevOps321"
  ami_name      = "golden-image-ansible"
}

build {
  name    = "golden-image-ansible"
  sources = [
    "source.amazon-ebs.rhel9_ansible"
  ]

  provisioner "shell" {
    inline = [
      "sudo pip3.11 install ansible hvac",
      "ansible-pull -i localhost, -U https://github.com/devops-learning-projects/roboshop-packer-images.git main.yml"
    ]
  }
}

