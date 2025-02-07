CREATE TABLE Subjects (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);
CREATE TABLE Classrooms (
    id SERIAL PRIMARY KEY,
    number VARCHAR(20) NOT NULL
);
CREATE TABLE Teachers (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    subject_id INT REFERENCES Subjects(id) ON DELETE SET NULL
);
CREATE TABLE Classes (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    curator_id INT REFERENCES Teachers(id) ON DELETE SET NULL
);
CREATE TABLE Students (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_date DATE,
    class_id INT REFERENCES Classes(id) ON DELETE SET NULL
);
CREATE TABLE Lessons (
    id SERIAL PRIMARY KEY,
    subject_id INT REFERENCES Subjects(id) ON DELETE CASCADE,
    teacher_id INT REFERENCES Teachers(id) ON DELETE SET NULL,
    class_id INT REFERENCES Classes(id) ON DELETE CASCADE,
    classroom_id INT REFERENCES Classrooms(id) ON DELETE SET NULL,
    date DATE NOT NULL,
    time TIME NOT NULL
);
CREATE TABLE Grades (
    id SERIAL PRIMARY KEY,
    student_id INT REFERENCES Students(id) ON DELETE CASCADE,
    lesson_id INT REFERENCES Lessons(id) ON DELETE CASCADE,
    grade INT CHECK (grade >= 1 AND grade <= 5)
);
CREATE TABLE Attendance (
    id SERIAL PRIMARY KEY,
    student_id INT REFERENCES Students(id) ON DELETE CASCADE,
    lesson_id INT REFERENCES Lessons(id) ON DELETE CASCADE,
    present BOOLEAN NOT NULL
);
CREATE TABLE Homework (
    id SERIAL PRIMARY KEY,
    lesson_id INT REFERENCES Lessons(id) ON DELETE CASCADE,
    task TEXT NOT NULL,
    deadline DATE NOT NULL
);
CREATE TABLE Schedule (
    id SERIAL PRIMARY KEY,
    class_id INT REFERENCES Classes(id) ON DELETE CASCADE,
    lesson_id INT REFERENCES Lessons(id) ON DELETE CASCADE,
    day_of_week VARCHAR(10) NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL
);
CREATE TABLE Parents (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(15)
);
CREATE TABLE Students_Parents (
    student_id INT REFERENCES Students(id) ON DELETE CASCADE,
    parent_id INT REFERENCES Parents(id) ON DELETE CASCADE,
    PRIMARY KEY (student_id, parent_id)
);
