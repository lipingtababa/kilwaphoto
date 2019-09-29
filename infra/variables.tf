#Use US West 2  
variable  "region" {
	default = "us-west-2"
}

provider "aws" {
  region	= "${var.region}"
  #AWS token is stored in ~/.aws/, not declared here 
}

variable "photobucketname" {
	default = "photo.kilwaphoto.com"
	description = "This bucket is for photo storage, not for js/html/css files"
}

variable "logbucketname"{
	default = "log.kilwaphoto.com"
	description = "This bucket is for storing logs"
}
