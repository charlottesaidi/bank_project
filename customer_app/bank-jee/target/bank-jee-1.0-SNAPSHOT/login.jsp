<%--
  Created by IntelliJ IDEA.
  User: Acer
  Date: 22/04/2022
  Time: 10:48
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            </div>
        </div>
    </div>
</section>
<%@ include file="inc/footer.jsp" %>