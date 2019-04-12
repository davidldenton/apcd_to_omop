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

 ####### #     # ####### ######      #####  ######  #     #            #####        ###      ######  #    #      ##       ###
 #     # ##   ## #     # #     #    #     # #     # ##   ##    #    # #     #      #   #     #     # #   #      #  #       #  #    # #####  #  ####  ######  ####
 #     # # # # # #     # #     #    #       #     # # # # #    #    # #           #     #    #     # #  #        ##        #  ##   # #    # # #    # #      #
 #     # #  #  # #     # ######     #       #     # #  #  #    #    # ######      #     #    ######  ###        ###        #  # #  # #    # # #      #####   ####
 #     # #     # #     # #          #       #     # #     #    #    # #     # ### #     #    #       #  #      #   # #     #  #  # # #    # # #      #           #
 #     # #     # #     # #          #     # #     # #     #     #  #  #     # ###  #   #     #       #   #     #    #      #  #   ## #    # # #    # #      #    #
 ####### #     # ####### #           #####  ######  #     #      ##    #####  ###   ###      #       #    #     ###  #    ### #    # #####  #  ####  ######  ####


sql server script to create the required primary keys and indices within the vocab tables for the OMOP common data model, version 6.0

last revised: 2018-04-12

description:  These primary keys and indices are considered a minimal requirement to ensure adequate performance of analyses.

*************************/


/************************
*************************
*************************
*************************

Primary key constraints

*************************
*************************
*************************
************************/


/************************

Standardized vocabulary

************************/

USE APCD;

ALTER TABLE cdm.concept ADD CONSTRAINT xpk_concept PRIMARY KEY NONCLUSTERED (concept_id);

ALTER TABLE cdm.vocabulary ADD CONSTRAINT xpk_vocabulary PRIMARY KEY NONCLUSTERED (vocabulary_id);

ALTER TABLE cdm.domain ADD CONSTRAINT xpk_domain PRIMARY KEY NONCLUSTERED (domain_id);

ALTER TABLE cdm.concept_class ADD CONSTRAINT xpk_concept_class PRIMARY KEY NONCLUSTERED (concept_class_id);

ALTER TABLE cdm.concept_relationship ADD CONSTRAINT xpk_concept_relationship PRIMARY KEY NONCLUSTERED (concept_id_1,concept_id_2,relationship_id);

ALTER TABLE cdm.relationship ADD CONSTRAINT xpk_relationship PRIMARY KEY NONCLUSTERED (relationship_id);

ALTER TABLE cdm.concept_ancestor ADD CONSTRAINT xpk_concept_ancestor PRIMARY KEY NONCLUSTERED (ancestor_concept_id,descendant_concept_id);

ALTER TABLE cdm.source_to_concept_map ADD CONSTRAINT xpk_source_to_concept_map PRIMARY KEY NONCLUSTERED (source_vocabulary_id,target_concept_id,source_code,valid_end_date);

ALTER TABLE cdm.drug_strength ADD CONSTRAINT xpk_drug_strength PRIMARY KEY NONCLUSTERED (drug_concept_id, ingredient_concept_id);


/************************
*************************
*************************
*************************

Indices

*************************
*************************
*************************
************************/


/************************

Standardized vocabulary

************************/

CREATE UNIQUE CLUSTERED INDEX idx_concept_concept_id ON cdm.concept (concept_id ASC);
CREATE INDEX idx_concept_code ON cdm.concept (concept_code ASC);
CREATE INDEX idx_concept_vocabluary_id ON cdm.concept (vocabulary_id ASC);
CREATE INDEX idx_concept_domain_id ON cdm.concept (domain_id ASC);
CREATE INDEX idx_concept_class_id ON cdm.concept (concept_class_id ASC);

CREATE UNIQUE CLUSTERED INDEX idx_vocabulary_vocabulary_id ON cdm.vocabulary (vocabulary_id ASC);

CREATE UNIQUE CLUSTERED INDEX idx_domain_domain_id ON cdm.domain (domain_id ASC);

CREATE UNIQUE CLUSTERED INDEX idx_concept_class_class_id ON cdm.concept_class (concept_class_id ASC);

CREATE INDEX idx_concept_relationship_id_1 ON cdm.concept_relationship (concept_id_1 ASC);
CREATE INDEX idx_concept_relationship_id_2 ON cdm.concept_relationship (concept_id_2 ASC);
CREATE INDEX idx_concept_relationship_id_3 ON cdm.concept_relationship (relationship_id ASC);

CREATE UNIQUE CLUSTERED INDEX idx_relationship_rel_id ON cdm.relationship (relationship_id ASC);

CREATE CLUSTERED INDEX idx_concept_synonym_id ON cdm.concept_synonym (concept_id ASC);

CREATE CLUSTERED INDEX idx_concept_ancestor_id_1 ON cdm.concept_ancestor (ancestor_concept_id ASC);
CREATE INDEX idx_concept_ancestor_id_2 ON cdm.concept_ancestor (descendant_concept_id ASC);

CREATE CLUSTERED INDEX idx_source_to_concept_map_id_3 ON cdm.source_to_concept_map (target_concept_id ASC);
CREATE INDEX idx_source_to_concept_map_id_1 ON cdm.source_to_concept_map (source_vocabulary_id ASC);
CREATE INDEX idx_source_to_concept_map_id_2 ON cdm.source_to_concept_map (target_vocabulary_id ASC);
CREATE INDEX idx_source_to_concept_map_code ON cdm.source_to_concept_map (source_code ASC);

CREATE CLUSTERED INDEX idx_drug_strength_id_1 ON cdm.drug_strength (drug_concept_id ASC);
CREATE INDEX idx_drug_strength_id_2 ON cdm.drug_strength (ingredient_concept_id ASC);
