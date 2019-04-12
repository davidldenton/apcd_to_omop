OMOP Common Data Model / SQL Server DDL Scripts
=================

This folder contains the DDL for the OMOP CDM on SQL Server. 

1. Create a database named 'APCD'.

2. Create an empty schema named 'cdm'.

3. Execute the script `omop_cdm_ddl.sql` to create the tables and fields for the CDM.

4. Download the vocabulary files.

5. Execute the script `omop_cdm_load_vocab.sql` to load the vocab tables.

6. Execute the script `omop_cdm_pk_indexes_vocab.sql` to add primary keys and indexes to the vocab tables.

7. Execute the script `omop_cdm_constraints_vocab.sql` to add foreign key constraints to the vocab tables.

8. Load your data into the schema, using the DML scripts (excluding 'omop_cdm_load_vocab.sql').

9. Execute the script `omop_cdm_pk_indexes_data.sql` to add primary keys and indexes to the data tables.

10. Execute the script `omop_cdm_constraints_data.sql` to add the foreign key constraints to the data tables.

11. Execute the script `omop_cdm_results.txt` to create the results schema, tables, and fields, as well as the keys and indexes.
