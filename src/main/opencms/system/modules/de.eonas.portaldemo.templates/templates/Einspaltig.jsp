<%@page buffer="none" session="false" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<cms:include file="../elements/header.jsp"/>

<c:set var="cols"><cms:property name="style.columns" file="search" default="3"/></c:set>
<c:set var="centerwidth" value="930"/>
<c:set var="centerspan" value="span12"/>

<c:choose>
    <c:when test="${cols == '3'}">
        <c:set var="centerwidth" value="450"/>
        <c:set var="centerspan" value="col-sm-8 col-md-6"/>
    </c:when>
    <c:when test="${cols == '2'}">
        <c:set var="centerwidth" value="700"/>
        <c:set var="centerspan" value="col-sm-8 col-md-9"/>
    </c:when>
    <c:otherwise>
        <c:set var="centerwidth" value="930"/>
        <c:set var="centerspan" value="col-sm-12 col-md-12"/>
    </c:otherwise>
</c:choose>

<div class="container">

    <%--@elvariable id="login" type="org.opencms.jsp.CmsJspLoginBean"--%>
    <c:if test="${!login.loggedIn && !login.loginSuccess}">
        <div class="alert alert-danger alert-dismissable">
            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
            <fmt:message key="login.message.failed"/>:<br/>
                ${login.loginException.localizedMessage}
        </div>
    </c:if>


    <div class="row">
        <c:if test="${cols == '3' || cols == '2'}">

            <div class="col-sm-12 col-md-3" id="leftcol">
                <cms:include file="../elements/menu/nav_side.jsp"/>

                <cms:container name="leftcontainer" type="left" width="160" maxElements="8"/>
            </div>

        </c:if>

        <div class="${centerspan}">
            <cms:container name="centercontainer" type="center" width="${centerwidth}" maxElements="8"
                           detailview="true"/>
        </div>

        <c:if test="${cols == '3'}">
            <div class="col-sm-4 col-md-3">
                <cms:container name="rightcontainer" type="right" width="230" maxElements="8"/>
            </div>
        </c:if>
    </div>

    <div class="row">
        <div class="span12">
            <cms:container name="footercontainer" type="footer" maxElements="1" width="480"/>
        </div>
    </div>

    <hr>

</div>

<cms:include file="../elements/footer.jsp"/>