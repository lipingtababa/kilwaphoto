resource "aws_s3_bucket" "log" {
	bucket = "${var.logbucketname}"
	acl    = "log-delivery-write"
	tags = {usage="kilwaphoto"}
}
