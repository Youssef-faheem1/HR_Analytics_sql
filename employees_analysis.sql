-- Query 1: 
SELECT
    employment_type,
    COUNT(*) AS total_employees
FROM employees
GROUP BY employment_type
ORDER BY total_employees DESC;

-- Results:
-- Full-time | 5943
-- Contract  | 2072
-- Part-time | 1985
-- Query 2: 
SELECT
    employment_status,
    COUNT(*) AS total_employees
FROM employees
GROUP BY employment_status
ORDER BY total_employees DESC;

-- Results:
-- Active     | 8035
-- Resigned   | 1420
-- Terminated | 440
-- Retired    | 105

-- Query 3: 
SELECT
    d.department_name,
    COUNT(e.employee_id) AS total_employees,
    ROUND(AVG(e.salary), 2) AS average_salary
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY average_salary DESC;

-- Results:
-- Data & Analytics | 1228 | 23800.83
-- IT               | 1235 | 20335.01
-- Finance          | 1305 | 18760.39
-- Marketing        | 1259 | 17865.87
-- Operations       | 1238 | 17498.56
-- Sales            | 1251 | 17482.31
-- Human Resources  | 1210 | 16465.43
-- Customer Support | 1274 | 13170.09

-- Query 4: 
SELECT
    YEAR(hire_date) AS hire_year,
    COUNT(*) AS total_hires
FROM employees
GROUP BY YEAR(hire_date)
ORDER BY hire_year;

-- Results:
-- 2018 | 1306
-- 2019 | 1278
-- 2020 | 1261
-- 2021 | 1222
-- 2022 | 1220
-- 2023 | 1232
-- 2024 | 1179
-- 2025 | 1302

-- Query 5:
SELECT
    l.city,
    COUNT(e.employee_id) AS total_employees
FROM employees e
JOIN locations l
    ON e.location_id = l.location_id
GROUP BY l.city
ORDER BY total_employees DESC;

-- Results:
-- Alexandria | 1735
-- Mansoura   | 1700
-- Banha      | 1678
-- Giza       | 1671
-- Assiut     | 1664
-- Cairo      | 1552




