.PHONY: init update validate

# PLEASE CHANGE THIS.
BUCKET_NAME=aws-cloudformation-drupal-showroom
STACK_NAME=aws-cloudformation-drupal-showroom
AWS_REGION=eu-west-1

# Create AWS S3 bucket to store code and deploy it to CloudFormation.
init:
	#aws s3api create-bucket --bucket $(BUCKET_NAME) --region $(AWS_REGION) --create-bucket-configuration LocationConstraint=$(AWS_REGION)
	#aws s3 cp infrastructure/ s3://$(BUCKET_NAME) --recursive
	aws cloudformation create-stack \
	--stack-name $(STACK_NAME) \
	--template-body file://infrastructure/ec2.yaml \
	--parameters ParameterKey=S3BucketName,ParameterValue="$(BUCKET_NAME)"

update:
	aws s3 cp infrastructure/ s3://$(BUCKET_NAME) --recursive

validate:
	pre-commit run --all-files
