/************************************************************************
Copyright 2018 Observational Health Data Sciences and Informatics

This file is part of Legend

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
************************************************************************/
SELECT concept_id AS filter_concept_id,
	concept_name AS filter_concept_name,
	descendant_concept_id AS concept_id
FROM @cdm_database_schema.concept
INNER JOIN @cdm_database_schema.concept_ancestor
	ON concept_id = ancestor_concept_id
WHERE descendant_concept_id IN (@exposure_concept_ids)
	AND (
		vocabulary_id = 'ATC'
		OR ancestor_concept_id = descendant_concept_id
		OR concept_class_id = 'Procedure'
		)

UNION

SELECT concept_id AS filter_concept_id,
	concept_name AS filter_concept_name,
	ancestor_concept_id AS concept_id
FROM @cdm_database_schema.concept
INNER JOIN @cdm_database_schema.concept_ancestor
	ON concept_id = descendant_concept_id
WHERE ancestor_concept_id IN (@exposure_concept_ids)