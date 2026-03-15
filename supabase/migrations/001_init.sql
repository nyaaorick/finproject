-- ============================================================
-- 001_init.sql
-- Initial schema: accounts + transactions tables
-- ============================================================

-- ------------------------------------------------------------
-- 1. ENUM types
-- ------------------------------------------------------------

CREATE TYPE public.account_type AS ENUM (
  'ASSET',
  'LIABILITY',
  'SHARE'
);

CREATE TYPE public.transaction_type AS ENUM (
  'EXPENSE',
  'INCOME',
  'TRANSFER',
  'REWARD_EARN',
  'REWARD_SPEND'
);

-- ------------------------------------------------------------
-- 2. accounts table
-- ------------------------------------------------------------

CREATE TABLE public.accounts (
  id              UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id         UUID        NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  name            TEXT        NOT NULL,
  type            public.account_type NOT NULL,
  currency        TEXT        NOT NULL,
  balance         DECIMAL(12,2) NOT NULL DEFAULT 0,
  credit_limit    DECIMAL(12,2),
  brokerage       TEXT,
  reward_rules    JSONB       NOT NULL DEFAULT '[]'::jsonb,
  reward_balances JSONB       NOT NULL DEFAULT '{}'::jsonb,
  spend_stats     JSONB       NOT NULL DEFAULT '{}'::jsonb,
  auto_pay_config JSONB,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Index: fast lookup of all accounts for a given user
CREATE INDEX accounts_user_id_idx ON public.accounts(user_id);

-- Trigger: keep updated_at in sync on every UPDATE
CREATE OR REPLACE FUNCTION public.set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER accounts_set_updated_at
  BEFORE UPDATE ON public.accounts
  FOR EACH ROW
  EXECUTE FUNCTION public.set_updated_at();

-- ------------------------------------------------------------
-- 3. transactions table
-- ------------------------------------------------------------

CREATE TABLE public.transactions (
  id             UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id        UUID        NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  type           public.transaction_type NOT NULL,
  amount         DECIMAL(12,2) NOT NULL CHECK (amount > 0),
  currency       TEXT        NOT NULL,
  from_account   UUID        REFERENCES public.accounts(id) ON DELETE SET NULL,
  to_account     UUID        REFERENCES public.accounts(id) ON DELETE SET NULL,
  category       TEXT,
  memo           TEXT,
  transaction_at TIMESTAMPTZ NOT NULL,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Indexes
CREATE INDEX transactions_user_id_idx      ON public.transactions(user_id);
CREATE INDEX transactions_from_account_idx ON public.transactions(from_account);
CREATE INDEX transactions_to_account_idx   ON public.transactions(to_account);

-- ------------------------------------------------------------
-- 4. Row Level Security
-- ------------------------------------------------------------

ALTER TABLE public.accounts     ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.transactions ENABLE ROW LEVEL SECURITY;

-- accounts policies
CREATE POLICY "accounts_select_own" ON public.accounts
  FOR SELECT USING (user_id = auth.uid());

CREATE POLICY "accounts_insert_own" ON public.accounts
  FOR INSERT WITH CHECK (user_id = auth.uid());

CREATE POLICY "accounts_update_own" ON public.accounts
  FOR UPDATE USING (user_id = auth.uid());

CREATE POLICY "accounts_delete_own" ON public.accounts
  FOR DELETE USING (user_id = auth.uid());

-- transactions policies
CREATE POLICY "transactions_select_own" ON public.transactions
  FOR SELECT USING (user_id = auth.uid());

CREATE POLICY "transactions_insert_own" ON public.transactions
  FOR INSERT WITH CHECK (user_id = auth.uid());

CREATE POLICY "transactions_update_own" ON public.transactions
  FOR UPDATE USING (user_id = auth.uid());

CREATE POLICY "transactions_delete_own" ON public.transactions
  FOR DELETE USING (user_id = auth.uid());
