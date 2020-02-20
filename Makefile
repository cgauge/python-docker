IMAGE_NAME = cg_python3
IMAGE_VERSION = 3.7
AWS_PROFILE = 250478887320

create-repo:
	aws ecr describe-repositories --repository-names $(IMAGE_NAME) --profile=research --region=eu-west-1 > /dev/null || aws ecr create-repository --repository-name $(IMAGE_NAME) --profile=research --region=eu-west-1 --image-scanning-configuration scanOnPush=true > /dev/null

docker-login:
	echo "Logging in to ECR"
	aws ecr get-login-password --profile research --region eu-west-1 | docker login --username AWS --password-stdin $(AWS_PROFILE).dkr.ecr.eu-west-1.amazonaws.com

docker-tag:
	docker tag cg_python3:latest $(AWS_PROFILE).dkr.ecr.eu-west-1.amazonaws.com/$(IMAGE_NAME):$(IMAGE_VERSION)

docker-push:
	docker push $(AWS_PROFILE).dkr.ecr.eu-west-1.amazonaws.com/$(IMAGE_NAME):$(IMAGE_VERSION)

docker-build:
	echo "Building image $(REPO_NAME)"
	docker build -t $(IMAGE_NAME):$(IMAGE_VERSION) .

ecr-push: docker-build docker-login create-repo docker-tag docker-push
	docker-build
	docker-login
	create-repo
	docker-tag
	docker-push
