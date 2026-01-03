# LAB 09 — Hpa

## Overview
Briefly describe what this lab teaches and why it matters in real environments.

## Objectives
- [ ] Objective 1
- [ ] Objective 2
- [ ] Objective 3

## Prerequisites
- Kubernetes cluster ready (kubeadm + CNI)
- kubectl configured (`kubectl get nodes`)
- (Optional) Docker registry access if pushing images

## Lab Files
- `manifests/` — YAML manifests used in this lab
- `notes/` — extra notes, outputs, and command logs
- `screenshots/` — optional proof screenshots

## Steps
> Add commands exactly as you ran them, with short explanations.

### Step 1 — (Title)
```bash
# command here
```
Expected result:
- …

### Step 2 — (Title)
```bash
# command here
```
Expected result:
- …

## Verification
```bash
kubectl get all -A
```

Checklist:
- [ ] Resources created successfully
- [ ] Pods are Running/Ready
- [ ] Service reachable (if applicable)

## Troubleshooting Notes
Common issues you hit and how you solved them:
- **Symptom:** …
  - **Cause:** …
  - **Fix:** …

Useful commands:
```bash
kubectl get events -A --sort-by=.metadata.creationTimestamp
kubectl describe pod <pod>
kubectl logs <pod> --previous
```

## Cleanup (Optional)
```bash
# delete resources here
```

## Key Takeaways
- Bullet point learning 1
- Bullet point learning 2
- Bullet point learning 3
