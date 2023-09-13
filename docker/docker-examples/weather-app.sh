#!/bin/bash

echo "We are now building a application"
pwd
cd ./docker/docker-examples
pwd
docker image build -t harbor.registry.local/jenkins/myapp:v1.$BUILD_NUMBER .

docker push harbor.registry.local/jenkins/myapp:v1.$BUILD_NUMBER
docker container stop my-app || true
docker container rm my-app || true

echo "Now running the container"

sudo docker run -itd --name my-app -p 8081:3000 harbor.registry.local/jenkins/myapp:v1.$BUILD_NUMBER

sudo docker ps
