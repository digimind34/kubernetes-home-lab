
---

# 📁 LAB-15 — Python Service Exposure

```md
# LAB-15 — Python Service Exposure

## 🎯 Objective
Expose Python applications using Kubernetes Services.

## 🧠 Service Types Covered
- ClusterIP
- NodePort
- LoadBalancer

## 🏗 Exposure Model
![Service Exposure](./diagrams/services.png)

## 🧪 Steps Performed
1. Create NodePort service
2. Test external access
3. Switch service types
4. Validate connectivity

## 🔍 Validation
```bash
curl http://<NODE-IP>:<PORT>


✅ Outcome

Learned service exposure strategies

Compared internal vs external access models

🧩 Real-World Use Case

Required for production APIs and web apps.
