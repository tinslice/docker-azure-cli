#!make

# terraform releases https://releases.hashicorp.com/terraform/
root_path := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

include $(root_path)/.env

docker_repo = tinslice/azure-cli

build-debian:
	echo "== building image with debian '${DEBIAN_VERSION}' and terraform '${TERRAFORM_VERSION}'";\
	docker build --pull \
		--build-arg DEBIAN_VERSION=${DEBIAN_VERSION} --build-arg TERRAFORM_VERSION=${TERRAFORM_VERSION} --build-arg HELM_VERSION=${HELM_VERSION} \
		-f $(root_path)/debian/Dockerfile -t $(docker_repo):debian-${DEBIAN_VERSION}-tf${TERRAFORM_VERSION}  $(root_path)/debian

build-ubuntu:
	echo "== building image with ubuntu '${UBUNTU_VERSION}' and terraform '${TERRAFORM_VERSION}'";\
	docker build --pull \
		--build-arg UBUNTU_VERSION=${UBUNTU_VERSION} --build-arg TERRAFORM_VERSION=${TERRAFORM_VERSION} --build-arg HELM_VERSION=${HELM_VERSION} \
		-f $(root_path)/ubuntu/Dockerfile -t $(docker_repo):ubuntu-${UBUNTU_VERSION}-tf${TERRAFORM_VERSION}  $(root_path)/ubuntu

scan-debian:
	docker scan $(docker_repo):debian-${DEBIAN_VERSION}-tf${TERRAFORM_VERSION}

scan-ubuntu:
	docker scan $(docker_repo):ubuntu-${UBUNTU_VERSION}-tf${TERRAFORM_VERSION}

push-debian:
	docker push $(docker_repo):debian-${DEBIAN_VERSION}-tf${TERRAFORM_VERSION}

push-ubuntu:
	docker push $(docker_repo):ubuntu-${UBUNTU_VERSION}-tf${TERRAFORM_VERSION}

clean:
	docker rmi $(docker_repo):debian-${DEBIAN_VERSION}-tf${TERRAFORM_VERSION}
	docker rmi $(docker_repo):debian-${UBUNTU_VERSION}-tf${TERRAFORM_VERSION}