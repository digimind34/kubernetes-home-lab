## 🚀 Prometheus Installation (kube-prometheus-stack)

This section documents the installation of **Prometheus and Grafana** using the official **kube-prometheus-stack Helm chart**.

### Prerequisites
- Kubernetes cluster (kubeadm-based)
- kubectl configured and working
- Internet access from the control plane node

---

### 🔧 Install Helm

```bash
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-4
chmod 700 get_helm.sh
./get_helm.sh
Verify:

bash
Copy code
helm version
📦 Add Prometheus Helm Repository
bash
Copy code
helm repo add prometheus https://prometheus-community.github.io/helm-charts
helm repo update
Search available charts:

bash
Copy code
helm search repo prometheus | grep -i kube
📊 Install kube-prometheus-stack
bash
Copy code
helm install monitoringstack prometheus/kube-prometheus-stack \
  --namespace monitoring \
  --create-namespace \
  --set prometheus.service.type=NodePort
Note:
NodePort was used for lab access simplicity. In production, LoadBalancer or Ingress is recommended.

🔍 Verify Deployment
Check Prometheus stack pods:

bash
Copy code
kubectl -n monitoring get pods -l "release=monitoringstack"
Verify namespace and resources:

bash
Copy code
kubectl get ns
kubectl get all -n monitoring
🌐 Access Prometheus UI
Retrieve the NodePort:

bash
Copy code
kubectl -n monitoring get svc monitoringstack-kube-prometheus-prometheus
Access Prometheus in browser:

text
Copy code
http://<NODE-IP>:<NODE-PORT>
In cloud environments (e.g., AWS), use the worker node public IP.
In home labs, use the node’s internal IP.
