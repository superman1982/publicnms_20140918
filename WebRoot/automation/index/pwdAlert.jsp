<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="java.util.Hashtable"%>
<%@page import="com.afunms.topology.model.ConnectTypeConfig"%>
<%@page import="java.util.*" %>
<%@page import="com.afunms.automation.model.PasswdTimingConfig"%>
<%@page import="com.afunms.automation.util.AutomationUtil"%>
<%@ include file="/automation/common/globe.inc"%>
<%@page import="java.util.List"%>
<%@page import="com.afunms.common.base.JspPage"%>
<%@page import="com.afunms.system.util.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	String rootPath = request.getContextPath();
	String menuTable = (String) request.getAttribute("menuTable");
	//密码到时提醒的远程设备集合 
	List<PasswdTimingConfig> pwdAlertList = (ArrayList<PasswdTimingConfig>) session
			.getAttribute("pwdAlertList");
	//到时提醒方式
	Hashtable<String, String> alarmWayHashtable = (Hashtable<String, String>) session
			.getAttribute("alarmWayHashtable");
%>
<!-- 功能：首页密码到期提醒列表加载面 -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>密码到期提醒列表</title>

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
th,td{
text-align: center;
align:center;
}
#customers {
	font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
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
	background: #dcddc0 url('<%=rootPath%>/automation/images/cell-grey.jpg');
}

#customers th{
	font-size : 12px ;
	text-align :left ;
	padding-top : 5px ;
	padding-bottom: 4px;
	background-color:#CAE8EA ;
	background : #dcddc0 url('<%=rootPath%>/automation/images/cell-blue.jpg') ;
	color: #ffffff ;
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
			<th align="center">序号</th>
			<th align="center">IP地址</th>
			<th align="center">任务创建时间</th>
			<th align="center">定时提醒时间</th>
			<th align="center">提醒方式</th>
			<th align="center">是否定时</th>
		</tr>
		<c:set var="pwsAlertList" value="<%=pwdAlertList %>"></c:set>
		<c:forEach var="l" items="${pwsAlertList }" varStatus="ind">
		<tr>
			<td align='center'>${ind.count }</td>
			<td align='center'>${l.telnetconfigips }</td>
			<td align='center'>${l.backup_date }</td>
			<td align='center'>${l.backup_sendfrequency } 时间：(<c:out value="${l.backup_time_hou }"></c:out>
			   <c:forEach var="tlist" items="${fn:split(l.backup_time_hou,'/') }">
			      <c:out value="${tlist时  }"></c:out>
			   </c:forEach>)
			</td>
			<td align='center'><c:out value="${((l.warntype==null)||(l.warntype==''))? '未设置':l.warntype }"></c:out> </td>
			<td align='center'>${l.status }</td>
		</tr>
		</c:forEach>
	</table>
</body>
</html>
