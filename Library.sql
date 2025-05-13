-- Step 1: Create the database
CREATE DATABASE IF NOT EXISTS library_db;
USE library_db;

-- Step 2: Create genres table
CREATE TABLE genres (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Step 3: Create publishers table
CREATE TABLE publishers (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    location VARCHAR(100)
);
-- Step 4: Create books table
CREATE TABLE IF NOT EXISTS books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    publication_year INT,
    genre_id INT,
    publisher_id INT,
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id),
    FOREIGN KEY (publisher_id) REFERENCES publishers(publisher_id)
);

-- Step 5: Create authors table
CREATE TABLE IF NOT EXISTS authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    bio TEXT
);

-- Step 6: Create books_authors table for M:M relationship
CREATE TABLE IF NOT EXISTS books_authors (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES authors(author_id) ON DELETE CASCADE
);

-- Step 7: Create members table
CREATE TABLE IF NOT EXISTS members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    join_date DATE NOT NULL
);

-- Step 8: Create book_copies table
CREATE TABLE IF NOT EXISTS book_copies (
    book_copy_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    status ENUM('available', 'loaned', 'lost') DEFAULT 'available',
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE
);

-- Step 9: Create loans table
CREATE TABLE IF NOT EXISTS loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    book_copy_id INT,
    member_id INT,
    loan_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    returned BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (book_copy_id) REFERENCES book_copies(book_copy_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

-- Step 10 : Create librarians table
CREATE TABLE IF NOT EXISTS librarians (
    librarian_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    email VARCHAR(100) UNIQUE
);
INSERT INTO books (title, isbn, publication_year, genre_id, publisher_id)
VALUES ('The Time Machine', '9780451528551', 1895, 2, 2);

INSERT INTO authors (name) VALUES ('H. G. Wells');

INSERT INTO books_authors (book_id, author_id) VALUES (1, 1);

INSERT INTO members (name, email, phone, join_date)
VALUES ('Jane Doe', 'jane@example.com', '0712345678', CURDATE());

INSERT INTO book_copies (book_id, status) VALUES (1, 'available');

INSERT INTO loans (book_copy_id, member_id, loan_date, due_date)
VALUES (1, 1, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 14 DAY));

