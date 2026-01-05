
---

# 📁 LAB-12 — RBAC & ServiceAccounts

```md
# LAB-12 — RBAC & ServiceAccounts

## 🎯 Objective
Secure Kubernetes access using Role-Based Access Control.

## 🧠 Concepts Covered
- Roles & ClusterRoles
- RoleBindings
- ServiceAccounts
- Least privilege principle

## 🏗 RBAC Architecture
![RBAC Flow](./diagrams/rbac-flow.png)

## 🧪 Steps Performed
1. Create ServiceAccount
2. Define role permissions
3. Bind roles to accounts
4. Validate access restrictions

## 🔍 Validation
```bash
kubectl auth can-i get pods --as=system:serviceaccount:default:test-sa
✅ Outcome

Controlled access to cluster resources

Improved security posture

🧩 Real-World Use Case

Critical for multi-team clusters and CI/CD automation.
