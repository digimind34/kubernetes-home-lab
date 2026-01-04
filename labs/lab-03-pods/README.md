LAB 03 — Pods
Overview

A Pod is the smallest deployable unit in Kubernetes. It represents one or more tightly coupled containers that share networking, storage, and lifecycle. Understanding pods is critical because every workload in Kubernetes ultimately runs inside a pod.

This lab focuses on pod lifecycle, states, debugging, logs, exec access, and failure scenarios—skills used daily by DevOps and Platform Engineers.

Objectives

 Understand what a pod is and how it works

 Create and inspect pods

 Observe pod lifecycle phases

 Debug failing pods (CrashLoopBackOff)

 Access pod logs and containers

 Work with multi-container pods (sidecar pattern)

 Clean up pod resources safely

Prerequisites

Kubernetes cluster running

kubectl configured and working

Familiarity with namespaces (LAB 02)

Ability to create resources in a namespace

Lab Files

manifests/ — Pod YAML manifests

notes/ — logs and outputs

screenshots/ — optional visual proof

Step 1 — Inspect existing pods

Check pods in all namespaces:

kubectl get pods -A


Expected:

System pods running in kube-system

No application pods in default or lab namespaces yet

Step 2 — Create a basic pod (imperative)

Create a simple nginx pod:

kubectl run nginx-pod \
  --image=nginx:stable \
  --restart=Never


Verify:

kubectl get pod nginx-pod


Expected:

Pod status: Running

Step 3 — Inspect pod details

Describe the pod to understand what Kubernetes created:

kubectl describe pod nginx-pod


Key things to observe:

Pod IP

Node placement

Container image

Events at the bottom

Step 4 — Pod lifecycle phases

Check pod phase:

kubectl get pod nginx-pod -o wide


Common pod phases:

Pending

Running

Succeeded

Failed

CrashLoopBackOff (state, not phase)

Step 5 — Access pod logs

Even simple containers produce logs:

kubectl logs nginx-pod


If multiple containers exist:

kubectl logs nginx-pod -c <container-name>

Step 6 — Exec into a pod

Access the container shell:

kubectl exec -it nginx-pod -- /bin/bash


Inside the container:

ls
hostname
exit


This is a core debugging technique in real environments.

Step 7 — Create a pod declaratively (YAML)

Create a manifest:

manifests/pod-nginx.yaml

apiVersion: v1
kind: Pod
metadata:
  name: nginx-yaml
spec:
  containers:
    - name: nginx
      image: nginx:stable
      ports:
        - containerPort: 80


Apply it:

kubectl apply -f manifests/pod-nginx.yaml
kubectl get pod nginx-yaml


Expected:

Pod created and Running

Step 8 — Simulate a failing pod (CrashLoopBackOff)

Create a broken pod:

manifests/pod-fail.yaml

apiVersion: v1
kind: Pod
metadata:
  name: crash-pod
spec:
  containers:
    - name: crash
      image: busybox
      command: ["sh", "-c", "exit 1"]


Apply:

kubectl apply -f manifests/pod-fail.yaml
kubectl get pod crash-pod


Expected:

Status: CrashLoopBackOff

Step 9 — Debug the failing pod

Describe the pod:

kubectl describe pod crash-pod


Check logs:

kubectl logs crash-pod
kubectl logs crash-pod --previous


This is exactly how production pod failures are diagnosed.

Step 10 — Multi-container pod (sidecar pattern)

Create a pod with two containers:

manifests/pod-sidecar.yaml

apiVersion: v1
kind: Pod
metadata:
  name: sidecar-pod
spec:
  containers:
    - name: app
      image: busybox
      command: ["sh", "-c", "while true; do echo app running; sleep 5; done"]
    - name: sidecar
      image: busybox
      command: ["sh", "-c", "while true; do echo sidecar logging; sleep 5; done"]


Apply:

kubectl apply -f manifests/pod-sidecar.yaml
kubectl get pod sidecar-pod


Check logs per container:

kubectl logs sidecar-pod -c app
kubectl logs sidecar-pod -c sidecar

Verification

Run:

kubectl get pods
kubectl get pod -o wide


Checklist:

 nginx-pod Running

 nginx-yaml Running

 crash-pod in CrashLoopBackOff

 sidecar-pod Running with 2 containers

 Logs accessible per container

 Exec works inside containers

Troubleshooting Notes
Issue: Pod stuck in Pending

Cause: Node resource constraints or scheduling issues
Fix:

kubectl describe pod <pod>
kubectl get nodes

Issue: CrashLoopBackOff

Cause: Application exits immediately
Fix:

kubectl logs <pod> --previous
kubectl describe pod <pod>

Issue: Cannot exec into pod

Cause: Container image lacks shell
Fix: Use /bin/sh instead of /bin/bash

Cleanup
kubectl delete pod nginx-pod nginx-yaml crash-pod sidecar-pod --ignore-not-found

Key Takeaways

Pods are the fundamental execution unit in Kubernetes

Containers inside a pod share network and lifecycle

kubectl describe and kubectl logs are primary debugging tools

CrashLoopBackOff is a symptom, not a root cause

Multi-container pods enable sidecar patterns (logging, proxying)
