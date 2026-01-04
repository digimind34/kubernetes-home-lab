# LAB 05 — Deployments

## Overview
A **Deployment** is the most commonly used Kubernetes workload object. It manages **ReplicaSets**, enables **rolling updates**, supports **rollbacks**, and ensures **zero-downtime application changes** when configured correctly.

In real production environments, engineers almost always interact with **Deployments**, not Pods or ReplicaSets directly.

---

## Objectives
- [ ] Understand what a Deployment is and why it’s used
- [ ] Create and inspect a Deployment
- [ ] Perform rolling updates
- [ ] Roll back to a previous version
- [ ] Scale applications safely
- [ ] Understand Deployment strategies and revision history

---

## Prerequisites
- Kubernetes cluster running
- `kubectl` configured
- Understanding of Pods (LAB 03)
- Understanding of ReplicaSets (LAB 04)

---

## Lab Files
- `manifests/` — Deployment YAML files
- `notes/` — outputs and observations
- `screenshots/` — optional proof

---

## Step 1 — Inspect existing Deployments
Check for any existing deployments:

```bash
kubectl get deploy
Across all namespaces:

kubectl get deploy -A


Expected:

Likely none in default unless created earlier

Step 2 — Create a Deployment (declarative YAML)

Create the manifest:

manifests/nginx-deploy.yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deploy
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 1
      maxSurge: 1
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx
          image: nginx:1.25
          ports:
            - containerPort: 80


Apply it:

kubectl apply -f manifests/nginx-deploy.yaml


Verify:

kubectl get deploy
kubectl get rs
kubectl get pods


Expected:

Deployment created

One ReplicaSet created

3 pods running

Step 3 — Inspect Deployment details

Describe the Deployment:

kubectl describe deploy nginx-deploy


Observe:

Desired vs available replicas

Strategy type

Events showing rollout progress

Step 4 — Observe rolling update behavior

Update the container image:

kubectl set image deploy/nginx-deploy nginx=nginx:1.26


Watch rollout live:

kubectl rollout status deploy/nginx-deploy


Check ReplicaSets:

kubectl get rs


Expected:

New ReplicaSet created

Old ReplicaSet scaled down gradually

No downtime during update

Step 5 — Check revision history

View Deployment history:

kubectl rollout history deploy/nginx-deploy


Expected:

Multiple revisions listed

Each corresponds to a configuration change

Step 6 — Roll back to a previous version

Roll back to the previous revision:

kubectl rollout undo deploy/nginx-deploy


Verify:

kubectl rollout status deploy/nginx-deploy
kubectl get pods


Expected:

Pods recreated using the previous image version

Step 7 — Scale the Deployment

Scale replicas manually:

kubectl scale deploy nginx-deploy --replicas=5
kubectl get pods


Scale down:

kubectl scale deploy nginx-deploy --replicas=2
kubectl get pods


Expected:

Pods increase or decrease without restarting the Deployment

Step 8 — Simulate a failed rollout

Set an invalid image:

kubectl set image deploy/nginx-deploy nginx=nginx:invalid


Watch rollout:

kubectl rollout status deploy/nginx-deploy


Expected:

Rollout stalls or fails

Pods show ImagePullBackOff

Check:

kubectl get pods
kubectl describe pod <pod>

Step 9 — Recover from a bad deployment

Undo the failed rollout:

kubectl rollout undo deploy/nginx-deploy
kubectl rollout status deploy/nginx-deploy


This demonstrates safe rollback in production scenarios.

Verification

Run:

kubectl get deploy
kubectl get rs
kubectl get pods


Checklist:

 Deployment exists and is available

 Rolling updates work

 Rollback restores previous version

 Scaling works without downtime

Troubleshooting Notes
Issue: Deployment stuck in Progressing

Cause: New pods failing readiness
Fix:

kubectl describe deploy nginx-deploy
kubectl get pods
kubectl logs <pod>

Issue: Multiple ReplicaSets active

Cause: Previous revisions retained
Fix: Normal behavior; controlled by Deployment

Issue: Pods recreated unexpectedly

Explanation: Deployment enforces desired state

Cleanup

Delete the Deployment and all managed resources:

kubectl delete deploy nginx-deploy


Verify:

kubectl get deploy
kubectl get rs
kubectl get pods

Key Takeaways

Deployments manage ReplicaSets and Pods

Rolling updates enable zero-downtime changes

Rollbacks are fast and safe

Deployments are the standard workload object in Kubernetes
