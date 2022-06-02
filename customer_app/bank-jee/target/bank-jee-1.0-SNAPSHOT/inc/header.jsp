<%--
  Created by IntelliJ IDEA.
  User: Acer
  Date: 22/04/2022
  Time: 11:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>BankMe</title>
    <link rel="stylesheet" href="asset/css/reset.css">
    <link rel="stylesheet" href="https://unpkg.com/swiper@8/swiper-bundle.min.css"/>
    <link rel="stylesheet" href="asset/css/style.css">
</head>
<body>
<%--navigation--%>
<header>
    <div class="wrap">
        <div class="header-container">
            <a href="index.jsp" class="logo"></a>
            <nav class="navigation">
                <div class="nav">
                    <div>
                        <ul>
                            <li><a href="dashboard.jsp">Accueil</a></li>
                            <li><a href="login.jsp">Connexion</a></li>
                        </ul>
                    </div>
                    <div class="circlelogos">
                        <a href="transfert.jsp" class="transfert"></a>
                        <a href="settings.jsp" class="settings"></a>
                    </div>
                </div>
                <div class="burger">
                    <span></span>
                </div>
            </nav>
        </div>
    </div>
</header>
<main>
    <div class="circle"></div>
    <div class="circle two"></div>
    <div class="circle three"></div>
    <div class="circle four"></div>