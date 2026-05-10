# Infrastructure Lab

Multi-cloud infrastructure as code for homelab environments.

## Architecture

```txt
┌─────────────────────────────────────────────────────────────┐
│                     GitHub Actions CI/CD                     │
│                  (GitOps - Single main branch)               │
└─────────────────────────────────────────────────────────────┘
                              │
                ┌─────────────┴─────────────┐
                │                           │
        ┌───────▼────────┐         ┌───────▼────────┐
        │   Cloudflare   │         │   Oracle Cloud │
        │                │         │  Infrastructure│
        │  • DNS Zones   │         │                │
        │  • Records     │         │  Multi-Region  │
        └────────────────┘         └────────────────┘
                                            │
                        ┌───────────────────┼───────────────────┐
                        │                   │                   │
                ┌───────▼────────┐  ┌──────▼───────┐  ┌───────▼────────┐
                │  Zurich (zrh)  │  │ Bombay (bom) │  │ Future Regions │
                │                │  │              │  │                │
                │  • 2x AMD VMs  │  │  • 2x AMD    │  │  • Singapore   │
                │  • 1x ARM VM   │  │  • 1x ARM    │  │  • ...         │
                │  • VCN + DNS   │  │  • VCN + DNS │  │                │
                └────────────────┘  └──────────────┘  └────────────────┘
```

## Stack

- **IaC**: OpenTofu + Terragrunt
- **CI/CD**: GitHub Actions
- **State**: HCP Terraform (remote state)
- **Clouds**: Oracle Cloud (compute), Cloudflare (DNS)

## Structure

```txt
infra_lab/
├── cloudflare/          # DNS management
│   ├── zones.tf
│   └── records.tf
│
├── oci/                 # Oracle Cloud Infrastructure
│   ├── _modules/        # Shared Terraform modules
│   ├── zurich/          # Zurich region config
│   ├── bombay/          # Bombay region config
│   └── root.hcl         # Shared Terragrunt config
│
└── .github/workflows/   # CI/CD pipelines
    ├── cloudflare.yml
    ├── oci-zurich.yml
    └── oci-bombay.yml
```

## Features

- **Multi-region OCI deployment** - Separate accounts per region
- **Automated CI/CD** - Plan on push, apply via comment (`/apply zurich`)
- **Scalable architecture** - Add new regions by copying config
- **GitOps workflow** - Single source of truth in Git

## Status

- ✅ Cloudflare DNS - Active
- ✅ OCI Zurich - Active
- 🔒 OCI Bombay - Disabled (ready to enable)
