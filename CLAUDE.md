# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

RVD is a SQL Server data warehouse for applicant/volunteer data at the Personnel Committee
Office (LCO) / Bethel, plus PowerShell automation. The target database is `rvdrehearsal` —
every `.sql` file begins with `use rvdrehearsal`.

There is **no build system and no migration runner**: DDL and procedures are applied by executing
the `.sql` files directly against the database. Procedures are authored idempotently
(`if object_id(...) is null exec('create procedure ...')` then `alter procedure`), so re-running
a file is safe. Preserve both the `use rvdrehearsal` header and the create-then-alter idiom when editing.

## Layout & architecture

- **`ddl/`** — schema and stored procedures. The ETL is a chain of procedures orchestrated by
  `dbo.ETL_main_proc` in `ETL_main.sql`, which calls, in order: `ETL_lkp_proc` → `ETL_data_proc`
  → `Data_Validation_proc` → the new-applicant procs (`Pursued_By_New_Apps_proc`,
  `Contacted_New_Apps_proc`), then stamps `App_Metadata` with HUB/BA load dates. Data flows from
  two source systems — **HUB** and **BA** — landed in staging (`staging_HuB.sql`, `staging_BA.sql`,
  `stg.*` tables) and loaded into `dbo.*` dimensions/facts.
- **`scripts/`** — ad-hoc/operational SQL (`daily_scratchpad.sql`, `app_attributes.sql`); **not**
  part of the ETL chain.
- **`ps/`** — PowerShell operational scripts. `ps/HPR/` runs from a shared drive
  (`H:\HPR\Personnel Support\RVD\...`), needs the `SqlServer` module
  (`Install-Module -Name SqlServer -Scope CurrentUser`), and ships Windows Task Scheduler XML
  (`Task - *.xml`) for scheduling. See `ps/HPR/README.md`. `ps/lco/` holds branch AD-group counts.
- **`jobs/`** — SQL Agent / scheduled-job XML definitions.

## Domain

This handles real personnel data. Org acronyms and enrollment codes (BBR, FR, FS, etc.) are
defined in `../lco_research/GLOSSARY.md`. Avoid surfacing names or sensitive personnel details
in generated output.
