resource "aws_s3_bucket" "static_file_site" {
	bucket = "${var.photobucketname}"
	acl    = "public-read-write"
	policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
		"Sid": "PublicWriteObject",
		"Effect": "Allow",
		"Principal": "*",
		"Action": ["s3:GetObject","s3:PutObject","s3:PutObjectTagging"],
		"Resource": ["arn:aws:s3:::${var.photobucketname}/*", "arn:aws:s3:::${var.photobucketname}"]
        }
    ]
}
EOF

	website {
		index_document = "index.html"
		error_document = "error.html"
	}
	cors_rule {
		allowed_headers = ["*"]
		allowed_methods = ["PUT", "POST","GET","DELETE","HEAD"]
		allowed_origins = ["*"]
		expose_headers  = ["ETag"]
		max_age_seconds = 3000
	}
	logging {
		target_bucket = "${aws_s3_bucket.log.id}"
		target_prefix = "photo.kilwaphoto.com/"
	}
	tags = {usage="kilwaphoto"}
}

output "static_site_url" {
	value = "${aws_s3_bucket.static_file_site.bucket_regional_domain_name}"
}
