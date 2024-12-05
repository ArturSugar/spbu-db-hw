-- Таблица с информацией о продуктах
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    product_type VARCHAR(50),
    weight DECIMAL(5, 2),
    price DECIMAL(10, 2));

-- Таблица с информацией о сотрудниках
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    position VARCHAR(50),
    salary DECIMAL(10, 2));

-- Таблица с информацией о заказах
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    product_id INT REFERENCES products(product_id),
    quantity INT NOT NULL,
    order_date DATE NOT NULL);

INSERT INTO products (product_name, product_type, weight, price) VALUES
('Молочный шоколад', 'Молочный', 100, 250.00),
('Темный шоколад', 'Темный', 100, 300.00),
('Белый шоколад', 'Белый', 100, 280.00),
('Шоколад с фундуком', 'Молочный', 150, 400.00),
('Шоколад с карамелью', 'Молочный', 120, 350.00),
('Шоколад с миндалем', 'Темный', 130, 420.00),
('Клубничный шоколад', 'Белый', 100, 300.00),
('Шоколад с изюмом', 'Молочный', 140, 380.00),
('Шоколад с орехами и медом', 'Темный', 160, 500.00),
('Шоколад с печеньем', 'Молочный', 130, 390.00),
('Шоколад с апельсином', 'Темный', 120, 370.00),
('Щоколад с карамелью', 'Молочный', 100, 320.00),
('Шоколад с морской солью', 'Темный', 110, 380.00);

INSERT INTO employees (first_name, last_name, position, salary) VALUES
('Анна', 'Иванова', 'Шоколатье', 300000.00),
('Петр', 'Сидоров', 'Контроль качества', 280000.00),
('Ольга', 'Кузнецова', 'Менеджер по продажам', 350000.00),
('Мария', 'Смирнова', 'Упаковщик', 250000.00),
('Елена', 'Васильева', 'Бухгалтер', 340000.00),
('Алексей', 'Николаев', 'Инженер по оборудованию', 360000.00),
('Татьяна', 'Михайлова', 'Начальник смены', 380000.00),
('Наталья', 'Романова', 'Оператор', 260000.00),
('Владимир', 'Крылов', 'Технолог', 400000.00);

INSERT INTO orders (customer_name, product_id, quantity, order_date) VALUES
('Компания А', 1, 500, '2024-12-01'),
('Компания Б', 2, 300, '2024-12-02'),
('Компания В', 3, 150, '2024-12-03'),
('Компания А', 4, 100, '2024-12-04'),
('Компания Г', 5, 200, '2024-12-05'),
('Компания Д', 6, 250, '2024-12-06'),
('Компания Е', 7, 180, '2024-12-05'),
('Компания Ж', 8, 300, '2024-12-08'),
('Компания А', 2, 400, '2024-12-09'),
('Компания Б', 1, 350, '2024-12-10'),
('Компания З', 9, 220, '2024-12-11'),
('Компания И', 10, 270, '2024-12-11'),
('Компания К', 11, 320, '2024-12-11'),
('Компания Л', 12, 190, '2024-12-14'),
('Компания М', 13, 210, '2024-12-11');


-- 1. Найти сотрудников с зарплатой выше 300000
SELECT * FROM employees WHERE salary > 300000 LIMIT 10;

-- 2. Заказы, сделанные после 10 декабря 2024 года
SELECT * FROM orders WHERE order_date > '2024-12-10' LIMIT 10;

-- 3. Найти среднюю зарплату сотрудников
SELECT AVG(salary) AS average_salary FROM employees;

-- 4. Посчитать общее количество заказов для каждого продукта
SELECT product_id, COUNT(order_id) AS total_orders
FROM orders
GROUP BY product_id
LIMIT 100;

-- 5. Топ продаж в штуках
SELECT product_id, SUM(quantity) AS total_quantity
FROM orders
GROUP BY product_id
ORDER BY total_quantity DESC
LIMIT 10;

-- 6. Самый продаваемый тип шоколада в штуках
SELECT p.product_type, SUM(o.quantity) AS total_quantity
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_type
ORDER BY total_quantity DESC
LIMIT 1;

-- 7. Самые большие заказы по выручке
SELECT o.order_id, o.customer_name, o.product_id, o.quantity, o.order_date, (o.quantity * p.price) AS total_price
FROM orders o
JOIN products p ON o.product_id = p.product_id
ORDER BY total_price DESC
LIMIT 10;
