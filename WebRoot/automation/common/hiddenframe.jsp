<%@page language="java" contentType="text/html;charset=GB2312"%>
<%
String rootPath = request.getContextPath();
%>
<html>
  <head> 
  <script type="text/javascript">
     function hidedtree()
    {
       var psc = parent.search.cols;              
	   if(psc == "222,12,*"){	        
		    hidedtreeBar();
	   }else{
		    showdtreeBar();
	   }
     }
    function showdtreeBar(){	   
	   parent.search.cols = "222,12,*";	   
    }
   function hidedtreeBar(){	   
	   parent.search.cols = "0,12,*";
   }
   
  </script>
  <style>
  body{
  margin:0,padding:0;background-color:#06223E;overflow:hidden;
  }
  </style>
   </head>
  
  <body>
    <table height="100%" width="100%">
       <tr>
         <td height="100%"  align="center" valign="middle">
          
         </td>
       </tr>
    </table>
  </body>
</html>
