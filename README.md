# Frontopedia 🚗

Wiki MkDocs pour ma voiture — déployé sur Cloud Run, pages sur GitHub.

```
push sur main → GitHub Actions → build Docker → push Artifact Registry → Cloud Run
```

---

## 1. Prérequis

- Un compte GCP avec un projet
- Les APIs activées :
  - Cloud Run
  - Artifact Registry
  - IAM
- GitHub repo (créer `waryz184/frontopedia`)

---

## 2. Structure du projet

```
frontopedia/
├── .github/workflows/deploy.yml   # CI/CD
├── docs/                           # Pages en Markdown
│   ├── index.md
│   ├── entretien/
│   │   ├── vidange.md
│   │   ├── pneus.md
│   │   └── freins.md
│   └── spec/
│       ├── moteur.md
│       └── dimensions.md
├── .gitignore
├── .dockerignore
├── Dockerfile                      # Build → nginx
├── mkdocs.yml                      # Config MkDocs
└── README.md
```

---

## 3. Preview en local

```bash
# Installer
pip install mkdocs mkdocs-material

# Lancer le serveur de dev (http://127.0.0.1:8000)
mkdocs serve

# Build statique
mkdocs build
```

---

## 4. Déploiement GCP (one-time setup)

### 4.1 Créer Artifact Registry

```bash
gcloud artifacts repositories create frontopedia \
  --repository-format docker \
  --location europe-west1 \
  --project waryz184-frontopedia
```

### 4.2 Créer le service account GitHub Actions

```bash
# Créer le compte de service
gcloud iam service-accounts create hermes \
  --display-name="GitHub Actions - Frontopedia"

# Donner les droits Cloud Run + Artifact Registry
gcloud projects add-iam-policy-binding waryz184-frontopedia \
  --member="serviceAccount:hermes@waryz184-frontopedia.iam.gserviceaccount.com" \
  --role="roles/run.admin"

gcloud projects add-iam-policy-binding waryz184-frontopedia \
  --member="serviceAccount:hermes@waryz184-frontopedia.iam.gserviceaccount.com" \
  --role="roles/artifactregistry.writer"

gcloud projects add-iam-policy-binding waryz184-frontopedia \
  --member="serviceAccount:hermes@waryz184-frontopedia.iam.gserviceaccount.com" \
  --role="roles/iam.serviceAccountUser"
```

### 4.3 Setup Workload Identity Federation (recommandé)

```bash
# Créer un pool d'identité
gcloud iam workload-identity-pools create github-pool \
  --location=global \
  --project=waryz184-frontopedia

# Créer un provider OIDC pour GitHub
gcloud iam workload-identity-pools providers create-oidc github-provider \
  --location=global \
  --workload-identity-pool=github-pool \
  --project=waryz184-frontopedia \
  --issuer-uri="https://token.actions.githubusercontent.com" \
  --attribute-mapping="google.subject=assertion.sub,attribute.repository=assertion.repository"

# Lier le service account au pool
gcloud iam service-accounts add-iam-policy-binding \
  hermes@waryz184-frontopedia.iam.gserviceaccount.com \
  --role="roles/iam.workloadIdentityUser" \
  --member="principalSet://iam.googleapis.com/projects/$(gcloud projects describe waryz184-frontopedia --format='value(projectNumber)')/locations/global/workloadIdentityPools/github-pool/attribute.repository/waryz184/frontopedia"
```

Récupérer le WIF_PROVIDER :

```bash
gcloud iam workload-identity-pools providers describe github-provider \
  --location=global \
  --workload-identity-pool=github-pool \
  --project=waryz184-frontopedia \
  --format="value(name)"
```

### 4.4 Ajouter les secrets GitHub

Dans les settings du repo GitHub → Settings > Secrets and variables > Actions :

| Secret | Valeur |
|--------|--------|
| `WIF_PROVIDER` | `projects/XXX/locations/global/workloadIdentityPools/github-pool/providers/github-provider` |
| `SERVICE_ACCOUNT_EMAIL` | `hermes@waryz184-frontopedia.iam.gserviceaccount.com` |

---

## 5. Workflow CI/CD

`.github/workflows/deploy.yml` — déclenché sur push/PR sur `main` :

1. Checkout du repo
2. Auth GCP via WIF
3. Build Docker image (multi-stage : mkdocs build → nginx)
4. Push sur Artifact Registry
5. Deploy sur Cloud Run (scaling à zéro, 256Mi, 1 CPU)

---

## 6. Ajouter / modifier une page

1. Créer/éditer un `.md` dans `docs/`
2. Mettre à jour `nav:` dans `mkdocs.yml` si nouvelle page
3. Commit + push (ou PR)
4. Le déploiement se fait automatiquement

---

## 7. Avantages

| Point | Pourquoi |
|-------|----------|
| **Zéro maintenance** | Cloud Run scale à zéro, pas de VM à gérer |
| **Pas de base de données** | Markdown + Git, tout versionné |
| **Déploiement automatique** | Push → GitHub Actions → déployé |
| **Rapide** | nginx sert des fichiers statiques, < 10ms |
| **Gratuit** | Cloud Run a 2M req/mois gratuits, largement assez |
| **Éditable depuis GitHub** | L'éditeur GitHub permet d'éditer les .md en ligne |
