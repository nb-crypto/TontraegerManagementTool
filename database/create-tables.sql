-- create tables

CREATE TABLE IF NOT EXISTS catalogue (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    description VARCHAR(45) NOT NULL);
    
CREATE TABLE IF NOT EXISTS cataloguevalue (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(45) NOT NULL,
    selected TINYINT NULL DEFAULT 1,
    deleted TINYINT NULL DEFAULT 0,
    catalogue_id INT NOT NULL);

CREATE TABLE IF NOT EXISTS album (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    releaseyear YEAR NULL,
    infotext LONGTEXT NULL,
    pressing VARCHAR(100) NULL;
    cat_label_id INT NULL,
    image_id INT NULL,
    cat_genre_id INT NULL
    cat_country_id INT NULL);

CREATE TABLE IF NOT EXISTS image (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    image LONGBLOB NOT NULL);

CREATE TABLE IF NOT EXISTS artist (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    infotext LONGTEXT NULL,
    image_id INT NULL);

CREATE TABLE IF NOT EXISTS song (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    duration INT CHECK (duration >= 0 AND duration <= 50000)); -- Länge des Songs in Sekunden

-- create relationship tables
    
CREATE TABLE IF NOT EXISTS artist_album_rel (
    artist_id INT NOT NULL,
    album_id INT NOT NULL);

CREATE TABLE IF NOT EXISTS song_album_rel (
    album_id INT NOT NULL,
    song_id INT NOT NULL);

CREATE TABLE IF NOT EXISTS artist_song_rel (
    artist_id INT NOT NULL,
    song_id INT NOT NULL);
    
-- add foreign keys
    
ALTER TABLE cataloguevalue 
    ADD CONSTRAINT fk_cataloguevalue_catalogue 
    FOREIGN KEY IF NOT EXISTS (catalogue_id)
    REFERENCES catalogue (id);

ALTER TABLE album
    ADD CONSTRAINT fk_album_cat_label
    FOREIGN KEY IF NOT EXISTS (cat_label_id)
    REFERENCES cataloguevalue (id),
    ADD CONSTRAINT fk_album_image
    FOREIGN KEY IF NOT EXISTS (image_id)
    REFERENCES image (id),
    ADD CONSTRAINT fk_album_cat_genre
    FOREIGN KEY IF NOT EXISTS (cat_genre_id)
    REFERENCES cataloguevalue (id)
    ADD CONSTRAINT fk_album_cat_country
    FOREIGN KEY IF NOT EXISTS (cat_country_id)
    REFERENCES cataloguevalue (id);

ALTER TABLE artist 
    ADD CONSTRAINT fk_artist_image
    FOREIGN KEY IF NOT EXISTS (image_id)
    REFERENCES image (id);

ALTER TABLE artist_album_rel 
    ADD CONSTRAINT fk_artist_album_rel_artist
    FOREIGN KEY IF NOT EXISTS (artist_id)
    REFERENCES artist (id),
    ADD CONSTRAINT fk_artist_album_rel_album
    FOREIGN KEY IF NOT EXISTS (album_id)
    REFERENCES album (id);
  
ALTER TABLE song_album_rel 
    ADD CONSTRAINT fk_song_album_rel_song
    FOREIGN KEY IF NOT EXISTS (song_id)
    REFERENCES song (id),
    ADD CONSTRAINT fk_song_album_rel_album
    FOREIGN KEY IF NOT EXISTS (album_id)
    REFERENCES album (id);
  
ALTER TABLE artist_song_rel 
    ADD CONSTRAINT fk_artist_song_rel_artist
    FOREIGN KEY IF NOT EXISTS (artist_id)
    REFERENCES artist (id),
    ADD CONSTRAINT fk_artist_song_rel_song
    FOREIGN KEY IF NOT EXISTS (song_id)
    REFERENCES song (id);
