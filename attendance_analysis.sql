-- Query 1: 
SELECT
    attendance_status,
    COUNT(*) AS total_records,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM attendance),
        2
    ) AS percentage
FROM attendance
GROUP BY attendance_status
ORDER BY total_records DESC;

-- Output:
-- Present      | 95079 | 68.05
-- Late         | 12606 | 9.02
-- Annual Leave | 9821  | 7.03
-- Remote       | 8269  | 5.92
-- Sick Leave   | 7018  | 5.02
-- Absent       | 6921  | 4.95

-- Query 2: 
SELECT
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    SUM(
        CASE
            WHEN a.attendance_status = 'Present' THEN 1
            ELSE 0
        END
    ) AS present_days,
    SUM(
        CASE
            WHEN a.attendance_status = 'Absent' THEN 1
            ELSE 0
        END
    ) AS absent_days,
    SUM(
        CASE
            WHEN a.attendance_status = 'Late' THEN 1
            ELSE 0
        END
    ) AS late_days
FROM attendance a
JOIN employees e
    ON a.employee_id = e.employee_id
GROUP BY
    e.employee_id,
    e.first_name,
    e.last_name
ORDER BY
    present_days DESC,
    e.employee_id
LIMIT 10;

-- Output:
-- 1878 | Reem Hassan    | 19 | 0 | 0
-- 7280 | Yasmin Ali     | 19 | 0 | 0
-- 118  | Sherif Lotfy   | 18 | 0 | 1
-- 772  | Karim Kamal    | 18 | 1 | 0
-- 2533 | Hassan Saber   | 18 | 0 | 0
-- 3217 | Yasmin Sayed   | 18 | 1 | 1
-- 3648 | Reem Gamal     | 18 | 0 | 1
-- 5021 | Tarek Saber    | 18 | 0 | 0
-- 5073 | Nour Farouk    | 18 | 0 | 0
-- 5583 | Khaled Mansour | 18 | 0 | 0
-- Query 3:
SELECT
    d.department_name,
    COUNT(*) AS total_records,
    SUM(CASE WHEN a.attendance_status = 'Present' THEN 1 ELSE 0 END) AS present_days,
    SUM(CASE WHEN a.attendance_status = 'Absent' THEN 1 ELSE 0 END) AS absent_days,
    SUM(CASE WHEN a.attendance_status = 'Late' THEN 1 ELSE 0 END) AS late_days,
    ROUND(
        SUM(CASE WHEN a.attendance_status = 'Present' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attendance_percentage
FROM attendance a
JOIN employees e
    ON a.employee_id = e.employee_id
JOIN departments d
    ON e.department_id = d.department_id
GROUP BY
    d.department_id,
    d.department_name
ORDER BY attendance_percentage DESC;

-- Output:
-- Marketing        | 17573 | 12035 | 870 | 1588 | 68.49
-- Sales            | 17623 | 12046 | 830 | 1554 | 68.35
-- Finance          | 18150 | 12396 | 925 | 1612 | 68.30
-- Human Resources  | 16911 | 11518 | 820 | 1528 | 68.11
-- Data & Analytics | 17213 | 11717 | 826 | 1508 | 68.07
-- Operations       | 17314 | 11776 | 907 | 1551 | 68.01
-- Customer Support | 17764 | 12041 | 893 | 1656 | 67.78
-- IT               | 17166 | 11550 | 850 | 1609 | 67.28 

-- Query 4:
SELECT
    l.city,
    l.region,
    l.country,
    COUNT(*) AS total_records,
    SUM(CASE WHEN a.attendance_status = 'Present' THEN 1 ELSE 0 END) AS present_days,
    SUM(CASE WHEN a.attendance_status = 'Absent' THEN 1 ELSE 0 END) AS absent_days,
    SUM(CASE WHEN a.attendance_status = 'Late' THEN 1 ELSE 0 END) AS late_days,
    ROUND(
        SUM(CASE WHEN a.attendance_status = 'Present' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attendance_percentage
FROM attendance a
JOIN employees e
    ON a.employee_id = e.employee_id
JOIN locations l
    ON e.location_id = l.location_id
GROUP BY
    l.location_id,
    l.city,
    l.region,
    l.country
ORDER BY attendance_percentage DESC;

-- Output:
-- Assiut     | Upper Egypt   | Egypt | 23331 | 15967 | 1149 | 2034 | 68.44
-- Banha      | Qalyubia      | Egypt | 23366 | 15977 | 1141 | 2102 | 68.38
-- Mansoura   | Dakahlia      | Egypt | 23685 | 16144 | 1128 | 2139 | 68.16
-- Cairo      | Greater Cairo | Egypt | 21644 | 14702 | 1069 | 1949 | 67.93
-- Alexandria | Alexandria    | Egypt | 24373 | 16557 | 1248 | 2240 | 67.93
-- Giza       | Greater Cairo | Egypt | 23315 | 15732 | 1186 | 2142 | 67.48

-- Query 5:
SELECT
    e.employment_type,
    COUNT(*) AS total_records,
    SUM(CASE WHEN a.attendance_status = 'Present' THEN 1 ELSE 0 END) AS present_days,
    SUM(CASE WHEN a.attendance_status = 'Absent' THEN 1 ELSE 0 END) AS absent_days,
    SUM(CASE WHEN a.attendance_status = 'Late' THEN 1 ELSE 0 END) AS late_days,
    ROUND(
        SUM(CASE WHEN a.attendance_status = 'Present' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attendance_percentage
FROM attendance a
JOIN employees e
    ON a.employee_id = e.employee_id
GROUP BY e.employment_type
ORDER BY attendance_percentage DESC;

-- Output:
-- Contract  | 28889 | 19757 | 1399 | 2542 | 68.39
-- Part-time | 28072 | 19080 | 1402 | 2581 | 67.97
-- Full-time | 82753 | 56242 | 4120 | 7483 | 67.96


