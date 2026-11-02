USE hr_analytics_project;

-- Query 1: 
SELECT
    rating,
    COUNT(*) AS total_reviews,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM performance_reviews),
        2
    ) AS percentage
FROM performance_reviews
GROUP BY rating
ORDER BY rating;

-- Query 1 Results:
-- Rating 1 | 4036 | 20.18%
-- Rating 2 | 4043 | 20.22%
-- Rating 3 | 3993 | 19.97%
-- Rating 4 | 3943 | 19.72%
-- Rating 5 | 3985 | 19.93%
-- Query 2:
SELECT
    d.department_name,
    COUNT(pr.review_id) AS total_reviews,
    ROUND(AVG(pr.rating), 2) AS average_rating
FROM performance_reviews pr
JOIN employees e
    ON pr.employee_id = e.employee_id
JOIN departments d
    ON e.department_id = d.department_id
GROUP BY
    d.department_id,
    d.department_name
ORDER BY average_rating DESC;

-- Query 2 Results:
-- Human Resources  | 2420 | 3.02
-- Data & Analytics | 2476 | 3.01
-- IT               | 2497 | 3.01
-- Sales            | 2497 | 3.01
-- Operations       | 2425 | 2.98
-- Customer Support | 2576 | 2.97
-- Finance          | 2602 | 2.97
-- Marketing        | 2507 | 2.95

-- Query 3: 
SELECT
    d.department_name,
    pr.rating,
    COUNT(*) AS total_reviews
FROM performance_reviews pr
JOIN employees e
    ON pr.employee_id = e.employee_id
JOIN departments d
    ON e.department_id = d.department_id
GROUP BY
    d.department_id,
    d.department_name,
    pr.rating
ORDER BY
    d.department_name,
    pr.rating;

-- Query 3 Results:
-- Customer Support | 1 | 521
-- Customer Support | 2 | 559
-- Customer Support | 3 | 485
-- Customer Support | 4 | 506
-- Customer Support | 5 | 505
-- Data & Analytics | 1 | 485
-- Data & Analytics | 2 | 497
-- Data & Analytics | 3 | 495
-- Data & Analytics | 4 | 505
-- Data & Analytics | 5 | 494
-- Finance          | 1 | 536
-- Finance          | 2 | 516
-- Finance          | 3 | 546
-- Finance          | 4 | 491
-- Finance          | 5 | 513
-- Human Resources  | 1 | 492
-- Human Resources  | 2 | 458
-- Human Resources  | 3 | 491
-- Human Resources  | 4 | 470
-- Human Resources  | 5 | 509
-- IT               | 1 | 477
-- IT               | 2 | 513
-- IT               | 3 | 501
-- IT               | 4 | 522
-- IT               | 5 | 484
-- Marketing        | 1 | 521
-- Marketing        | 2 | 516
-- Marketing        | 3 | 520
-- Marketing        | 4 | 455
-- Marketing        | 5 | 495
-- Operations       | 1 | 513
-- Operations       | 2 | 481
-- Operations       | 3 | 461
-- Operations       | 4 | 478
-- Operations       | 5 | 492
-- Sales            | 1 | 491
-- Sales            | 2 | 503
-- Sales            | 3 | 494
-- Sales            | 4 | 516
-- Sales            | 5 | 493
-- Query 4: 
SELECT
    CASE
        WHEN average_rating >= 4 THEN 'High Performance'
        WHEN average_rating >= 3 THEN 'Medium Performance'
        ELSE 'Low Performance'
    END AS performance_level,
    COUNT(*) AS total_employees
FROM (
    SELECT
        employee_id,
        AVG(rating) AS average_rating
    FROM performance_reviews
    GROUP BY employee_id
) AS employee_performance
GROUP BY performance_level
ORDER BY total_employees DESC;

-- Output:
-- Low Performance    | 4073
-- Medium Performance | 3286
-- High Performance   | 2641

-- Query 5: 
SELECT
    YEAR(review_date) AS review_year,
    COUNT(*) AS total_reviews,
    COUNT(DISTINCT employee_id) AS reviewed_employees,
    ROUND(AVG(rating), 2) AS average_rating
FROM performance_reviews
GROUP BY YEAR(review_date)
ORDER BY review_year;

-- Output:
-- 2022 | 5111 | 5111 | 3.01
-- 2023 | 4934 | 4934 | 3.00
-- 2024 | 4978 | 4978 | 2.98
-- 2025 | 4977 | 4977 | 2.98
