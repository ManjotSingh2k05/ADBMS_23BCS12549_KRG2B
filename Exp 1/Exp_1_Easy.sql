USE KRG_2B;

CREATE TABLE Authors (
    author_id INT PRIMARY KEY,
    author_name VARCHAR(100),
    author_country VARCHAR(100)
);

CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    book_title VARCHAR(200),
    author_id INT,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

INSERT INTO Authors (author_id, author_name, author_country) VALUES
(10, 'Jane Austen', 'United Kingdom'),
(20, 'Mark Twain', 'United States'),
(30, 'Gabriel Garcia Marquez', 'Colombia');

INSERT INTO Books (book_id, book_title, author_id) VALUES
(1001, 'Pride and Prejudice', 10),
(1002, 'The Adventures of Tom Sawyer', 20),
(1003, 'One Hundred Years of Solitude', 30);

SELECT Books.book_title AS BookTitle, Authors.author_name AS AuthorName, Authors.author_country AS AuthorCountry
FROM Books
INNER JOIN Authors 
ON Books.author_id = Authors.author_id;