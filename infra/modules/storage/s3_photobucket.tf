resource "aws_s3_bucket" "user_photo" {
	bucket = "${var.photobucketname}"
	acl    = "public-read-write"
	
	#This bucket should NOT be deleted automatically since it might contains user data!
	force_destroy = var.force_destroy
	lifecycle {
		#https://github.com/hashicorp/terraform/issues/3116
		#Due to this stupid bug(yes, it is a bug), you can't set the value to a dynamic variable, but a literal only
		prevent_destroy = false
	}


	#TODO not sure what to do with ACL
	policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
		"Sid": "PublicObject",
		"Effect": "Allow",
		"Principal": "*",
		"Action": ["s3:GetObject", "s3:PutObject", "s3:PutObjectTagging"],
		"Resource": ["arn:aws:s3:::${var.photobucketname}/*", "arn:aws:s3:::${var.photobucketname}"]
        }
    ]
}
EOF

	logging {
		target_bucket = "${aws_s3_bucket.log.id}"
		target_prefix = "${var.photobucketname}"
	}
	tags = {usage="kilwaphoto"}
}

output "photo_bucket_arn" {
	value = "${aws_s3_bucket.user_photo.arn}"
}
