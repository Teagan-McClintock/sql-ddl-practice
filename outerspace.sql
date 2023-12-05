CREATE TABLE stars (
    name VARCHAR(30) PRIMARY KEY,
    temp_kelvin INT NOT NULL --float
);

CREATE TABLE planets (
    name VARCHAR(30) PRIMARY KEY,
    orbits_star VARCHAR(30) NOT NULL REFERENCES stars,
    orbital_period FLOAT NOT NULL --_yrs
);

CREATE TABLE moons (
    name VARCHAR(30) PRIMARY KEY,
    orbits_planet VARCHAR(30) NOT NULL REFERENCES planets
);

INSERT INTO stars (name, temp_kelvin) VALUES
    ('The Sun', 5800),
    ('Proxima Centauri', 3042),
    ('Gliese 876', 3192);

INSERT INTO planets (name, orbits_star, orbital_period) VALUES
    ('Earth', 'The Sun', 1.00),
    ('Mars', 'The Sun', 1.882),
    ('Venus', 'The Sun', 0.62),
    ('Proxima Centauri b', 'Proxima Centauri', 0.03),
    ('Gliese 876 b', 'Gliese 876', 0.236);

INSERT INTO moons (name, orbits_planet) VALUES
    ('The Moon', 'Earth'),
    ('Phobos', 'Mars'),
    ('Deimos', 'Mars');

SELECT p.name AS planet,
    s.name AS star,
    COUNT(m.name) AS moon_count -- Count (NULL) = 0
FROM planets AS p
INNER JOIN stars AS s
    ON p.orbits_star = s.name
LEFT JOIN moons AS m
    ON p.name = m.orbits_planet
GROUP BY p.name, s.name
ORDER BY planet;

