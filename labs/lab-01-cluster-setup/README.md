# LAB 01 — Kubernetes Cluster Setup & Validation

## Overview
This lab documents the setup and validation of a Kubernetes home lab cluster
using kubeadm. It establishes the foundation for all subsequent labs.

## Objectives
- [x] Install container runtime
- [x] Initialize Kubernetes control plane
- [x] Join worker nodes
- [x] Verify cluster health
- [x] Configure kubectl access

## Validation
```bash
kubectl get nodes
kubectl get pods -A
