<%@page language="java" contentType="text/html;charset=GB2312"%>
<%@page import="com.afunms.automation.model.CmdCfgFile"%>
<%@ include file="/automation/common/globe.inc"%>
<%@page import="java.util.List"%>


<%
	String rootPath = request.getContextPath();
	List list = (List) request.getAttribute("list");
	List ipList = (List) request.getAttribute("ipList");
	String ip = (String) request.getAttribute("ip");
%>


<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<link href="<%=rootPath%>/resource/<%=com.afunms.common.util.CommonAppUtil.getSkinPath() %>css/global/global.css"
			rel="stylesheet" type="text/css" />
		<script  type="text/javascript" src="<%=rootPath%>/automation/js/navbar.js"></script>
		<LINK href="<%=rootPath%>/automation/css/style.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="<%=rootPath%>/resource/js/jquery-1.8.2.min.js"></script>
		<script type="text/javascript" src="<%=rootPath%>/automation/js/page.js"></script>
		<script language="JavaScript" type="text/JavaScript">
			
	  		function toDelete(){  
     				mainForm.action = "<%=rootPath%>/autoControl.do?action=deleteLogFile";
     				mainForm.submit();
	  		}
	  		
	  		function showFileContent(id)
			{
			    window.open("<%=rootPath%>/autoControl.do?action=showFileContent&id="+id,"onetelnet", "height=650, width=900, top=20, left=120");
			}
	  		
	  		
		</script>
	</head>
	<body id="body" class="body" >
		
		<form id="mainForm" method="post" name="mainForm">
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
											                	<td class="add-content-title">&nbsp;自动化 >> 配置文件管理 >> 定时命令列表</td>
											                    <td align="right"><img src="<%=rootPath%>/common/images/right_t_03.jpg" width="5" height="29" /></td>
											       			</tr>
											        	</table>
				        							</td>
				        						</tr>
				        						<tr>
														<td>
															<table width="100%" cellpadding="0" cellspacing="1">
																<tr>
																	<td bgcolor="#ECECEC" width="60%">
																	&nbsp;根据IP地址选择：<select id="netip" name="netip" onchange="showIpList()">
																	       <% if(ipList!=null&&ipList.size()>0){ 
																	       String selected="";
																	       for(int i=0;i<ipList.size();i++){
																	       String tempip=(String)ipList.get(i);
																	       if(tempip.equals(ip)){
																	       selected="selected";
																	       }else{
																	       selected="";
																	       }
																	       %>
																	       <option  value="<%=ipList.get(i) %>" <%=selected %>><%=ipList.get(i) %></option>
																	       
																	       <%
																	       }
																	       } %>
																	</select>
																		<input type="hidden" id="ip" name="ip"value="<%=ip%>">
																	</td>

																		<td bgcolor="#ECECEC" width="40%" align='right'>
																					<a href="#" onclick="toDelete()">删除</a>&nbsp;&nbsp;

																		</td>
																</tr>
															</table>
														</td>
													</tr>
				        						<tr>
				        							<td>
				        								<table id="detail-content-body" class="detail-content-body">
				        									<tr>
				        										<td>
				        												<table border="0" id="table1" cellpadding="0" cellspacing="1" width="100%">
				        													<tr>
				        														<td colspan="2">
						        													<table cellspacing="0" border="1" bordercolor="#ababab">
								        												<tr height=28 style="background: #ECECEC"
																				align="center" class="content-title">
																				<td align="center">
																					<INPUT type="checkbox" id="checkall"
																						name="checkall" onclick="javascript:chkall()"
																						class=noborder>
																				</td>
																				<td align="center">
																					序号
																				</td>
																				<td align="center" width="20%">
																					IP地址
																				</td>
																				<td align="center">
																					文件名
																				</td>
																				<td align="center">
																					扫描时间
																				</td>

																				<td align="center" width="25%">
																					命令
																				</td>


																			</tr>
								        									<%
																				CmdCfgFile vo = null;
																				//int startRow = jp.getStartRow();
																				if (list != null) {
																					String checked = "";
																					for (int i = 0; i < list.size(); i++) {
																						if (i == 0) {
																							checked = "checked";
																						} else {
																							checked = "";
																						}
																						vo = (CmdCfgFile) list.get(i);
																						String time="";
																		               if(vo.getBackupTime()!=null){
																		               time=vo.getBackupTime().toString().substring(0,vo.getBackupTime().toString().length()-5);
																		                }
																			%>
																			<tr <%=onmouseoverstyle%>>
																				<td align='center'>
																					<INPUT type="checkbox" class=noborder
																						name="checkbox" value="<%=vo.getId()%>">
																				</td>
																				<td align='center'>
																					<font color='blue'><%=i + 1%></font>
																				</td>
																				<td align='center'>
																					<a href='#'
																						onclick="showFileContent('<%=vo.getId()%>')"><font
																						color='blue'><%=vo.getIpaddress()%></font> </a>
																				</td>
																				<td align='center'><%=vo.getFileName()%></td>
																				<td align='center'><%=time%></td>
																				<%
																					String content = vo.getContent();
																							String commands = content.replaceAll("\r\n", ";");

																							String sysdescrforshow = "";//用于显示设备信息简称
																							if (commands != "" && commands != null) {
																								if (commands.length() > 40) {
																									sysdescrforshow = commands.substring(0, 40) + "...";
																								} else {
																									sysdescrforshow = commands;
																								}
																							}
																				%>

																				<td align='center'>
																					<acronym title="<%=commands%>"><%=sysdescrforshow%></acronym>
																				</td>

																			</tr>
																			<%
																				}
																				}
																			%>
								        											</table>
							        											</td>
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
								</table>
							</td>
						</tr>
					</table>
				</td>
		         </tr>
		         </table>
					</form>
	</body>
</html>
