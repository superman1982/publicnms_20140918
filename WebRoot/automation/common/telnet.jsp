 <%@ page language="java" contentType="text/html; charset=GBK" %>
<%
	String getIp=(String)request.getParameter("ipaddress") ;
if(getIp==null) getIp="";
String rootPath = request.getContextPath();
%>
<html>
  <head>

<script type="text/javascript" src="<%=rootPath%>/resource/js/page.js"></script>
<link href="<%=rootPath%>/resource/<%=com.afunms.common.util.CommonAppUtil.getSkinPath()%>css/global/global.css" rel="stylesheet" type="text/css" />

<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="javascript">
  function startTelnet() {
  try {

        var ws = new ActiveXObject("Wscript.Shell");
        ws.Run("cmd.exe /c start telnet " + "<%=getIp%>");
	   window.close(); 
  } catch(e) {
  	e.printStackTrace();
  }
  }
  function closeOldWin() {
  	try {
  		//window.close();
  	} catch (e) {
  	}
  }
  function closeTelnet() {
  	try {
  		newWin.close();
  		parent.close();
  	} catch (e) {
  	}
  }
  

  
</script>
</head>
<body onload="startTelnet();" onunload="closeTelnet();">
</body>
</html>

