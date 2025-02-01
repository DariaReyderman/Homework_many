CREATE TABLE countries (
	country_id INTEGER PRIMARY KEY AUTOINCREMENT,
	country_name TEXT NOT NULL UNIQUE,
	country_capital TEXT NOT NULL,
	country_language TEXT NOT NULL
);

CREATE TABLE songs (
	song_id INTEGER PRIMARY KEY AUTOINCREMENT,
	song_name TEXT NOT NULL,
	song_language TEXT NOT NULL,
	singer TEXT NOT NULL,
	winning_country_id INTEGER,
	FOREIGN KEY (winning_country_id) REFERENCES countries(country_id)
);

CREATE TABLE competitions (
    competition_year INTEGER PRIMARY KEY,
    hosting_country_id INTEGER NOT NULL,
    FOREIGN KEY (hosting_country_id) REFERENCES countries(country_id)
);

CREATE TABLE winners (
	competition_year INTEGER NOT NULL,
	song_id INTEGER NOT NULL,
	PRIMARY KEY (competition_year, song_id),
	FOREIGN KEY (competition_year) REFERENCES competitions(competition_year),
	FOREIGN KEY (song_id) REFERENCES songs(song_id)
);

INSERT INTO countries (country_name, country_capital, country_language) VALUES
	('Austria', 'Vienna', 'German'),
	('Azerbaijan', 'Baku', 'Azerbaijani'),
	('Denmark', 'Copenhagen', 'Danish'),
	('Israel', 'Jerusalem', 'Hebrew'),
	('Italy', 'Rome', 'Italian'),
	('Netherlands', 'Amsterdam', 'Dutch'),
	('Portugal', 'Lisbon', 'Portuguese'),
	('Sweden', 'Stockholm', 'Swedish'),
	('Switzerland', 'Bern', 'German'),
	('Ukraine', 'Kiev', 'Ukrainian');

INSERT INTO songs (song_name, song_language, singer, winning_country_id) VALUES
    ('Euphoria', 'English', 'Loreen', 8),
    ('Only Teardrops', 'English', 'Emmelie de Forest', 3),
    ('Rise Like a Phoenix', 'English', 'Conchita Wurst', 1),
    ('Heroes', 'English', 'Måns Zelmerlöw', 8),
    ('1944', 'English/Ukrainian', 'Jamala', 10),
    ('Amar pelos dois', 'Portuguese', 'Salvador Sobral', 7),
    ('Toy', 'English', 'Netta', 4),
    ('Arcade', 'English', 'Duncan Laurence', 6),
    ('Zitti e buoni', 'Italian', 'Måneskin', 5),
    ('Stefania', 'Ukrainian', 'Kalush Orchestra', 10),
    ('Tattoo', 'English', 'Loreen', 8),
    ('The Code', 'English', 'Nemo', 9);

INSERT INTO competitions VALUES
    (2024, 8),
    (2023, 11),
    (2022, 5),
    (2021, 6),
    (2019, 4),
    (2018, 7),
    (2017, 10),
    (2016, 8),
    (2015, 1),
    (2014, 3),
    (2013, 8),
    (2012, 2);

INSERT INTO winners VALUES
    (2024, 12),
    (2023, 11),
    (2022, 10),
    (2021, 9),
    (2019, 8),
    (2018, 7),
    (2017, 6),
    (2016, 5),
    (2015, 4),
    (2014, 3),
    (2013, 2),
    (2012, 1);

SELECT c.competition_year,
	   hc.country_name AS hosting_country,
	   wc.country_name AS winning_country_name,
	   wc.country_language,
	   s.song_name,
	   s.song_language,
	   wc.country_capital,
	   s.singer
FROM winners w
LEFT JOIN competitions c ON w.competition_year = c.competition_year
LEFT JOIN songs s ON w.song_id = s.song_id
LEFT JOIN countries wc ON s.winning_country_id = wc.country_id
LEFT JOIN countries hc ON c.hosting_country_id = hc.country_id;