# Application Banquier
## Requis
- [Java Spring Boot](https://spring.io/quickstart)
- [Node.js](https://nodejs.org/en/)

## Installation

### Base de données
Créer une base de données "bank_api"

### Exécution de l'Application
###### Java Spring (server)
Pour faire tourner l'api, il faut se rendre dans le dossier projet de l'application java :

```bash
cd /server
```
Puis lancer *BankApiApplication*. -> http://localhost:8080

Une [Documentation](https://documenter.getpostman.com/view/17771184/Uz5DqckF) est disponible pour utiliser l'api.

###### NextJs (client)

```bash
cd /client
npm install
npm run dev
```
Url de l'application -> http://localhost:3000

### Connexion
Pour tester la connexion, utiliser le *username* de l'utilisateur (visible dans la base de données)  
Mot de passe de l'utilisateur test banquier : *bankerpass*  
Mot de passe de l'utilisateur test directeur : *directorpass*