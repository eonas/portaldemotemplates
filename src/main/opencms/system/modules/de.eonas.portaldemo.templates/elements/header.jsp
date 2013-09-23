<%@page buffer="none" session="false" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<!DOCTYPE html>
<html>
<head>
    <title><cms:info property="opencms.title"/></title>
    <cms:enable-ade/>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.0-wip/css/bootstrap.min.css">
    <link rel="stylesheet" href="<cms:link>../resources/css/main.css</cms:link>">

    <!--script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script-->
    <script src="<cms:link>../resources/js/vendor/jquery.complete.js</cms:link>"></script>

    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.0-wip/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        try {
            document.execCommand('BackgroundImageCache', false, true);
        } catch (e) {
        }
    </script>



    <cms:headincludes type="javascript"/>
    <cms:headincludes type="css"/>

    <!-- Fav and touch icons -->
    <link rel="apple-touch-icon-precomposed" sizes="144x144"
          href="<cms:link>../resources/apple-touch-icon-144-precomposed.png</cms:link>">
    <link rel="apple-touch-icon-precomposed" sizes="114x114"
          href="<cms:link>../resources/apple-touch-icon-114-precomposed.png</cms:link>">
    <link rel="apple-touch-icon-precomposed" sizes="72x72"
          href="<cms:link>../resources/apple-touch-icon-72-precomposed.png</cms:link>">
    <link rel="apple-touch-icon-precomposed"
          href="<cms:link>../resources/apple-touch-icon-57-precomposed.png</cms:link>">
    <link rel="shortcut icon" href="../assets/ico/favicon.png">

</head>

<body>
<cms:include file="menu/nav_top.jsp"/>

