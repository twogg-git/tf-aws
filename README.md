# tf-aws
Some examples of terraform provisioning in AWS

Dont forget to setup your aws-cli enviroment (AWS Documentation)[https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html]
```sh
$ aws configure
AWS Access Key ID [None]: abc12345Key
AWS Secret Access Key [None]: abc12345Secret
Default region name [None]: us-east-1
Default output format [None]: json
```

Or adding your provider info into the terraform.tfvars file
```sh
$ vim terraform.tfvars
provider "aws" {
  version = "~> 2.6"
  access_key = "abc12345Key"
  secret_key = "abc12345Secret"
  region = "us-east-1
}
```