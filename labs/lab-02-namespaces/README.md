# LAB 02 — Namespaces

## Overview
Namespaces are a Kubernetes feature used to **logically isolate resources** inside the same cluster. They are commonly used to separate environments (dev/test/prod), teams, or applications, and to apply policies like RBAC, quotas, and network policies per namespace.

---

## Objectives
- [ ] Understand what namespaces are and why they matter
- [ ] Create and manage namespaces
- [ ] Deploy resources into a specific namespace
- [ ] Use context switching to avoid repeating `-n`
- [ ] Verify and troubleshoot namespace-scoped resources

---

## Prerequisites
- Working Kubernetes cluster
- `kubectl` configured (you can run `kubectl get nodes`)
- Access to create namespaces (cluster-admin in a lab)

---

## Lab Files
- `manifests/` — YAML manifests used in this lab
- `notes/` — command logs / outputs
- `screenshots/` — optional screenshots for proof

---

## Step 1 — View existing namespaces
```bash
kubectl get ns

Expected:

You should see common defaults like default, kube-system, kube-public (and possibly kube-node-lease).

Step 2 — Create a namespace

Create a dedicated namespace for this lab:

kubectl create ns lab-02
kubectl get ns | grep lab-02


Expected:

lab-02 appears in the namespaces list.

Step 3 — Describe a namespace (useful for debugging)
kubectl describe ns lab-02


What to look for:

Status: Active

Labels/Annotations (optional)

Resource quotas / limit ranges (if any are applied later)

Step 4 — Deploy a pod into the namespace (imperative)
kubectl run nginx --image=nginx:stable --restart=Never -n lab-02
kubectl get pod -n lab-02


Expected:

nginx pod shows Running.

Optional deeper check:

kubectl describe pod nginx -n lab-02
kubectl logs nginx -n lab-02

Step 5 — Verify isolation (same command, different namespaces)

Check default namespace:

kubectl get pod


Expected:

The nginx pod should NOT appear here.

Check lab-02 again:

kubectl get pod -n lab-02


Expected:

You see nginx only in lab-02.

Step 6 — Create a deployment in the namespace (declarative YAML)

Create a file:

manifests/nginx-deploy.yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deploy
  namespace: lab-02
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx-deploy
  template:
    metadata:
      labels:
        app: nginx-deploy
    spec:
      containers:
        - name: nginx
          image: nginx:stable
          ports:
            - containerPort: 80


Apply:

kubectl apply -f manifests/nginx-deploy.yaml
kubectl get deploy,pod -n lab-02


Expected:

Deployment nginx-deploy created

Two pods Running

Step 7 — Namespace context switching (avoid repeating -n)

Set your current context namespace to lab-02:

kubectl config set-context --current --namespace=lab-02
kubectl config view --minify | grep namespace


Now try without -n:

kubectl get pod
kubectl get deploy


Expected:

Commands operate inside lab-02 by default.

Return to default when done:

kubectl config set-context --current --namespace=default

Verification

Run these checks:

kubectl get ns
kubectl get all -n lab-02
kubectl get pod -o wide -n lab-02


Checklist:

 Namespace lab-02 exists and is Active

 nginx pod running in lab-02

 nginx-deploy deployment running 2 replicas in lab-02

 Default namespace doesn’t show lab-02 resources

Troubleshooting Notes
Issue: Error from server (Forbidden): namespaces is forbidden

Cause: Your kubeconfig user doesn’t have cluster-admin privileges
Fix: Use a cluster-admin context or update RBAC (covered later in LAB 12).

Issue: Pod stuck in ImagePullBackOff

Cause: Image name typo or network/DNS issue
Fix:

kubectl describe pod <pod> -n lab-02
kubectl get events -n lab-02 --sort-by=.metadata.creationTimestamp

Issue: Resources created in the wrong namespace

Cause: Context namespace not set (or YAML missing metadata.namespace)
Fix:

Always confirm:

kubectl config view --minify | grep namespace


Add metadata.namespace: lab-02 in YAML files

Cleanup (Optional)

Delete resources and the namespace:

kubectl delete pod nginx -n lab-02 --ignore-not-found
kubectl delete deploy nginx-deploy -n lab-02 --ignore-not-found
kubectl delete ns lab-02 --ignore-not-found

Key Takeaways

Namespaces are logical partitions inside a cluster

Most resources are namespace-scoped; some are cluster-scoped (nodes, namespaces)

Context switching prevents mistakes and speeds up workflows

Namespaces enable RBAC, quotas, and network policies per environment/team


---

## ✅ Now do this (commands)

1) Open the file:
```bash
nano labs/lab-02-namespaces/README.md


Paste the content above and save.

Create the manifest file:

nano labs/lab-02-namespaces/manifests/nginx-deploy.yaml
