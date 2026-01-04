LAB 06 — Services (ClusterIP, NodePort, LoadBalancer)
Overview

Kubernetes Services provide a stable network identity for Pods. Because Pods are ephemeral (they can die and be recreated with new IPs), Services act as a reliable access layer that routes traffic to healthy Pods using labels.

In this lab, you will work with:

ClusterIP (internal-only access)

NodePort (external access via node IPs)

LoadBalancer (cloud-style access, simulated in lab)

Why Services Are Needed (Visual Intuition)
<p align="center">
  <img src="images/services-intuition.png" width="750" alt="Why Kubernetes Services Are Needed">
</p>

<p align="center">
  <img src="images/Why Kubernetes Services Are Needed.png" width="700" alt="Why Kubernetes Services Are Needed">
</p>

Key idea:
Clients never talk to Pods directly — they talk to Services, and Kubernetes handles routing.

Objectives

 Understand why Services exist

 Create and test a ClusterIP Service

 Expose an app using NodePort

 Understand LoadBalancer behavior

 Verify service-to-pod traffic flow

 Troubleshoot common Service issues

Prerequisites

Kubernetes cluster running

Completed LAB 05 (Deployments)

A running Deployment with labels

kubectl configured

Lab Files

manifests/ — Service YAML files

notes/ — test commands and outputs

screenshots/ — optional proof

Step 1 — Confirm existing Deployment

We’ll reuse the Deployment from LAB 05.

kubectl get deploy
kubectl get pods --show-labels


Ensure:

Deployment exists

Pods have labels (e.g. app=nginx)

Step 2 — ClusterIP Service (internal access)
What ClusterIP means

Default Service type

Only accessible inside the cluster

Used for internal microservice communication

Create ClusterIP Service

manifests/nginx-clusterip.yaml

apiVersion: v1
kind: Service
metadata:
  name: nginx-clusterip
spec:
  type: ClusterIP
  selector:
    app: nginx
  ports:
    - port: 80
      targetPort: 80


Apply:

kubectl apply -f manifests/nginx-clusterip.yaml
kubectl get svc


Expected:

Service has a ClusterIP

No external IP

Test ClusterIP (inside cluster)
kubectl run testbox --rm -it --image=busybox -- /bin/sh


Inside the pod:

wget -qO- http://nginx-clusterip
exit


Expected:

HTML response from nginx

Step 3 — NodePort Service (external access via node)
What NodePort means

Exposes service on every node’s IP

Uses a port in range 30000–32767

Common for labs and testing

Create NodePort Service

manifests/nginx-nodeport.yaml

apiVersion: v1
kind: Service
metadata:
  name: nginx-nodeport
spec:
  type: NodePort
  selector:
    app: nginx
  ports:
    - port: 80
      targetPort: 80
      nodePort: 30080


Apply:

kubectl apply -f manifests/nginx-nodeport.yaml
kubectl get svc nginx-nodeport

Test NodePort (from host)
curl http://<NODE-IP>:30080


Expected:

nginx welcome page

Step 4 — LoadBalancer Service (cloud-style access)
What LoadBalancer means

Requests an external load balancer

Standard in cloud environments (AWS ELB, Azure LB, GCP LB)

In labs, usually simulated (e.g., MetalLB)

Create LoadBalancer Service

manifests/nginx-loadbalancer.yaml

apiVersion: v1
kind: Service
metadata:
  name: nginx-loadbalancer
spec:
  type: LoadBalancer
  selector:
    app: nginx
  ports:
    - port: 80
      targetPort: 80


Apply:

kubectl apply -f manifests/nginx-loadbalancer.yaml
kubectl get svc nginx-loadbalancer


Expected:

EXTERNAL-IP pending (or assigned if MetalLB/cloud exists)

Step 5 — Understand traffic flow (conceptual)

Traffic path:

Client → Service → kube-proxy → Pod


Kubernetes handles:

Load balancing

Pod replacement

Health-based routing

Verification
kubectl get svc
kubectl describe svc nginx-clusterip
kubectl describe svc nginx-nodeport
kubectl describe svc nginx-loadbalancer


Checklist:

 ClusterIP reachable internally

 NodePort reachable externally

 LoadBalancer created successfully

 Services route traffic to Pods

Troubleshooting Notes
Issue: Service not routing traffic

Cause: Selector doesn’t match pod labels
Fix:

kubectl get pods --show-labels
kubectl describe svc <service>

Issue: NodePort not accessible

Cause: Firewall or wrong node IP
Fix:

Verify node IP

Check security groups / firewall rules

Issue: LoadBalancer EXTERNAL-IP pending

Cause: No cloud provider or MetalLB
Explanation: Expected behavior in bare-metal labs

Cleanup
kubectl delete svc nginx-clusterip nginx-nodeport nginx-loadbalancer

Key Takeaways

Services abstract Pod IPs

ClusterIP is internal-only

NodePort exposes via node IP

LoadBalancer integrates with cloud networking

Services are core to microservice communication
