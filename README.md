# CJConnect — ERP de CELSA Junior Communication

ERP interne pour la gestion des études, trésorerie, RH et documents de CJC.

## Fonctionnalités

- **SafeProcess** — Gestion complète des études (devis → convention → factures → PVRF)
- **Trésorerie** — Factures clients/fournisseurs, BV, budget, suivi envoi/réception
- **RH** — Membres du bureau et intervenants avec assignation aux études
- **Documents** — Génération de 10 types de documents (devis, CE, factures, RM, PVRF, BV...)
- **Email** — Templates d'emails personnalisés pour chaque document
- **Archives** — Clôture de mandat et consultation historique

## Lancer en local

```bash
npm install
npm run dev
```

Ouvrir http://localhost:3000

## Déployer sur Vercel

### 1. Préparer le repo Git

```bash
git init
git add .
git commit -m "CJConnect v1.0"
```

Pousser sur GitHub :
```bash
# Créer un repo sur github.com puis :
git remote add origin https://github.com/VOTRE-COMPTE/cjconnect.git
git push -u origin main
```

### 2. Déployer

1. Aller sur https://vercel.com
2. Se connecter avec GitHub
3. Cliquer "New Project" → importer le repo `cjconnect`
4. Framework: Vite → Déployer
5. Le site est en ligne en ~1 min !

### 3. (Optionnel) Ajouter Supabase pour les données persistantes

1. Créer un projet sur https://supabase.com
2. Aller dans SQL Editor → coller le contenu de `supabase-schema.sql`
3. Copier l'URL et la clé anon depuis Settings → API
4. Ajouter les variables d'environnement dans Vercel :
   - `VITE_SUPABASE_URL`
   - `VITE_SUPABASE_ANON_KEY`

## Structure du projet

```
cjconnect/
├── public/
│   └── logo.png          # Logo CJC détouré
├── src/
│   ├── App.jsx            # Application complète (composant unique)
│   ├── main.jsx           # Point d'entrée React
│   └── index.css          # Reset CSS
├── index.html             # Page HTML
├── package.json
├── vite.config.js
├── supabase-schema.sql    # Schéma base de données
├── .env.example           # Variables d'environnement
└── README.md
```

## Version actuelle

La version actuelle fonctionne en **mode standalone** (données en mémoire avec seed).
Pour une utilisation en production avec données persistantes, connecter Supabase.

## Licence

Usage interne CELSA Junior Communication.
