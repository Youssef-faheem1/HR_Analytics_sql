-- Query 1:
SELECT
    change_reason,
    COUNT(*) AS total_changes,
    ROUND(AVG(salary), 2) AS average_salary,
    ROUND(MIN(salary), 2) AS minimum_salary,
    ROUND(MAX(salary), 2) AS maximum_salary
FROM salary_history
GROUP BY change_reason
ORDER BY total_changes DESC;

-- Output:
-- Annual Review     | 4248 | 16725.04 | 5243.39 | 40261.24
-- Promotion         | 4145 | 16772.85 | 5347.54 | 43454.22
-- Role Change       | 4139 | 16594.74 | 5385.29 | 42196.65
-- Market Adjustment | 4114 | 16591.60 | 5183.13 | 44422.58
-- New Hire          | 4046 | 16707.33 | 5389.19 | 42559.96

-- Query 2:
SELECT
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    COUNT(sh.salary_history_id) AS salary_records,
    ROUND(AVG(sh.salary), 2) AS average_salary
FROM salary_history sh
JOIN employees e
    ON sh.employee_id = e.employee_id
GROUP BY
    e.employee_id,
    e.first_name,
    e.last_name
ORDER BY average_salary DESC
LIMIT 10;

-- Output:
-- 8993 | Ahmed Abdelrahman | 3 | 40288.61
-- 4712 | Jana Abdelrahman  | 3 | 39772.27
-- 1084 | Laila Fathy       | 4 | 38866.03
-- 1996 | Nour Fathy        | 4 | 38633.36
-- 6467 | Ali Gamal         | 3 | 38146.70
-- 3480 | Adel Tawfik       | 4 | 38077.39
-- 9168 | Malak Samir       | 2 | 37839.53
-- 1119 | Nour Kamal        | 4 | 37518.78
-- 9490 | Ahmed Sayed       | 4 | 37435.06
-- 4765 | Farah Mostafa     | 4 | 37105.29 

-- Query 3: 
SELECT
    d.department_name,
    COUNT(sh.salary_history_id) AS total_salary_records,
    ROUND(AVG(sh.salary), 2) AS average_salary
FROM salary_history sh
JOIN employees e
    ON sh.employee_id = e.employee_id
JOIN departments d
    ON e.department_id = d.department_id
GROUP BY
    d.department_id,
    d.department_name
ORDER BY average_salary DESC;

-- Results:
-- Data & Analytics | 2552 | 21942.83
-- IT | 2564 | 18566.92
-- Finance | 2680 | 17233.78
-- Marketing | 2641 | 16335.67
-- Sales | 2565 | 16173.68
-- Operations | 2522 | 16114.05
-- Human Resources | 2525 | 15177.25
-- Customer Support | 2643 | 12006.20

-- Query 4:
SELECT
    YEAR(effective_date) AS salary_year,
    COUNT(*) AS total_records,
    ROUND(AVG(salary), 2) AS average_salary
FROM salary_history
GROUP BY YEAR(effective_date)
ORDER BY salary_year;

-- Results:
-- 2018 | 1336 | 16141.71
-- 2019 | 2184 | 16565.99
-- 2020 | 2716 | 16672.99
-- 2021 | 2858 | 16741.37
-- 2022 | 2908 | 16761.92
-- 2023 | 2893 | 16809.92
-- 2024 | 2813 | 16754.56
-- 2025 | 2984 | 16665.97

