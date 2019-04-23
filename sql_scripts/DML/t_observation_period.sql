USE APCD;

IF (OBJECT_ID('cdm.observation_period') IS NOT NULL) TRUNCATE TABLE cdm.observation_period;

INSERT INTO cdm.observation_period(person_id, observation_period_start_date, observation_period_end_date, period_type_concept_id)

SELECT
  make_dates.patkey AS person_id
  ,DATEFROMPARTS(make_dates.year_start, make_dates.month_start, 1) AS observation_period_start_date
  ,EOMONTH(DATEFROMPARTS(make_dates.year_end, make_dates.month_end, 1), 0) AS observation_period_end_date
  ,(SELECT c.concept_id AS period_type_concept_id
    FROM cdm.concept c
    WHERE c.vocabulary_id = 'Obs Period Type' AND c.concept_name = 'Period while enrolled in insurance'
  ) AS period_type_concept_id

FROM

  (SELECT DISTINCT
    add_start_and_end.patkey AS patkey
    ,CAST(add_start_and_end.period_start AS INT) % 12 + 1 AS month_start
    ,CAST(add_start_and_end.period_end AS INT) % 12 + 1 AS month_end
    ,FLOOR(add_start_and_end.period_start/12) + 2015 AS year_start
    ,FLOOR(add_start_and_end.period_end/12) + 2015 AS year_end

  FROM

    (SELECT
      add_period_id.patkey AS patkey
      ,MIN(add_period_id.elig_period) OVER (PARTITION BY add_period_id.patkey, add_period_id.period_id) AS period_start
      ,MAX(add_period_id.elig_period) OVER (PARTITION BY add_period_id.patkey, add_period_id.period_id) AS period_end

    FROM

      (SELECT
        add_period_flag.patkey AS patkey
        ,add_period_flag.elig_period AS elig_period
        ,SUM(add_period_flag.new_period_flag) OVER (PARTITION BY add_period_flag.patkey ORDER BY add_period_flag.elig_period ROWS UNBOUNDED PRECEDING) AS period_id

      FROM

        (SELECT
          lag_elig_periods.patkey AS patkey
          ,lag_elig_periods.elig_period AS elig_period
          ,lag_elig_periods.lag_elig_period AS lag_elig_period
          ,CASE
            WHEN lag_elig_periods.lag_elig_period IS NULL OR lag_elig_periods.elig_period - lag_elig_periods.lag_elig_period > 1
              THEN 1
              ELSE 0
          END AS new_period_flag

        FROM

          (SELECT
            elig_periods.patkey AS patkey
            ,elig_periods.elig_period AS elig_period
            ,LAG(elig_periods.elig_period, 1, NULL) OVER (PARTITION BY elig_periods.patkey ORDER BY elig_periods.elig_period) AS lag_elig_period

          FROM

            (SELECT 
              me.patkey AS patkey
              ,(me.year - 2015)*12 + me.month - 1 AS elig_period

            FROM rch.me AS me
            
            ) AS elig_periods
          ) AS lag_elig_periods
        ) AS add_period_flag
      ) AS add_period_id
    ) AS add_start_and_end
  ) AS make_dates
;