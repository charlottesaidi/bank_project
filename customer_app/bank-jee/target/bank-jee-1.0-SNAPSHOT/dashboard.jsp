<%--
  Created by IntelliJ IDEA.
  User: Acer
  Date: 22/04/2022
  Time: 10:44
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <h1>Dashboard</h1>
    <h2>${test}</h2>
<%--    <c:forEach items="${array}" var="c">--%>
<%--        <tr>--%>
<%--            <td>${c.hashid}</td>--%>
<%--        </tr>--%>
<%--    </c:forEach>--%>
<%--    <p>${user.hashid}</p>--%>
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
<body>

</body>
</html>
