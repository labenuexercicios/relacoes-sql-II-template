-- Active: 1673874091088@@127.0.0.1@3306

-- Práticas
CREATE TABLE users (
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    created_at TEXT DEFAULT(DATETIME()) NOT NULL
);

INSERT INTO users(id, name, email, password)
VALUES
('u001', 'Fulane', 'fulana@email.com', 'fulana123'),
('u002', 'Ciclana', 'ciclana@email.com', 'ciclana123'),
('u003', 'Beltrana', 'beltrana@email.com', 'beltrana123');

SELECT * FROM users;

CREATE TABLE follows(
 follower_id TEXT NOT NULL,
 followed_id TEXT NOT NULL,
 FOREIGN KEY (follower_id) REFERENCES users(id),
 FOREIGN KEY (followed_id) REFERENCES users(id)
);

INSERT INTO follows(follower_id, followed_id)
VALUES
('u001', 'u002'), -- pessoa A segue B
('u001', 'u003'), -- pessoa A segue C
('u002', 'u001'); -- pessoa B segue A

DROP TABLE follows;
 
SELECT * FROM follows;


SELECT * FROM follows
INNER JOIN users
ON follows.follower_id = users.id;

SELECT * FROM follows -- define a left
RIGHT JOIN users --definiu a tabela b RIGHT
ON follows.follower_id = users.id;

--mostrando os dados da pessoa q foi sguda tb 
SELECT 
follows.followed_id AS followedId,
follows.follower_id AS followerId,
users.name AS followerName,
users.email AS followerEmail
 FROM follows
RIGHT JOIN users 
ON follows.follower_id = users.id
LEFT JOIN users AS followedUsers
ON follows.followed_id = followedUsers.id;










