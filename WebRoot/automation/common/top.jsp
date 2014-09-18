<%@page language="java" contentType="text/html;charset=GB2312"%>
<%
	String rootPath = request.getContextPath();
%>
 <html>
     <head>
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
      <title>Top</title>
      <link rel="stylesheet" type="text/css"href="<%= rootPath%>/automation/css/top.css">
      <script>
             function changeFrameUrl(flag){
               if(flag==1){
               parent.mainFrame.location="<%=rootPath%>/automation/common/home.jsp?lType=tree&rType=list";
               }else if(flag==2){
               parent.mainFrame.location="<%=rootPath%>/event.do?action=summary&jp=1";
               }else if(flag==3){
               parent.mainFrame.location="<%=rootPath%>/system.do?action=list";
               }else if(flag==4){
               parent.mainFrame.location="<%=rootPath%>/automation/common/home.jsp?lType=tree&rType=list";
               }else if(flag==5){
               parent.mainFrame.location="<%=rootPath%>/automation/common/home.jsp?lType=tree&rType=configlist";
               }else if(flag==6){
               parent.mainFrame.location="<%=rootPath%>/automation/common/home.jsp?lType=tree&rType=cmdCfgList";
               }else if(flag==7){
               parent.mainFrame.location="<%=rootPath%>/automation/common/home.jsp?lType=menu&rType=showAllDevice";
               }
             }
      </script>
     </head>
     <body>
<div class="top_bg">
    <ul class="sf-menu">
              <li style="cursor:hand" onclick="changeFrameUrl(1)"><img src="<%= rootPath%>/automation/images/a.png"><br/><span class="below">首页</span></li>
              <li style="cursor:hand" onclick="changeFrameUrl(4)"><img src="<%= rootPath%>/automation/images/d.png"><br/><span class="below">设备维护</span></li>
              <li style="cursor:hand" onclick="changeFrameUrl(5)"><img src="<%= rootPath%>/automation/images/e.png"><br/><span class="below">配置管理</span></li>
              <li style="cursor:hand" onclick="changeFrameUrl(6)"><img src="<%= rootPath%>/automation/images/f.png"><br/><span class="below">自动化控制</span></li>
              <li style="cursor:hand" onclick="changeFrameUrl(7)"><img src="<%= rootPath%>/automation/images/g.png"><br/><span class="below">合规性检查</span></li>
              <li style="cursor:hand" onclick="changeFrameUrl(2)"><img src="<%= rootPath%>/automation/images/b.png"><br/><span  class="below">告警</span></li>
              <li style="cursor:hand" onclick="changeFrameUrl(3)"><img src="<%= rootPath%>/automation/images/c.png"><br/><span class="below">系统管理</span></li>
    </ul>
    <span class="icons_box"><a href="#">帮助</a>&nbsp;|&nbsp;<a href="#">退出</a></span> 
    </div>
     </body>
    </html>