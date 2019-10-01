resource "aws_cognito_user_pool" "kilwauserpool" {
	name = "${var.user_pool_name}"
	username_attributes = ["email"]
	tags = {usage="kilwaphoto"}
}

resource "aws_cognito_user_pool_client" "kilwaclient" {
	name = "${var.user_pool_name}client"
	generate_secret	= false
	user_pool_id = "${aws_cognito_user_pool.kilwauserpool.id}"
	#TODO how to set enabled identity providers?
	#supported_identity_providers	= ["cognito"]
}

resource "aws_cognito_identity_pool" "kilwa" {
	identity_pool_name               = "${var.user_pool_name}IdentityPool"
	allow_unauthenticated_identities = true

	cognito_identity_providers {
		client_id               = "${aws_cognito_user_pool_client.kilwaclient.id}"
		provider_name           = "${aws_cognito_user_pool.kilwauserpool.endpoint}"
		server_side_token_check = false
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
	value = "${aws_cognito_identity_pool.kilwa.id}"
}
