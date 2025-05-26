# Flutter Restaurant App [M2]

L'objectif de ce projet est de créé une application comme The FORK.

Un utilisateur doit pouvoir choisir le restaurant, voir son menu pour ensuite prendre une réservation, sur la table et le créneau horaire de son choix.

## Lancement du projet

### API

Pour l'API il suffit de lancer la commande suivante :

```bash
docker compose up -d --build
```

Attention, si vous êtes sur Windows penser à lancer l'API sur WSL.

### Front

Démarrez votre meilleur émulateur sur Android Studio et cliquer sur "Lancer".

---

Et voilà, votre application est prête à l'emploi.

## Fonctionnalités réalisées

### API

Vous trouverez ci-dessous la liste des fonctionnalités existantes sur l'API :

- Connexion / Inscription d'un utilisateur (jusqu'à que quentin essaie de mettre en place le provider)
- Gestion des utilisateurs en tant qu'administrateur
- Gestion des tables et des créneaux en tant qu'administrateur
- Gestion des réservations en tant que hôte/serveur
- En tant qu'utilisateur nous pouvons réserver une table sur un créneau spécifique

### Front

Vous trouverez ci-dessous la liste des fonctionnalités existantes sur le front :

- Accéder au détail d'un restaurant (actuellement uniquement, le premier de la liste)
- Accéder au menu du restaurant en question
- Connexion / Inscription en tant que client sur l'application
- Accéder à la liste des réservations en tant qu'un client
- Gestion des réservations en tant que serveur
