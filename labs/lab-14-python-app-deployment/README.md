# LAB-14 — Python App Deployment

## 🎯 Objective
Deploy a containerized Python application to Kubernetes.

## 🧠 Stack
- Python
- Docker
- Kubernetes Deployment & Service

## 🏗 Architecture
![Python App on Kubernetes](./diagrams/python-app.png)

## 🧪 Steps Performed
1. Build Docker image
2. Push to registry
3. Deploy to Kubernetes
4. Validate application access

## 🔍 Validation
```bash
kubectl get pods
kubectl logs <pod>


✅ Outcome

Successfully ran Python workload on Kubernetes

Understood container lifecycle

🧩 Real-World Use Case

Foundation for backend microservices.
