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
SELECT * FROM animals LEFT JOIN owners ON animals.owner_id = owners.id WHERE full_name = 'Melody';
SELECT * FROM animals LEFT JOIN species ON animals.species = species.id WHERE species.name = 'Pokemon';
SELECT owners.full_name, animals.name FROM owners LEFT JOIN animals ON owners.id=animals.owner_id ORDER BY full_name;
SELECT species.name, COUNT(animals.name) AS count FROM animals INNER JOIN species ON animals.species = species.id GROUP BY species.id ORDER BY count DESC;
SELECT animals.name FROM animals INNER JOIN owners ON animals.owner_id = owners.id INNER JOIN species ON animals.species = species.id WHERE species.name='Digimon' AND owners.full_name='Jennifer Orwell' ORDER BY animals.name;
SELECT animals.name FROM animals INNER JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name='Dean Winchester' AND escape_attempts=0 ORDER BY animals.name;
SELECT owners.full_name, COUNT(animals.name) AS count FROM animals INNER JOIN owners ON animals.owner_id = owners.id GROUP BY owners.full_name ORDER BY count DESC LIMIT 1;

SELECT COUNT(DISTINCT animals.name) FROM visits INNER JOIN animals ON animal_id = animals.id
INNER JOIN vets ON vet_id=vets.id WHERE vets.name='Stephanie Mendez';

SELECT vets.name, species.name FROM vets LEFT JOIN specializations ON vets.id = vet_id
LEFT JOIN species ON species_id=species.id ORDER BY vets.name;

SELECT animals.name FROM visits INNER JOIN animals ON animal_id= animals.id
INNER JOIN vets ON vet_id=vets.id
WHERE vets.name='Stephanie Mendez' AND visit_date BETWEEN '2020-04-01' AND '2020-08-30'
ORDER BY animals.name;

SELECT animals.name, COUNT(animals.name) AS number_visits FROM visits INNER JOIN animals ON animal_id= animals.id 
GROUP BY animals.name ORDER BY number_visits DESC LIMIT 1;

SELECT animals.name, visit_date  FROM visits INNER JOIN animals ON animal_id= animals.id
INNER JOIN vets ON vet_id=vets.id
WHERE vets.name='Maisy Smith'
ORDER BY visit_date ASC LIMIT 1;

SELECT animals.name, animals.date_of_birth, animals.escape_attempts, animals.neutered, animals.weight_kg, 
vets.name, vets.age, vets.date_of_graduation
visit_date  FROM visits INNER JOIN animals ON animal_id= animals.id
INNER JOIN vets ON vet_id=vets.id
ORDER BY visit_date DESC LIMIT 1;

SELECT COUNT(animals.name) FROM visits 
INNER JOIN animals ON animal_id= animals.id
INNER JOIN vets ON vet_id=vets.id
WHERE animals.species NOT IN((SELECT species_id FROM specializations WHERE vet_id=visits.vet_id));

SELECT species.name FROM animals INNER JOIN visits ON animals.id=animal_id
INNER JOIN vets ON vet_id=vets.id
INNER JOIN species ON animals.species=species.id
WHERE vets.name='Maisy Smith'
GROUP BY species.name ORDER BY  COUNT(species.name) DESC LIMIT 1