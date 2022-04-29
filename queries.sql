/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name like '%mon';
SELECT name FROM animals where date_of_birth between '2016-01-01' and '2019-01-01';
SELECT name from animals WHERE neutered=true and escape_attempts<3;
SELECT date_of_birth FROM animals where name='Agumon' or name='Pikachu';

Select name, escape_attempts FROM animals where weight_kg > 10.5;
SELECT * FROM animals WHERE neutered=true;
SELECT * FROM animals WHERE name='Gabumon';
SELECT * FROM animals WHERE weight_kg>=10.4 and weight_kg<=17.4;

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * from animals;
ROLLBACK;

Begin;
UPDATE animals SET species='digimon' where name like '%mon';
UPDATE animals SET species='pokemon' where species='';
COMMIT;
SELECT * FROM animals;

Begin;
DELETE FROM animals;
SELECT * FROM animals;
Rollback;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth>'2022-01-01';
SAVEPOINT first_savepoint;
UPDATE animals set weight_kg=weight_kg*-1;
SELECT * FROM animals;
ROLLBACK TO SAVEPOINT first_savepoint;
SELECT * FROM animals;
UPDATE animals set weight_kg=weight_kg*-1 WHERE weight_kg < 0;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts=0;
SELECT AVG(weight_kg) FROM animals;
SELECT CASE WHEN (COUNT(CASE WHEN neutered THEN 1 END)) > COUNT(CASE WHEN not neutered THEN 1 END) THEN 'NEUTERED' ELSE 'NOT NEUTERED' END FROM animals;
SELECT species, MIN(weight_kg) as "Minimum Weight", MAX(weight_kg) as "Maximum Weight" FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) as "AVERAGE ESCAPE ATTEMPTS" from animals WHERE date_of_birth BETWEEN '1990-01-01' and '2000-01-01' GROUP BY species;
