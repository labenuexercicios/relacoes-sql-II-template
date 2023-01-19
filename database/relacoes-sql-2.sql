-- Active: 1674131484558@@127.0.0.1@3306

-- Práticas

-- Crie a tabela users 
CREATE TABLE users (
  id TEXT PRIMARY KEY UNIQUE NOT NULL,
  name TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL,
  created_at TEXT DEFAULT(DATETIME('now', 'localtime')) NOT NULL
);

-- Popule-a com pelo menos 3 pessoas 

INSERT INTO users(id, name, email, password)
VALUES 
("u001", "Fulano", "fulano@gmail.com", "fulano123"),
("u002", "Ciclano", "ciclano@gmail.com", "ciclano123"),
("u003", "Beutrano", "beutrano@gmail.com", "beutrano123");


SELECT * FROM users;

-- Crie a tabela de relação

CREATE TABLE follows (
  follower_id TEXT NOT NULL,
  followed_id TEXT NOT NULL,
  FOREIGN KEY (follower_id) REFERENCES users(id)
  FOREIGN KEY (followed_id) REFERENCES users(id)
);

INSERT INTO follows (follower_id, followed_id)
VALUES 
("u001", "u002"),
("u001", "u003"),
("u002", "u001");


SELECT * FROM follows;

-- Faça uma consulta com junção INNER JOIN entre as duas tabelas. 

SELECT * FROM users
INNER JOIN follows
ON follows.follower_id = users.id;

-- Crie uma junção que possibilite a visualização das pessoas que não seguem niguém. 

SELECT * FROM users
LEFT JOIN follows
ON follows.follower_id = users.id;

-- Crie uma consulta que mantém o mesmo resultado anterior, mas também retorna o nome da pessoa seguida.

SELECT 
users.id AS userId,
users.name,
users.email,
users.password,
users.created_at AS createAt,
follows.follower_id AS followerId
follows.followed_id AS followedId
usersFollowed.name AS nameFollowed
FROM users
INNER JOIN follows
ON follows.follower_id = users.id
INNER JOIN users AS usersFollowed
ON follows.followed_id = usersFollowed.id;