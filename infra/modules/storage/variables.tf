variable  "region" {
	description = "Specify region please"
}

variable "force_destroy"{
	description="should remove S3 bucket even though there are files inside"
}

provider "aws" {
  region	= var.region
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
