# Terraform Boilerplate

## Set State Key

### AWS CLI

```
$PROJECT-NAME=[]
[terraform-boilerplate]

aws configure --profile $PROJECT-NAME
```

### Terraform AWS Provider

```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.69.0"
    }
  }
  backend "s3" {
    bucket = "bananaforscale-aws-tf-state"
    region = "us-east-1"
    # Name of MicroWebService
    key = "boilerplate"
  }
}
```

### Terraform CLI

```
$TF-STATE-BUCKET=[]
[bananaforscale-aws-tf-state]

$TF-SC-KEY=[]
[AKIA4UL35THJWMKBI547]

$TF-SC-SECRET=[]
[***]

terraform init -backend-config="bucket=$(TF-STATE-BUCKET)" -backend-config="access_key=$(TF-SC-KEY)" -backend-config="secret_key=$(TF-SC-SECRET)"

terraform plan -input=false -out=plan -var "aws_access_key=$(TF-SC-KEY)" -var "aws_secret_key=$(TF-SC-SECRET)"

terraform apply -auto-approve -input=false
```
