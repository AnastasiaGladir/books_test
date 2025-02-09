-- Создание ролей
CREATE ROLE admin WITH LOGIN PASSWORD 'hbjbk00VBJH56Gfgvjh';
CREATE ROLE manager WITH LOGIN PASSWORD 'jdfhajGHGH895JJ';
CREATE ROLE employee WITH LOGIN PASSWORD 'gggiiYUHUY56fgf';
CREATE ROLE customer WITH LOGIN PASSWORD 'shgnvGhhgjHBG13G6';

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO admin;

-- Доступ к таблицам Orders, Customers, Books, Reviews
GRANT SELECT, INSERT, UPDATE, DELETE ON Orders, Customers, Books, Reviews TO manager;

-- Доступ только для чтения к другим таблицам
GRANT SELECT ON Authors, Publishers, Genres, Warehouses, Departments, Employees TO manager;
-- Доступ к таблицам Books, Warehouses, Reviews
GRANT SELECT, INSERT, UPDATE, DELETE ON Books, Warehouses, Reviews TO employee;

-- Доступ только для чтения к другим таблицам
GRANT SELECT ON Authors, Publishers, Genres, Orders, Customers, Departments, Employees TO employee;
-- Доступ только для чтения к таблице Books
GRANT SELECT ON Books TO customer;

-- Доступ к заказам
GRANT SELECT ON Orders TO customer;

-- Доступ к отзывам
GRANT SELECT, INSERT, UPDATE, DELETE ON Reviews TO customer;
ALTER TABLE Orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE Reviews ENABLE ROW LEVEL SECURITY;
-- Политика для заказов
CREATE POLICY customer_orders_policy ON Orders
FOR SELECT
TO customer
USING (customer_id = current_setting('app.current_customer_id')::INT);

SET app.current_customer_id = 1;  -- Устанавливаем ID текущего клиента
