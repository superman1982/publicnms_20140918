<%@page language="java" contentType="text/html;charset=gb2312" %>

<%
  String rootPath = request.getContextPath();
String flag=(String)request.getAttribute("flag");
  %>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

<link href="<%=rootPath%>/resource/<%=com.afunms.common.util.CommonAppUtil.getSkinPath() %>css/global/global.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript">
function backList(){
window.location="<%=rootPath%>/configRule.do?action=ruleDetailList";
}
</script>
</head>

<body id="body" class="body" >



	<form id="mainForm" method="post" name="mainForm" >
		
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
											                	<td class="add-content-title"></td>
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
				        											<table border="0" id="table1" cellpadding="0" cellspacing="1" width="100%" >
				        											    <% if(flag!=null&&flag.equals("1")){ %>
				        												<tr>
				        												   <TD nowrap  align=center>
				        														<img src="<%=rootPath %>/automation/images/success.png"></img>
				        													</TD>
				        													
				        												</tr>
				        												<tr>
				        												    <TD nowrap  align=center style="font-size:14px;color:#84E879;" >
				        														恭喜您，修改成功!!!
				        													</TD>
				        											    </tr>
				        												<%}else{ %>
				        												<tr>
				        												   <TD nowrap  align=center>
				        														<img src="<%=rootPath %>/automation/images/fail.png"></img>
				        													</TD>
				        													
				        												</tr>
				        												<tr>
				        												<TD nowrap  align=center style="font-size:14px;color:red;" >
				        														对不起，修改失败!!!
				        													</TD>
				        												</tr>
				        												<%} %>
																		<tr>
																			<TD nowrap  align=center>
																				<br><input type="button" value="规则列表" style="width:50" onclick="backList()" >&nbsp;&nbsp;
																				 <input type="button" value="返 回" style="width:50" onclick="javascript:history.back()" >
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
										<td>
											
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