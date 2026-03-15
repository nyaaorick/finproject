// Raw Supabase DB types — auto-synced with supabase/migrations/001_init.sql
// Do NOT mix ViewModels into this file; see lib/types/accounts.ts for those.

export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  public: {
    Tables: {
      accounts: {
        Row: {
          id:              string
          user_id:         string
          name:            string
          type:            Database['public']['Enums']['account_type']
          currency:        string
          balance:         number
          credit_limit:    number | null
          brokerage:       string | null
          reward_rules:    Json
          reward_balances: Json
          spend_stats:     Json
          auto_pay_config: Json | null
          created_at:      string
          updated_at:      string
        }
        Insert: {
          id?:             string
          user_id:         string
          name:            string
          type:            Database['public']['Enums']['account_type']
          currency:        string
          balance?:        number
          credit_limit?:   number | null
          brokerage?:      string | null
          reward_rules?:   Json
          reward_balances?: Json
          spend_stats?:    Json
          auto_pay_config?: Json | null
          created_at?:     string
          updated_at?:     string
        }
        Update: {
          id?:             string
          user_id?:        string
          name?:           string
          type?:           Database['public']['Enums']['account_type']
          currency?:       string
          balance?:        number
          credit_limit?:   number | null
          brokerage?:      string | null
          reward_rules?:   Json
          reward_balances?: Json
          spend_stats?:    Json
          auto_pay_config?: Json | null
          created_at?:     string
          updated_at?:     string
        }
      }
      transactions: {
        Row: {
          id:             string
          user_id:        string
          type:           Database['public']['Enums']['transaction_type']
          amount:         number
          currency:       string
          from_account:   string | null
          to_account:     string | null
          category:       string | null
          memo:           string | null
          transaction_at: string
          created_at:     string
        }
        Insert: {
          id?:            string
          user_id:        string
          type:           Database['public']['Enums']['transaction_type']
          amount:         number
          currency:       string
          from_account?:  string | null
          to_account?:    string | null
          category?:      string | null
          memo?:          string | null
          transaction_at: string
          created_at?:    string
        }
        Update: {
          id?:            string
          user_id?:       string
          type?:          Database['public']['Enums']['transaction_type']
          amount?:        number
          currency?:      string
          from_account?:  string | null
          to_account?:    string | null
          category?:      string | null
          memo?:          string | null
          transaction_at?: string
          created_at?:    string
        }
      }
    }
    Enums: {
      account_type:     'ASSET' | 'LIABILITY' | 'SHARE'
      transaction_type: 'EXPENSE' | 'INCOME' | 'TRANSFER' | 'REWARD_EARN' | 'REWARD_SPEND'
    }
  }
}

// Convenience aliases — use these in Server Actions and ViewModels
export type AccountRow       = Database['public']['Tables']['accounts']['Row']
export type AccountInsert    = Database['public']['Tables']['accounts']['Insert']
export type AccountUpdate    = Database['public']['Tables']['accounts']['Update']
export type TransactionRow   = Database['public']['Tables']['transactions']['Row']
export type TransactionInsert = Database['public']['Tables']['transactions']['Insert']
export type TransactionUpdate = Database['public']['Tables']['transactions']['Update']
