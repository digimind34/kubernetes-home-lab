# Kubernetes Home Lab 
![Kubernetes](https://img.shields.io/badge/Kubernetes-1.33-blue?logo=kubernetes)
![Containerd](https://img.shields.io/badge/Runtime-containerd-blue)
![Calico](https://img.shields.io/badge/CNI-Calico-green)
![MetalLB](https://img.shields.io/badge/LoadBalancer-MetalLB-orange)
![Prometheus](https://img.shields.io/badge/Monitoring-Prometheus-red)
![License](https://img.shields.io/badge/License-MIT-success)

An end-to-end Kubernetes home lab showcasing real-world DevOps and Cloud Engineering skills—from cluster bootstrap to production-style application deployments, networking, security, monitoring, and troubleshooting.

This repository demonstrates practical Kubernetes engineering using kubeadm, containerd, Calico, MetalLB, RBAC, Network Policies, Horizontal Pod Autoscaling (HPA), and Prometheus. It reflects production-oriented practices rather than isolated tutorials.

---
📂 **Detailed lab documentation:**  
➡️ [View Labs Index](labs/README.md)

## 🏗️ Architecture Overview

### Cluster Topology

- **1 Control Plane Node**
- **3 Worker Nodes**
- Ubuntu Linux (VM-based home lab)
- Kubernetes installed with **kubeadm**

### Core Components

| Component | Technology |
|-----------|------------|
| Container Runtime | containerd |
| CNI | Calico |
| Load Balancer | MetalLB |
| DNS | CoreDNS |
| Ingress | Kubernetes Ingress |
| Monitoring | Prometheus |
| Autoscaling | HPA |
| Security | RBAC, Network Policies |
| Workloads | Python Flask, Java Spring Boot |

This architecture mirrors many concepts used in managed Kubernetes platforms such as Amazon EKS, Azure AKS, and Google GKE.
---

## ⚙️ Environment

| Item | Value |
|------|-------|
| OS | Ubuntu Linux |
| Kubernetes | kubeadm |
| Container Runtime | containerd |
| CNI | Calico |
| Load Balancer | MetalLB |
| Monitoring | Prometheus |
| Languages | Python, Java |
| Deployment | kubectl |

---
## 💼 Skills Demonstrated

- Kubernetes Administration
- Cluster Installation with kubeadm
- Pod Lifecycle Management
- Deployments & ReplicaSets
- Kubernetes Services
- Ingress Networking
- ConfigMaps & Secrets
- RBAC & Service Accounts
- Network Policies
- Horizontal Pod Autoscaling (HPA)
- Production Troubleshooting
- Monitoring with Prometheus
- Linux Administration
- Container Operations

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
