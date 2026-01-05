# LAB-07 — Kubernetes Networking & DNS

## 🎯 Objective
Understand how networking works inside a Kubernetes cluster, including pod-to-pod communication, services, DNS resolution, and CNI behavior.

## 🧠 Concepts Covered
- Pod-to-Pod Networking
- ClusterIP Services
- kube-proxy
- CoreDNS
- CNI (Calico)
- Service discovery

## 🏗 Architecture Overview
![Kubernetes Networking & DNS](./diagrams/networking-dns-flow.png)

## 📂 Files
- pod-a.yaml
- pod-b.yaml
- service.yaml

## 🧪 Steps Performed
1. Deploy multiple pods in the same namespace
2. Expose pods using a ClusterIP service
3. Test pod-to-pod communication
4. Validate DNS-based service discovery

## 🔍 Validation Commands
```bash
kubectl exec pod-a -- curl http://service-name
kubectl exec pod-a -- nslookup service-name
