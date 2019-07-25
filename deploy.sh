docker build -t aandito/multi-client:latest -t aandito/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aandito/multi-server:latest -t aandito/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t aandito/multi-worker:latest -t aandito/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push aandito/multi-client:latest
docker push aandito/multi-server:latest
docker push aandito/multi-worker:latest

docker push aandito/multi-client:$SHA
docker push aandito/multi-server:$SHA
docker push aandito/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=aandito/multi-server:$SHA
kubectl set image deployments/client-deployment client=aandito/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=aandito/multi-worker:$SHA