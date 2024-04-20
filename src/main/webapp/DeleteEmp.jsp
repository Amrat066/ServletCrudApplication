<%@page import="java.sql.PreparedStatement"%>
<%@page import="Servlets.DBconnection,java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>

<%
		int id=Integer.parseInt(request.getParameter("id"));
		try{
			Connection conn=DBconnection.getConnection();
			PreparedStatement st=conn.prepareStatement("delete from employees where id=?");
			st.setInt(1,id);
			int rowdeleted=st.executeUpdate();
			if(rowdeleted>0){
				 out.println("<script type=\"text/javascript\">");
                 out.println("alert('Employee deleted Successfully');");
                 out.println("window.location.href='employee.jsp';");
                 out.println("</script>");
				
			}else{
				out.println("<script type=\"text/javascript\">");
                out.println("alert('Something error');");
                out.println("window.location.href='employee.jsp';");
                out.println("</script>");
			}
            conn.close();

			
			
		}catch(Exception e){
			e.printStackTrace();
		}
%>

</body>
</html>