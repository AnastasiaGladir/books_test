CREATE TABLE Authors (
    author_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    birth_date DATE,
    country VARCHAR(100)
);
CREATE TABLE Publishers (
    publisher_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    phone VARCHAR(20)
);
CREATE TABLE Genres (
    genre_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(20),
    address VARCHAR(255)
);
CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES Customers(customer_id) ON DELETE CASCADE,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) DEFAULT 'Pending'
);
CREATE TABLE Warehouses (
    warehouse_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    capacity INT
);
CREATE TABLE Books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author_id INT REFERENCES Authors(author_id) ON DELETE SET NULL,
    publisher_id INT REFERENCES Publishers(publisher_id) ON DELETE SET NULL,
    genre_id INT REFERENCES Genres(genre_id) ON DELETE SET NULL,
    price DECIMAL(10, 2) NOT NULL,
    publication_date DATE,
    isbn VARCHAR(20) UNIQUE,
    warehouse_id INT REFERENCES Warehouses(warehouse_id) ON DELETE SET NULL
);

CREATE TABLE Departments (
    department_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE Employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    department_id INT REFERENCES Departments(department_id) ON DELETE SET NULL,
    hire_date DATE,
    salary DECIMAL(10, 2)
);

CREATE TABLE Reviews (
    review_id SERIAL PRIMARY KEY,
    book_id INT REFERENCES Books(book_id) ON DELETE CASCADE,
    customer_id INT REFERENCES Customers(customer_id) ON DELETE CASCADE,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    review_date DATE DEFAULT CURRENT_DATE
);
