Prometheus Installation on Kubernetes (LAB-18)

This document covers the end-to-end installation of Prometheus on a Kubernetes cluster using official manifests, followed by validation and access steps.

Lab Objective:
Deploy Prometheus in a Kubernetes cluster, verify all components, and access the Prometheus UI for metrics collection.

📌 Prerequisites

Before starting, ensure the following are in place:

A running Kubernetes cluster (kubeadm, kubeconfig configured)

kubectl access to the cluster

Cluster nodes in Ready state

Internet access to pull container images

Verify cluster status:

kubectl get nodes


Expected output:

NAME         STATUS   ROLES           AGE   VERSION
k8s-master   Ready    control-plane   ...
k8s-worker1  Ready    <none>           ...
k8s-worker2  Ready    <none>           ...

📁 Directory Structure (Recommended)
LAB-18-prometheus/
├── installation.md
├── manifests/
└── troubleshooting.md

🔹 Step 1: Create Namespace for Prometheus

Create a dedicated namespace:

kubectl create namespace monitoring


Verify:

kubectl get namespaces

🔹 Step 2: Create ClusterRole & Permissions

Prometheus needs permission to read metrics from Kubernetes components.

Apply the ClusterRole:

kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/kube-prometheus/main/manifests/setup/prometheus-operator-0clusterRole.yaml


This grants access to:

Nodes

Pods

Services

Endpoints

Metrics APIs

🔹 Step 3: Create ConfigMap (prometheus.yml)

Create a ConfigMap containing Prometheus scrape configuration.

Create a file:

nano prometheus-config.yaml


Paste the following:

apiVersion: v1
kind: ConfigMap
metadata:
  name: prometheus-config
  namespace: monitoring
data:
  prometheus.yml: |
    global:
      scrape_interval: 15s
      evaluation_interval: 15s

    scrape_configs:
      - job_name: "kubernetes-nodes"
        kubernetes_sd_configs:
          - role: node
        relabel_configs:
          - action: labelmap
            regex: __meta_kubernetes_node_label_(.+)

      - job_name: "kubernetes-pods"
        kubernetes_sd_configs:
          - role: pod

      - job_name: "kubernetes-services"
        kubernetes_sd_configs:
          - role: service


Apply it:

kubectl apply -f prometheus-config.yaml


Verify:

kubectl get configmap -n monitoring

🔹 Step 4: Create Prometheus Deployment

Create the deployment manifest:

nano prometheus-deployment.yaml


Paste:

apiVersion: apps/v1
kind: Deployment
metadata:
  name: prometheus
  namespace: monitoring
spec:
  replicas: 1
  selector:
    matchLabels:
      app: prometheus
  template:
    metadata:
      labels:
        app: prometheus
    spec:
      containers:
        - name: prometheus
          image: prom/prometheus:v2.49.0
          args:
            - "--config.file=/etc/prometheus/prometheus.yml"
            - "--storage.tsdb.path=/prometheus"
            - "--web.enable-lifecycle"
          ports:
            - containerPort: 9090
          volumeMounts:
            - name: config-volume
              mountPath: /etc/prometheus
            - name: storage-volume
              mountPath: /prometheus
      volumes:
        - name: config-volume
          configMap:
            name: prometheus-config
        - name: storage-volume
          emptyDir: {}


Apply:

kubectl apply -f prometheus-deployment.yaml

🔹 Step 5: Create Prometheus Service

Expose Prometheus using NodePort (for lab access):

nano prometheus-service.yaml


Paste:

apiVersion: v1
kind: Service
metadata:
  name: prometheus-service
  namespace: monitoring
spec:
  type: NodePort
  selector:
    app: prometheus
  ports:
    - port: 9090
      targetPort: 9090
      nodePort: 30090


Apply:

kubectl apply -f prometheus-service.yaml

🔹 Step 6: Verify Deployment

Check pods:

kubectl get pods -n monitoring


Expected:

prometheus-xxxxxx   1/1   Running


Check service:

kubectl get svc -n monitoring

🔹 Step 7: Access Prometheus UI

Open a browser and navigate to:

http://<NODE-IP>:30090


Prometheus UI should load successfully.

🔹 Step 8: Validate Targets

In the Prometheus UI:

Go to Status → Targets

Confirm:

kubernetes-nodes → UP

kubernetes-pods → UP

kubernetes-services → UP

🔍 Validation Commands
kubectl logs -n monitoring deploy/prometheus

kubectl describe pod -n monitoring prometheus-xxxxxx

🧹 Cleanup (Optional)

To remove Prometheus completely:

kubectl delete namespace monitoring

✅ Lab Outcome

✔ Prometheus successfully deployed
✔ Metrics scraped from Kubernetes components
✔ Prometheus UI accessible
✔ Ready for Alertmanager, Grafana, and advanced troubleshooting labs
