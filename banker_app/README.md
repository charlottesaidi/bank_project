# Application Banquier
## Requis
- [Java Spring Boot](https://spring.io/quickstart)
- [Node.js](https://nodejs.org/en/)

## Installation

### Base de données
Créer une base de données "bank_api" ou importer le fichier ***bank_api.sql***  

### Exécution de l'Application

###### Java Spring (server)
#### Fixtures
La base de données se remplira de fausse données au lancement de l'application :  
Aller dans ***src/main/java/com/nsf/bank/payload/LoadDatabase.java*** puis décommenter le bloc de code suivant :

```java
@Bean
CommandLineRunner initDatabase() throws ParseException {
    // commenter après le premier lancement de l'application
    int usersCount = createUsers();
    int accountTypesCount = createAccountTypes();

    return args -> {
        log.info("Loading fixtures : " + usersCount + " utilisateur.s inséré.s");
        log.info("Loading fixtures : " + accountTypesCount + " type.s de compte inséré.s");
    };
    
    // ...
}
```

#### Run
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
Pour tester la connexion, utiliser le *username* de l'utilisateur (visible dans la base de données). Utiliser les 3 premiers utilisateurs dont les emails ont pour domaines : *banker.fr*, *customer.fr* et *director.fr*  

Mot de passe de l'utilisateur banquier : *bankerpass*  
Mot de passe de l'utilisateur directeur : *directorpass*