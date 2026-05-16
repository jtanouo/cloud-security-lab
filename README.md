# 🛡️ Cloud Security Lab

> Environnement personnel d'apprentissage et de pratique de la sécurité cloud, de l'Infrastructure as Code et de l'industrialisation des bonnes pratiques DevSecOps.

[![Status](https://img.shields.io/badge/status-in_progress-yellow)]()
[![Terraform](https://img.shields.io/badge/IaC-Terraform-purple)]()
[![Azure](https://img.shields.io/badge/cloud-Azure-blue)]()
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)

---

## 🎯 Objectifs du projet

Ce lab vise à acquérir et démontrer une maîtrise pratique des compétences suivantes :

- **Évaluation de la posture de sécurité cloud** : audit Azure, mapping CIS Benchmark, identification et priorisation des risques
- **Infrastructure as Code sécurisée** : développement de modules Terraform réutilisables, patterns *secure by default*
- **Sécurisation des pipelines CI/CD** : scans IaC (tfsec, Checkov), gestion des secrets, authentification fédérée (OIDC)
- **Gestion des identités et accès** : modélisation RBAC, principe du moindre privilège, automatisation via IaC
- **Documentation et standards** : knowledge base structurée, guides *do & don't*, runbooks opérationnels

## 🏗️ Architecture du repo

```
cloud-security-lab/
├── docs/              # Knowledge base et runbooks
├── terraform/         # Modules et environnements
│   ├── modules/       # Modules secure by default réutilisables
│   ├── environments/  # Lab vulnérable vs. lab hardened
│   └── policies/      # Azure Policy as Code
├── .github/workflows/ # Pipelines CI/CD sécurisés
├── audits/            # CIS Benchmark, risk register, remédiations
└── scripts/           # Helpers et scripts d'audit
```

## 🚀 Roadmap

- [x] **Phase 0** — Setup du projet et des outils
- [ ] **Phase 1** — Fondamentaux cloud & Azure
- [ ] **Phase 2** — Infrastructure as Code avec Terraform
- [ ] **Phase 3** — Évaluation de la posture de sécurité (CSPM, CIS)
- [ ] **Phase 4** — Sécurisation des pipelines CI/CD
- [ ] **Phase 5** — IAM, RBAC et secure by default
- [ ] **Phase 6** — Documentation et finalisation

## 🛠️ Stack technique

| Domaine | Outils |
|---|---|
| Cloud | Azure |
| IaC | Terraform, Azure Policy |
| CI/CD | GitHub Actions |
| Sécurité IaC | tfsec, Checkov, tflint |
| CSPM | Microsoft Defender for Cloud |
| Référentiels | CIS Benchmark Azure |

## 📚 Knowledge base

La documentation complète est dans le dossier [`docs/`](./docs/).

## 👤 Auteur

Japhet TANOUO — En préparation d'un stage en Cloud Security Engineering (sept. 2026).

## 📄 Licence

Ce projet est sous licence MIT — voir [LICENSE](./LICENSE) pour les détails.