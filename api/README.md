# API Backend - Restaurant Management System

## Description
Cette API RESTful a été développée avec NestJS pour gérer un système de réservation de restaurant. Elle permet la gestion des utilisateurs, des tables, des créneaux horaires et des réservations.

## Prérequis
- Node.js (v14 ou supérieur)
- PostgreSQL
- npm ou yarn

## Installation

1. Cloner le repository
```bash
git clone [URL_DU_REPO]
cd api
```

2. Installer les dépendances
```bash
npm install
```

3. Configurer les variables d'environnement
Créer un fichier `.env` à la racine du projet (copier le fichier `.env.example`) avec les variables suivantes :
```env
JWT_SECRET=votre_secret_jwt
JWT_EXPIRES_IN=3600
```

4. Lancer la base de données et le serveur
```bash
docker-compose up -d
```

5. Le serveur est lancé sur le port 3000 http://localhost:3000

## Structure de l'API

### Authentification (`/auth`)
- `POST /auth/login` - Connexion utilisateur
- `POST /auth/register` - Inscription d'un nouvel utilisateur

### Utilisateurs (`/users`)
- `GET /users` - Liste des utilisateurs (Admin)
- `POST /users` - Création d'un utilisateur (Admin)
- `GET /users/profile` - Profil de l'utilisateur connecté
- `DELETE /users/:id` - Suppression d'un utilisateur (Admin)
- `GET /users/reservations` - Réservations de l'utilisateur connecté

### Tables (`/tables`)
- `GET /tables` - Liste des tables
- `POST /tables` - Création d'une table (Admin)
- `GET /tables/:id` - Détails d'une table
- `PUT /tables/:id` - Mise à jour d'une table (Admin)
- `DELETE /tables/:id` - Suppression d'une table (Admin)

### Créneaux horaires (`/time-slots`)
- `GET /time-slots` - Liste des créneaux horaires
- `POST /time-slots` - Création d'un créneau (Admin)
- `GET /time-slots/:id` - Détails d'un créneau
- `PUT /time-slots/:id` - Mise à jour d'un créneau (Admin)
- `DELETE /time-slots/:id` - Suppression d'un créneau (Admin)

### Réservations (`/reservations`)
- `POST /reservations/available` - Vérifier les disponibilités
- `POST /reservations` - Créer une réservation
- `GET /reservations` - Liste des réservations (Admin)
- `GET /reservations/:id` - Détails d'une réservation (Admin)
- `PUT /reservations/:id` - Mise à jour d'une réservation (Admin)
- `DELETE /reservations/:id` - Suppression d'une réservation (Admin)

## Sécurité
- Authentification JWT
- Gestion des rôles (Admin, User)
- Protection des routes avec Guards
- Validation des données avec DTOs

## Technologies utilisées
- NestJS
- TypeORM
- PostgreSQL
- JWT
- Passport
- Class Validator
- Class Transformer

