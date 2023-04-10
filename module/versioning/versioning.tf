#____________________________________________Versioning
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.44.0, <=4.61.0"
    }
    template = {
      source  = "hashicorp/template"
      version = "2.2.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.1.0"
    }
  }
  required_version = ">= 1.3.6, <= 1.4.4"
}