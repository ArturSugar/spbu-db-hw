--Создание таблицы логирования операций
CREATE TABLE IF NOT EXISTS sales_log (
log_id SERIAL PRIMARY KEY,
operation_type VARCHAR(50),
sale_id INT,
employee_id INT,
product_id INT,
quantity INT,
sale_date DATE,
operation_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

--Функция для логирования вставок
CREATE OR REPLACE FUNCTION log_sales_operations()
RETURNS TRIGGER AS $$
BEGIN
IF TG_OP = 'INSERT' THEN
INSERT INTO sales_log (operation_type, sale_id, employee_id, product_id, quantity, sale_date)
VALUES (TG_OP, NEW.sale_id, NEW.employee_id, NEW.product_id, NEW.quantity, NEW.sale_date);
RAISE NOTICE 'Insert operation logged: %', NEW.sale_id;
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--Создание триггера для логирования вставок
CREATE TRIGGER after_sales_insert
AFTER INSERT ON sales
FOR EACH ROW
EXECUTE FUNCTION log_sales_operations();

--Функция для проверки количества при обновлении
CREATE OR REPLACE FUNCTION check_sales_quantity()
RETURNS TRIGGER AS $$
BEGIN
IF NEW.quantity < 0 THEN
RAISE EXCEPTION 'Quantity cannot be negative: %', NEW.quantity;
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--Создание триггера для проверки при обновлении
CREATE TRIGGER before_sales_update
BEFORE UPDATE ON sales
FOR EACH ROW
EXECUTE FUNCTION check_sales_quantity();

--Функция для логирования удалений
CREATE OR REPLACE FUNCTION log_sales_deletion()
RETURNS TRIGGER AS $$
BEGIN
INSERT INTO sales_log (operation_type, sale_id, employee_id, product_id, quantity, sale_date)
VALUES (TG_OP, OLD.sale_id, OLD.employee_id, OLD.product_id, OLD.quantity, OLD.sale_date);
RAISE NOTICE 'Delete operation logged: %', OLD.sale_id;
RETURN OLD;
END;
$$ LANGUAGE plpgsql;

--Создание триггера для логирования удалений
CREATE TRIGGER after_sales_delete
AFTER DELETE ON sales
FOR EACH ROW
EXECUTE FUNCTION log_sales_deletion();

--Пример успешной транзакции
BEGIN;
INSERT INTO sales (employee_id, product_id, quantity, sale_date)
VALUES (2, 3, 5, '2024-11-28');
UPDATE employees
SET salary = salary + 5000
WHERE employee_id = 2;
COMMIT;

--Пример транзакции с ошибкой
BEGIN;
INSERT INTO sales (employee_id, product_id, quantity, sale_date)
VALUES (2, 999, 5, '2024-11-28');
COMMIT;
-- Транзакция не выполнится из-за нарушения внешнего ключа, нет такого продукта
