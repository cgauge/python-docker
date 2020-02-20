ifndef IMAGE_NAME
	override IMAGE_NAME = cg_python3
endif

ifndef IMAGE_VERSION
	override IMAGE_VERSION = 3.7
endif

ifndef AWS_PROFILE_ID
	override AWS_PROFILE_ID = 250478887320
endif

ifndef AWS_PROFILE
	override AWS_PROFILE = research
endif

ifndef AWS_REGION
	override AWS_REGION = eu-west-1
endif

AWS_PUSH_URL = $(AWS_PROFILE_ID).dkr.ecr.$(AWS_REGION).amazonaws.com
AWS_PUSH_TAG = $(AWS_PUSH_URL)/$(IMAGE_NAME):$(IMAGE_VERSION)

docker-build:
	@echo "Building image: $(IMAGE_NAME)"
	docker build -t $(IMAGE_NAME):$(IMAGE_VERSION) .

docker-login:
	@echo "Logging in to ECR"
	aws ecr get-login-password --profile=$(AWS_PROFILE) --region=$(AWS_REGION) | docker login --username AWS --password-stdin $(AWS_PUSH_URL)

ecr-create-repo:
	@aws ecr describe-repositories --profile=$(AWS_PROFILE) --region=$(AWS_REGION) | grep -q $(IMAGE_NAME) && echo "ECR Repository already exists:" $(IMAGE_NAME) || echo "Creating ECR Repository:" $(IMAGE_NAME)
	@aws ecr describe-repositories --profile=$(AWS_PROFILE) --region=$(AWS_REGION) | grep -q $(IMAGE_NAME) || aws ecr create-repository --repository-name $(IMAGE_NAME) --profile=$(AWS_PROFILE) --region=$(AWS_REGION) --image-scanning-configuration scanOnPush=true > /dev/null

docker-tag:
	@echo "Tagging docker image"
	docker tag $(IMAGE_NAME):$(IMAGE_VERSION) $(AWS_PUSH_TAG)

docker-push:
	@echo "Pushing to ECR with tag:" $(AWS_PUSH_TAG)
	docker push $(AWS_PUSH_TAG)

deploy: docker-build docker-login ecr-create-repo docker-tag docker-push
	@echo "Deploy completed:" ${IMAGE_NAME}
