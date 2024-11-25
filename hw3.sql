-- Создание таблицы сотрудников
CREATE TABLE IF NOT EXISTS employees (
employee_id SERIAL PRIMARY KEY,
name VARCHAR(50) NOT NULL,
position VARCHAR(50) NOT NULL,
department VARCHAR(50) NOT NULL,
salary NUMERIC(10, 2) NOT NULL,
manager_id INT REFERENCES employees(employee_id));

-- Заполнение таблицы сотрудников
INSERT INTO employees (name, position, department, salary, manager_id)
VALUES
('Павел Алимов', 'Менеджер', 'Продажи', 85000, NULL),
('Давид Асатуров', 'Специалист по продажам', 'Продажи', 60000, 1),
('Эшгин Байрамов', 'Специалист по продажам', 'Продажи', 60000, 1),
('Данил Белоусов', 'Стажер по продажам', 'Продажи', 40000, 2),
('Всеволод Битепаж', 'Стажер по продажам', 'Продажи', 40000, 3),
('Артем Буренок', 'Разработчик', 'IT', 90000, 25),
('Диана Винницкая', 'Разработчик', 'IT', 90000, 25),
('Элина Владимирова', 'Специалист по поддержке', 'Техническая поддержка', 55000, NULL),
('Егор Вундер', 'Специалист по поддержке', 'Техническая поддержка', 55000, 8),
('Николай Григорьев', 'Тестировщик', 'Тестирование', 60000, 25),
('Ян Егоров', 'Тестировщик', 'Тестирование', 60000, 25),
('Артем Ермаков', 'Менеджер', 'Техническая поддержка', 70000, NULL),
('Даниил Ерофеевский', 'Специалист по продажам', 'Продажи', 60000, 1),
('Максим Есин', 'Разработчик', 'IT', 95000, 25),
('Данила Заварзин', 'Стажер', 'Продажи', 40000, 2),
('Борис Закатов', 'Разработчик', 'IT', 95000, 25),
('Абакар Махамат', 'Менеджер', 'Тестирование', 75000, NULL),
('Фис Де Дье Алуна Нку', 'Специалист по поддержке', 'Техническая поддержка', 55000, 8),
('Абубакари Ба', 'Разработчик', 'IT', 85000, 25),
('Владислав Байханов', 'Специалист по продажам', 'Продажи', 60000, 1),
('Михаил Минаев', 'Тестировщик', 'Тестирование', 60000, 18),
('Анна Овчинникова', 'Разработчик', 'IT', 85000, 25),
('Роман Павлов', 'Разработчик', 'IT', 90000, 25),
('Анна Платонова', 'Специалист по продажам', 'Продажи', 60000, 1),
('Георгий Пономарев', 'Специалист по поддержке', 'Техническая поддержка', 55000, 8),
('Данил Прибытков', 'Стажер', 'Техническая поддержка', 40000, 8),
('Артём Пышный', 'Тестировщик', 'Тестирование', 60000, 18),
('Александра Решетникова', 'Специалист по продажам', 'Продажи', 60000, 1),
('Вадим Сазанов', 'Менеджер', 'Техническая поддержка', 70000, NULL),
('Артур Сахаров', 'Менеджер', 'IT', 100000, NULL),
('Глеб Семакин', 'Разработчик', 'IT', 90000, 25),
('Софья Теплинских', 'Специалист по продажам', 'Продажи', 60000, 1),
('Максим Трапер', 'Тестировщик', 'Тестирование', 60000, 25),
('Максим Трифонов', 'Тестировщик', 'Тестирование', 60000, 25),
('Артём Федосеев', 'Стажер по продажам', 'Продажи', 40000, 2),
('Анна Цветкова', 'Специалист по продажам', 'Продажи', 60000, 1),
('Вероника Циунчик', 'Стажер', 'Тестирование', 40000, 18),
('Артём Чекалев', 'Разработчик', 'IT', 90000, 25),
('Бандиугу Сиссоко', 'Разработчик', 'IT', 90000, 25),
('Цзучэн Лю', 'Разработчик', 'IT', 95000, 25),
('Лэ Чан', 'Разработчик', 'IT', 95000, 25);

-- Создание таблицы продуктов
CREATE TABLE IF NOT EXISTS products (
product_id SERIAL PRIMARY KEY,
name VARCHAR(50) NOT NULL,
price NUMERIC(10, 2) NOT NULL);

-- Заполнение таблицы продуктов
INSERT INTO products (name, price)
VALUES
('iPhone 15 Pro', 120000.00),
('MacBook Pro 16"', 250000.00),
('iPad Pro 12.9"', 100000.00),
('Apple Watch Ultra', 90000.00),
('AirPods Pro 2', 25000.00),
('iMac 24"', 150000.00),
('Mac Mini M2', 70000.00),
('Apple TV 4K', 20000.00),
('Magic Keyboard', 15000.00),
('Magic Mouse', 10000.00);

-- Создание таблицы продаж
CREATE TABLE IF NOT EXISTS sales (
sale_id SERIAL PRIMARY KEY,
employee_id INT REFERENCES employees(employee_id),
product_id INT REFERENCES products(product_id),
quantity INT NOT NULL,
sale_date DATE NOT NULL);

-- Заполнение таблицы продаж
INSERT INTO sales (employee_id, product_id, quantity, sale_date)
VALUES
(2, 1, 7, '2024-09-05'),
(3, 2, 5, '2024-09-10'),
(5, 3, 12, '2024-09-15'),
(6, 4, 3, '2024-09-20'),
(7, 5, 10, '2024-09-25'),
(8, 6, 1, '2024-09-28'),
(9, 7, 4, '2024-09-30'),
(2, 1, 10, '2024-10-05'),
(3, 2, 8, '2024-10-08'),
(5, 3, 15, '2024-10-12'),
(6, 4, 4, '2024-10-15'),
(7, 5, 7, '2024-10-18'),
(8, 6, 2, '2024-10-20'),
(9, 7, 3, '2024-10-22'),
(10, 8, 5, '2024-10-25'),
(11, 9, 6, '2024-10-28'),
(2, 1, 5, '2024-11-01'),
(3, 2, 6, '2024-11-03'),
(5, 3, 9, '2024-11-07'),
(6, 4, 2, '2024-11-08'),
(7, 5, 11, '2024-11-10'),
(8, 6, 1, '2024-11-12'),
(9, 7, 6, '2024-11-14'),
(10, 8, 4, '2024-11-15'),
(11, 9, 5, '2024-11-16'),
(12, 10, 7, '2024-11-24'),
(7, 5, 17, '2024-11-25'),
(8, 6, 20, '2024-11-26'),
(9, 7, 15, '2024-11-30');


-- **1**
CREATE TEMP TABLE high_sales_products AS
SELECT
p.product_id,
p.name AS product_name,
SUM(s.quantity) AS total_quantity
FROM sales s
JOIN products p ON s.product_id = p.product_id
WHERE s.sale_date >= CURRENT_DATE - INTERVAL '7 days'
GROUP BY p.product_id, p.name
HAVING SUM(s.quantity) > 10;
SELECT * FROM high_sales_products
LIMIT 10;
--**2.1**
WITH employee_sales_stats AS (
SELECT
s.employee_id,
e.name AS employee_name,
COUNT(s.sale_id) AS total_sales_count,
AVG(s.quantity) AS avg_sales_quantity
FROM sales s
JOIN employees e ON s.employee_id = e.employee_id
WHERE s.sale_date >= CURRENT_DATE - INTERVAL '30 days'
GROUP BY s.employee_id, e.name)
SELECT * FROM employee_sales_stats
LIMIT 10;

--**2.2**
WITH company_avg_sales AS (
SELECT AVG(total_sales_count) AS avg_sales
FROM (
SELECT COUNT(sale_id) AS total_sales_count
FROM sales
WHERE sale_date >= CURRENT_DATE - INTERVAL '30 days'
GROUP BY employee_id) AS sales_per_employee),
employee_sales_stats AS (
SELECT s.employee_id,e.name AS employee_name,
COUNT(s.sale_id) AS total_sales_count
FROM sales s
JOIN employees e ON s.employee_id = e.employee_id
WHERE s.sale_date >= CURRENT_DATE - INTERVAL '30 days'
GROUP BY s.employee_id, e.name)
SELECT
es.employee_id,
es.employee_name,
es.total_sales_count
FROM employee_sales_stats es
CROSS JOIN company_avg_sales
WHERE es.total_sales_count > company_avg_sales.avg_sales
LIMIT 10;

--**3.1**
WITH RECURSIVE employee_hierarchy AS (
SELECT
employee_id,
name,
manager_id
FROM employees
WHERE name = 'Павел Алимов'

UNION ALL
SELECT
e.employee_id,
e.name,
e.manager_id
FROM employees e
JOIN employee_hierarchy eh ON e.manager_id = eh.employee_id)
SELECT name AS subordinate_name
FROM employee_hierarchy
WHERE employee_id != (SELECT employee_id FROM employees WHERE name = 'Павел Алимов');

--**3.2**
WITH monthly_product_sales AS (
SELECT
p.product_id,
p.name AS product_name,
SUM(s.quantity) AS total_quantity,
CASE
WHEN date_part('month', s.sale_date) = date_part('month', CURRENT_DATE) THEN 'Current Month'
WHEN date_part('month', s.sale_date) = date_part('month', CURRENT_DATE) - 1 THEN 'Previous Month'
END AS sales_month
FROM sales s
JOIN products p ON s.product_id = p.product_id
WHERE date_part('month', s.sale_date) IN (
date_part('month', CURRENT_DATE),
date_part('month', CURRENT_DATE) - 1)
GROUP BY p.product_id, p.name, sales_month)
SELECT
product_id,
product_name,
total_quantity,
sales_month
FROM monthly_product_sales
ORDER BY sales_month, total_quantity DESC
LIMIT 3;

--**4**
CREATE INDEX idx_employee_sale_date ON sales(employee_id, sale_date);
-- Выполнение запроса с индексом
EXPLAIN ANALYZE
SELECT *
FROM sales
WHERE employee_id = 2 AND sale_date BETWEEN '2024-11-01' AND '2024-11-30'
LIMIT 5;

-- время Execution Time без 0.023 ms что быстро ...