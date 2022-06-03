<%--
  Created by IntelliJ IDEA.
  User: Acer
  Date: 22/04/2022
  Time: 10:48
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="inc/header.jsp"%>

    <h1>Connexion</h1>

    <%--Formulaire--%>
    <form class="customer-login-form" method="post" action="login">
        <%--Identifiant--%>
        <div>
            <input class="customer-login-identifiant" type="text" name="identifiant" placeholder="Identifiant">
            <span class="error customer-login-identifiant-error"></span>

        <%--Mot de passe--%>
        <div>
            <input class="customer-login-password" type="password" name="password" placeholder="Votre Mot de passe">
            <span class="error customer-login-password-error"></span>
        </div>
        <%--Boutton envoyer--%>
        <div>
            <button name="submitted" type="submit">Se connecter</button>
        </div>
    </form>
