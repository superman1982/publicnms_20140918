<%@ page language="java" contentType="text/html;charset=gb2312"%>
<%@page import="java.util.List"%>
<%@page import="com.afunms.automation.model.CmdCfgFile"%>

<html>
<head>
<%

  String rootPath = request.getContextPath();
 String contentStr=(String)request.getAttribute("conStr");
 String cmdContent= (String)request.getAttribute("content");
 CmdCfgFile fileConfig=(CmdCfgFile)request.getAttribute("config");
 List list=(List)request.getAttribute("list");
   String ip= fileConfig.getIpaddress();
  String type= fileConfig.getBkpType();
  String command= fileConfig.getContent();
   int length=command.split("\r\n").length;
   String[] commands=new String[length];
  commands=command.split("\r\n");
  String cmd=command.replaceAll("\r\n","; "); 
 
  if(ip==null){
  	ip = "";
  }
 
%>
<link href="<%=rootPath%>/resource/<%=com.afunms.common.util.CommonAppUtil.getSkinPath() %>css/global/global.css" rel="stylesheet" type="text/css"/>

<title>Ping</title>
<!-- snow add 2010-5-28 -->
<style>
<!--
body{
background-image: url(${pageContext.request.contextPath}/resource/image/bg4.jpg);
TEXT-ALIGN: center; 
}
-->


</style>
<!-- snow add end -->
<script type="text/javascript"
			src="<%=rootPath%>/automation/js/jquery-1.4.2.min.js"></script>
<script language="javascript">

 function showContent(){
 var command=document.getElementById("command").value;
 var cmdContent=document.getElementById("cmdContent").value;

  $.ajax({
			type:"POST",
			dataType:"json",
			data:"command="+command+"&cmdContent="+cmdContent+"&f="+Math.random(),
			url:"<%=rootPath%>/netCfgFileAjaxManager.ajax?action=showContent",
			success:function(data){
			document.getElementById("content").value=data.content;
			}
		});
 }
 function showFileContent(){
  var arrayObj1= new Array(); 
   var arrayObj2 = new Array(); 
 $selectc=$("#custom  select");
　　$textc=$("#custom  input:text");
  for(var i=0;i<$selectc.length;i++){
   arrayObj1[i]=$selectc.get(i).value;
       }
   for(var i=0;i<$textc.length;i++){
   arrayObj2[i]=$textc.get(i).value;
   }
   var cmdContent=document.getElementById("cmdContent").value;
 
  $.ajax({
			type:"POST",
			dataType:"json",
			data:"contain="+arrayObj1+"&command="+arrayObj2+"&cmdContent="+cmdContent+"&f="+Math.random(),
			url:"<%=rootPath%>/netCfgFileAjaxManager.ajax?action=showFileContent",
			success:function(data){
			 alert(data.content);
			document.getElementById("content").value=data.content;
			
			}
		});
 }
 function downloadLog(){
 
   mainForm.action="<%=rootPath%>/autoControl.do?action=downloadLog";
	mainForm.submit();
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body id="body" class="body" >
<form id="mainForm" method="post" name="mainForm">
	<table id="container-main" class="container-main">
		<tr>
			<td>
				<table id="container-main-win" class="container-main-win">
					<tr>
						<td>
							<table id="win-content" class="win-content">
								<tr>
									<td>
										<table id="win-content-header" class="win-content-header">
				                			<tr>
							                	<td align="left" width="5"><img src="<%=rootPath%>/common/images/right_t_01.jpg" width="5" height="29" /></td>
							                	<td class="win-content-title"> 自动化 >> 配置文件管理 >> 定时命令信息</td>
							                    <td align="right"><img src="<%=rootPath%>/common/images/right_t_03.jpg" width="5" height="29" /></td>											   
											</tr>
									    
					       				</table>
				       				</td>
				       			</tr>
						       	<tr>
						       		<td>
						       			<table id="win-content-body" class="win-content-body">
											<tr bgcolor="#F1F1F1">
						       					<td>
													<table >
														<tr align="left" valign="middle"> 
														<td width="7%" height="29" align=right valign=middle nowrap  class="win-data-title">IP地址：</td>
														<td width="43%" height="29" align=left valign=middle nowrap ><%=ip %></td>
														<td width="7%" height="29" align=right valign=middle nowrap class="win-data-title">类  型：</td>
														<td width="43%" height="29" align=left valign=middle nowrap ><%=type %></td>
														
														</tr>  
													</table>
						       					</td>
						       				</tr>
						       				
											<tr bgcolor="#F1F1F1">
											<%
											
                  									String sysdescrforshow="";//用于显示设备信息简称
                  									if(cmd!=""&&cmd!=null){
														if(cmd.length()>50){
														sysdescrforshow=cmd.substring(0,50)+"...";
													 	} else{
														sysdescrforshow=cmd;
														}
													}
														String sysdescrforshow1="";
                  									
                  									if(contentStr.length()>30){
														sysdescrforshow1=contentStr.substring(0,30)+"...";
													 	} else{
														sysdescrforshow1=contentStr;
														}
												 %>
							                	<td  height="29">
							                	   <table>
							                	         <tr align="left" valign="middle"> 
														<td width="7%" height="29" align=right valign=middle nowrap  class="win-data-title"> 命 令 ：</td>
														<td width="43%" height="29" align=left valign=middle nowrap ><acronym title="<%=command%>"><%=sysdescrforshow %></acronym></td>
														<td width="7%" height="29" align=right valign=middle nowrap class="win-data-title">过滤条件：</td>
														<td width="43%" height="29" align=left valign=middle nowrap ><acronym title="<%=contentStr%>"><%=sysdescrforshow1 %></acronym></td>
														
														</tr>  
							                	   </table>
							                	
							                	</td>
							       			</tr>
							       			<tr bgcolor="#F1F1F1">
						       					<td align=right>
												  <a href="#" onclick="downloadLog()"><img src="<%=rootPath%>/resource/image/menu/snmp_mb.gif" /> <font color="blue" >导出LOG</font></a>&nbsp;&nbsp;&nbsp;
						       					</td>
						       				</tr>
													
							       			<tr align="left" valign="center"> 
			             						<td  align="left" border="0">
													<textarea id="content" name="content" rows="34" cols="140" readonly="readonly" ><%=cmdContent %></textarea>                    			
			             						</td>
											</tr>  
							       			<tr align="left" > 
			             						<td  align="left" >
													<textarea id="cmdContent" name="cmdContent" rows="34" cols="140" style="display:none"><%=cmdContent %></textarea>                    			
			             						</td>
											</tr>  
						       			</table>
						       		</td>
						       	</tr>
						                
              					</table>
              				</td>
              			</tr>
      				</table>
					</td>
				</tr>
       			</table>
			
            		<div align=center>
            			<input type=button value="关闭窗口" onclick="window.close()">
            		</div>  
					<br>
					</form>
</body>         		 
</html>