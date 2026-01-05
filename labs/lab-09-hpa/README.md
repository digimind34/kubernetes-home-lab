
---

# 📁 LAB-09 — Horizontal Pod Autoscaler (HPA)

```md
# LAB-09 — Horizontal Pod Autoscaler (HPA)

## 🎯 Objective
Implement automatic scaling of applications based on resource usage.

## 🧠 Concepts Covered
- Metrics Server
- CPU-based autoscaling
- Resource requests & limits
- HPA controller

## 🏗 Scaling Architecture
![HPA Scaling](./diagrams/hpa-scaling.png)

## 📂 Files
- deployment.yaml
- hpa.yaml
- load-generator.yaml

## 🧪 Steps Performed
1. Deploy application with resource requests
2. Enable Metrics Server
3. Create HPA object
4. Generate load to trigger scaling

## 🔍 Validation
```bash
kubectl get hpa
kubectl top pods
