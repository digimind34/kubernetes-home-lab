
---

# 📁 LAB-10 — ConfigMaps & Secrets

```md
# LAB-10 — ConfigMaps & Secrets

## 🎯 Objective
Externalize configuration and sensitive data from container images.

## 🧠 Concepts Covered
- ConfigMaps
- Secrets
- Environment variables
- Volume mounts

## 🏗 Configuration Injection
![ConfigMaps & Secrets](./diagrams/configmaps-secrets.png)

## 🧪 Steps Performed
1. Create ConfigMap for app configuration
2. Create Secret for sensitive data
3. Inject data via env vars and volumes
4. Validate application behavior

## 🔍 Validation
```bash
kubectl describe pod <pod-name>
kubectl exec <pod> -- env

✅ Outcome

Clean separation of config from code

Improved security and portability

🧩 Real-World Use Case

Mandatory for secure, environment-agnostic deployments.
