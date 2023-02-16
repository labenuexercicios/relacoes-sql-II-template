-- Active: 1676514109511@@127.0.0.1@3306

-- Práticas

CREATE TABLE users(
    id TEXT UNIQUE PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    created_at TEXT DEFAULT(DATETIME('now', 'localtime')) NOT NULL
);

INSERT INTO users (id, name, email, password)
VALUES  ("a001", "Xablau", "xablauzinho@email.com", "Ualblax123"),
        ("a002", "Devizinho", "devizinho@demodev.com", "Devilring123"),
        ("a003", "AstroDev", "astrodev@labenu.com", "Aluaénossa123");

SELECT * FROM users;

CREATE TABLE follows (
    follower_id TEXT NOT NULL,
    followed_id TEXT NOT NULL,
    FOREIGN KEY (followed_id) REFERENCES users(id),
    FOREIGN KEY (follower_id) REFERENCES users(id)
);

INSERT INTO follows (follower_id, followed_id)
VALUES  ("a001", "a002"),
        ("a001", "a003"),
        ("a002", "a001");

-- Consulta inner join entre as tabelas

SELECT * FROM users
INNER JOIN follows
ON follows.follower_id = users.id;

-- Junção que permitirá a visualização de pessoas que não seguem ninguém

SELECT * FROM users
LEFT JOIN follows
ON follows.follower_id = users.id;

-- Junção que permitirá tudo acima + info da pessoa seguida

SELECT * FROM users
LEFT JOIN follows
ON follows.follower_id = users.id
INNER JOIN users as usersFollowed
On follows.followed_id = usersFollowed.id;

-- Removendo ambiguidades, estruturando a tabela conforme quero

SELECT 
    users.id as userId,
    users.name as userName,
    follows.follower_id as followerId,
    follows.followed_id as followedId,
    usersFollowed.name as followedName
FROM users
LEFT JOIN follows
ON follows.follower_id = users.id
INNER JOIN users as usersFollowed
On follows.followed_id = usersFollowed.id;

/*                  O que dá para entender desse processo todo?

    - O SELECT seleciona coisas a partir das relações da tabela users
    - Acima temos o left join que faz a inclusão de todas as informações
      da tabela a esquerda (para lembrar, reler anotações do exercício anterior
    - O inner join puxa as informações a partir da FOREIGN KEY
    - Para não ter problema de duplicidade, temos que renomear (usando alias 'as') a tabela
    - Depois, referencia o que quer com o novo nome da tabela e terá seu resultado.

*/