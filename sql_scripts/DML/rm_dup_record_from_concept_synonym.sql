USE APCD;

DELETE FROM cdm.concept_synonym WHERE cdm.concept_synonym.concept_id = 43534828 AND cdm.concept_synonym.concept_synonym_name = 'PHENIBUT'
;

INSERT INTO cdm.concept_synonym VALUES(43534828, 'PHENIBUT', 4180186)