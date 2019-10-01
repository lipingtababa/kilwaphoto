variable region {
	default = "us-west-2"
}

variable projectname {
	default = "kilwapicture"
}

module "storage" {
	source = "../modules/storage"
	region = "us-west-2"

	photobucketname	=	"photo${var.projectname}"
	codebucketname	=	"code${var.projectname}"
	logbucketname	=	"log${var.projectname}"
}

module "users" {
	source = "../modules/users"
	region = "us-west-2"

	user_pool_name = "kilwafans"
}


data "template_file" "appjs" {
	template = "${file("${path.module}/../../frontend/app_template.js")}"
	vars = {
		BUCKET_NAME	=  "photo${var.projectname}",
		AWS_REGION	=	var.region	
		IDENTITY_POOL_ID	=	module.users.identity_pool_id
	}
}

resource "local_file" "appjs" {
    content     = data.template_file.appjs.rendered
    filename = "${path.module}/../../frontend/app.js"
}

resource "null_resource" "void"{

	triggers = {
		copy = "copy"
	}

	provisioner "local-exec" {
		command = "aws s3 cp ../../frontend/app.js s3://code${var.projectname}/app.js"
	}

	provisioner "local-exec" {
		command = "aws s3 cp ../../frontend/app.js s3://code${var.projectname}/app.js"
	}

	provisioner "local-exec" {
		command = "aws s3 cp ../../frontend/index.html s3://code${var.projectname}/index.html"
	}

	depends_on = [module.users, module.storage]
}

output "static_site_url" {
	value = module.storage.static_site_url
}
