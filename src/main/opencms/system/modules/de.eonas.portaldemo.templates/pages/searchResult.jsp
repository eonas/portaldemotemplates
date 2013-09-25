<%@page session="false" import="org.opencms.file.*" %>
<%@ page import="org.opencms.search.CmsSearchResult" %>
<%@ page import="java.util.List" %>
<%@ page import="org.opencms.jsp.CmsJspActionElement" %>
<%@ page import="org.codehaus.jackson.map.ObjectMapper" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%--

	to use this JSP as function provider the following parameters may be set:
	'searchIndex' to set the index searched, default: 'Online project EN (VFS)'
	'searchRoot' to set the folder to be searched, default: '/'
	'searchMatchesPerPage' to set the number of results displayed per page, default: '5'

 --%>
<fmt:setLocale value="${cms.locale}"/>
<fmt:bundle basename="com.alkacon.opencms.v8.search.frontend">
    <c:set var="cmsobj" value="${cms.vfs.cmsObject}"/>
    <%-- searching 'Online project EN (VFS)' by default,
         supply function provider parameter 'searchIndex' to use any other --%>
    <c:set var="index">${(empty param.searchIndex)? "Online project EN (VFS)" : param.searchIndex }</c:set>
    <%-- searching from site root by default,
         supply function provider parameter 'searchRoot' to use any other --%>
    <c:set var="root">${(empty param.searchRoot)? "/" : param.searchRoot }</c:set>
    <c:set var="matches">${(empty param.searchMatchesPerPage)? 5 : param.searchMatchesPerPage }</c:set>
    <jsp:useBean id="search" class="org.opencms.search.CmsSearch" scope="request">
        <jsp:setProperty name="search" property="*"/>
        <%
            CmsJspActionElement cms = new CmsJspActionElement();
            cms.init(pageContext, request, response);
            CmsObject cmso = cms.getCmsObject();
            // initialize the search bean
            search.init(cmso);
            search.setIndex((String) pageContext.getAttribute("index"));
            int matches = 5;
            try {
                matches = Integer.parseInt((String) pageContext.getAttribute("matches"));
            } catch (Exception e) {
                // ignore, use default for number of matches
            }
            search.setMatchesPerPage(matches);
            String[] search_root = new String[]{(String) pageContext.getAttribute("root")};
            search.setSearchRoots(search_root);

            List<CmsSearchResult> result = search.getSearchResult();
            ObjectMapper mapper = new ObjectMapper();
            mapper.writeValue(response.getOutputStream(), result);

        %>
    </jsp:useBean>
</fmt:bundle>