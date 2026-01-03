#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="labs"

declare -A LABS=(
  [02]="namespaces"
  [03]="pods"
  [04]="replicasets"
  [05]="deployments"
  [06]="services-clusterip-nodeport"
  [07]="networking-dns"
  [08]="troubleshooting"
  [09]="hpa"
  [10]="configmaps-secrets"
  [11]="network-policies"
  [12]="rbac-serviceaccounts"
  [13]="smart-yaml-practices"
  [14]="python-app-deployment"
  [15]="python-service-exposure"
  [16]="flask-production-setup"
  [17]="spring-boot-on-kubernetes"
)

mkdir -p "$BASE_DIR"

# Build Labs Index
INDEX_FILE="$BASE_DIR/README.md"
{
  echo "# Labs Index"
  echo
  echo "This folder contains LAB 02–LAB 17 documentation, YAML manifests, commands, and troubleshooting notes."
  echo
  echo "## Quick Links"
  echo
  echo "| Lab | Topic | Link |"
  echo "|---:|---|---|"
} > "$INDEX_FILE"

for n in "${!LABS[@]}"; do
  slug="${LABS[$n]}"
  lab_dir="$BASE_DIR/lab-${n}-${slug}"
  mkdir -p "$lab_dir/manifests" "$lab_dir/notes" "$lab_dir/screenshots"

  # Add to index table (always)
  topic="$(echo "$slug" | tr '-' ' ' | sed 's/\b\(.\)/\u\1/g')"
  echo "| LAB ${n} | ${topic} | [Open](lab-${n}-${slug}/README.md) |" >> "$INDEX_FILE"

  readme="$lab_dir/README.md"
  if [[ -f "$readme" ]]; then
    echo "SKIP (exists): $readme"
    continue
  fi

  cat > "$readme" <<EOM
# LAB ${n} — ${topic}

## Overview
Briefly describe what this lab teaches and why it matters in real environments.

## Objectives
- [ ] Objective 1
- [ ] Objective 2
- [ ] Objective 3

## Prerequisites
- Kubernetes cluster ready (kubeadm + CNI)
- kubectl configured (\`kubectl get nodes\`)
- (Optional) Docker registry access if pushing images

## Lab Files
- \`manifests/\` — YAML manifests used in this lab
- \`notes/\` — extra notes, outputs, and command logs
- \`screenshots/\` — optional proof screenshots

## Steps
> Add commands exactly as you ran them, with short explanations.

### Step 1 — (Title)
\`\`\`bash
# command here
\`\`\`
Expected result:
- …

### Step 2 — (Title)
\`\`\`bash
# command here
\`\`\`
Expected result:
- …

## Verification
\`\`\`bash
kubectl get all -A
\`\`\`

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
\`\`\`bash
kubectl get events -A --sort-by=.metadata.creationTimestamp
kubectl describe pod <pod>
kubectl logs <pod> --previous
\`\`\`

## Cleanup (Optional)
\`\`\`bash
# delete resources here
\`\`\`

## Key Takeaways
- Bullet point learning 1
- Bullet point learning 2
- Bullet point learning 3
EOM

  echo "CREATED: $readme"
done

echo
echo "Done ✅ Created LAB 02–LAB 17 folders + README skeletons + labs/README.md index."
