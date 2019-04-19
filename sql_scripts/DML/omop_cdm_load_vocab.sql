/*********************************************************************************
# Copyright 2014 Observational Health Data Sciences and Informatics
#
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
********************************************************************************/

/************************

 ####### #     # ####### ######      #####  ######  #     #           ####### 
 #     # ##   ## #     # #     #    #     # #     # ##   ##    #    # #       
 #     # # # # # #     # #     #    #       #     # # # # #    #    # #       
 #     # #  #  # #     # ######     #       #     # #  #  #    #    # ######  
 #     # #     # #     # #          #       #     # #     #    #    #       # 
 #     # #     # #     # #          #     # #     # #     #     #  #  #     # 
 ####### #     # ####### #           #####  ######  #     #      ##    #####  
                                                                              

Script to load the common data model, version 5.0 vocabulary tables for SQL Server database

Notes

1) There is no data file load for the SOURCE_TO_CONCEPT_MAP table because that table is deprecated in CDM version 5.0
2) This script assumes the CDM version 5 vocabulary zip file has been unzipped into the "C:\CDMV5Vocabulary" directory. 
3) If you unzipped your CDM version 5 vocabulary files into a different directory then replace all file paths below, with your directory path.
4) Run this SQL query script in the database where you created your CDM Version 5 tables

last revised: 2018-04-12


*************************/

USE APCD;

TRUNCATE TABLE cdm.drug_strength;
BULK INSERT cdm.drug_strength 
FROM 'D:\projects\omop_cdm\vocab\DRUG_STRENGTH.csv' 
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = '\t',
ROWTERMINATOR = '0x0a',
ERRORFILE = 'D:\projects\omop_cdm\vocab\DRUG_STRENGTH.bad',
TABLOCK
);

TRUNCATE TABLE cdm.concept;
BULK INSERT cdm.concept 
FROM 'D:\projects\omop_cdm\vocab\CONCEPT.csv' 
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = '\t',
ROWTERMINATOR = '0x0a',
ERRORFILE = 'D:\projects\omop_cdm\vocab\CONCEPT.bad',
TABLOCK
);

TRUNCATE TABLE cdm.concept_relationship;
BULK INSERT cdm.concept_relationship 
FROM 'D:\projects\omop_cdm\vocab\CONCEPT_RELATIONSHIP.csv' 
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = '\t',
ROWTERMINATOR = '0x0a',
ERRORFILE = 'D:\projects\omop_cdm\vocab\CONCEPT_RELATIONSHIP.bad',
TABLOCK
);

TRUNCATE TABLE cdm.concept_ancestor;
BULK INSERT cdm.concept_ancestor 
FROM 'D:\projects\omop_cdm\vocab\CONCEPT_ANCESTOR.csv' 
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = '\t',
ROWTERMINATOR = '0x0a',
ERRORFILE = 'D:\projects\omop_cdm\vocab\CONCEPT_ANCESTOR.bad',
TABLOCK
);

TRUNCATE TABLE cdm.concept_synonym;
BULK INSERT cdm.concept_synonym 
FROM 'D:\projects\omop_cdm\vocab\CONCEPT_SYNONYM.csv' 
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = '\t',
ROWTERMINATOR = '0x0a',
ERRORFILE = 'D:\projects\omop_cdm\vocab\CONCEPT_SYNONYM.bad',
TABLOCK
);

TRUNCATE TABLE cdm.vocabulary;
BULK INSERT cdm.vocabulary 
FROM 'D:\projects\omop_cdm\vocab\VOCABULARY.csv' 
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = '\t',
ROWTERMINATOR = '0x0a',
ERRORFILE = 'D:\projects\omop_cdm\vocab\VOCABULARY.bad',
TABLOCK
);

TRUNCATE TABLE cdm.relationship;
BULK INSERT cdm.relationship 
FROM 'D:\projects\omop_cdm\vocab\RELATIONSHIP.csv' 
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = '\t',
ROWTERMINATOR = '0x0a',
ERRORFILE = 'D:\projects\omop_cdm\vocab\RELATIONSHIP.bad',
TABLOCK
);

TRUNCATE TABLE cdm.concept_class;
BULK INSERT cdm.concept_class 
FROM 'D:\projects\omop_cdm\vocab\CONCEPT_CLASS.csv' 
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = '\t',
ROWTERMINATOR = '0x0a',
ERRORFILE = 'D:\projects\omop_cdm\vocab\CONCEPT_CLASS.bad',
TABLOCK
);

TRUNCATE TABLE cdm.domain;
BULK INSERT cdm.domain 
FROM 'D:\projects\omop_cdm\vocab\DOMAIN.csv' 
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = '\t',
ROWTERMINATOR = '0x0a',
ERRORFILE = 'D:\projects\omop_cdm\vocab\DOMAIN.bad',
TABLOCK
);
