docker build -t <CLIENT_IMAGE_NAME>:latest -t <CLIENT_IMAGE_NAME>:$SHA -f ./client/Dockerfile ./client
docker build -t <SERVER_IMAGE_NAME>:latest -t <SERVER_IMAGE_NAME>:$SHA -f ./server/Dockerfile ./server
docker push <CLIENT_IMAGE_NAME>:latest
docker push <SERVER_IMAGE_NAME>:latest

docker push <CLIENT_IMAGE_NAME>:$SHA
docker push <SERVER_IMAGE_NAME>:$SHA

kubectl apply -f k8s
kubectl set image deployments/multi-docker-server-deployment multi-docker-server=<SERVER_IMAGE_NAME>:$SHA
kubectl set image deployments/multi-docker-client-deployment multi-docker-client=<CLIENT_IMAGE_NAME>:$SHA