-- Индекс на department_id
CREATE INDEX idx_employees_department_id ON Employees(department_id);

-- Индекс на last_name
CREATE INDEX idx_employees_last_name ON Employees(last_name);

-- Индекс на hire_date
CREATE INDEX idx_employees_hire_date ON Employees(hire_date);

-- Индекс на salary
CREATE INDEX idx_employees_salary ON Employees(salary);
-- Уникальный индекс на email (уже создан автоматически, так как email UNIQUE)
CREATE UNIQUE INDEX idx_customers_email ON Customers(email);

-- Индекс на last_name
CREATE INDEX idx_customers_last_name ON Customers(last_name);

-- Составной индекс на first_name и last_name
CREATE INDEX idx_customers_full_name ON Customers(first_name, last_name);
