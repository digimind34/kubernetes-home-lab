# LAB-17 — Spring Boot on Kubernetes

## 🎯 Objective
Deploy a Java Spring Boot application to Kubernetes.

## 🧠 Stack
- Java 17
- Spring Boot
- Docker
- Kubernetes
- LoadBalancer (MetalLB)

## 🏗 Architecture
![Spring Boot on Kubernetes](./diagrams/springboot-k8s.png)

## 🧪 Steps Performed
1. Build JAR using Maven
2. Create Docker image
3. Deploy using Kubernetes manifests
4. Expose via LoadBalancer

## 🔍 Validation
```bash
kubectl get svc
curl http://<EXTERNAL-IP>
