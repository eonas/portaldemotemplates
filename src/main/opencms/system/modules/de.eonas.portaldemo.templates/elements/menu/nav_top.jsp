<%@page buffer="none" session="false" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="navStartLevel"><cms:property name="NavStartLevel" file="search" default="0"/></c:set>
<cms:navigation type="treeForFolder" startLevel="${navStartLevel}" endLevel="${navStartLevel + 3}" var="nav"/>

<c:if test="${!empty nav.items}">
    <div class="navbar navbar-inverse navbar-fixed-top">
        <div class="container">
            <div class="navbar-header">

                <a class="navbar-brand" href="#"><cms:info property="opencms.title"/></a>
            </div>

            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <c:set var="oldLevel" value=""/>
                    <c:forEach items="${nav.items}" var="elem" varStatus="status">
                    <c:set var="currentLevel" value="${elem.navTreeLevel}"/>
                    <c:choose>
                        <c:when test="${empty oldLevel}"></c:when>
                        <c:when test="${currentLevel > oldLevel}"><ul class="dropdown-menu"></c:when>
                        <c:when test="${currentLevel == oldLevel}"></li></c:when>
                        <c:when test="${oldLevel > currentLevel}">
                            <c:forEach begin="${currentLevel + 1}" end="${oldLevel}"></li></ul></c:forEach></li>
                        </c:when>
                    </c:choose>

                    <c:choose>
                        <c:when test="${!status.last && nav.items[status.index + 1].navTreeLevel > currentLevel}">
                            <c:set var="dropdown">
                                data-toggle="dropdown" class="dropdown-toggle
                            </c:set>
                            <c:set var="caret">
                                <b class="caret"></b>
                            </c:set>
                        </c:when>
                        <c:otherwise>
                            <c:set var="dropdown">
                                class="
                            </c:set>
                            <c:set var="caret" value=""/>
                        </c:otherwise>
                    </c:choose>
                    <li><a href="<cms:link>${elem.resourceName}</cms:link>" ${dropdown}
                           <c:if test="${!elem.navigationLevel && nav.isActive[elem.resourceName]}">active</c:if>">${elem.navText}${caret}</a>

                        <c:set var="oldLevel" value="${currentLevel}"/>
                        </c:forEach>

                        <c:forEach begin="${navStartLevel}" end="${oldLevel}"></li>
                </ul>
                </c:forEach>
                <c:if test="${not empty nav.items}"></li></c:if>
                </ul>

                <cms:include file="nav_top_right.jsp"/>
            </div>
        </div>
    </div>
</c:if>
