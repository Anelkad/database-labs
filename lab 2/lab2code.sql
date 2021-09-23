/* 1. DDL & DML
    DDL - Data Definition Language, define the different structures in a database.
    DDL statements create, modify, and remove database objects such as tables, indexes, and users.
    DDL statements are CREATE, ALTER, and DROP.

    CREATE DATABASE lab2;
    CREATE TABLE table1(
        name varchar(50),
        age int
    );
    ALTER TABLE table1
        ADD COLUMN city varchar(50);
    DROP DATABASE lab2;

    DML - Data Manipulation Language, manipulate data, INSERT, UPDATE, DELETE and SELECT.
    INSERT into table1 VALUES ('Mauno Tiffani', 24);
    UPDATE table1 SET name='Louisa Marceline' WHERE name='Mauno Tiffani';
    SELECT * FROM table1 WHERE age>20;
    DELETE FROM table1 WHERE age<10;

  */


--2.
CREATE DATABASE lab2db1;

CREATE TABLE customers(
    id int NOT NULL UNIQUE,
    full_name varchar(50) NOT NULL,
    timestamp timestamp NOT NULL,
    delivery_address text NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE orders(
    code int NOT NULL UNIQUE,
    costumer_id int,
    total_sum double precision NOT NULL CHECK (total_sum>0),
    is_paid boolean NOT NULL,
    PRIMARY KEY (code),
    FOREIGN KEY (costumer_id) REFERENCES customers
);

CREATE TABLE products(
    id varchar NOT NULL UNIQUE,
    name varchar NOT NULL UNIQUE,
    description text,
    price double precision NOT NULL CHECK (price>0),
    PRIMARY KEY (id)
);

CREATE TABLE order_items(
    order_code int NOT NULL UNIQUE,
    product_id varchar NOT NULL UNIQUE,
    quantity int NOT NULL CHECK(quantity>0),
    PRIMARY KEY (order_code,product_id),
    FOREIGN KEY (order_code) REFERENCES orders,
    FOREIGN KEY (product_id) REFERENCES products

);


--3.
CREATE DATABASE lab2db2;

CREATE TABLE students(
    id char(6) NOT NULL UNIQUE,
    full_name varchar(100) NOT NULL,
    age int NOT NULL CHECK (age>0),
    birth_date date NOT NULL,
    gender varchar(10) NOT NULL,
    avg_grade double precision NOT NULL CHECK ( avg_grade>=0 ),
    info text,
    dormitory_need boolean NOT NULL,
    add_info text,
    PRIMARY KEY (id)

);

CREATE TABLE instructors(
    id char(6) NOT NULL UNIQUE,
    full_name varchar(100) NOT NULL,
    speaking_languages text NOT NULL,
    work_experience text NOT NULL,
    remote_lessons boolean NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE lessons(
    lesson_title varchar(80) NOT NULL,
    instructor_id char(6) NOT NULL,
    instructor_name varchar (100) NOT NULL,
    lesson_room int NOT NULL CHECK ( lesson_room>0 ),
    PRIMARY KEY (lesson_title, instructor_id),
    FOREIGN KEY (instructor_id) REFERENCES instructors
);

CREATE TABLE lesson_participants(
    lesson_title varchar(80) NOT NULL,
    student_id char(6) NOT NULL,
    student_name varchar(100) NOT NULL,
    teacher_id char(6) NOT NULL,
    teacher_name varchar(100) NOT NULL,
    PRIMARY KEY (lesson_title, student_id),
    FOREIGN KEY (student_id) REFERENCES students,
    FOREIGN KEY (lesson_title, teacher_id) REFERENCES lessons,
    FOREIGN KEY (teacher_id) REFERENCES instructors
);

--4.
    INSERT into customers VALUES (1,'Mauno Tiffani',CURRENT_TIMESTAMP, 'Austin, Texas, United States');
    INSERT into orders VALUES (1,1,300.0,true);
    INSERT into products VALUES (1,'soap','salt of a fatty acid used in a variety of cleansing and lubricating products',300.0);
    INSERT into order_items VALUES (1,1,100);
    UPDATE order_items SET quantity=1 WHERE quantity=100;
    INSERT into customers VALUES (2,'Bella Tatyanna',CURRENT_TIMESTAMP, 'New Delhi, India');
    DELETE FROM customers WHERE id=2;



 
