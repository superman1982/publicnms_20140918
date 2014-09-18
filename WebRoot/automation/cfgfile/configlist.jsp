<%@page language="java" contentType="text/html;charset=GB2312"%>
<%@page import="java.util.List"%>
<%@page import="com.afunms.common.base.JspPage"%>
<%@page import="com.afunms.automation.model.ConfiguringDevice"%>


<%
  String rootPath = request.getContextPath();
  List list = (List)request.getAttribute("list");
  JspPage jp = (JspPage) request.getAttribute("page");
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<link href="<%=rootPath%>/automation/css/contextmenu.css" rel="stylesheet">
		<script src="<%=rootPath%>/automation/js/jquery-1.8.2.min.js" type="text/javascript"></script>
		<script src="<%=rootPath%>/automation/js/contextmenu.js" type="text/javascript"></script>
		<link href="<%=rootPath%>/resource/<%=com.afunms.common.util.CommonAppUtil.getSkinPath() %>css/global/global.css" rel="stylesheet"
			type="text/css" />
		<script type="text/javascript" src="<%=rootPath%>/automation/js/page.js"></script>
		<link rel="stylesheet" href="<%=rootPath%>/automation/css/style.css" type="text/css">
		<script type="text/javascript">
			var listAction = "<%=rootPath%>/netCfgFile.do?action=configlist";
	  		var delAction = "<%=rootPath%>/netCfgFile.do?action=delete";
			var curpage= <%=jp.getCurrentPage()%>;
  			var totalpages = <%=jp.getPageTotal()%>;
		</script>
		<script language="JavaScript" type="text/JavaScript">
		//备份
			
			
			//网络设备详细配置文件
			function showAllFile(ip,type)
			{
				location.href="<%=rootPath%>/netCfgFile.do?action=showAllFile&ip="+ip+"&type="+type;
				
			}
			//批量配置
			function deployCfgForBatch()
			{
				mainForm.action = "<%=rootPath%>/netCfgFile.do?action=ready_deployCfgForBatch";
				mainForm.submit();
			}
  			
  			function CreateWindow(url){
				msgWindow=window.open(url,"protypeWindow","toolbar=no,width=850,height=400,directories=no,status=no,scrollbars=yes,menubar=no")
			}
			//批量备份
			function backupForBatch()
			{
				mainForm.action = "<%=rootPath%>/netCfgFile.do?action=ready_backupForBatch";
				mainForm.submit();
			}
			function uploadCfgFile()
			{
				window.open("<%=rootPath%>/netCfgFile.do?action=readyuploadCfgFile&&id="+node+"&ipaddress="+ipaddress,"oneping", "height=400, width= 800, top=300, left=100,scrollbars=yes");
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
								<td class="td-container-main-content">
									<table id="container-main-content" class="container-main-content">
										<tr>
											<td>
												<table id="content-header" class="content-header">
								                	<tr>
									                	<td align="left" width="5"><img src="<%=rootPath%>/common/images/right_t_01.jpg" width="5" height="29" /></td>
									                	<td class="content-title"> 自动化 >> 配置文件管理 >> 配置文件列表</td>
									                    <td align="right"><img src="<%=rootPath%>/common/images/right_t_03.jpg" width="5" height="29" /></td>
									       			</tr>
									        	</table>
		        							</td>
		        						</tr>
		        						<tr>
		        							<td>
		        								<table id="content-body" class="content-body">
		        									<tr>
														<td>
															<table width="100%" cellpadding="0" cellspacing="1">
																<tr>
																	<td bgcolor="#ECECEC" width="60%">
																	&nbsp;&nbsp;&nbsp;
																		<!-- ip地址：<input type="text" size="30" name="ipfindaddress">
																		<input type="button" value="查询" onclick="toFindIp()">-->
																	</td>
																	<td bgcolor="#ECECEC" width="40%" align='right'>
																		
																		<a href="#" onclick="backupForBatch()">批量备份</a>&nbsp;
																		<a href="#" onclick="deployCfgForBatch()">批量配置</a>&nbsp;
																		
																	</td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<td>
															<table width="100%" cellpadding="0" cellspacing="1">
																<tr>
																	<td bgcolor="#ECECEC" width="80%" align="center">
																		<jsp:include page="../../common/page.jsp">
																			<jsp:param name="curpage" value="<%=jp.getCurrentPage()%>" />
																			<jsp:param name="pagetotal" value="<%=jp.getPageTotal()%>" />
																		</jsp:include>
																	</td>
																</tr>
															</table>
														</td>
													</tr>
		        									<tr>
		        										<td>
		        											<table cellspacing="0" border="1" bordercolor="#ababab">
		        												<tr height=28 style="background:#ECECEC" align="center" class="content-title">
		        													<td align="center"><INPUT type="checkbox" id="checkall" name="checkall" onclick="javascript:chkall()" class=noborder></td>
		        													<td align="center">序号</td>
		        													<td align="center" width="20%">别名</td>
		        													<td align="center" width="20%">IP地址</td>
		        													<td align="center">设备类型</td>
		        													<td align="center">最后一次备份时间</td>
		        													<td align="center" width="20%">操作</td>
		        												</tr>
		        												<%
		        													ConfiguringDevice vo=null;
		        													int startRow = jp.getStartRow();
		        													if(list!=null&&list.size()>0){
			        												for (int i = 0; i < list.size(); i++) 
			        												{
			        													vo = (ConfiguringDevice)list.get(i);
																		vo = (ConfiguringDevice) list.get(i);
																		String lastUpdateTime = "没有备份文件";
																		if(vo.getLastUpdateTime() != null)
																		{
																			lastUpdateTime = vo.getLastUpdateTime().toString().substring(0,vo.getLastUpdateTime().toString().length()-5);
																		}
																		
			        											%>
			        													<tr >
											        						<td align='center'>
																			<INPUT type="checkbox" class=noborder name="checkbox"
																					value="<%=vo.getId() %>">
																			</td>
																			<td align='center'>
																				<font color='blue'><%=startRow + i%></font>
			        														</td>
			        														<td align='center'><a href="#" onclick="showAllFile('<%=vo.getIpaddress()%>','<%=vo.getDeviceRender() %>')"><font color='blue'><%=vo.getAlias()%></font></a></td>
			        														<td align='center'><a href="#" onclick="showAllFile('<%=vo.getIpaddress()%>','<%=vo.getDeviceRender() %>')"><font color='blue'><%=vo.getIpaddress()%></font></a></td>
			        														<td align='center'><%=vo.getDeviceRender() %></td>
			        														<td align='center'><%=lastUpdateTime %></td>
			        														
																			<td align='center'>
																			     <input type="hidden" id="id" name="id" value="<%=vo.getId()%>">
								        										 <input type="hidden" id="ipaddress" name="ipaddress" value="<%=vo.getIpaddress()%>">
																				 <img class="img" src="<%=rootPath%>/resource/image/status.gif" border="0" width=15 alt="右键操作"/>
																			</td>
			        													</tr>
			        													<%
			        												}
		        													}
		        												%>
		        											</table>
		        										</td>
		        									</tr>
		        								</table>
		        							</td>
		        						</tr>
		        						<tr>
		        							<td>
		        								<table id="content-footer" class="content-footer">
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
		</form>
	</body>
	<script language="JavaScript">
		$('.img').contextmenu({
			height:115,
			width:100,
			items : [{
					text :'备份',
					icon :'<%=rootPath%>/automation/images/copy.png',
					action: function(target){
						var id=$($(target).parent()).find('#id').val();
						var ip=$($(target).parent()).find('#ipaddress').val();
						backup(id,ip);
					}
				},{
					text :'管理备份',
					icon :'<%=rootPath%>/automation/images/addEndPoint.gif',
					action: function(target){
						var id=$($(target).parent()).find('#id').val();
						var ip=$($(target).parent()).find('#ipaddress').val();
						setupcfg(id,ip);
					}
				}]
		}
		);
		function backup(node,ipaddress)
			{
				window.open("<%=rootPath%>/netCfgFile.do?action=readyBackupConfig&&id="+node+"&ipaddress="+ipaddress,"oneping", "height=400, width= 500, top=300, left=100,scrollbars=yes");
			}	
			//管理备份
			function setupcfg(node,ipaddress)
			{
				window.open("<%=rootPath%>/netCfgFile.do?action=readyBkpManage&&id="+node+"&ipaddress="+ipaddress,"oneping", "height=400, width= 800, top=300, left=100,scrollbars=yes");
			}
			
	</script>
</html>
