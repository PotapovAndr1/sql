-- Исполнители
INSERT INTO artists (id, name) VALUES
(1, 'Leningrad'),
(2, 'Ivanushki int'),
(3, 'Zveri'),
(4, 'Valeria');

-- Жанры
INSERT INTO genres (id, name) VALUES
(1, 'Pop'),
(2, 'Rock'),
(3, 'Alternative');

-- Альбомы
INSERT INTO albums (id, name, release_year) VALUES
(1, 'WWW', 2008),
(2, 'Tuchi', 2000),
(3, 'Chasiki', 2005),
(4, 'Nova', 2020);

-- Треки
INSERT INTO tracks (id, name, duration, album_id) VALUES
(1, 'WWW', 186, 1),
(2, 'Terminator', 177, 1),
(3, 'Tuchi', 295, 2),
(4, 'Topoliniy puh', 223, 2),
(5, 'Do skoroy vstrechi', 201, 3),
(6, 'Tramvai', 281, 3),
(10, 'Nova Era', 240, 4),
(11, 'Start Again', 210, 4);

-- Сборники
INSERT INTO collections (id, name, release_year) VALUES
(1, 'Greatest Hits 2000s', 2010),
(2, 'Hits 2000', 2016),
(3, 'Best Rock', 2019),
(4, 'Love Songs', 2015);

-- Связь исполнителей с жанрами
INSERT INTO artist_genre (artist_id, genre_id) VALUES
(1, 2), 
(1, 3),  
(2, 1),  
(3, 2), 
(4, 1); 

-- Связь исполнителей с альбомами
INSERT INTO artist_album (artist_id, album_id) VALUES
(1, 1),
(2, 2),
(4, 3),
(3, 4);

-- Связь сборников с треками
INSERT INTO collection_track (collection_id, track_id) VALUES
(1, 1),
(1, 3),
(2, 2),
(2, 4),
(3, 1),
(3, 5),
(4, 4),
(4, 6),
(3, 10),
(4, 11);

-- 1. Название и продолжительность самого длительного трека
SELECT name, duration
FROM tracks
ORDER BY duration DESC
LIMIT 1;

-- 2. Названия треков, продолжительность которых не менее 3,5 минут (210 сек)
SELECT name
FROM tracks
WHERE duration >= 210;

-- 3. Названия сборников, вышедших в период с 2018 по 2020 год включительно
SELECT name
FROM collections
WHERE release_year BETWEEN 2018 AND 2020;

-- 4. Исполнители, чьё имя состоит из одного слова
SELECT name
FROM artists
WHERE name NOT LIKE '% %';

-- 5. Название треков, которые содержат слово «мой» или «my»
SELECT name
FROM tracks
WHERE LOWER(name) LIKE '%my%' OR LOWER(name) LIKE '%мой%';

-- 6. Количество исполнителей в каждом жанре
SELECT g.name AS genre, COUNT(ag.artist_id) AS artist_count
FROM genres g
JOIN artist_genre ag ON g.id = ag.genre_id
GROUP BY g.name;

-- 7. Количество треков, вошедших в альбомы 2019–2020 годов
SELECT COUNT(t.id) AS track_count
FROM tracks t
JOIN albums a ON t.album_id = a.id
WHERE a.release_year BETWEEN 2019 AND 2020;

-- 8. Средняя продолжительность треков по каждому альбому
SELECT a.name AS album_name, ROUND(AVG(t.duration), 2) AS avg_duration
FROM albums a
JOIN tracks t ON a.id = t.album_id
GROUP BY a.name;

-- 9. Все исполнители, которые не выпустили альбомы в 2020 году
SELECT DISTINCT ar.name
FROM artists ar
WHERE ar.id NOT IN (
    SELECT aa.artist_id
    FROM artist_album aa
    JOIN albums a ON aa.album_id = a.id
    WHERE a.release_year = 2020
);

-- 10. Названия сборников, в которых присутствует конкретный исполнитель
SELECT DISTINCT c.name
FROM collections c
JOIN collection_track ct ON c.id = ct.collection_id
JOIN tracks t ON ct.track_id = t.id
JOIN albums a ON t.album_id = a.id
JOIN artist_album aa ON a.id = aa.album_id
JOIN artists ar ON aa.artist_id = ar.id
WHERE ar.name = 'Leningrad';
