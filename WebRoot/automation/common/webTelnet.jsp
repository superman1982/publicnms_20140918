<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String ipaddress=request.getParameter("ipaddress");
	String rootPath = request.getContextPath();
 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>Web Telnet</title>
		<link href="<%=rootPath%>/resource/<%=com.afunms.common.util.CommonAppUtil.getSkinPath()%>css/global/global.css" rel="stylesheet" type="text/css" />
		
		<link href="<%=rootPath%>/automation/css/telnetStyle.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="<%=rootPath%>/automation/js/jquery-1.8.2.min.js"></script>
		<script type="text/javascript">
  $(document).ready(function(){
  	var tcHashCode=$("#tcHashCode");
  	
  	var connectInfo=$("#connectInfo");
  	var displayPanel=$("#printArea");
  	var commandText=$("#commandText");
	var server = $("#ipaddress"); 
	var port = $("#port");
	var terminalType=$("#terminalType");
	
	commandText.attr("disabled", "disabled");  
	
	$("#login").click(function (){
		connectInfo.text("Connected to "+server.val()+":"+port.val());
		displayPanel.empty();
			$.ajax({ 
					type:"post",  
					url:"<%=rootPath%>/telnetLogin",
					data:"server="+server.val()+"&port="+port.val()+"&terminalType="+terminalType.val()+"&tcHashCode="+tcHashCode.val(),
					dataType:'json', 
					success:function(data){
						tcHashCode.val(data.tcHashCode);
						displayPanel.append(data.serverOutputInfo);
						commandText.removeAttr("disabled");
						commandText.focus();
					}, 
					error:function(data) {
						alert("登录失败");
					} 
				});
	});

  	$("html").die().live("keydown",function(event){
		if(event.keyCode==13){
			$.ajax({ 
					type:"post", 
					url:"<%=rootPath%>/telnetSendCommand", 
					data:"commandText="+commandText.val()+"&tcHashCode="+tcHashCode.val(),
					success:function(info){
						commandText.val("");
						displayPanel.empty();
						displayPanel.text(info);
						var scrollTop = $("#printArea")[0].scrollHeight;  
                        $("#printArea").scrollTop(scrollTop);  
						commandText.focus();
					}, 
					error:function(info) {
						alert("error");
					} 
				});  
		}
	});
	$(window).unload(function () { 
			$.ajax({ 
					type:"post", 
					url:"<%=rootPath%>/telnetAjaxManager.ajax?action=endSession", 
					data:"tcHashCode="+tcHashCode.val(), 
					success:function(info){
						alert(info);
					}, 
					error:function(info) {
						alert("error");
					} 
				}); 
	});

	});		
</script>
	</head>

	<body id="body" class="body">
		<form id="form" name="form" method="post" action="">
			<div class="mainContainner">
				<div class="title">
					Web Telnet Tool
				</div>
				<div class="loginContainner">
					<div class="server">
						Server:
						<input name="ipaddress" id="ipaddress" type="text" value="<%=ipaddress %>"/>
						<input name="tcHashCode" type="hidden" id="tcHashCode" value="001">
					</div>
					<div class="port">
						Port:
						<input name="port" id="port" type="text" value="23" />
					</div>
					<div class="terminalType">
						终端模式:
						<select name="terminalType" size="1" id="terminalType">
							<option value="windows" selected="selected">
								Windows
							</option>
							<option value="linux">
								Linux
							</option>
							<option value="unix">
								Unix
							</option>
						</select>
					</div>
					<div class="login">
						<input name="login" id="login" type="button" value="Login" />
					</div>
				</div>
				<div class="connectInfo" id="connectInfo">
					Connected to ...
				</div>
				<div class="printArea">
					<textarea name="printArea" id="printArea" ></textarea>
				</div>
				<div class="commandContanner">
					<div class="command">
						Command:
						<input type="text" name="commandText" id="commandText" />
					</div>
				</div>
			</div>
		</form>
	</body>
</html>

