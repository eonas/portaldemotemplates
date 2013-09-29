<%@page buffer="none" session="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="portlet" uri="http://eonas.de/portaltaglib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<cms:formatter var="content" val="value">

    <div>
        <!-- Portlet -->
            <%--@elvariable id="value" type="Map<String, Map<String, org.opencms.jsp.util.CmsJspContentAccessValueWrapper>>"--%>

        <c:set var="ID">${value.WindowID}</c:set>
        <c:set var="Portlet">${value.Portlet}</c:set>
        <c:set var="Title">${value.Title}</c:set>

        <c:choose>
            <c:when test="${!empty ID and !empty Portlet}">
                <c:set var="PortletID">${Portlet}${ID}</c:set>
                <portlet:portlet portletId="${PortletID}">
                    <!-- Window State Controls -->
                    <portlet:render/>

                </portlet:portlet>
                <%
                    pageContext.removeAttribute("javax.servlet.jsp.jstl.fmt.localizationContext.request");
                    pageContext.removeAttribute("javax.servlet.include.servlet_path");
                %>
            </c:when>
            <c:otherwise>

                <div class="panel-heading">
                        ${Title}
                </div>
                <div class="panel-body">
                    unconfigured portlet
                </div>
            </c:otherwise>
        </c:choose>
    </div>

</cms:formatter>
