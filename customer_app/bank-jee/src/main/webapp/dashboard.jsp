<%--
  Created by IntelliJ IDEA.
  User: Acer
  Date: 22/04/2022
  Time: 10:44
  To change this template use File | Settings | File Templates.
--%>
<%--<html>
<head>
    <title>Title</title>
    <h1>Dashboard</h1>
    <h2>${test}</h2>
&lt;%&ndash;    <c:forEach items="${array}" var="c">&ndash;%&gt;
&lt;%&ndash;        <tr>&ndash;%&gt;
&lt;%&ndash;            <td>${c.hashid}</td>&ndash;%&gt;
&lt;%&ndash;        </tr>&ndash;%&gt;
&lt;%&ndash;    </c:forEach>&ndash;%&gt;
&lt;%&ndash;    <p>${user.hashid}</p>&ndash;%&gt;
    <c:if test="${ !empty user[0].username }">
        <p>Vous êtes ${ user[0].username } !</p>
    </c:if>

    <c:if test="${ !empty accounts[0] }">
        <p>Vous êtes ${ accounts[0].balance } !</p>
    </c:if>
    <c:if test="${ !empty transactions[0] }">
        <p>Transaction : ${ transactions[0].amount } euros !</p>
    </c:if>
</head>
<body>--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="inc/header.jsp" %>
<section id="dashboard">
    <div class="wrap">
        <div class="dashboard-container">
            <div class="dashboard-container__accounts">
                <div class="dashboard-container__accounts__box grid1">
                    <p class="dashboard-container__accounts__box-title">Mes comptes courants</p>
                    <div class="dashboard-container__accounts__box-slider">
                        <div class="swiper swiper-first">
                            <ul class="dashboard-container__accounts__box-slider swiper-wrapper">

                                <c:if test="${ !empty accounts_courrants }">
                                    <c:forEach items="${accounts_courrants}" var="a">
                                        <li class="swiper-slide">
                                            <input class="accountId" type="hidden" value="${a.id}">
                                            <div class="card-container">
                                                <div class="card-container__wrap dashboard">
                                                    <div class="card-container__wrap__top">
                                                        <div class="card-container__wrap__top-left"></div>
                                                        <div class="card-container__wrap__top-right"></div>
                                                    </div>
                                                    <div class="card-container__wrap__bottom">
                                                        <div class="card-container__wrap__bottom__content">
                                                            <p>${a.account_type.name}</p>
                                                            <p>${a.balance}</p>
                                                        </div>
                                                        <div class="card-container__wrap__bottom__img"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                    </c:forEach>
                                </c:if>
                            </ul>
                            <div class="swiper-pagination swiper-pagination-first"></div>
                        </div>
                    </div>
                </div>
                <div class="dashboard-container__accounts__box grid2">
                    <p class="dashboard-container__accounts__box-title">Comptes épargnes</p>
                    <div class="dashboard-container__accounts__box-slider">
                        <div class="swiper swiper-second">
                            <ul class="swiper-wrapper">
                                <c:if test="${ !empty accounts_epargnes }">
                                    <c:forEach items="${accounts_epargnes}" var="a">
                                        <li class="swiper-slide">
                                            <input class="accountId" type="hidden" value="${a.id}">
                                            <div class="card-container">
                                                <div class="card-container__wrap dashboard">
                                                    <div class="card-container__wrap__top">
                                                        <div class="card-container__wrap__top-left"></div>
                                                        <div class="card-container__wrap__top-right"></div>
                                                    </div>
                                                    <div class="card-container__wrap__bottom">
                                                        <div class="card-container__wrap__bottom__content">
                                                            <p>${a.account_type.name}</p>
                                                            <p>${a.balance}</p>
                                                        </div>
                                                        <div class="card-container__wrap__bottom__img"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                    </c:forEach>
                                </c:if>
                            </ul>
                            <div class="swiper-pagination swiper-pagination-second"></div>
                        </div>
                    </div>
                </div>
                <div class="dashboard-container__table grid3">
                    <p class="dashboard-container__table-title">Transaction <span>Mai</span></p>
                    <div class="dashboard-container__table__content">
                        <c:if test="${ !empty transacs }">
                            <c:forEach items="${transacs}" var="days">
                            <div class="dashboard-container__table__content__container">
                                <p class="dashboard-container__table__content-date">13 Mai 2022</p>
                                <div class="swiper swiper-third">
                                    <ul class="swiper-wrapper">
                                        <c:if test="${ !empty days }">
                                            <c:forEach items="${days}" var="t">
                                                <li class="swiper-slide">
                                                    <div class="dashboard-container__table__content__transfer">
                                                        <div class="dashboard-container__table__content__transfer-icon">
                                                            <i class="fa-solid fa-barcode fa-xl"></i>
                                                        </div>
                                                        <div class="dashboard-container__table__content__transfer__container">
                                                            <div class="dashboard-container__table__content__transfer__container-split">
                                                                <p class="dashboard-container__table__content__transfer__container-top">
                                                                    Starbucks</p>
                                                                <p class="dashboard-container__table__content__transfer__container-top">
                                                                    ${t.amount}€</p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </li>
                                            </c:forEach>
                                        </c:if>
                                    </ul>
                                <div class="swiper-pagination swiper-pagination-third"></div>
                            </div>
                        </div>
                        </c:forEach>
                    </c:if>

                    </div>

                </div>
            </div>
        </div>
    </div>
</section>

<script src="https://unpkg.com/swiper@8/swiper-bundle.min.js" defer></script>
<script src="asset/js/dashboard.js" type="text/javascript" defer></script>
<%@ include file="inc/footer.jsp" %>