<%@page buffer="none" session="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="portlet" uri="http://eonas.de/portaltaglib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<cms:formatter var="content" val="value">

    <div class="panel panel-default">
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
                    <div class="panel-heading">
                        <span style="display: inline-block;">
                            <portlet:modeDropDown styleClass=""/>
                        </span>
                        <c:choose>
                            <c:when test="${fn:length(Title) > 0}">
                                ${Title}
                            </c:when>
                            <c:otherwise>
                                <portlet:title/>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="panel-body">
                        <portlet:render/>
                    </div>

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
