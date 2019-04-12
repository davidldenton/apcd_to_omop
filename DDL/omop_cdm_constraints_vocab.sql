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

 ####### #     # ####### ######      #####  ######  #     #            #####        ###       #####
 #     # ##   ## #     # #     #    #     # #     # ##   ##    #    # #     #      #   #     #     #  ####  #    #  ####  ##### #####    ##   # #    # #####  ####
 #     # # # # # #     # #     #    #       #     # # # # #    #    # #           #     #    #       #    # ##   # #        #   #    #  #  #  # ##   #   #   #
 #     # #  #  # #     # ######     #       #     # #  #  #    #    # ######      #     #    #       #    # # #  #  ####    #   #    # #    # # # #  #   #    ####
 #     # #     # #     # #          #       #     # #     #    #    # #     # ### #     #    #       #    # #  # #      #   #   #####  ###### # #  # #   #        #
 #     # #     # #     # #          #     # #     # #     #     #  #  #     # ###  #   #     #     # #    # #   ## #    #   #   #   #  #    # # #   ##   #   #    #
 ####### #     # ####### #           #####  ######  #     #      ##    #####  ###   ###       #####   ####  #    #  ####    #   #    # #    # # #    #   #    ####


sql server script to create foreign key, unique, and check constraints within the vocab tables for the OMOP common data model, version 6.0

last revised: 2018-04-12



*************************/


/************************
*************************
*************************
*************************

Foreign key constraints

*************************
*************************
*************************
************************/


/************************

Standardized vocabulary

************************/

USE APCD;

ALTER TABLE cdm.concept ADD CONSTRAINT fpk_concept_domain FOREIGN KEY (domain_id)  REFERENCES cdm.domain (domain_id);

ALTER TABLE cdm.concept ADD CONSTRAINT fpk_concept_class FOREIGN KEY (concept_class_id)  REFERENCES cdm.concept_class (concept_class_id);

ALTER TABLE cdm.concept ADD CONSTRAINT fpk_concept_vocabulary FOREIGN KEY (vocabulary_id)  REFERENCES cdm.vocabulary (vocabulary_id);

ALTER TABLE cdm.vocabulary ADD CONSTRAINT fpk_vocabulary_concept FOREIGN KEY (vocabulary_concept_id)  REFERENCES cdm.concept (concept_id);

ALTER TABLE cdm.domain ADD CONSTRAINT fpk_domain_concept FOREIGN KEY (domain_concept_id)  REFERENCES cdm.concept (concept_id);

ALTER TABLE cdm.concept_class ADD CONSTRAINT fpk_concept_class_concept FOREIGN KEY (concept_class_concept_id)  REFERENCES cdm.concept (concept_id);

ALTER TABLE cdm.concept_relationship ADD CONSTRAINT fpk_concept_relationship_c_1 FOREIGN KEY (concept_id_1)  REFERENCES cdm.concept (concept_id);

ALTER TABLE cdm.concept_relationship ADD CONSTRAINT fpk_concept_relationship_c_2 FOREIGN KEY (concept_id_2)  REFERENCES cdm.concept (concept_id);

ALTER TABLE cdm.concept_relationship ADD CONSTRAINT fpk_concept_relationship_id FOREIGN KEY (relationship_id)  REFERENCES cdm.relationship (relationship_id);

ALTER TABLE cdm.relationship ADD CONSTRAINT fpk_relationship_concept FOREIGN KEY (relationship_concept_id)  REFERENCES cdm.concept (concept_id);

ALTER TABLE cdm.relationship ADD CONSTRAINT fpk_relationship_reverse FOREIGN KEY (reverse_relationship_id)  REFERENCES cdm.relationship (relationship_id);

ALTER TABLE cdm.concept_synonym ADD CONSTRAINT fpk_concept_synonym_concept01 FOREIGN KEY (concept_id)  REFERENCES cdm.concept (concept_id);

ALTER TABLE cdm.concept_synonym ADD CONSTRAINT fpk_concept_synonym_concept02 FOREIGN KEY (language_concept_id)  REFERENCES cdm.concept (concept_id);

ALTER TABLE cdm.concept_ancestor ADD CONSTRAINT fpk_concept_ancestor_concept_1 FOREIGN KEY (ancestor_concept_id)  REFERENCES cdm.concept (concept_id);

ALTER TABLE cdm.concept_ancestor ADD CONSTRAINT fpk_concept_ancestor_concept_2 FOREIGN KEY (descendant_concept_id)  REFERENCES cdm.concept (concept_id);

ALTER TABLE cdm.source_to_concept_map ADD CONSTRAINT fpk_source_to_concept_map_v_1 FOREIGN KEY (source_vocabulary_id)  REFERENCES cdm.vocabulary (vocabulary_id);

ALTER TABLE cdm.source_to_concept_map ADD CONSTRAINT fpk_source_to_concept_map_v_2 FOREIGN KEY (target_vocabulary_id)  REFERENCES cdm.vocabulary (vocabulary_id);

ALTER TABLE cdm.source_to_concept_map ADD CONSTRAINT fpk_source_to_concept_map_c_1 FOREIGN KEY (target_concept_id)  REFERENCES cdm.concept (concept_id);

ALTER TABLE cdm.drug_strength ADD CONSTRAINT fpk_drug_strength_concept_1 FOREIGN KEY (drug_concept_id)  REFERENCES cdm.concept (concept_id);

ALTER TABLE cdm.drug_strength ADD CONSTRAINT fpk_drug_strength_concept_2 FOREIGN KEY (ingredient_concept_id)  REFERENCES cdm.concept (concept_id);

ALTER TABLE cdm.drug_strength ADD CONSTRAINT fpk_drug_strength_unit_1 FOREIGN KEY (amount_unit_concept_id)  REFERENCES cdm.concept (concept_id);

ALTER TABLE cdm.drug_strength ADD CONSTRAINT fpk_drug_strength_unit_2 FOREIGN KEY (numerator_unit_concept_id)  REFERENCES cdm.concept (concept_id);

ALTER TABLE cdm.drug_strength ADD CONSTRAINT fpk_drug_strength_unit_3 FOREIGN KEY (denominator_unit_concept_id)  REFERENCES cdm.concept (concept_id);


/************************
*************************
*************************
*************************

Unique constraints

*************************
*************************
*************************
************************/


ALTER TABLE cdm.concept_synonym ADD CONSTRAINT uq_concept_synonym UNIQUE (concept_id, concept_synonym_name, language_concept_id);


/************************
*************************
*************************
*************************

Check constraints

*************************
*************************
*************************
************************/


ALTER TABLE cdm.concept ADD CONSTRAINT chk_c_concept_name CHECK (concept_name <> '');

ALTER TABLE cdm.concept ADD CONSTRAINT chk_c_standard_concept CHECK (COALESCE(standard_concept,'C') in ('C','S'));

ALTER TABLE cdm.concept ADD CONSTRAINT chk_c_concept_code CHECK (concept_code <> '');

ALTER TABLE cdm.concept ADD CONSTRAINT chk_c_invalid_reason CHECK (COALESCE(invalid_reason,'D') in ('D','U'));

ALTER TABLE cdm.concept_relationship ADD CONSTRAINT chk_cr_invalid_reason CHECK (COALESCE(invalid_reason,'D')='D');

ALTER TABLE cdm.concept_synonym ADD CONSTRAINT chk_csyn_concept_synonym_name CHECK (concept_synonym_name <> '');

