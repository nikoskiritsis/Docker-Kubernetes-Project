# Docker-Kubernetes-Project
**Step 1: Dockerize Application**  
I cloned my own repository, in its earlier version (only app.py file present):   
* Create requirements.txt file   
* Create Dockerfile

Build image <docker_hub_username>/<application_name>   
Push image <docker_hub_username>/<application_name>   
```bat
git clone https://github.com/nikoskiritsis/Docker-Kubernetes-Project.git
sudo docker build -t nikosk598/python-redis-sql .
sudo docker push nikosk598/python-redis-sql
```
**Step 2: Kubernetes orchestration**   
* Start minikube   
```bat
minikube start
```
* Create Pods and Services   
```bat
kubectl create -f db-pod.yml
kubectl create -f db-svc.yml
kubectl create -f web-pod-1.yml
kubectl create -f web-svc.yml
```
* Check that Pods and Services are Running   
```bat
kubectl get pods
kubectl get svc
```
* Get the IP address of the Nodes (minikube)   
```bat
kubectl get nodes -o wide
```
* Get NodePort and insert them into variables   
```bat
kubectl describe svc web
export NODE_IP=<NODE_IP>
export NODE_PORT=<NODE_PORT>
```
* Initialize database
```bat
curl http://$NODE_IP:$NODE_PORT/init
```
* Insert data
```bat
curl -i -H "Content-Type: application/json" -X POST -d '{"uid": "1", "user":"Nikos Papadopoulos"}' http://$NODE_IP:$NODE_PORT/users/add
curl -i -H "Content-Type: application/json" -X POST -d '{"uid": "2", "user":"Ioannis Malgaris"}' http://$NODE_IP:$NODE_PORT/users/add
```
* Access the data   
```bat
curl http://$NODE_IP:$NODE_PORT/users/1
```
* Create Replica sets to check the data   
```bat
kubectl create -f web-rc.yml
curl http://$NODE_IP:$NODE_PORT/users/1
```
