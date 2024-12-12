-- Временная таблица для заказов текущего месяца
CREATE TEMP TABLE temp_monthly_orders AS
SELECT o.order_id, o.customer_name, p.product_name, o.quantity, o.order_date
FROM orders o
JOIN products p ON o.product_id = p.product_id
WHERE o.order_date >= date_trunc('month', current_date)
LIMIT 100;

-- Временная таблица для сотрудников с зарплатой выше среднего
CREATE TEMP TABLE temp_high_salary_employees AS
SELECT e.employee_id, e.first_name, e.last_name, e.position, e.salary
FROM employees e
WHERE e.salary > (SELECT AVG(salary) FROM employees)
LIMIT 100;

-- Временная таблица для популярных продуктов (продано более 100 единиц за текущий месяц)
CREATE TEMP TABLE temp_popular_products AS
SELECT
p.product_id,
p.product_name,
SUM(o.quantity) AS total_sold
FROM orders o
JOIN products p ON o.product_id = p.product_id
WHERE o.order_date >= date_trunc('month', current_date)
GROUP BY p.product_id, p.product_name
HAVING SUM(o.quantity) > 100
LIMIT 100;


-- Представление для отображения прибыли от продаж по продуктам
CREATE VIEW sales_profit AS
SELECT
p.product_name,
SUM(o.quantity * p.price) AS total_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC
LIMIT 100;


-- Представление для проверки заказов с некорректным количеством
CREATE VIEW invalid_orders AS
SELECT *
FROM orders
WHERE quantity <= 0
LIMIT 100;


-- Представление для отображения списка всех заказов за текущий месяц
CREATE VIEW monthly_orders AS
SELECT
o.order_id,
o.customer_name,
p.product_name,
o.quantity,
o.order_date
FROM orders o
JOIN products p ON o.product_id = p.product_id
WHERE o.order_date >= date_trunc('month', current_date)
ORDER BY o.order_date
LIMIT 100;

-- Представление для отображения топ-3 самых популярных продуктов по количеству заказов
CREATE VIEW top_popular_products AS
SELECT
p.product_name,
SUM(o.quantity) AS total_sold
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC
LIMIT 3;

-- Представление для отображения сотрудников с зарплатой выше среднего
CREATE VIEW high_salary_employees AS
SELECT
e.employee_id,
e.first_name,
e.last_name,
e.position,
e.salary
FROM employees e
WHERE e.salary > (SELECT AVG(salary) FROM employees)
LIMIT 15;

-- Процедура для проверки корректности вводимых данных заказа
CREATE OR REPLACE FUNCTION validate_order_input( product_id INT,  quantity INT)
RETURNS BOOLEAN AS $$
BEGIN
    IF quantity <= 0 THEN
        RAISE EXCEPTION 'Количество должно быть больше 0';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM products WHERE product_id = product_id) THEN
        RAISE EXCEPTION 'Товар с таким ID не существует';
    END IF;

    RETURN TRUE;
END;
$$ LANGUAGE plpgsql;


