<%@page buffer="none" session="false" import="org.opencms.main.*, org.opencms.file.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="${cms.locale}" />
<fmt:bundle basename="com.alkacon.opencms.v8.login.messages">
<div class="panel panel-default box ${cms.element.settings.boxschema}">
<jsp:useBean id="login" class="org.opencms.jsp.CmsJspLoginBean" scope="page">
        <%
                login.init (pageContext, request, response);
        %>
        <c:set var ="loginou">${cms.element.settings.loginou}</c:set>
        <c:if test="${param.action eq 'login' && !empty param.name && !empty param.password}">
                <c:choose>
                        <c:when test ="${not empty cms.element.settings.loginou}">
                          <% login.login ("/"+(String)pageContext.getAttribute ("loginou")+"/" + request.getParameter("name"), request.getParameter("password"), "Offline", request.getParameter("requestedResource")); %>
                        </c:when>
                        <c:otherwise>
                         <% login.login (request.getParameter("name"), request.getParameter("password"), "Offline", request.getParameter("requestedResource")); %>
                        </c:otherwise>
                </c:choose>
        </c:if>
        <c:if test="${param.action eq 'logoff'}">
        <%
                login.logout();
        %>
        </c:if>
</jsp:useBean>

<%-- Title of the login box--%>
<div class="panel-heading">
<fmt:message key="login.title" />
</div>

<div class="panel-body">
<c:choose>
        <c:when test="${!login.loggedIn}">
                <p><fmt:message key="login.text" /></p>
        </c:when>
        <c:otherwise>
                <p><b><fmt:message key="login.message.loggedin" />:</b></p>
                <c:set var="firstname"><cms:user property="firstname"/></c:set>
                <c:set var="lastname"><cms:user property="lastname"/></c:set>
                <c:if test="${not empty firstname}">${firstname}&nbsp;</c:if><c:if test="${not empty lastname}">${lastname}</c:if>
                <c:set var="username"><cms:user property="name"/></c:set>
                <c:if test="${empty firstname && empty lastname}">
                        <c:if test="${fn:indexOf(username, '/') != -1}">
                                <c:set var="username">${fn:substringAfter(username, '/')}</c:set>
                        </c:if>
                        (${username})
                </c:if>
        </c:otherwise>
        </c:choose>
                <c:if test="${!login.loginSuccess}">
                        <div class="login-errormessage">
                                <fmt:message key="login.message.failed" />:<br />
                                ${login.loginException.localizedMessage}
                        </div>
                </c:if>
                <form method="get" action="<cms:link>${cms.requestContext.uri}</cms:link>" class="loginform">
                        <div class="boxform">
                                <label for="name"><fmt:message key="login.label.username" />:</label>
                                <input type="text" name="name">
                        </div>
                        <div class="boxform">
                                <label for="password"><fmt:message key="login.label.password" />:</label>
                                <input type="password" name="password">
                        </div>
                        <div class="boxform">
                                <input type="hidden" name="action" value="login" />
                                <input type="hidden" name="requestedResource" value="${param.requestedResource}" />
                                <input class="button" type="submit" value="<fmt:message key="login.label.login" />"/>
                        </div>
                </form>
</div>
</div>
</fmt:bundle> 