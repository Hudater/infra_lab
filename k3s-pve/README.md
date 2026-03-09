# k3s-cluster — 6-node HA cluster on Proxmox

OpenTofu (bpg/proxmox) + Ansible to spin up a 3-server / 3-agent k3s cluster
on a single Proxmox host. Designed as a professional homelab SRE project.

## Prerequisites

- Proxmox VE with a cloud-init Ubuntu 22.04 VM template (VMID set in tfvars)
    - Create template: https://pve.proxmox.com/wiki/Cloud-Init_Support
- `tofu` ≥ 1.3, `ansible` ≥ 2.14, `jq`, `kubectl`
- API token in Proxmox: Datacenter → API Tokens → Add
    - Permissions: VM.Allocate, VM.Clone, VM.Config.\*, Datastore.AllocateSpace, etc.

## Workflow

```bash
# 1. Provision VMs
cd terraform
cp terraform.tfvars.example terraform.tfvars
tofu init
tofu plan
tofu apply

# 2. Generate Ansible inventory from tofu outputs
cd ..
bash gen-inventory.sh

# 3. Install k3s across all nodes
cd ansible
ansible-playbook site.yml

# 4. Get kubeconfig (also runs as last step of site.yml)
ansible-playbook site.yml --tags kubeconfig
export KUBECONFIG=~/.kube/k3s-homelab.yaml
kubectl get nodes -o wide

# 5. Tear down
cd ../terraform
tofu destroy
```

## Architecture

```
Proxmox Host (Ryzen 5600x / 48GB)
├── k3s-server-1  (VMID 200, 192.168.10.10)  (init node, etcd leader)
├── k3s-server-2  (VMID 201, 192.168.10.11)
├── k3s-server-3  (VMID 202, 192.168.10.12)
├── k3s-agent-1   (VMID 210, 192.168.10.20)
├── k3s-agent-2   (VMID 211, 192.168.10.21)
└── k3s-agent-3   (VMID 212, 192.168.10.22)
```

3 servers = embedded etcd HA (quorum requires 2/3 healthy).
Traefik + ServiceLB disabled — external Traefik handles ingress.

## Key design decisions

| Decision                     | Reason                                                             |
| ---------------------------- | ------------------------------------------------------------------ |
| `bpg/proxmox` provider       | Active maintenance, proper cloud-init support, better than telmate |
| `--cluster-init` on server-1 | Required to bootstrap embedded etcd HA                             |
| `serial: 1` on server play   | Ensures init node is Ready before others attempt to join           |
| Traefik disabled             | Already running Traefik + traefik-kop externally                   |
| CPU type `x86-64-v2-AES`     | Best perf for Ryzen 5600x; supports AES-NI                         |
| `balloon=0`                  | k3s needs predictable memory, not dynamic allocation               |

## Observability (next steps)

- Deploy kube-prometheus-stack (Prometheus + Grafana + Alertmanager)
- Ship logs to existing Loki instance via Promtail DaemonSet
- Add cluster to existing Grafana with new datasource
