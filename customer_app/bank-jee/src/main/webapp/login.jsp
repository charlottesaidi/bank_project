<%--
  Created by IntelliJ IDEA.
  User: Acer
  Date: 22/04/2022
  Time: 10:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <h1>Page Login</h1>
<%--    Formulaire--%>
    <form action="">
    <%--        Nom--%>
        <div>
            <label for="name"> Nom :</label>
            <input type="text" id="name" placeholder="Votre Nom">
        </div>
    <%--        Prénom--%>
        <div>
            <label for="lastname"> Prénom :</label>
            <input type="text" id="lastname" placeholder="Votre Prénom">
        </div>
    <%--        Adresse mail--%>
        <div>
            <label for="mail">Adresse mail</label>
            <input type="email" id="mail" placeholder="ex: abcd@mail.com">
        </div>
    <%--        Mot de passe--%>
        <div>
            <label for="password">Votre Mot de passe</label>
            <input type="password" id="password" placeholder="Votre Mot de passe">
        </div>
    <%--        Confirmation de mot de passe--%>
        <div>
            <label for="passwordconfirm">Confirmez votre mot de passe </label>
            <input type="password" id="passwordconfirm" placeholder="Confirmez votre Mot de passe">
        </div>
<%--        Boutton envoyer--%>
        <div>
            <button type="submit">S'inscrire</button>
        </div>
    </form>
</head>
<body>

</body>
</html>
