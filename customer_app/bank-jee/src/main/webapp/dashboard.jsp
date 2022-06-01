<%--
  Created by IntelliJ IDEA.
  User: Acer
  Date: 22/04/2022
  Time: 10:44
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

<%@ include file="inc/header.jsp" %>

    <section id="dashboard">
        <div class="wrap">
            <div class="dashboard-container">

                <div class="dashboard-container__accounts">
                    <div class="dashboard-container__accounts__box">
                        <p class="dashboard-container__accounts__box-title">Mes comptes courants</p>
                        <div class="swiper">
                            <ul class="dashboard-container__accounts__box-slider swiper-wrapper">
                                <li class="swiper-slide">

                                </li>
                            </ul>
                            <div class="swiper-pagination"></div>
                        </div>
                    </div>
                    <div class="dashboard-container__accounts__box">
                        <p class="dashboard-container__accounts__box-title">Comptes épargnes</p>
                        <div class="swiper">
                            <ul class="dashboard-container__accounts__box-slider swiper-wrapper">
                                <li class="swiper-slide">

                                </li>
                            </ul>
                            <div class="swiper-pagination"></div>
                        </div>
                    </div>
                </div>


                <div class="dashboard-container__board">

                </div>


            </div>
        </div>
    </section>

<%@ include file="inc/footer.jsp" %>