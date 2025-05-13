# Library Management System Database (MySQL)

## Overview
A full-featured relational database for managing a library system, including books, members, loans, and authors.

## Features
- Track books and their multiple authors
- Manage book loans and returns
- Store detailed member and copy information
## Tables
- books
- authors
- genres
- books_authors
- members
- loans
- book_copies

## How to Run
1. Import the `library_db.sql` into your MySQL server:
```bash
mysql -u username -p < library_db.sql
