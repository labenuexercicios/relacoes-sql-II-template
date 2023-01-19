-- Active: 1673874129566@@127.0.0.1@3306

-- Práticas

CREATE TABLE users (
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    created_at TEXT DEFAULT (DATETIME()) NOT NULL
);

CREATE TABLE follows (
    follower_id TEXT NOT NULL,
    followed_id TEXT NOT NULL,
    FOREIGN KEY (follower_id) REFERENCES users(id),
    FOREIGN KEY (followed_id) REFERENCES users(id)
);

INSERT INTO users (id, name, email, password)
VALUES
    ("u001", "Fulano", "fulano@email.com", "fulana123"),
    ("u002", "Ciclana", "ciclana@email.com", "ciclana"),
    ("u003", "Beltrana", "beltrana@email.com", "beltrana"); 

INSERT INTO follows (follower_id , followed_id)
    VALUES
        ("u001", "u002"),
        ("u001", "u003"),
        ("u002", "u001");

SELECT * FROM users;

SELECT * FROM follows;

SELECT * FROM users
LEFT JOIN follows
ON follows.follower_id = users.id;

SELECT * FROM users
LEFT JOIN follows
ON follows.follower_id = users.id
INNER JOIN users AS followedUsers
ON follows.followed_id = followedUsers.id;