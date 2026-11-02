-- Query 1:
SELECT
    application_stage,
    COUNT(*) AS total_applications,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM recruitment),
        2
    ) AS percentage
FROM recruitment
GROUP BY application_stage
ORDER BY total_applications DESC;

-- Results:
-- Rejected            | 2926 | 16.26%
-- Applied             | 2662 | 14.79%
-- Phone Interview     | 2221 | 12.34%
-- Technical Interview | 2188 | 12.16%
-- Screening           | 2166 | 12.03%
-- Hired               | 1832 | 10.18%
-- Final Interview     | 1810 | 10.06%
-- Offer               | 1497 | 8.32%
-- Withdrawn           | 698  | 3.88%

-- Query 2:
SELECT
    candidate_source,
    COUNT(*) AS total_applications,
    SUM(CASE
        WHEN application_stage = 'Hired' THEN 1
        ELSE 0
    END) AS hired_candidates,
    ROUND(
        SUM(CASE
            WHEN application_stage = 'Hired' THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS hiring_rate
FROM recruitment
GROUP BY candidate_source
ORDER BY hiring_rate DESC;

-- Results:
-- University         | 3075 | 329 | 10.70%
-- Referral           | 3006 | 318 | 10.58%
-- LinkedIn           | 3014 | 313 | 10.38%
-- Company Website    | 2998 | 306 | 10.21%
-- Recruitment Agency | 2938 | 286 | 9.73%
-- Job Board          | 2969 | 280 | 9.43%

-- Query 3:
SELECT
    candidate_source,
    COUNT(*) AS total_applications,
    ROUND(AVG(days_to_hire), 2) AS average_days_to_hire
FROM recruitment
WHERE application_stage = 'Hired'
GROUP BY candidate_source
ORDER BY average_days_to_hire;

-- Results:
-- LinkedIn           | 313 | 39.56
-- Company Website    | 306 | 39.80
-- Recruitment Agency | 286 | 39.96
-- University         | 329 | 40.21
-- Referral           | 318 | 40.53
-- Job Board          | 280 | 40.67

-- Query 4:
SELECT
    application_stage,
    COUNT(*) AS total_applications,
    ROUND(AVG(offered_salary), 2) AS average_offered_salary
FROM recruitment
GROUP BY application_stage
ORDER BY average_offered_salary DESC;

-- Results:
-- Offer               | 1497 | 18634.78
-- Hired               | 1832 | 18413.51
-- Rejected            | 2926 | NULL
-- Screening           | 2166 | NULL
-- Applied             | 2662 | NULL
-- Withdrawn           | 698  | NULL
-- Final Interview     | 1810 | NULL
-- Phone Interview     | 2221 | NULL
-- Technical Interview | 2188 | NULL

