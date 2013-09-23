<%@page buffer="none" session="false" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="navStartLevel"><cms:property name="NavStartLevel" file="search" default="0"/></c:set>
<cms:navigation type="treeForFolder" startLevel="${navStartLevel + 1}" endLevel="${navStartLevel + 3}" var="nav"/>

<c:if test="${!empty nav.items}">
    <div class="panel panel-default">
        <div class="panel-heading">
            Menü
        </div>
        <div class="panel-body">
            <ul class="nav nav-pills nav-stacked">
                <c:set var="oldLevel" value=""/>
                    <c:forEach items="${nav.items}" var="elem">
                        <c:set var="currentLevel" value="${elem.navTreeLevel}"/>
                            <c:choose>
                                <c:when test="${empty oldLevel}"></c:when>
                                <c:when test="${currentLevel > oldLevel}"><ul></c:when>
                                <c:when test="${currentLevel == oldLevel}"></li></c:when>
                                <c:when test="${oldLevel > currentLevel}">
                                    <c:forEach begin="${currentLevel + 1}" end="${oldLevel}"></li></ul></c:forEach></li>
                                </c:when>
                            </c:choose>

                        <li>

                                <a href="<cms:link>${elem.resourceName}</cms:link>"
                                   <c:if test="${!elem.navigationLevel && nav.isActive[elem.resourceName]}"> class="active" </c:if>>${elem.navText}</a>

                                <c:set var="oldLevel" value="${currentLevel}"/>
                 </c:forEach>

             <c:forEach begin="${navStartLevel}" end="${oldLevel}"></li>
                </ul>
             </c:forEach>
            <c:if test="${not empty nav.items}"></li></c:if>
            </ul>
        </div>
    </div>
</c:if>
