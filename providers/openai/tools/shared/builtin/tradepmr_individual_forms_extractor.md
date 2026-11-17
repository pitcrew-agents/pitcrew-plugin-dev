# tradepmr_individual_forms_extractor

## extract_individual_form
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "pdf_path": {
      "type": "string",
      "description": "Local path to the filled TradePMR individual client form PDF. The form type is auto-detected from the filename. Supported forms: Account Linking, Account Transfer (ACAT), Account Update, ACH Authorization, Client Signature Verification, Daily Trade Confirmation Waiver, DRS Transfer Authorization, IRA Distribution Request, IRA for Minor Child, IRA Removal of Excess Contribution, Letter of Authorization (Check/Journal), Letter of Authorization (Wire Funds), One and Same Letter, Options Agreement, Qualified Retirement Plan LOA, Request for Security Removal, Roth IRA Conversion, Traditional and Roth IRA Recharacterization, Trusted Contact Person Authorization."
    },
    "form_type": {
      "type": "string",
      "description": "Override auto-detection. One of: account_linking, account_transfer, account_update, ach_authorization, client_signature, daily_trade_waiver, drs_transfer, ira_distribution, ira_minor, ira_excess_removal, check_journal_loa, wire_loa, one_and_same, options_agreement, qualified_plan_loa, security_removal, roth_conversion, ira_recharacterization, trusted_contact."
    },
    "s3_bucket": {
      "type": "string",
      "description": "S3 bucket for Textract fallback. Defaults to app config."
    },
    "max_wait_seconds": {
      "type": "integer",
      "default": 300,
      "description": "Max seconds to wait for Textract job (fallback only)."
    }
  },
  "required": [
    "pdf_path"
  ]
}
```

**Output schema:**
```json
{
  "type": "object",
  "properties": {
    "form_type": {
      "type": "string"
    },
    "fields": {
      "type": "object"
    },
    "_meta": {
      "type": "object"
    },
    "error": {
      "type": "string"
    }
  }
}
```
