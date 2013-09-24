<%@page buffer="none" session="false" import="org.opencms.main.*, org.opencms.file.*" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="${cms.locale}"/>
<fmt:bundle basename="com.alkacon.opencms.v8.login.messages">

    <jsp:useBean id="login" class="org.opencms.jsp.CmsJspLoginBean" scope="request"/>
    <%
        login.init(pageContext, request, response);
    %>
    <c:set var="loginou">${cms.element.settings.loginou}</c:set>
    <c:if test="${param.action eq 'login' && !empty param.name && !empty param.password}">
        <c:choose>
            <c:when test="${not empty cms.element.settings.loginou}">
                <% login.login("/" + (String) pageContext.getAttribute("loginou") + "/" + request.getParameter("name"), request.getParameter("password"), "Offline", request.getParameter("requestedResource")); %>
            </c:when>
            <c:otherwise>
                <% login.login(request.getParameter("name"), request.getParameter("password"), "Online", request.getParameter("requestedResource")); %>
            </c:otherwise>
        </c:choose>
    </c:if>
    <c:if test="${param.action eq 'logoff'}">
        <%
            login.logout();
        %>
    </c:if>


    <c:choose>
        <c:when test="${!login.loggedIn}">

            <form method="get" action="<cms:link>${cms.requestContext.uri}</cms:link>" class="navbar-form navbar-right">

                <input name="name" type="text" placeholder="Email" class="form-control">
                <input name="password" type="password" placeholder="Password" class="form-control">
                <input type="hidden" name="action" value="login"/>
                <input type="hidden" name="requestedResource" value="${param.requestedResource}"/>
                <button type="submit" class="btn">Sign in</button>
            </form>
        </c:when>
        <c:otherwise>
            <c:set var="firstname"><cms:user property="firstname"/></c:set>
            <c:set var="lastname"><cms:user property="lastname"/></c:set>
            <c:set var="displayname">
                <c:if test="${not empty firstname}">${firstname}&nbsp;</c:if><c:if
                    test="${not empty lastname}">${lastname}</c:if>
                <c:set var="username"><cms:user property="name"/></c:set>
                <c:if test="${empty firstname && empty lastname}">
                    <c:if test="${fn:indexOf(username, '/') != -1}">
                        <c:set var="username">${fn:substringAfter(username, '/')}</c:set>
                    </c:if>
                    (${username})
                </c:if>
            </c:set>

            <form class="navbar-form navbar-left" role="search">
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="Search">
                </div>
            </form>

            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a data-toggle="dropdown" class="dropdown-toggle" href="#">${displayname}<b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="<cms:link>/admin/messages.html</cms:link>">Messages</a></li>
                        <li><a href="<cms:link>/admin/subscriptions.html</cms:link>">Subscriptions</a></li>
                        <li><a href="<cms:link>/admin/friends.html</cms:link>">Friends</a></li>
                        <li class="divider"></li>
                        <li><a href="<cms:link>/homes/${username}/profile.html</cms:link>">User Profile</a></li>
                        <li><a href="<cms:link>/admin/preferences.html</cms:link>">Preferences</a></li>
                        <li class="divider"></li>
                        <li><a href="<cms:link>${cms.requestContext.uri}</cms:link>?action=logoff">Logout</a></li>
                    </ul>
                </li>
                <li>
                    <a style="padding: 0" href="">
                <span style="font-size: 27px; vertical-align: middle; line-height: 180%; color: #fff; margin-right: -11px; z-index: -1;"
                      class="glyphicon glyphicon-info-sign"></span>
                        <span style="background-color: #f00" class="badge">2</span>
                    </a>
                </li>
                <li>
                    <c:set var="now" value="<%=new java.util.Date()%>"/>
                    <p class="navbar-text"><fmt:formatDate type="time"
                                                           timeStyle="short"
                                                           value="${now}"/></p>
                </li>
            </ul>

        </c:otherwise>
    </c:choose>


</fmt:bundle>