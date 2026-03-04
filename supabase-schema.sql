-- ═══════════════════════════════════════════════
-- CJConnect — Schema Supabase
-- ═══════════════════════════════════════════════

-- Membres (bureau CJC)
CREATE TABLE membres (
  id BIGSERIAL PRIMARY KEY,
  prenom TEXT NOT NULL,
  nom TEXT NOT NULL,
  email TEXT,
  role TEXT,
  fichiers JSONB DEFAULT '[]',
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Intervenants (étudiants)
CREATE TABLE intervenants (
  id BIGSERIAL PRIMARY KEY,
  prenom TEXT NOT NULL,
  nom TEXT NOT NULL,
  specialite TEXT,
  adresse TEXT,
  num_ss TEXT,
  email TEXT,
  fichiers JSONB DEFAULT '[]',
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Études
CREATE TABLE etudes (
  id BIGSERIAL PRIMARY KEY,
  ref TEXT NOT NULL UNIQUE,
  client TEXT NOT NULL,
  siren TEXT,
  client_addr TEXT,
  titre TEXT,
  date_debut DATE,
  date_fin DATE,
  montant_ht NUMERIC(10,2) DEFAULT 0,
  tva NUMERIC(4,2) DEFAULT 20,
  acompte INTEGER DEFAULT 30,
  fact_inter_pct INTEGER DEFAULT 0,
  frais_ht NUMERIC(10,2) DEFAULT 0,
  frais_offerts BOOLEAN DEFAULT true,
  phases JSONB DEFAULT '[]',
  cse_id BIGINT REFERENCES membres(id),
  intervenant_ids JSONB DEFAULT '[]',
  docs JSONB DEFAULT '{}',
  bloquee BOOLEAN DEFAULT false,
  encaisse NUMERIC(10,2) DEFAULT 0,
  fichiers JSONB DEFAULT '[]',
  has_pvri BOOLEAN DEFAULT false,
  has_fact_inter BOOLEAN DEFAULT false,
  has_avenant BOOLEAN DEFAULT false,
  contexte TEXT,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Bulletins de versement
CREATE TABLE bvs (
  id BIGSERIAL PRIMARY KEY,
  ref TEXT NOT NULL,
  intervenant_id BIGINT REFERENCES intervenants(id),
  etude_id BIGINT REFERENCES etudes(id),
  date DATE,
  jeh INTEGER DEFAULT 1,
  taux NUMERIC(10,2) DEFAULT 400,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Factures fournisseurs
CREATE TABLE factures_fournisseurs (
  id BIGSERIAL PRIMARY KEY,
  date DATE,
  fournisseur TEXT NOT NULL,
  poste TEXT,
  description TEXT,
  montant_ht NUMERIC(10,2) DEFAULT 0,
  tva NUMERIC(4,2) DEFAULT 20,
  paiement TEXT DEFAULT 'CB',
  payee BOOLEAN DEFAULT false,
  fichiers JSONB DEFAULT '[]',
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Subventions
CREATE TABLE subventions (
  id BIGSERIAL PRIMARY KEY,
  date DATE,
  source TEXT NOT NULL,
  description TEXT,
  montant NUMERIC(10,2) DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Postes de dépense (budget)
CREATE TABLE expense_posts (
  id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  budget NUMERIC(10,2) DEFAULT 0
);

-- Suivi factures (envoyée/reçue)
CREATE TABLE fact_tracking (
  id TEXT PRIMARY KEY,  -- ex: "1-ac", "2-sol"
  envoyee DATE,
  recue DATE
);

-- Archives de mandats
CREATE TABLE archives (
  id BIGSERIAL PRIMARY KEY,
  label TEXT NOT NULL,
  year INTEGER,
  closed_at DATE,
  data JSONB NOT NULL,
  summary JSONB,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Notes communication (dashboard)
CREATE TABLE settings (
  key TEXT PRIMARY KEY,
  value TEXT
);

-- ═══════════════════════════════════════════════
-- Row Level Security (RLS)
-- À activer une fois l'auth configurée
-- ═══════════════════════════════════════════════

-- ALTER TABLE membres ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE intervenants ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE etudes ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE bvs ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE factures_fournisseurs ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE subventions ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE expense_posts ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE fact_tracking ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE archives ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE settings ENABLE ROW LEVEL SECURITY;
