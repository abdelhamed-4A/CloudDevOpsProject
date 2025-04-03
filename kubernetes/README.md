# 🚀 Deploying a Java Web Application on Kubernetes

This project deploys a Java web application to a Kubernetes cluster using a **Deployment**, **Service**, and **Ingress**. The application is containerized and accessible via a custom domain (`myapp.ivolve.com`) through an **NGINX Ingress Controller**.

---
## 📌 Prerequisites

Ensure you have the following installed:
- 🏗 **Minikube** – Local Kubernetes cluster
- 🔧 **kubectl** – Kubernetes CLI tool
- 🐳 **Docker** – For containerization
- 🌐 **NGINX Ingress Controller** – For traffic routing

---
## 📂 Project Structure

```
kubernetes/
├── deployment.yaml    # Defines the Java app deployment
├── service.yaml       # Exposes the app within the cluster
└── ingress.yaml       # Routes external traffic to the app
```

---
## 🚀 Deployment Steps

### 🔹 1. Start Minikube
Ensure Minikube is running:
```bash
minikube start
```

### 🔹 2. Enable NGINX Ingress Controller
Enable the Ingress addon:
```bash
minikube addons enable ingress
```
Verify:
```bash
kubectl get pods -n ingress-nginx
```

### 🔹 3. Create a Namespace
Create a dedicated namespace:
```bash
kubectl create namespace ivolve
```
Verify:
```bash
kubectl get namespaces
```

### 🔹 4. Deploy the Application
Apply the deployment manifest:
```bash
kubectl apply -f deployment.yaml
```
Check pod status:
```bash
kubectl get pods -n ivolve
```

### 🔹 5. Expose the Application
Apply the service configuration:
```bash
kubectl apply -f service.yaml
```
Verify:
```bash
kubectl get svc -n ivolve
```

### 🔹 6. Configure Ingress
Apply the Ingress resource to route traffic:
```bash
kubectl apply -f ingress.yaml
```
Check Ingress:
```bash
kubectl get ingress -n ivolve
```

### 🔹 7. Update Hosts File
Get Minikube IP:
```bash
minikube ip
```
Update `/etc/hosts`:
```bash
sudo nano /etc/hosts
```
Add:
```
<minikube-ip> myapp.ivolve.com
```
Example:
```
192.168.49.2 myapp.ivolve.com
```

### 🔹 8. Test the Application
Test with `curl`:
```bash
curl http://myapp.ivolve.com
```
Or open in a browser:
```
http://myapp.ivolve.com
```

---
## 📜 Kubernetes Manifests

### 🔹 `deployment.yaml`
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app-deployment
  namespace: ivolve
spec:
  replicas: 2
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
      - name: myapp
        image: abdelhamed4a/java-web-app:v1
        ports:
        - containerPort: 8081
```

### 🔹 `service.yaml`
```yaml
apiVersion: v1
kind: Service
metadata:
  name: app-service
  namespace: ivolve
spec:
  selector:
    app: myapp
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8081
  type: ClusterIP
```

### 🔹 `ingress.yaml`
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: app-ingress
  namespace: ivolve
  annotations:
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  ingressClassName: nginx
  rules:
  - host: myapp.ivolve.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: app-service
            port:
              number: 80
```

---
## 🛠 Troubleshooting

| Issue                     | Solution |
|---------------------------|----------------------------------|
| **Pods Not Running**      | Check logs: `kubectl logs <pod-name> -n ivolve-namespace` |
| **Ingress Not Working**   | Ensure NGINX is running: `kubectl get pods -n ingress-nginx` |
| **curl Fails**            | Verify DNS resolution: `ping java-app.example.com` |
| **Service Connectivity**  | Test with port forwarding: `kubectl port-forward svc/java-app-service -n ivolve-namespace 8081:80` |

🎯 **Congratulations! Your Java web application is now running on Kubernetes!** 🚀

