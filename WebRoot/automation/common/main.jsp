<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!-- 功能：首页主体，展示内容有密码到期提醒列表、告警列表、合规则性检测汇总、定时巡检列表 -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>首页-main</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="密码到期提醒列表,告警,合规则性">
<meta http-equiv="description" content="首页">

<link rel="stylesheet" type="text/css" href="<%= path %>/automation/css/main.css">

</head>

<body>
<div class="part01">

		<div class="part01_title">
			<div class="part01_title_name">密码到期提醒</div>
			<div class="part01_title_img">
				<img src="<%= path %>/automation/images/sqlt_41.png">
			</div>
		</div>
		<div class="part01_content">
		<iframe frameborder="0" scrolling="no" src="indexService.do?action=pwdAlertList"></iframe>
		</div>
</div>

<div class="part02">

		<div class="part02_title">
			<div class="part02_title_name">告警列表</div>
			<div class="part02_title_img">
				<img src="<%= path %>/automation/images/sqlt_41.png">
			</div>
		</div>
		<div class="part02_content">
			<iframe frameborder="0" scrolling="no" src="indexService.do?action=alertList"></iframe>
		</div>
</div>

<div class="part03">

		<div class="part03_title">
			<div class="part03_title_name">合规性检测汇总</div>
			<div class="part03_title_img">
				<img src="<%= path %>/automation/images/sqlt_41.png">
			</div>
		</div>
		<div class="part03_content">
			<iframe frameborder="0" scrolling="no" src="indexService.do?action=hgxjchzList"></iframe>
		</div>
</div>

<div class="part04">

		<div class="part04_title">
			<div class="part04_title_name">定时巡检列表</div>
			<div class="part04_title_img">
				<img src="<%= path %>/automation/images/sqlt_41.png">
			</div>
		</div>
		<div class="part04_content">
			<iframe frameborder="0" scrolling="no" src="indexService.do?action=dsxjList"></iframe>
		</div>
</div>
</body>
</html>
