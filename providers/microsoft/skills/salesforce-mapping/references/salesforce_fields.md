# Choosing Salesforce fields for form questions

These are the usual choices. Always confirm a path in `crm_get_schema` for the user's org: custom fields (ending `__c`) are different in every org, and
a standard field can be hidden from a user.

## What Salesforce types fit each question type

| Question type | Salesforce types it can read |
|---|---|
| `email` | `email` (or `string`) |
| `phone` | `phone` (or `string`) |
| `date`, `date_of_birth`, `month_year` | `date`, `datetime` (or `string`) |
| `integer`, `decimal`, `currency`, `percentage`, `year` | `int`, `double`, `currency`, `percent` (or `string`) |
| `single_select` | `picklist`, `combobox` (or `string`) |
| `multi_select` | `multipicklist`, `picklist` (or `string`) |
| `yes_no` | `boolean`, `picklist` (or `string`) |
| `country` | `picklist` (or `string`) |
| `address` | `address` (read only; it can't be written as one field) |
| `short_text`, `long_text`, `person_name` | any text-like field |

A picklist answer must be one of the Salesforce picklist values when it is written back. If the form's options differ from the org's picklist,
map it read-only or make the form's option values match.

## Usual standard fields (Contact is the client)

| Question | Usual field | Notes |
|---|---|---|
| Full name | `Contact.Name` | Read only in Salesforce: prefill, don't write |
| Email | `Contact.Email` | Read and write |
| Mobile phone | `Contact.MobilePhone` | Read and write |
| Home or other phone | `Contact.Phone`, `Contact.HomePhone`, `Contact.OtherPhone` | Check which the org uses |
| Date of birth | `Contact.Birthdate` | `date` |
| Mailing address | `Contact.MailingAddress` | Read only as a whole |
| Employer, company | `Account.Name` | Changes the shared Account: prefill only unless the user wants it written |
| Job title | `Contact.Title` | |
| Opportunity amount, stage | `Opportunity.Amount`, `Opportunity.StageName` | Newest open opportunity of the client's account |

Search by the question's words: `crm_get_schema(search="birth")`, `search="mobile"`, `search="income"`.
Citizenship, employment status, trusted contact, risk tolerance, net worth and similar are usually **custom fields**: search for them, and if
nothing matches, leave the question unmapped and tell the user (they can ask their Salesforce admin to add the field).

## Patterns

- **Confirm-and-correct** (most common): reads `Contact.Email`, writes `Contact.Email`. The client sees their address filled in, fixes it if wrong, and the fix goes back.
- **Prefill only**: reads, no write. Right for names and anything the form must not change in the CRM.
- **Write only**: no read, writes. A new answer the CRM should keep (a number the sender types when sending, a new preference).
- **Read one, write another**: reads `Account.Name`, writes `Contact.Title`. Rare; say why.

## Write-back mode

| Mode | Use when |
|---|---|
| `manual` (default) | The sender should look before anything changes in Salesforce |
| `auto` | The user asks for it, and the mapped fields are low risk (contact details). Writes on submit with the sender's own access; a value someone changed in Salesforce after the prefill is left for the sender |
| `off` | Prefill only |

## A worked example

Form questions: `full_name` (person_name), `email`, `mobile` (phone), `dob` (date_of_birth), `employer` (short_text), `income` (currency), `ssn` (government_id).

```
crm_get_schema(objects=["Contact"], search="birth")      → Contact.Birthdate  (date)
crm_get_schema(search="income")                          → Contact.Annual_Income__c (currency, updateable)
studio_set_crm_mapping(session_id,
  read ={"full_name": "Contact.Name", "email": "Contact.Email", "mobile": "Contact.MobilePhone",
         "dob": "Contact.Birthdate", "employer": "Account.Name", "income": "Contact.Annual_Income__c"},
  write={"email": "Contact.Email", "mobile": "Contact.MobilePhone", "dob": "Contact.Birthdate",
         "income": {"target": "Contact.Annual_Income__c", "policy": "admin_approval"}},
  write_back="manual")
```

Left unmapped: `ssn` (secret). `full_name` and `employer` are prefill only (Name is read only; Account.Name belongs to the shared account).
