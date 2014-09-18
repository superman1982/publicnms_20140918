<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.afunms.topology.model.HostNode"%>
<%@page import="com.afunms.common.base.JspPage"%>
<%@page import="java.util.List"%>
<%@page import="com.afunms.common.util.SysUtil"%>
<%@page import="com.afunms.common.util.SessionConstant"%>
<%@page import="com.afunms.system.model.User"%>
<%@page import="com.afunms.event.model.EventReport"%>
<%@include file="/include/globe.inc"%>
<%@page import="java.util.List"%>
<%@page import="com.afunms.config.model.*"%>
<%@page import="com.afunms.event.model.EventList"%>
<%@page import="com.afunms.topology.dao.*"%>
<%@page import="com.afunms.topology.model.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import="java.lang.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String rootPath = request.getContextPath();
	User vo = (User) session.getAttribute(SessionConstant.CURRENT_USER);
	String username = vo.getName();
	List<EventList> eventlist = (List<EventList>) session.getAttribute("eventlist");
%>
<!-- 功能：首页告警列表展示页面 -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>告警列表</title>
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
			<th>等级</th>
			<th>告警来源</th>
			<th>告警描述</th>
			<th>处理状态</th>
		</tr>
		<c:set var="elist" value="<%=eventlist %>"></c:set>
		<c:forEach var="l" items="${elist }" varStatus="ind" >
		<tr>
			<td>${ind.count }</td>
			<c:choose>
				<c:when test="${l.level1==1 }"><td>普通事件</td></c:when>
				<c:when test="${l.level1==2 }"><td>严重事件</td></c:when>
				<c:when test="${l.level1==3 }"><td>紧急事件</td></c:when>
			</c:choose>
			<td>${l.eventlocation }</td>
			<td>${l.content }</td>
			<c:choose>
				<c:when test="${l.managesign==0 }"><td>未处理</td></c:when>
				<c:when test="${l.managesign==1 }"><td>处理中</td></c:when>
				<c:when test="${l.managesign==2 }"><td>已完成</td></c:when>
			</c:choose>
		</tr>
		</c:forEach>
	</table>
</body>
</html>
