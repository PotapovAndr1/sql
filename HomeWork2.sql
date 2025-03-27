-- Таблица для исполнителей
CREATE TABLE Artist (
    artistid INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

-- Таблица для жанров
CREATE TABLE Genre (
    genreid INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

-- Связь "исполнитель-жанр" (многие-ко-многим)
CREATE TABLE ArtistGenres (
    artistid INT,
    genreid INT,
    PRIMARY KEY (artistid, genreid),
    FOREIGN KEY (artistid) REFERENCES Artists(artistid) ON DELETE CASCADE,
    FOREIGN KEY (genreid) REFERENCES Genres(genreid) ON DELETE CASCADE
);

-- Таблица для альбомов
CREATE TABLE Album (
    albumid INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL
);

-- Связь "альбом-исполнители" (многие-ко-многим)
CREATE TABLE AlbumArtist (
    albumid INT,
    artistid INT,
    PRIMARY KEY (albumid, artistid),
    FOREIGN KEY (albumid) REFERENCES Albums(albumid) ON DELETE CASCADE,
    FOREIGN KEY (artistid) REFERENCES Artists(artistid) ON DELETE CASCADE
);

-- Таблица для треков
CREATE TABLE Track (
    trackid INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    albumid INT,
    FOREIGN KEY (albumid) REFERENCES Albums(albumid) ON DELETE CASCADE
);

-- Таблица для сборников
CREATE TABLE Collection (
    collectionid INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    releaseyear YEAR NOT NULL
);

-- Связь "трек-сборник" (многие-ко-многим)
CREATE TABLE TrackCollection (
    trackid INT,
    collectionid INT,
    PRIMARY KEY (trackid, collectionid),
    FOREIGN KEY (trackid) REFERENCES Tracks(trackid) ON DELETE CASCADE,
    FOREIGN KEY (collectionid) REFERENCES Collections(collectionid) ON DELETE CASCADE
);