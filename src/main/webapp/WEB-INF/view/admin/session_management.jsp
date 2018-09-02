<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 29-Aug-18
  Time: 16:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

</head>
<body>
<jsp:include page="../../../view/menu.jsp"/>

<fmt:bundle basename="page_strings" prefix="string.">
    <table class="table table-striped table-bordered table-sm">
        <tr>
            <th>
                <fmt:message key="username"/>
            </th>
            <th>
                <fmt:message key="role"/>
            </th>
            <th>
                <fmt:message key="creation"/>
            </th>
            <th>
                <fmt:message key="last_activity"/>
            </th>
            <th>
                <fmt:message key="language"/>
            </th>
            <th>
                <fmt:message key="session_number"/>
            </th>
            <th>

            </th>
        </tr>
        <c:forEach var="sessionDto" items="${requestScope.sessions}">
            <tr>
                <td>
                    <c:if test="${sessionDto.role!='guest'}">
                        <form action="/app/edit_user_page">
                            <input type="hidden" name="username" value="${sessionDto.username}">
                            <input class="btn btn-link" type="submit" value="${sessionDto.username}">
                        </form>
                    </c:if>
                    <c:if test="${sessionDto.role=='guest'}">
                        ${sessionDto.username}
                    </c:if>
                </td>
                <td>
                    <fmt:message key="role.${sessionDto.role}"/>
                </td>
                <td>
                        ${sessionDto.creationTime}
                </td>
                <td>
                        ${sessionDto.lastActivity}
                </td>
                <td>
                        ${sessionDto.language}
                </td>
                <td>
                        ${sessionDto.sessionId}
                </td>
                <td>
                    <form action="/app/session_management_page?records_per_page=${records_per_page}&current_page=${current_page}&sort_column=${sort_column}">
                        <input type="hidden" name="session_to_remove" value="${sessionDto.username}">
                        <input class="btn btn-danger" type="submit" value="<fmt:message key="invalidate"/>">
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>

    <ul class="pagination">
        <c:if test="${current_page != 1}">
            <li class="page-item"><a class="page-link"
                                     href="/app/session_management_page?records_per_page=${records_per_page}&current_page=${current_page-1}&sort_column=${sort_column}">Previous</a>
            </li>
        </c:if>

        <c:forEach begin="1" end="${no_of_pages}" var="i">
            <c:choose>
                <c:when test="${current_page eq i}">
                    <li class="page-item active"><a class="page-link">
                            ${i} <span class="sr-only">(current)</span></a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="page-item"><a class="page-link"
                                             href="/app/session_management_page?records_per_page=${records_per_page}&current_page=${i}&sort_column=${sort_column}">${i}</a>
                    </li>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:if test="${current_page lt no_of_pages}">
            <li class="page-item"><a class="page-link"
                                     href="/app/session_management_page?records_per_page=${records_per_page}&current_page=${current_page+1}&sort_column=${sort_column}">Next</a>
            </li>
        </c:if>
    </ul>
</fmt:bundle>




</body>
</html>