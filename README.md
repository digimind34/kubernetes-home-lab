# Kubernetes Home Lab 🚀

md
An end-to-end Kubernetes home lab showcasing **real-world DevOps and Cloud Engineering skills** — from cluster bootstrap to production-style application deployments, networking, security, and troubleshooting.

This project reflects hands-on experience with **how Kubernetes behaves in practice**, not just theory.

---
📂 **Detailed lab documentation:**  
➡️ [View Labs Index](labs/README.md)

## 🧱 Architecture Overview

**Cluster Topology**
- 1 × Control Plane (kubeadm)
- 3 × Worker Nodes
- Ubuntu Linux (VM-based home lab)

**Core Components**
- Container Runtime: Docker
- CNI: Calico
- Service Exposure: ClusterIP, NodePort, MetalLB (LoadBalancer)
- Workloads: Python (Flask), Java (Spring Boot)

> The lab intentionally mirrors on-prem and cloud-native Kubernetes patterns used in production environments.

---

## 🛠️ Environment

- Kubernetes (kubeadm)
- Ubuntu Linux
- Docker
- Calico CNI
- MetalLB
- Python (Flask)
- Java (Spring Boot)

---

## 🧪 Labs Overview

| Lab | Topic |
|----|------|
| LAB 01 | Cluster Setup (kubeadm + Calico) |
| LAB 02 | Namespaces |
| LAB 03 | Pods |
| LAB 04 | ReplicaSets |
| LAB 05 | Deployments |
| LAB 06 | Services (ClusterIP, NodePort) |
| LAB 07 | Networking & DNS |
| LAB 08 | Troubleshooting |
| LAB 09 | HPA |
| LAB 10 | ConfigMaps & Secrets |
| LAB 11 | Network Policies |
| LAB 12 | RBAC & ServiceAccounts |
| LAB 13 | Smart YAML Practices |
| LAB 14 | Python App Deployment |
| LAB 15 | Python Service Exposure |
| LAB 16 | Flask Production Setup |
| LAB 17 | Spring Boot on Kubernetes |
| LAB 18 | Prometheus Monitoring & Troubleshooting on Kubernetes |
🔗 Full lab breakdown and documentation:  
➡️ [Go to labs/README.md](labs/README.md)

📂 Each lab includes:
- YAML manifests
- Commands executed
- Observed behavior
- Troubleshooting notes

---

## 🎯 Objective

Demonstrate **production-ready Kubernetes skills** aligned with:
- DevOps Engineer
- Platform Engineer
- Cloud Engineer roles

Focus areas:
- Cluster operations
- Networking & traffic flow
- Security & access control
- Application lifecycle management
- Debugging real failures

---

## 🧠 Key Challenges Solved

- Kubernetes networking misconfiguration (CNI, services, DNS)
- CrashLoopBackOff and pod-level debugging
- RBAC permission design and enforcement
- Safe exposure of services using MetalLB
- Horizontal Pod Autoscaling behavior under load
- YAML structure and maintainability at scale

---

## 📌 Status

- ✅ All labs completed
- ✅ YAML manifests included
- ✅ Troubleshooting documented
- 🔄 Cloud mapping (EKS) in progress

---

## ☁️ Cloud Readiness (Next Phase)

This lab is designed to map cleanly to managed Kubernetes platforms:
- AWS EKS
- Azure AKS
- Google GKE

Upcoming work:
- EKS cluster migration
- Helm chart packaging
- GitHub Actions CI/CD
- Observability (Prometheus + Grafana)

---

## 📎 Notes

This repository is part of a broader DevOps learning and portfolio journey, emphasizing **practical system understanding**, not just passing certifications.
