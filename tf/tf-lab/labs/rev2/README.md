# Terraform Boilerplate

## Set State Key

### AWS CLI
```
$PROJECT-NAME=[]
[deep-dive]

aws configure --profile $PROJECT-NAME
```
### Bash
```
mkdir .aws
cd .aws
touch credentials
echo "[profile-name]" > credentials
echo "aws_access_key_id=$(TF-SC-KEY)" > credentials
echo "aws_secret_access_key=$(TF-SC-SECRET)" > credentials
cat credentials
touch config
echo "[profile profile-name]" > config
echo "region = us-east-1" > config
echo "output = json" > config
cat config
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
$PROJECT-NAME=[]
[deep-dive]

$AWS-PROFILE=[]
[deep-dive]

$AWS-REGION=[]
[us-east-1]

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
