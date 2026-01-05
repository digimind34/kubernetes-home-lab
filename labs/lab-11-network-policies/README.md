
---

# 📁 LAB-11 — Network Policies (Zero Trust)

```md
# LAB-11 — Network Policies (Zero Trust)

## 🎯 Objective
Control pod-level traffic using Kubernetes Network Policies.

## 🧠 Concepts Covered
- Default deny
- Namespace isolation
- Label-based access control

## 🏗 Network Policy Model
![Network Policy](./diagrams/network-policy.png)

## 🧪 Steps Performed
1. Deploy multiple pods
2. Apply deny-all policy
3. Explicitly allow required traffic
4. Validate blocked and allowed flows

## 🔍 Validation
```bash
kubectl exec pod-a -- curl pod-b
✅ Outcome

Implemented Zero Trust networking

Gained deep understanding of pod-level security

🧩 Real-World Use Case

Used in regulated environments and secure multi-tenant clusters.
