SELECT
    exit_type,
    COUNT(*) AS total_exits,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM employee_exits),
        2
    ) AS percentage_of_exits
FROM employee_exits
GROUP BY exit_type
ORDER BY total_exits DESC;
-- Query 1 Results:
 --Voluntary	1420	72.26
--Involuntary	545	27.74 
-- Query 2:
SELECT
    eligible_for_rehire,
    COUNT(*) AS total_exits
FROM employee_exits
GROUP BY eligible_for_rehire
ORDER BY total_exits DESC;

-- Query 2 Results:
-- No  | 1022
-- Yes | 943
-- Query 3: 
SELECT
    exit_reason,
    COUNT(*) AS total_exits
FROM employee_exits
GROUP BY exit_reason
ORDER BY total_exits DESC;

-- Query 3 Results:
-- Career Growth        | 288
-- Personal Reasons     | 288
-- Compensation         | 288
-- Manager Relationship | 280
-- Relocation            | 276
-- Performance           | 274
-- Retirement            | 271

-- Query 4: 

SELECT
    d.department_name,
    COUNT(DISTINCT e.employee_id) AS total_employees,
    COUNT(DISTINCT x.employee_id) AS employees_who_left,
    ROUND(
        COUNT(DISTINCT x.employee_id) * 100.0 /
        COUNT(DISTINCT e.employee_id),
        2
    ) AS exit_rate_percentage
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
LEFT JOIN employee_exits x
    ON e.employee_id = x.employee_id
GROUP BY
    d.department_id,
    d.department_name
ORDER BY exit_rate_percentage DESC;

-- Query 4 Results:
-- IT               | 1235 | 275 | 22.27%
-- Operations       | 1238 | 260 | 21.00%
-- Sales            | 1251 | 260 | 20.78%
-- Finance          | 1305 | 262 | 20.08%
-- Data & Analytics | 1228 | 240 | 19.54%
-- Customer Support | 1274 | 237 | 18.60%
-- Human Resources  | 1210 | 213 | 17.60%
-- Marketing        | 1259 | 218 | 17.32%
-- Query 5: 
SELECT
    e.employment_type,
    COUNT(DISTINCT e.employee_id) AS total_employees,
    COUNT(DISTINCT x.employee_id) AS employees_who_left,
    ROUND(
        COUNT(DISTINCT x.employee_id) * 100.0 /
        COUNT(DISTINCT e.employee_id),
        2
    ) AS exit_rate_percentage
FROM employees e
LEFT JOIN employee_exits x
    ON e.employee_id = x.employee_id
GROUP BY e.employment_type
ORDER BY exit_rate_percentage DESC;

-- Query 5 Results:
-- Part-time | 1985 | 416  | 20.96%
-- Full-time | 5943 | 1151 | 19.37%
-- Contract  | 2072 | 398  | 19.21%

-- Query 6:
SELECT
    e.gender,
    COUNT(DISTINCT e.employee_id) AS total_employees,
    COUNT(DISTINCT x.employee_id) AS employees_who_left,
    ROUND(
        COUNT(DISTINCT x.employee_id) * 100.0 /
        COUNT(DISTINCT e.employee_id),
        2
    ) AS exit_rate_percentage
FROM employees e
LEFT JOIN employee_exits x
    ON e.employee_id = x.employee_id
GROUP BY e.gender
ORDER BY exit_rate_percentage DESC;

-- Query 6 Results:
-- Female            | 3281 | 672 | 20.48%
-- Male              | 3400 | 675 | 19.85%
-- Prefer not to say | 3319 | 618 | 18.62%
-- Query 7: 
SELECT
    CASE
        WHEN TIMESTAMPDIFF(YEAR, e.hire_date, '2025-12-31') < 1
            THEN 'Less than 1 year'
        WHEN TIMESTAMPDIFF(YEAR, e.hire_date, '2025-12-31') BETWEEN 1 AND 2
            THEN '1-2 years'
        WHEN TIMESTAMPDIFF(YEAR, e.hire_date, '2025-12-31') BETWEEN 3 AND 4
            THEN '3-4 years'
        ELSE '5+ years'
    END AS tenure_group,
    COUNT(DISTINCT e.employee_id) AS total_employees,
    COUNT(DISTINCT x.employee_id) AS employees_who_left,
    ROUND(
        COUNT(DISTINCT x.employee_id) * 100.0 /
        COUNT(DISTINCT e.employee_id),
        2
    ) AS exit_rate_percentage
FROM employees e
LEFT JOIN employee_exits x
    ON e.employee_id = x.employee_id
GROUP BY tenure_group
ORDER BY
    CASE tenure_group
        WHEN 'Less than 1 year' THEN 1
        WHEN '1-2 years' THEN 2
        WHEN '3-4 years' THEN 3
        ELSE 4
    END;

-- Query 7 Results:
-- Less than 1 year | 1302 | 0   | 0.00%
-- 1-2 years        | 2411 | 532 | 22.07%
-- 3-4 years        | 2442 | 539 | 22.07%
-- 5+ years         | 3845 | 894 | 23.25%
-- Query 8: 
SELECT
    exit_type,
    exit_reason,
    COUNT(*) AS total_exits
FROM employee_exits
GROUP BY
    exit_type,
    exit_reason
ORDER BY
    exit_type,
    total_exits DESC;

-- Query 8 Results:
-- Involuntary | Retirement           | 86
-- Involuntary | Career Growth        | 85
-- Involuntary | Relocation           | 81
-- Involuntary | Personal Reasons     | 76
-- Involuntary | Performance          | 75
-- Involuntary | Manager Relationship | 74
-- Involuntary | Compensation         | 68
-- Voluntary   | Compensation         | 220
-- Voluntary   | Personal Reasons     | 212
-- Voluntary   | Manager Relationship | 206
-- Voluntary   | Career Growth        | 203
-- Voluntary   | Performance          | 199
-- Voluntary   | Relocation           | 195
-- Voluntary   | Retirement           | 185


