-- Active: 1674045279687@@127.0.0.1@3306

-- Práticas 1
CREATE TABLE users(
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    created_at TEXT DEFAULT (DATETIME()) NOT NULL
);

INSERT INTO users (id, name, email, password)
VALUES
    ('u001', 'Fulana', 'fulana@email.com', 'fulana123'),
    ('u002', 'Ciclano', 'ciclano@email.com', 'ciclano123'),
    ('u003', 'Beltrana', 'beltrana@email.com', 'beltrana123');

SELECT * FROM users;

-- Prática 2

CREATE TABLE follows (
    follower_id TEXT NOT NULL,
    followed_id TEXT NOT NULL,
    FOREIGN KEY (follower_id) REFERENCES users(id),
    FOREIGN KEY (followed_id) REFERENCES users(id)
);

-- Pessoa A segue B
-- Pessoa A segue C

INSERT INTO follows(follower_id, followed_id)
VALUES
    ('u001', 'u002'), -- Pessoa A segue a B
    ('u001', 'u003'), -- Pessoa A segue a C
    ('u002', 'u001'); -- Pessoa B segue a A

SELECT * FROM follows;

SELECT * FROM follows
INNER JOIN users
ON follows.follower_id = users.id;

-- Prática 3
-- Mostra quem está seguindo e quem não seguiu
-- A = follows e B = users , portanto RIGHT JOIN
SELECT * FROM users
LEFT JOIN follows
ON follows.follower_id = users.id;

-- Tb Mostra quem está seguindo e quem não seguiu,
-- mas muda a perspectiva A e B
-- A = users e B = follows , portanto LEFT JOIN
SELECT * FROM users
LEFT JOIN follows
ON follows.follower_id = users.id;

-- Mostrando os dados da pessoa q foi seguida
SELECT
    follows.follower_id AS followerId,
    follows.followed_id AS followedId,
    users.name AS followerName,
    followedUsers.name AS followedName,
    users.email AS followerEmail
FROM users
LEFT JOIN follows
ON follows.follower_id = users.id
LEFT JOIN users AS followedUsers
ON follows.followed_id = followedUsers.id;

-- Fixação

CREATE TABLE authors (
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    name TEXT NOT NULL
);

SELECT * FROM authors;

INSERT INTO authors (id, name)
VALUES
    ('a001', 'Fulano'),
    ('a002', 'Ciclano'),
    ('a003', 'Beltrano');

CREATE TABLE books (
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    book_name TEXT NOT NULL
);

INSERT INTO books(id, book_name)
VALUES 
    ('b001', 'Meu mundo'),
    ('b002', 'Mares'),
    ('b003', 'Qualque coisa'),
    ('b004', 'To cansada');

SELECT * FROM books;

CREATE TABLE author_book(
    author_id TEXT NOT NULL,
    book_id TEXT NOT NULL,
    FOREIGN KEY (author_id) REFERENCES authors(id),
    FOREIGN KEY (book_id) REFERENCES books(id)
);

SELECT * FROM author_book;

INSERT INTO author_book (author_id, book_id)
VALUES
    ('a001', 'b001'),
    ('a002', 'b002'),
    ('a003', 'b004'),
    ('a003', 'b003'),
    ('a003', 'b001');

SELECT * FROM author_book
INNER JOIN authors ON author_book.author_id = authors.id
INNER JOIN books ON author_book.book_id = books.id;

SELECT 
    author_book.author_id AS authorId,
    author_book.book_id AS bookId,
    authors.name AS authorName,
    books.book_name AS bookName
FROM author_book
INNER JOIN authors ON author_book.author_id = authors.id
INNER JOIN books ON author_book.book_id = books.id;

