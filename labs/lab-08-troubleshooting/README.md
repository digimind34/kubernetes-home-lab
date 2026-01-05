
---

# 📁 LAB-08 — Kubernetes Troubleshooting

```md
# LAB-08 — Kubernetes Troubleshooting

## 🎯 Objective
Develop a structured approach to diagnosing and resolving Kubernetes workload failures.

## 🧠 Concepts Covered
- CrashLoopBackOff
- ImagePullBackOff
- Pending Pods
- Events & logs
- Resource misconfiguration

## 🏗 Troubleshooting Flow
![Kubernetes Troubleshooting Flow](./diagrams/troubleshooting-flow.png)

## 🧪 Troubleshooting Methodology
1. Check pod status
2. Inspect pod events
3. Analyze logs
4. Validate YAML configuration
5. Fix and redeploy

## 🔍 Core Commands
```bash
kubectl get pods
kubectl describe pod <pod-name>
kubectl logs <pod-name>
kubectl get events --sort-by=.metadata.creationTimestamp
