-- Query 1:
SELECT
    YEAR(promotion_date) AS promotion_year,
    COUNT(*) AS total_promotions
FROM promotions
GROUP BY YEAR(promotion_date)
ORDER BY promotion_year;

-- Results:
-- 2019 | 37
-- 2020 | 86
-- 2021 | 137
-- 2022 | 190
-- 2023 | 260
-- 2024 | 280
-- 2025 | 257
-- Query 2: 
SELECT
    YEAR(promotion_date) AS promotion_year,
    COUNT(*) AS total_promotions,
    ROUND(AVG(salary_after - salary_before), 2) AS average_increase
FROM promotions
GROUP BY YEAR(promotion_date)
ORDER BY promotion_year;

-- Results:
-- 2019 | 37  | 4654.95
-- 2020 | 86  | 4742.62
-- 2021 | 137 | 4539.91
-- 2022 | 190 | 4360.70
-- 2023 | 260 | 4218.67
-- 2024 | 280 | 4129.09
-- 2025 | 257 | 4005.27
-- Query 3: 
SELECT
    CASE
        WHEN previous_job_role_id = new_job_role_id
            THEN 'Same Job Role'
        ELSE 'Changed Job Role'
    END AS promotion_type,
    COUNT(*) AS total_promotions,
    ROUND(AVG(salary_after - salary_before), 2) AS average_increase
FROM promotions
GROUP BY promotion_type
ORDER BY total_promotions DESC;

-- Results:
-- Changed Job Role | 1168 | 4258.28
-- Same Job Role    | 79   | 4294.70

