variable  "region" {
	default = "us-west-2"
}

provider "aws" {
  region	= "${var.region}"
  #AWS token is stored in ~/.aws/, not declared here 
}

variable "codebucketname" {
	description = "This bucket is for hosting static js/html/css files, not for photos"
}

variable "photobucketname" {
	description = "This bucket is for photo storage, not for js/html/css files"
}

variable "logbucketname"{
	description = "This bucket is for storing logs"
}