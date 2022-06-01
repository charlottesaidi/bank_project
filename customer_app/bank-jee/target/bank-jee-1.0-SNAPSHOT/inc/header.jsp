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
    <title>BankMe</title>
    <%--    reset css--%>
    <link rel="stylesheet" href="asset/css/reset.css">
    <%--    style css--%>
    <link rel="stylesheet" href="asset/css/style.css">
</head>
<body>
<%--navigation--%>
<header>
    <div class="wrap">
        <div class="header-container">
            <a href="index.jsp" class="logo"></a>
            <nav class="navigation">
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
            </nav>
        </div>
    </div>
</header>