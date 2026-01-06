# LAB 18 — Prometheus Monitoring & Troubleshooting on Kubernetes

## Overview
This lab documents the complete process of installing, validating, and troubleshooting
Prometheus in a Kubernetes home lab. It focuses on real-world monitoring issues and
production-style fixes.

---

## Objectives
- Install Prometheus in Kubernetes
- Verify Prometheus targets
- Troubleshoot target discovery issues
- Fix kube-proxy and node metrics problems
- Understand Prometheus scrape mechanics

---

## Tools & Stack
- Kubernetes (kubeadm cluster)
- Prometheus
- Node Exporter
- kubectl
- YAML manifests

---

## Installation Summary
- Created monitoring namespace
- Deployed Prometheus manifests
- Exposed Prometheus UI
- Verified services and pods

```bash
kubectl get pods -n monitoring
kubectl get svc -n monitoring


Troubleshooting Scenarios
Issue 1: Prometheus Targets DOWN

Root Cause

Metrics endpoints not exposed

Resolution

Updated kube-proxy ConfigMap

Enabled metricsBindAddress

Issue 2: kube-proxy Metrics Not Reachable

Fix Applied

metricsBindAddress: 0.0.0.0:10249


Restarted kube-proxy pods to apply changes.

Validation

Prometheus UI accessible

All targets reporting UP

Metrics scraping confirmed

Key Learnings

Monitoring failures are often configuration-related

Kubernetes metrics endpoints are not always enabled by default

Prometheus troubleshooting requires understanding service discovery

Status

✅ Completed
