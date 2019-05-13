docker build -t ashskywalker10/multi-client:latest -t ashskywalker10/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ashskywalker10/multi-server:latest -t ashskywalker10/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ashskywalker10/multi-worker:latest -t ashskywalker10/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ashskywalker10/multi-client:latest
docker push ashskywalker10/multi-server:latest
docker push ashskywalker10/multi-client:$SHA
docker push ashskywalker10/multi-worker:latest
docker push ashskywalker10/multi-server:$SHA
docker push ashskywalker10/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ashskywalker10/multi-server:$SHA
kubectl set image deployments/client-deployment client=ashskywalker10/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ashskywalker10/multi-worker:$SHA