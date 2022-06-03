<%--
  Created by IntelliJ IDEA.
  User: Acer
  Date: 22/04/2022
  Time: 10:48
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<<<<<<< HEAD
<%@ include file="inc/header.jsp"%>

<section id="home">
    <div class="wrap">
        <div class="home-container">
            <div class="content">

                <h1 class="content__title">Connexion</h1>

            <%--Formulaire--%>
                <div class="card-container" id="card-home">
                    <div class="card-container__wrap__top">
                        <div class="card-container__wrap__top-left"></div>
                        <div class="card-container__wrap__top-right"></div>
                    </div>
                    <form method="post" action="login">
                        <%--Identifiant--%>
                        <div>
                            <input type="text" name="identifiant" placeholder="Identifiant">
                            <c:if test="${ !empty errors[0] }">
                                <p>${ errors[0] }</p>
                            </c:if>
                        <div>
                        <%--Mot de passe--%>
                        <div>
                            <input type="password" name="password" placeholder="Votre Mot de passe">
                            <c:if test="${ !empty errors[1] }">
                                <p>${ errors[1] }</p>
                            </c:if>
                        </div>
                        <%--Boutton envoyer--%>
                        <div>
                            <button name="submitted" type="submit">Se connecter</button>
                        </div>
                    </form>
                </div>
=======
<%@ include file="inc/header.jsp" %>
<section id="settings">
    <div class="wrap">
        <div class="settings-container">
            <div class="settings-container__content">
                <h1 class="settings-container__content-title">Connexion</h1>
                <p class="settings-container__content-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed
                    do eiusmod tempor incididunt ut labore et dolore magna aliqua. Urna id volutpat lacus laoreet.</p>
            </div>
            <div class="settings-container__forms">
                <form method="PUT" action="" class="settings-container__forms-login">
                    <input type="text" id="user" name="user" class="user" placeholder="identifiant">
                    <input type="password" id="pass" name="password" class="password" placeholder="mot de passe">
                    <input type="submit" value="connexion" class="sign button__gray submit-form">
                </form>
>>>>>>> 82194cd163ba0919d4e6e47ed84649f8be85f48d
            </div>
        </div>
    </div>
</section>
<<<<<<< HEAD

=======
<%@ include file="inc/footer.jsp" %>
>>>>>>> 82194cd163ba0919d4e6e47ed84649f8be85f48d
