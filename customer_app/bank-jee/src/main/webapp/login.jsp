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
            </div>
        </div>
    </div>
</section>

