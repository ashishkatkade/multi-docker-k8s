docker build -t ashishkatkade/multi-client:latest -t ashishkatkade/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ashishkatkade/multi-server:latest -t ashishkatkade/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ashishkatkade/multi-worker:latest -t ashishkatkade/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ashishkatkade/multi-client:latest
docker push ashishkatkade/multi-server:latest
docker push ashishkatkade/multi-worker:latest

docker push ashishkatkade/multi-client:$SHA
docker push ashishkatkade/multi-server:$SHA
docker push ashishkatkade/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ashishkatkade/multi-server:$SHA
kubectl set image deployments/client-deployment client=ashishkatkade/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ashishkatkade/multi-worker:$SHA