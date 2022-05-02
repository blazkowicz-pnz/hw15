UPDATE animals
SET color1 = TRIM(color1),
    color2 = TRIM(color2);


CREATE TABLE outcome_types (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    outcome_type VARCHAR(50)
);


CREATE TABLE outcome_subtypes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    outcome_subtypes VARCHAR(50)
);


CREATE TABLE types (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    type VARCHAR(50)
);


CREATE TABLE breeds (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    breed VARCHAR(50)
);


CREATE TABLE color_first (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    color1 VARCHAR(50)


);

CREATE TABLE color_second (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    color2 VARCHAR(50)


);


CREATE table animals_new (
    id INTEGER PRIMARY KEY,
    name VARCHAR(50),
    date_of_birth DATE,
    id_types INTEGER,
    id_breeds INTEGER,
    id_color_first INTEGER,
    id_color_second INTEGER,
    FOREIGN KEY (id_types) REFERENCES types(id),
    FOREIGN KEY (id_breeds) REFERENCES breeds(id),
    FOREIGN KEY (id_color_first) REFERENCES  color_first(id),
    FOREIGN KEY (id_color_second) REFERENCES color_second(id)
);


CREATE TABLE outcomes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    month INTEGER,
    year INTEGER,
    age_upon_outcome INTEGER,
    id_animals INTEGER,
    id_outcome_types,
    id_outcome_subtypes,
    FOREIGN KEY (id_animals) REFERENCES animals_new(id),
    FOREIGN KEY (id_outcome_types) REFERENCES outcome_types(id),
    FOREIGN KEY (id_outcome_subtypes) REFERENCES outcome_subtypes(id)
);


-- MIGRATION DATA
-- Заполняем таблицу цветов и удаляем значения  NULL
INSERT INTO color_first (color1)
SELECT DISTINCT color1
FROM animals;


INSERT INTO color_second (color2)
SELECT DISTINCT color2
FROM animals;


-- заполням таблицу с породами
INSERT INTO breeds (breed)
SELECT DISTINCT breed
FROM animals;


INSERT INTO outcome_types (outcome_type)
SELECT DISTINCT outcome_type
FROM animals;


INSERT INTO outcome_subtypes (outcome_subtypes)
SELECT DISTINCT outcome_subtype
FROM animals;


INSERT INTO types (type)
SELECT DISTINCT animal_type
FROM animals;



INSERT INTO animals_new (id, name, date_of_birth, id_types, id_breeds, id_color_first, id_color_second)
SELECT DISTINCT "index", name, date_of_birth, types.id, breeds.id, color_first.id, color_second.id
FROM animals
LEFT JOIN  color_first ON color_first.color1 = animals.color1
LEFT JOIN color_second ON color_second.color2 = animals.color2
LEFT JOIN types ON types.type = animals.animal_type
LEFT JOIN breeds ON breeds.breed = animals.breed;


INSERT INTO outcomes (month, year, age_upon_outcome, id_animals, id_outcome_types, id_outcome_subtypes)
SELECT DISTINCT outcome_month, outcome_year, age_upon_outcome, animals_new.id, outcome_types.id, outcome_subtypes.id
FROM animals
LEFT JOIN outcome_types ON outcome_types.outcome_type = animals.outcome_type
LEFT JOIN outcome_subtypes ON outcome_subtypes.outcome_subtypes = animals.outcome_subtype
LEFT JOIN animals_new ON animals_new.id = animals."index";





