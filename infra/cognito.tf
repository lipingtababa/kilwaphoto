resource "aws_cognito_user_pool" "kilwauserpool" {
	name = "kilwauserpool"
	username_attributes = ["email"]
	tags = {usage="kilwaphoto3"}
}

resource "aws_cognito_user_pool_client" "kilwaclient" {
	name = "kilwaclient"
	generate_secret	= false
	user_pool_id = "${aws_cognito_user_pool.kilwauserpool.id}"
	#TODO how to set enabled identity providers?
	#supported_identity_providers	= ["cognito"]
}

resource "aws_cognito_identity_pool" "kilwauser" {
	identity_pool_name               = "kilwauser"
	allow_unauthenticated_identities = true

	cognito_identity_providers {
		client_id               = "${aws_cognito_user_pool_client.kilwaclient.id}"
		provider_name           = "${aws_cognito_user_pool.kilwauserpool.endpoint}"
		server_side_token_check = false
	}
	provisioner "local-exec" {
		command = "sed -i 's/BUCKET_NAME/${var.photobucketname}/' ../app.js"
	}
	provisioner "local-exec" {
		command = "sed -i 's/AWS_REGION/${var.region}/' ../app.js"
	}
	provisioner "local-exec" {
		command = "sed -i 's/IDENTITY_POOL_ID/${aws_cognito_identity_pool.kilwauser.id}/' ../app.js"
	}
	tags = {usage="kilwaphoto"}
}

output "user_pool_id" {
	value = "${aws_cognito_user_pool.kilwauserpool.id}"
}

output "user_client_id" {
	value = "${aws_cognito_user_pool_client.kilwaclient.id}"
}

output "identity_pool_id"{
	value = "${aws_cognito_identity_pool.kilwauser.id}"
}
