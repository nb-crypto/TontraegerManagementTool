-- SHOW TABLES;
-- DESC catalogue;

-- set values in table catalogue in column description

INSERT INTO catalogue (description) VALUES ('Label');
INSERT INTO catalogue (description) VALUES ('Genre');
INSERT INTO catalogue (description) VALUES ('Pressung'); 

-- SHOW TABLES;
-- DESC catalogue;
-- SELECT * FROM catalogue;

-- DESC cataloguevalues;

-- set values in table cataloguevalues in column name

INSERT INTO cataloguevalue (name, catalogue_id) VALUES ('ABKCO', (SELECT id FROM catalogue WHERE description = 'Label'));

-- SELECT * FROM cataloguevalues;

INSERT INTO cataloguevalue (name, catalogue_id) VALUES ('Rock', (SELECT id FROM catalogue WHERE description = 'Genre'));

-- SELECT * FROM cataloguevalues;

INSERT INTO cataloguevalue (name, catalogue_id) VALUES ('Deutschland', (SELECT id FROM catalogue WHERE description = 'Land'));

-- SELECT * FROM cataloguevalues;

-- set values in table album

INSERT INTO album (name, releaseyear, cat_label_id, cat_country_id, cat_genre_id)
    VALUES ('Metamorphosis', 1975, 
    (SELECT id FROM cataloguevalue WHERE catalogue_id = 
        (SELECT id FROM catalogue WHERE description = 'Label') AND name = 'Decca'),
    (SELECT id FROM cataloguevalue WHERE catalogue_id = 
        (SELECT id FROM catalogue WHERE description = 'Land') AND name = 'Vereinigtes Königreich'),
    (SELECT id FROM cataloguevalue WHERE catalogue_id = 
        (SELECT id FROM catalogue WHERE description = 'Genre') AND name = 'Rock'));

-- set new values in cataloguevalues in column name
        
INSERT INTO cataloguevalue (name, catalogue_id) VALUES ('Arista', (SELECT id FROM catalogue WHERE description = 'Label'));

INSERT INTO cataloguevalue (name, catalogue_id) VALUES ('Pop', (SELECT id FROM catalogue WHERE description = 'Genre'));

-- set values in table album

INSERT INTO album (name, releaseyear, cat_label_id, cat_country_id, cat_genre_id)
    VALUES ('Whitney Houston', 1985, 
    (SELECT id FROM cataloguevalue WHERE catalogue_id = 
        (SELECT id FROM catalogue WHERE description = 'Label') AND name = 'Arista'),
    (SELECT id FROM cataloguevalue WHERE catalogue_id = 
        (SELECT id FROM catalogue WHERE description = 'Land') AND name = 'Deutschland'),
    (SELECT id FROM cataloguevalue WHERE catalogue_id = 
        (SELECT id FROM catalogue WHERE description = 'Genre') AND name = 'Pop'));

-- set values in table artist
        
INSERT INTO artist (name) VALUES ('Whitney Houston');

INSERT INTO artist (name) VALUES ('The Rolling Stones');

-- allocate datasets in table artist to datasets in table album

INSERT INTO artist_album_rel VALUES ((SELECT id FROM artist WHERE name = 'Whitney Houston'), (SELECT id FROM album WHERE name = 'Whitney Houston'));

INSERT INTO artist_album_rel VALUES ((SELECT id FROM artist WHERE name = 'The Rolling Stones'), (SELECT id FROM album WHERE name = 'Metamorphosis'));

-- retrieve column name from table album, column releaseyear from table album and column name from table artist using relationship table artist_album_rel

SELECT al.name, al.releaseyear, ar.name FROM album al
    JOIN artist_album_rel r ON al.id = r.album_id
    JOIN artist ar ON ar.id = r.artist_id;

-- display custom table headers
    
SELECT al.name AS Albumname, al.releaseyear AS Jahr, ar.name AS Künstler FROM album al
    JOIN artist_album_rel r ON al.id = r.album_id
    JOIN artist ar ON ar.id = r.artist_id;
    
-- retrieve column name from table album, column releaseyear from table album, column name from table artist and values from table cataloguevalue where id points to 'Label' using relationship table artist_album_rel

SELECT al.name AS Albumname, al.releaseyear AS Jahr, ar.name AS Künstler, cat.name AS Label FROM album al
    JOIN artist_album_rel r ON al.id = r.album_id
    JOIN artist ar ON ar.id = r.artist_id
    JOIN cataloguevalue cat ON cat.id = al.cat_label_id;

-- retrieve column name from table album, column releaseyear from table album, column name from table artist and values from table cataloguevalue where column name has value 'Decca' using relationship table artist_album_rel
    
SELECT al.name AS Albumname, al.releaseyear AS Jahr, ar.name AS Künstler, cat.name AS Label FROM album al
    JOIN artist_album_rel r ON al.id = r.album_id
    JOIN artist ar ON ar.id = r.artist_id
    JOIN cataloguevalue cat ON cat.id = al.cat_label_id
    WHERE cat.name = 'Decca';
