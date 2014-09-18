<%@page language="java" contentType="text/html;charset=gb2312" %>
<%@page import="com.afunms.automation.model.NetCfgFileNode"%>

<%
  String rootPath = request.getContextPath();
  NetCfgFileNode vo=(NetCfgFileNode)request.getAttribute("vpntelnetconf");
  String deviceType = (String)request.getAttribute("deviceType");
  int connecttype = 0;
	String sshSelected = "";
	String telnetSelected = "";
	String ipaddress = "";
	String userName = "";
	String pwd = "";
	String suName = "";
	String suPwd = "";
	String alias = "";
	String deviceVender = "";
	String osType="";
	int id = 0;
	int port = 0;
	
	if (vo != null) {
		id = vo.getId();
		connecttype = vo.getConnecttype();
		ipaddress = vo.getIpaddress();
		userName = vo.getUser();
		pwd = vo.getPassword();
		suName = vo.getSuuser();
		suPwd = vo.getSupassword();
		port = vo.getPort();
		alias = vo.getAlias();
		suName = vo.getSuuser();
		deviceVender = vo.getDeviceRender();
		osType=vo.getOstype();
	}
	if (connecttype == 1) {
		sshSelected = "selected";
	} else if (connecttype == 0) {
		telnetSelected = "selected";
	}
	String checked = "";
	if (suName != null && !suName.equals("0")) {
		checked = "checked";
	}
	if(suPwd==null)suPwd="";
  %>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="<%=rootPath%>/resource/<%=com.afunms.common.util.CommonAppUtil.getSkinPath() %>css/global/global.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" type="text/css" 	href="<%=rootPath%>/automation/css/ext/ext-all.css" charset="gb2312" />
<script type="text/javascript" 	src="<%=rootPath%>/automation/js/ext/ext-base.js" charset="gb2312"></script>
<script type="text/javascript" src="<%=rootPath%>/automation/js/ext/ext-all.js" charset="gb2312"></script>
<script type="text/javascript" src="<%=rootPath%>/automation/js/ext/ext-lang-zh_CN.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=rootPath%>/automation/js/jquery-1.4.2.min.js"></script>
<script>

Ext.onReady(function(){
 Ext.get("vpn").on("click",function(){
 
     //var chk1 = checkinput("user","string","用户",50,false);
     //var chk2 = checkinput("password","string","密码",50,false);
     //var chk3 = checkinput("suuser","string","su用户",50,false);
     //var chk4 = checkinput("supassowrd","string","su密码",50,false);
     // var chk5 = checkinput("port","String","端口",50,false);
     //var chk6 = checkinput("ipaddress","String","su密码",50,false);  //&&chk2&&chk3&&chk4&&chk5&&chk6
     
     // if(chk1&&chk2&&chk3&&chk4&&chk5&&chk6)
     //{      
          	Ext.MessageBox.wait('数据加载中，请稍后.. ');
        	mainForm.action = "<%=rootPath%>/remoteDevice.do?action=updatepassword";
			mainForm.submit();
			//window.close();
     //}
       // mainForm.submit();
 });	
	
});



//-- nielin modify at 2010-01-04 start ----------------
function CreateWindow(url)
{
	
msgWindow=window.open(url,"protypeWindow","toolbar=no,width=600,height=400,directories=no,status=no,scrollbars=yes,menubar=no")
}    

function setReceiver(eventId){
	var event = document.getElementById(eventId);
	return CreateWindow('<%=rootPath%>/user.do?action=setReceiver&event='+event.id+'&value='+event.value);
}

function checksuUserName(){
if($("#isSuper1").attr('checked')==false){
 $("#supwd_tr1").hide();
 }else{
 $("#supwd_tr1").show();
 }
}

</script>



</head>
<body id="body" class="body" onload="checksuUserName()">



	<form id="mainForm" method="post" name="mainForm" action="<%=rootPath%>/remoteDevice.do?action=updatepassword">
	    <input type=hidden name="id" value="<%=vo.getId()%>">
		<input type=hidden name="deviceType" value="<%=deviceType %>">
		<table id="body-container" class="body-container">
			<tr>
			
				<td class="td-container-main">
					<table id="container-main" class="container-main">
						<tr>
							<td class="td-container-main-add">
								<table id="container-main-add" class="container-main-add">
									<tr>
										<td>
											<table id="add-content" class="add-content">
												<tr>
													<td>
														<table id="add-content-header" class="add-content-header">
										                	<tr>
											                	<td align="left" width="5"><img src="<%=rootPath%>/common/images/right_t_01.jpg" width="5" height="29" /></td>
											                	<td class="add-content-title">修改密码</td>
											                    <td align="right"><img src="<%=rootPath%>/common/images/right_t_03.jpg" width="5" height="29" /></td>
											       			</tr>
											        	</table>
				        							</td>
				        						</tr>
				        						<tr>
				        							<td>
				        								<table id="detail-content-body" class="detail-content-body">
				        									<tr>
				        										<td>
				        										
				        												<table border="0" id="table1" cellpadding="0" cellspacing="1"
																	width="100%">
																
																	        <tr>
																			    <TD nowrap align="right" height="24" width="10%">用户&nbsp;</TD>				
																				<TD nowrap width="40%">&nbsp;<input type="text" name="user" size="40"  class="formStyle" value="<%=vo.getUser() %>" readonly="readonly"><font color="red">&nbsp;*</font></TD>
																				<TD nowrap align="right" height="24">密码&nbsp;</TD>				
																				<TD nowrap>&nbsp;<input type="password" name="password" size="40" class="formStyle" value="<%=vo.getPassword() %>" readonly="readonly"><font color="red">&nbsp;*</TD>	
																			</tr>
																			<!--  
																			<tr style="background-color: #ECECEC;">
																				<TD nowrap align="right" height="24">
																					超级用户&nbsp;
																				</TD>
																				<TD nowrap>
																					&nbsp;
																					<input type=checkbox name="isSuper" id="isSuper"  <%=checked%> onclick="checksuUserName()">
																					<input name="suuser" type="hidden" size="22" id="suuser" class="formStyle" value="enable">
																				</TD>
																				<TD nowrap align="right" height="24">
																					&nbsp;
																				</TD>
																				<TD nowrap>
																					&nbsp;
																				</TD>
																			</tr>
																			-->
						                                                    <tr id="supwd_tr1" 
																				style="background-color: #ECECEC;">
																				<TD nowrap align="right" height="24">
																					超级用户密码&nbsp;
																				</TD>
																				<TD nowrap>
																					&nbsp;
																					<input type="password" name="supassword"
																						id="supassword" size="24" class="formStyle"
																						value="<%=suPwd%>">
																				</TD>
																				<TD nowrap align="right" height="24">
																					&nbsp;
																				</TD>
																				<TD nowrap>
																					&nbsp;

																				</TD>
																			</tr>
																			<tr>
																				<TD nowrap align="right" height="24">ip&nbsp;</TD>				
																				<TD nowrap>&nbsp;<input name="ipaddress" type="text" size="40" class="formStyle" value="<%=vo.getIpaddress() %>" readonly="readonly"><font color="red" readonly="readonly">&nbsp;* </font></TD>								
																				<td align="right" height="20">端口&nbsp;</td>
																				<td colspan="3" align="left">&nbsp;<input name="port" type="text" size="16" class="formStyle" value="<%=vo.getPort() %>" readonly="readonly"><font color="red">&nbsp;* </font></td>
																			</tr>
																			<tr>
																			<td align="right" height="20">&nbsp;采集方式</td>
																				<td colspan="3" align="left">
																					&nbsp;<select name="connecttype">
													                                   <option value="telnet" <%=telnetSelected %>>telnet</option>
													                                   <option value="ssh"  <%=sshSelected %>>ssh</option>
													                                   </select>
																				</td>
																				<TD nowrap align="right" height="24">&nbsp;</TD>				
																				<TD nowrap>&nbsp;</TD>								
																				
																			</tr>
																				<tr>
																				<TD nowrap align="right" height="24">新用户&nbsp;</TD>				
																				<TD nowrap>&nbsp;<input name="modifyuser" type="text" size="40" class="formStyle" value=""><font color="red">&nbsp;* </font></TD>								
																				<td align="right" height="20">&nbsp;新密码</td>
																				<td colspan="3" align="left">&nbsp;<input name="newpassword" type="password" size="40" class="formStyle" ></td>
																			</tr>
																			
																		     <tr>
																				<TD nowrap align="right" height="24">认证(3a)&nbsp;</TD>				
																				<TD nowrap>&nbsp;<select name="threeA">
													                                   <option value="" ></option>
													                                   <option value="aaa" >aaa</option>
													                                   </select></TD>								
																				<td align="right" height="20">&nbsp;密码模式</td>
																				<td colspan="3" align="left">&nbsp;
																				<select name="encrypt">
													                                   <option value="1" >明文</option>
													                                   <option value="0" >加密</option>
													                                   </select>
																				</td>
																			</tr>
															                 										                      								

									            							
															<tr>
																<TD nowrap colspan="4" align=center>
																<br><input type="button" value="修 改" style="width:50" id="vpn" onclick="#" >&nbsp;&nbsp;
																<input type="button" value="关 闭" style="width:50" id="vpn" onclick="window.close()" >
																	
																</TD>	
															</tr>	
							
						                        </TABLE>						
				        										</td>
				        									</tr>
				        								</table>
				        							</td>
				        						</tr>
				        						<tr>
				        							<td>
				        								<table id="detail-content-footer" class="detail-content-footer">
				        									<tr>
				        										<td>
				        											<table width="100%" border="0" cellspacing="0" cellpadding="0">
											                  			<tr>
											                    			<td align="left" valign="bottom"><img src="<%=rootPath%>/common/images/right_b_01.jpg" width="5" height="12" /></td>
											                    			<td></td>
											                    			<td align="right" valign="bottom"><img src="<%=rootPath%>/common/images/right_b_03.jpg" width="5" height="12" /></td>
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
									<tr>
										<td align="right">
											
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>	
				</td>
			</tr>
		</table>
	</form>
</body>
</HTML>