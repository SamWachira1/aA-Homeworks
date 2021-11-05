DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;


PRAGMA foreign_keys = ON;

-- USERS 

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname VARCHAR(255) NOT NULL,
    lname VARCHAR(255) NOT NULL
);

INSERT INTO 
    users (fname, lname)
VALUES
    ('Samuel', 'Wachira'),
    ('James', 'Ness');

-- QUESTIONS

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    body TEXT NOT NULL,
    author_id INTEGER NOT NULL,

    FOREIGN KEY (author_id) REFERENCES users(id)
);

INSERT INTO 
    questions (title, body, author_id)

SELECT 
    "Samuel Question", "is this a master based learning course?", 1
FROM 
    users 
WHERE 
    users.fname = "Samuel" AND users.lname = "Wachira";

INSERT INTO 
    questions (title, body, author_id)
SELECT
    "James Question", "How long does it take to finish the course?", users.id
FROM 
    users
WHERE 
    users.fname = "James" AND users.lname = "Ness";


-- QUESTION_FOLLOWS

CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO 
    question_follows (user_id, question_id)
VALUES
    ((SELECT id FROM users WHERE users.fname = "Samuel" AND users.lname = "Wachira"),
     (SELECT id FROM questions WHERE questions.title = "James Question")),

     ((SELECT id FROM users WHERE users.fname = "James" AND users.lname = 
     "Ness"),
     (SELECT id FROM questions WHERE questions.title =  "Samuel Question")
);

-- REPLIES 
CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    parent_reply_id INTEGER,
    author_id INTEGER NOT NULL,
    body TEXT NOT NULL,
    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (parent_reply_id) REFERENCES replies(id),
    FOREIGN KEY (author_id) REFERENCES users(id)
);

INSERT INTO
    replies (question_id, parent_reply_id, author_id, body)
VALUES
    ((SELECT id FROM questions WHERE questions.title = "James Question"), 
    NULL,

    (SELECT id FROM users WHERE users.fname = "Samuel" AND users.lname = "Wachira"),
    "it takes a while, you'll finish faster if your determined"
    );

INSERT INTO 
    replies (question_id, parent_reply_id, author_id, body)
VALUES
    ((SELECT id FROM questions WHERE questions.title = "James Question"),
    (SELECT id FROM replies WHERE body = "it takes a while, you'll finish faster if your determined"),
    (SELECT id FROM users WHERE users.fname = "James" AND users.lname = "Ness" ),
    "Thank you so much I'll get started"
    );


-- QUESTION_LIKES

CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
    question_likes( user_id, question_id)
VALUES
    ((SELECT id FROM users WHERE fname = "Samuel" AND lname = "Wachira"),
    (SELECT id FROM questions WHERE questions.title = "James Question")
    ),

    ((SELECT id FROM users WHERE fname = "James" AND lname = "Ness"),
    (SELECT id FROM questions WHERE questions.title = "Samuel Question")
    );







