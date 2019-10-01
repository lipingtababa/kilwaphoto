variable "region"{
	description = "Must be set by the caller"
}

provider "aws" {
  region	= "${var.region}"
  #AWS token is stored in ~/.aws/, not declared here 
}

variable "user_pool_name"{
	description ="default name for user pool, identity pool and other related stuff"
}
