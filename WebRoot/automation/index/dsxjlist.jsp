<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.util.Map"%>
<%@page import="com.afunms.automation.model.NetCfgFileNode"%>
<%@ include file="/automation/common/globe.inc"%>
<%@page import="java.util.List"%>
<%@page import="com.afunms.automation.model.CmdCfgFile"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	String rootPath = request.getContextPath();
	List<CmdCfgFile> ccfList = (List<CmdCfgFile>) session.getAttribute("ccfList");
	List<String> aliasList = (List<String>) session.getAttribute("aliasList");
%>
<!-- 功能：首页定时巡检列表展示页面 -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>定时巡检列表</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<style type="text/css">
html,body{
	margin: 0px;
	padding: 0px;
}

#customers {
	font-family: "Trebuchet MS", Arial, Helvetica, sans-serif ;
	width: 100%;
	margin-top:0px;
	margin:0px;
	padding:0px;
	border-collapse: collapse;
}

#customers td,#customers th {
	font-size: 11px;
	border: 1px solid #9aafe5;
	padding: 3px 7px 2px 7px;
}

#customers td {
	background:#dcddc0 url('<%=rootPath%>/automation/images/cell-grey.jpg');
}

#customers th {
	font-size:12px ;
	text-align:left;
	padding-top: 5px;
	padding-bottom: 4px;
	background : #dcddc0 url('<%=rootPath%>/automation/images/cell-blue.jpg') ;
	background-color:#CAE8EA;
	color: #ffffff;
}

#customers tr.alt td {
	color:#000000;
	background-color: #EAF2D3;
}
</style>
</head>
<body>
	<table id="customers">
		<tr>
			<th>序号</th>
			<th>设备名称</th>
			<th>IP地址</th>
			<th>设备类型</th>
			<th>扫描时间</th>
		</tr>
		<c:set var="ccfList" value="<%=ccfList %>"></c:set>
		<c:set var="aliasList" value="<%=aliasList %>"></c:set>
		<c:forEach var="l" items="${ccfList }" varStatus="ind">
			<c:forEach var="l1" items="${aliasList }">
		<tr>
			<td><c:out value="${ind.count }"></c:out></td>
			<td><c:out value="${l1 }"></c:out></td>
			<td>${l.ipaddress }</td>
			<td>${l.bkpType }</td>
			<td>${l.backupTime }</td>
		</tr>
			</c:forEach>
		</c:forEach>
	</table>
</body>
</html>
