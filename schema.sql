/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
)
ALTER TABLE animals ADD species VARCHAR(255);
CREATE TABLE owners(id SERIAL PRIMARY KEY, full_name VARCHAR, age INT);
CREATE TABLE species(id SERIAL PRIMARY KEY, name VARCHAR);
ALTER TABLE animals ADD owner_id INT;
ALTER TABLE animals ALTER COLUMN species TYPE INT USING species::integer;
ALTER TABLE animals ADD CONSTRAINT FK_species FOREIGN KEY (species) REFERENCES species(id);
ALTER TABLE animals ADD CONSTRAINT FK_owners FOREIGN KEY (owner_id) REFERENCES owners(id);
