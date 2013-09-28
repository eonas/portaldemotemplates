<%@page session="false" import="org.opencms.file.CmsObject" %>
<%@ page import="org.opencms.file.CmsResource" %>
<%@ page import="org.opencms.file.CmsUser" %>
<%@ page import="org.opencms.jsp.CmsJspActionElement" %>
<%@ page import="org.opencms.main.OpenCms" %>
<%@ page import="org.opencms.search.*" %>
<%@ page import="org.opencms.util.CmsUUID" %>
<%@ page import="javax.xml.stream.XMLEventFactory" %>
<%@ page import="javax.xml.stream.XMLEventWriter" %>
<%@ page import="javax.xml.stream.XMLOutputFactory" %>
<%@ page import="javax.xml.stream.XMLStreamException" %>
<%@ page import="javax.xml.stream.events.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="org.opencms.file.CmsProperty" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>

<%! public static final String SITES_DEFAULT = "/sites/default";

    private void createNode(XMLEventWriter eventWriter, String name,

                            String value) throws XMLStreamException {
        XMLEventFactory eventFactory = XMLEventFactory.newInstance();
        // Create Start node
        StartElement sElement = eventFactory.createStartElement("", "", name);
        eventWriter.add(sElement);
        // Create Content
        Characters characters = eventFactory.createCharacters(value);
        eventWriter.add(characters);
        // Create End node
        EndElement eElement = eventFactory.createEndElement("", "", name);
        eventWriter.add(eElement);
    }
%>
<%
    String filterUsername = request.getParameter("u");
    String[] categorys = request.getParameterValues("c");
    boolean reportHiddenContent = (request.getParameter("h") != null);

    CmsJspActionElement cms = new CmsJspActionElement();
    cms.init(pageContext, request, response);


    CmsObject cmso = cms.getCmsObject();

    CmsSearchManager search = OpenCms.getSearchManager();
    CmsSearchIndex index = search.getIndex("Online project EN (VFS)");
    CmsSearchParameters parameter = new CmsSearchParameters();
    parameter.setSort(CmsSearchParameters.SORT_DATE_LASTMODIFIED);
    parameter.setQuery("*:*");
    if (categorys != null && categorys.length > 0) {
        List<String> cList = Arrays.asList(categorys);
        parameter.setCategories(cList);
    }
    CmsSearchResultList result = index.search(cmso, parameter);


    SimpleDateFormat formatter =
            new SimpleDateFormat("DDD, dd MMM yyyy HH:mm:ss Z");
    String today = formatter.format(new Date());

    XMLOutputFactory outputFactory = XMLOutputFactory.newInstance();
    XMLEventWriter eventWriter = outputFactory
            .createXMLEventWriter(response.getOutputStream());

    XMLEventFactory eventFactory = XMLEventFactory.newInstance();

// Create and write Start Tag
    StartDocument startDocument = eventFactory.createStartDocument();
    eventWriter.add(startDocument);

// Create open tag

    StartElement rssStart = eventFactory.createStartElement("", "", "rss");
    eventWriter.add(rssStart);
    eventWriter.add(eventFactory.createAttribute("version", "2.0"));


    eventWriter.add(eventFactory.createStartElement("", "", "channel"));


    createNode(eventWriter, "title", "OpenCms Modifications");
    createNode(eventWriter, "link", request.getRequestURI());
    createNode(eventWriter, "description", "Latest Modifications");
    createNode(eventWriter, "language", "en");
    createNode(eventWriter, "copyright", "-");
    createNode(eventWriter, "pubdate", today);

    int i;
    if (result != null) {
        for (i = 0; i < result.size(); i++) {
            final CmsSearchResult cmsSearchResult = result.get(i);
            String path = cmsSearchResult.getPath();

            // TODO this is shit!
            if (path.startsWith(SITES_DEFAULT)) {
                path = path.substring(SITES_DEFAULT.length());
            }

            if ( path.contains(".content") && reportHiddenContent == false ) continue;

            try {
                final CmsResource cmsResource = cmso.readResource(path);
                String title = cmsSearchResult.getTitle();
                if ( title == null ) {
                    title = cmsResource.getName();
                }
                final CmsUUID userLastModified = cmsResource.getUserLastModified();
                final CmsUser cmsUser = cmso.readUser(userLastModified);
                final String name = cmsUser.getName();

                if (filterUsername == null || filterUsername.equalsIgnoreCase(name)) {

                    final long dateCreated = cmsResource.getDateCreated();
                    final long dateModified = cmsResource.getDateLastModified();

                    String operation;
                    String suffix;
                    if (dateCreated == dateModified) {
                        operation = "created";
                        suffix = "";
                    } else {
                        operation = "updated";
                        suffix = ", Version " + cmsResource.getVersion();
                    }

                    eventWriter.add(eventFactory.createStartElement("", "", "item"));
                    createNode(eventWriter, "title", "" + name + " " + operation + " " + title);
                    createNode(eventWriter, "description", "" + name + " " + operation + " Resource " + cmsResource.getName() + " (" + path + suffix + ")");
                    createNode(eventWriter, "link", cms.link(path));
                    createNode(eventWriter, "author", name);
                    createNode(eventWriter, "pubDate", formatter.format(new Date(dateModified)));
                    createNode(eventWriter, "guid", path + "/" + dateModified);

                    eventWriter.add(eventFactory.createEndElement("", "", "item"));
                }
            } catch (org.opencms.file.CmsVfsResourceNotFoundException ex) {
                // skip this entry
                // TODO: add logging
            }
        }
    }

    eventWriter.add(eventFactory.createEndElement("", "", "channel"));
    eventWriter.add(eventFactory.createEndElement("", "", "rss"));

    eventWriter.add(eventFactory.createEndDocument());

    eventWriter.close();
%>

