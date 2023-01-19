-- Active: 1674131483936@@127.0.0.1@3306

-- Prática 1.1: Crie a tabela users

CREATE TABLE users (
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    -- Não esquecer das aspas simples no DATETIME
    create_at TEXT DEFAULT(DATETIME('now', 'localtime')) NOT NULL
    
);

SELECT * FROM users;

SELECT DATETIME('now', 'localtime');

DROP TABLE users;

-- Prática 1.2: Popule a tabela com pelo menos 3 pessoas

INSERT INTO users(id, name, email, password)
VALUES ("u001", "fulano", "fulano@gmail.com", "12345"),
        ("u002", "ciclano", "ciclano@gmail.com", "6789"),
        ("u003", "beltrano", "beltrano@gmail.com", "4165465");

DELETE FROM users;

-- Prática 2.1: Criar tabela de relação

CREATE TABLE follows (
    follower_id TEXT NOT NULL,
    followed_id TEXT NOT NULL,
    FOREIGN KEY (follower_id) REFERENCES users (id),
    FOREIGN KEY (followed_id) REFERENCES users (id)
);

SELECT * FROM follows;

-- Prática 2.2

INSERT INTO follows (follower_id, followed_id)
VALUES ("u001", "u002"),
   ("u001", "u003"),
   ("u002", "u001");

DELETE FROM follows;

SELECT * FROM users
INNER JOIN follows
ON follows.follower_id = users.id
;

-- Prática 3.1

SELECT * FROM users
LEFT JOIN follows
ON follows.follower_id = users.id
;

-- Prática 3.2

SELECT * FROM users
LEFT JOIN follows
ON follows.follower_id = users.id
INNER JOIN users AS  usersFollowed
ON follows.followed_id = usersFollowed.id
;

-- Removendo ambiguidades
SELECT
users.id AS userId,
users.name,
users.email,
users.password,
users.create_at AS createAt,
follows.follower_id AS followerId,
follows.followed_id AS followedId,
usersFollowed.name AS nameFollowed
  FROM users
LEFT JOIN follows
ON follows.follower_id = users.id
INNER JOIN users AS  usersFollowed
ON follows.followed_id = usersFollowed.id
;