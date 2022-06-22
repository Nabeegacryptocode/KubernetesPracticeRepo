docker build -t terriwunde/multi-client:latest -t terriwunde/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t terriwunde/multi-worker:latest -t terriwunde/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker build -t terriwunde/multi-server:latest -t terriwunde/multi-server:$SHA -f ./server/Dockerfile ./server

docker push terriwunde/muli-client:latest
docker push terriwunde/muli-worker:latest
docker push terriwunde/muli-server:latest

docker push terriwunde/muli-client:$SHA
docker push terriwunde/muli-server:$SHA
docker push terriwunde/muli-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server: terriwunde/multi-server:$SHA
kubectl set image deployments/client-deployment client: terriwunde/multi-client:$SHA
kubectl set image deployments/worker-deployment worker: terriwunde:multi-worker:$SHA


