<%--
  Created by IntelliJ IDEA.
  User: Acer
  Date: 22/04/2022
  Time: 10:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="inc/header.jsp" %>
<section id="settings">
    <div class="wrap">
        <div class="settings-container">
            <div class="settings-container__content">
                <h1 class="settings-container__content-title">Informations Personnels</h1>
                <p class="settings-container__content-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed
                    do eiusmod tempor incididunt ut labore et dolore magna aliqua. Urna id volutpat lacus laoreet.</p>
            </div>
            <div class="settings-container__forms">
                <form method="PUT" action="" class="settings-container__forms-first">
                    <input type="email" id="email" pattern=".+@globex\.com" placeholder="qvannarath@gmail.com" class="email">
                    <input type="tel" id="phone" name="phone" pattern="[0-9]{3}-[0-9]{3}-[0-9]{4}" placeholder="07 83 57 40 54" class="phone">
                    <input type="password" id="pass" name="password" placeholder="0754121sdfg" class="password" disabled="disabled">
                    <input type="submit" value="modifier" class="submit button__gray submit-form">
                </form>
                <form method="PUT" action="" class="settings-container__forms-second">
                    <input type="text" id="name" placeholder="Vannarath" class="name">
                    <input type="text" id="surname" name="surname" placeholder="Quentin" class="surname">
                    <input type="text" id="town" name="town" placeholder="Rouen" class="town">
                    <input type="text" id="address" name="address" placeholder="118 Rue du Renard" class="address">
                    <input type="submit" value="demande de modification" class="modify button__gray submit-form">
                </form>
            </div>
        </div>
    </div>
</section>
<%@ include file="inc/footer.jsp" %>
