resource "aws_s3_bucket" "static_file_site" {
	bucket = "${var.codebucketname}"
	acl    = "public-read"

	#This bucket could be deleted by force since it contains just reproducible code (js, html & css etc)
	force_destroy = true
	policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
		"Sid": "PublicObject",
		"Effect": "Allow",
		"Principal": "*",
		"Action": ["s3:GetObject"],
		"Resource": ["arn:aws:s3:::${var.codebucketname}/*", "arn:aws:s3:::${var.codebucketname}"]
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
		target_prefix = "${var.codebucketname}"
	}
	tags = {usage="kilwaphoto"}
}

output "static_site_url" {
	value = "${aws_s3_bucket.static_file_site.website_endpoint}"
}
