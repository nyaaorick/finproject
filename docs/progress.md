# Development Progress

> Last updated: 2026-03-15

## Current Phase

**Phase 1 — Local MVP** (in progress)

## Completed

### Scaffold Setup (2026-03-15)

- [x] Next.js project initialized (App Router, TypeScript, Tailwind CSS, ESLint)
  - Next.js 16.1.6, React 19.2.3, Tailwind v4
  - No `src/` directory — `app/`, `components/`, `lib/` at project root
- [x] shadcn/ui initialized (style: base-nova, RSC: true, icon: lucide)
  - `components/ui/button.tsx` generated as seed component
  - `components.json` configured with `@/*` alias
- [x] Core dependencies installed
  - `@supabase/ssr` ^0.9.0
  - `@supabase/supabase-js` ^2.99.1
  - `zod` ^4.3.6
- [x] Directory structure created per `.cursorrules` spec
  - `components/features/{dashboard,accounts,transactions,rewards}/` — empty `index.ts` placeholders
  - `lib/actions/` — empty `index.ts` placeholder
  - `lib/utils/` — empty `index.ts` placeholder (shadcn also generated `lib/utils.ts` for `cn()`)
  - `docs/architecture/` — `.gitkeep`
- [x] Supabase client helpers created
  - `lib/supabase/client.ts` — `createBrowserClient` via `@supabase/ssr`
  - `lib/supabase/server.ts` — `createServerClient` via `@supabase/ssr`, cookie API uses **only** `getAll`/`setAll`
- [x] Type skeleton files created (empty exports, to be filled later)
  - `lib/types/database.ts` — raw Supabase DB types
  - `lib/types/rewards.ts` — RewardRule, SpendStats, RewardBalance
  - `lib/types/accounts.ts` — Account ViewModels
  - `lib/types/transactions.ts` — Transaction ViewModels
- [x] `.env.local` template created (`NEXT_PUBLIC_SUPABASE_URL`, `NEXT_PUBLIC_SUPABASE_ANON_KEY`)
- [x] Node.js v20.20.1 installed via nvm (`.zshrc` configured)

## Not Yet Done

- [ ] Supabase local Docker setup
- [ ] `lib/supabase/middleware.ts` (session-refresh middleware client)
- [ ] `middleware.ts` at project root (Next.js middleware calling Supabase session refresh)
- [ ] Google OAuth configuration
- [ ] App Router route groups: `(auth)/`, `(dashboard)/`
- [ ] Route pages: `dashboard/`, `accounts/`, `transactions/`, `rewards/`
- [ ] Database schema (`docs/SUPABASE_SCHEMA.md`)
- [ ] Type definitions (fill in the empty skeleton files)
- [ ] Server Actions in `lib/actions/`
- [ ] Feature components in `components/features/`
- [ ] `docs/decisions.md` (ADR log)

## Known Issues

- None at this stage.
