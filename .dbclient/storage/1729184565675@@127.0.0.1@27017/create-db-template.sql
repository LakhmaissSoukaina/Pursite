-- Active: 1729184565675@@127.0.0.1@27017
use etudiantDB;

// 2. Créer une collection appelée "etudiants"
db.createCollection('etudiants');

// 3. Créer une collection appelée "cours"
db.createCollection('cours');

// 4. Insérer un document dans la collection "etudiants"
db.etudiants.insertOne({
    "nom": "Sara",
    "age": 23,
    "specialite": "Informatique",
    "ville": "Casablanca"
});

// 5. Insérer plusieurs documents dans la collection "cours"
db.cours.insertMany([
    {
        "titre": "Programmation Web",
        "professeur": "Mr. El Fassi",
        "credits": 3
    },
    {
        "titre": "Bases de données",
        "professeur": "Mme. Rahmani",
        "credits": 4
    }
]);

// 6. Afficher tous les documents dans la collection "etudiants"
db.etudiants.find({});

// 7. Afficher tous les documents dans la collection "cours"
db.cours.find({});
