docker build -t markgaisinsky/multi-client:latest -t markgaisinsky/multi-client:$SHA -f ..client/Dockerfile ./client
docker build -t markgaisinsky/multi-server:latest -t markgaisinsky/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t markgaisinsky/multi-worker:latest -t markgaisinsky/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push markgaisinsky/multi-client:latest
docker push markgaisinsky/multi-worker:latest
docker push markgaisinsky/multi-server:latest

docker push markgaisinsky/multi-client:$SHA
docker push markgaisinsky/multi-worker:$SHA
docker push markgaisinsky/multi-server:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=markgaisinsky/multi-server
kubectl set image deployments/worker-deployment worker=markgaisinsky/multi-worker
kubectl set image deployments/client-deployment client=markgaisinsky/multi-client
