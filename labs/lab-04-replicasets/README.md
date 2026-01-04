# LAB 04 — ReplicaSets

## Overview
A **ReplicaSet** ensures that a specified number of identical pod replicas are running at all times. If a pod fails, is deleted, or a node goes down, the ReplicaSet automatically **recreates missing pods**, providing **self-healing** at the pod level.

While ReplicaSets are rarely managed directly in production (Deployments manage them), understanding ReplicaSets is essential to fully grasp **Kubernetes scaling and recovery mechanics**.

---

## Objectives
- [ ] Understand what a ReplicaSet is and why it exists
- [ ] Create and inspect a ReplicaSet
- [ ] Observe automatic pod recreation (self-healing)
- [ ] Scale replicas up and down
- [ ] Understand the relationship between Pods, ReplicaSets, and Deployments

---

## Prerequisites
- Kubernetes cluster running
- `kubectl` configured
- Basic understanding of Pods (LAB 03)
- Access to create resources in the cluster

---

## Lab Files
- `manifests/` — ReplicaSet YAML files
- `notes/` — command outputs and observations
- `screenshots/` — optional visual proof

---

## Step 1 — Inspect existing ReplicaSets
Check if any ReplicaSets already exist:

```bash
kubectl get rs

Expected:

Likely no ReplicaSets in the default namespace unless created earlier by Deployments.

Check across all namespaces:

kubectl get rs -A

Step 2 — Create a ReplicaSet (declarative YAML)

Create the following manifest:

manifests/nginx-rs.yaml

apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: nginx-rs
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx-rs
  template:
    metadata:
      labels:
        app: nginx-rs
    spec:
      containers:
        - name: nginx
          image: nginx:stable
          ports:
            - containerPort: 80


Apply the ReplicaSet:

kubectl apply -f manifests/nginx-rs.yaml


Verify:

kubectl get rs
kubectl get pods


Expected:

ReplicaSet nginx-rs created

3 pods running

Step 3 — Inspect ReplicaSet details

Describe the ReplicaSet:

kubectl describe rs nginx-rs


Observe:

Desired vs Current vs Ready replicas

Pod selector labels

Events at the bottom

Step 4 — Verify ReplicaSet self-healing

Delete one pod manually:

kubectl get pods
kubectl delete pod <one-nginx-rs-pod>


Immediately recheck:

kubectl get pods


Expected:

A new pod is automatically created

Total pods remain 3

This demonstrates self-healing behavior.

Step 5 — Scale the ReplicaSet

Scale replicas up:

kubectl scale rs nginx-rs --replicas=5
kubectl get pods


Expected:

5 pods running

Scale down:

kubectl scale rs nginx-rs --replicas=2
kubectl get pods


Expected:

Only 2 pods remain

Step 6 — Understand label selectors (critical concept)

ReplicaSets manage pods only by labels.

Check pod labels:

kubectl get pods --show-labels


Try changing a pod label:

kubectl label pod <pod-name> app=other --overwrite
kubectl get pods


Expected:

ReplicaSet creates a new pod to maintain replica count

The modified pod is no longer managed by the ReplicaSet

Step 7 — Compare Pods vs ReplicaSets vs Deployments
Object	Purpose
Pod	Runs a single instance of a container
ReplicaSet	Ensures a fixed number of pod replicas
Deployment	Manages ReplicaSets and enables rolling updates

In production, Deployments manage ReplicaSets, not humans.

Verification

Run the following:

kubectl get rs
kubectl get pods
kubectl describe rs nginx-rs


Checklist:

 ReplicaSet exists

 Desired replicas match actual pods

 Pod deletion triggers recreation

 Scaling works as expected

Troubleshooting Notes
Issue: ReplicaSet not creating pods

Cause: Label selector does not match pod template
Fix: Ensure spec.selector.matchLabels matches template.metadata.labels

Issue: Too many or too few pods

Cause: Another controller managing the same labels
Fix:

kubectl get deploy,rs,pod --show-labels

Issue: Pods recreated after manual deletion

Explanation: This is expected behavior — ReplicaSets enforce desired state.

Cleanup

Delete the ReplicaSet and its pods:

kubectl delete rs nginx-rs


Verify:

kubectl get rs
kubectl get pods

Key Takeaways

ReplicaSets provide self-healing and scaling

Pods are ephemeral; ReplicaSets maintain desired state

Label selectors are the core control mechanism

ReplicaSets are usually managed by Deployments in real systems
