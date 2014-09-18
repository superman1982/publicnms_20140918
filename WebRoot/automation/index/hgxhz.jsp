<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.afunms.automation.model.CheckResult"%>
<%@page import="com.afunms.automation.dao.CheckResultDao"%>
<%@page import="com.afunms.automation.model.CompCheckResultModel"%>
<%@page import="com.afunms.automation.model.StrategyIp"%>
<%@ include file="/automation/common/globe.inc"%>
<%@ include file="/automation/common/globeChinese.inc"%>
<%@page import="java.util.*"%>

<%

	String rootPath = request.getContextPath();
		List<CheckResult> checkList = (List<CheckResult>) request.getAttribute("list");
	List deviceList = (List) request.getAttribute("deviceList");
	String data = "";
	int wrongCount = 0;
	int exactCount = 0;
	int disabledCount = 0;
	if (deviceList != null && deviceList.size() > 0)
		disabledCount = deviceList.size();
	CheckResultDao resultDao = new CheckResultDao();
	List resultList = resultDao.getExtraCountList();
	if (resultList != null)
		exactCount = resultList.size();
	if (checkList != null && checkList.size() > 0) {

		for (int i = 0; i < checkList.size(); i++) {
			CheckResult result = checkList.get(i);
			if (result.getCount0() > 0 || result.getCount1() > 0
					|| result.getCount2() > 0) {
				wrongCount++;
			} else {
				exactCount++;
			}
		}
		
	}
	data = "<pie><slice title='违反'>" + wrongCount
				+ "</slice><slice title='顺从'>" + exactCount
				+ "</slice><slice title='不可用'>" + disabledCount
				+ "</slice></pie>";
	
String common="<img src='"+rootPath+"/automation/images/common.gif'>";				
String correct="<img src='"+rootPath+"/automation/images/correct.gif'>";				
String serious="<img src='"+rootPath+"/automation/images/serious.gif'>";	
String urgency="<img src='"+rootPath+"/automation/images/urgency.gif'>";	
String statusImg="<img src='"+rootPath+"/automation/images/correct.gif'>";
String disable="<img src='"+rootPath+"/automation/images/blue.gif'>";
String error="<img src='"+rootPath+"/automation/images/error.gif'>";			
%>

<!-- 功能：首页合规性检测汇总展示页面 -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>合规性检测汇总</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link
	href="<%=rootPath%>/resource/<%=com.afunms.common.util.CommonAppUtil.getSkinPath()%>css/global/global.css"
	rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css"
	href="<%=rootPath%>/automation/css/ext/ext-all.css" charset="gb2312" />
<script type="text/javascript"
	src="<%=rootPath%>/automation/js/ext/ext-base.js" charset="gb2312"></script>
<script type="text/javascript"
	src="<%=rootPath%>/automation/js/ext/ext-all.js" charset="gb2312"></script>

<script type="text/javascript"
	src="<%=rootPath%>/automation/js/ext/ext-lang-zh_CN.js" charset="utf-8"></script>

<script type="text/javascript"
	src="<%=rootPath%>/automation/js/jquery-1.8.2.min.js"></script>
</head>
  
  <body>
    	<table align=center  width="100%">
		<tr>
			<td width="40%" align=center>
				<table>
					<tr>
						<td height="36" align=center>
							所有策略的设备：&nbsp;&nbsp;<%=exactCount + wrongCount + disabledCount%></td>
					</tr>
					<tr>
					    <td height="36" align=center>
					                  合规策略的设备：&nbsp;&nbsp;<%=exactCount%></td>
				    </tr>
					<tr>
						<td height="36" align=center>
						        违反策略的设备：&nbsp;&nbsp;<%=wrongCount%></td>
					</tr>
					<tr>
						<td height="36" align=center>
							数据不可用设备：&nbsp;&nbsp;<%=disabledCount%></td>
					</tr>
		        </table>
	        </td>

			<td width="60%" align=center>
				<div id="strategyPie" align=center>
				</div>
				<script type="text/javascript"
					src="<%=rootPath%>/automation/js/swfobject.js"></script> 
				<script type="text/javascript">
						<%if(wrongCount==0&&exactCount==0&&disabledCount==0){%>
						var _div=document.getElementById("strategyPie");
						var img=document.createElement("img");
						img.setAttribute("src","<%=rootPath%>/resource/image/nodata.gif");
						_div.appendChild(img);
						        <%}else{%>
						 var so = new SWFObject("<%=rootPath%>/automation/amchart/ampie.swf",  "ampie", "320", "250", "8", "#FFFFFF");
						 so.addVariable("path", "<%=rootPath%>/automation/amchart/");
						 so.addVariable("settings_file", escape("<%=rootPath%>/automation/amcharts_settings/strategyPie.xml"));
						 so.addVariable("chart_data","<%=data%>
						");
						so.write("strategyPie");
					<%}%>
						
					</script>
			</td>
		</tr>
      </table>
  </body>
</html>
