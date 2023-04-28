
--Create Database--
CREATE DATABASE "catalog_my_things";

---table items---
CREATE TABLE items(
    id serial PRIMARY KEY,
    genre_id serial,
    author_id serial,
    label_id serial,
    source_id serial,
    publish_date DATE NOT NULL,
    archived BOOLEAN NOT NULL,
    FOREIGN KEY (genre_id) REFERENCES genres (id),
    FOREIGN KEY (author_id) REFERENCES authors (id),
    FOREIGN KEY (label_id) REFERENCES labels (id),
    FOREIGN KEY (source_id) REFERENCES sources (id)
);

---table books---
CREATE TABLE books (
    id serial primary key,
    title VARCHAR(100),
    publisher VARCHAR(100),
    cover_state VARCHAR(100),
    FOREIGN KEY(id) REFERENCES items(id)
);

---table sources---
CREATE TABLE labels (
    id serial primary key,
    title VARCHAR(100),
    color VARCHAR(100)
);

---sources table---
CREATE TABLE sources(
    id serial PRIMARY KEY,
    name VARCHAR(255)   
);

---Authors table---
CREATE TABLE authors(
    id serial PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255)     
);
---genres table ---
CREATE TABLE genres (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

---music album table---
CREATE TABLE music_album (
   id serial primary key,
   on_spotify boolean not null,
   publish_date date not null,
   archived boolean not null,
   author_id int references authors(id),
   genre_id int references genres(id),
   source_id int references sources(id),
   label_id int references labels(id)
);