OMOP Common Data Model / SQL Server Scripts
=================

This folder contains the DDL for the OMOP CDM on SQL Server. 

1. Create a case-sensitive database named 'APCD'.
   - Collation = SQL_Latin1_General_CP1_CS_AS

2. Create an empty schema named 'cdm'.

3. Execute the script `omop_cdm_ddl.sql` to create the tables and fields for the OMOP CDM.

4. Download the vocabulary files.

5. Execute the script `omop_cdm_load_vocab.sql` to load the vocab tables.

6. Execute the script `rm_dup_record_from_concept_synonym.sql` to remove a duplicate record from the `concept_synonym` table.

7. Execute the script `omop_cdm_pk_indexes_vocab.sql` to add primary keys and indexes to the vocab tables.

8. Execute the script `omop_cdm_constraints_vocab.sql` to add foreign key constraints to the vocab tables.

9. Load the APCD data into the common data model, using the DML scripts (excluding `omop_cdm_load_vocab.sql`).

10. Execute the script `omop_cdm_pk_indexes_data.sql` to add primary keys and indexes to the data tables.

11. Execute the script `omop_cdm_constraints_data.sql` to add foreign key constraints to the data tables.

12. Execute the script `omop_cdm_results.txt` to create the results schema, tables, and fields, as well as the keys and indexes.
