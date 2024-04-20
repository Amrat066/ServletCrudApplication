<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat, Servlets.DBconnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Employee</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-12 col-md-8 col-lg-6">
                <h1 class="text-center mb-4">Add Employee</h1>
                <form action="AddEmployee.jsp" method="post">
                    <div class="form-group">
                        <input type="text" class="form-control" name="name" placeholder="Enter name" required>
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control" name="designation" placeholder="Enter designation" required>
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control" name="salary" placeholder="Enter salary" required>
                    </div>
                    <div class="form-group">
                        <input type="date" class="form-control" name="hireDate" placeholder="Enter hire date" required>
                    </div>
                    <button type="submit" class="btn btn-primary btn-block">Submit</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>

<%
    String Name = request.getParameter("name");
    String designation = request.getParameter("designation");
    String salary = request.getParameter("salary");
    String date = request.getParameter("hireDate");

    try {
        Connection conn = DBconnection.getConnection();
        PreparedStatement ps=conn.prepareStatement("select * from employees where name=?");
        ps.setString(1, Name);
        ResultSet rs=ps.executeQuery();
        if(rs.next()){
        	 out.println("<script type=\"text/javascript\">");
             out.println("alert('Employee is exist');");
             out.println("window.location.href='AddEmployee.jsp';");
             out.println("</script>");	
        }
        else
        {
        	try
        	{
        		String sql = "INSERT INTO employees (name, designation, salary, hire_date) VALUES (?, ?, ?, ?)";
                PreparedStatement st = conn.prepareStatement(sql);
                st.setString(1, Name);
                st.setString(2, designation);
                st.setString(3, salary);

                // Convert the hire date string to java.sql.Date
                java.util.Date utilDate = new SimpleDateFormat("yyyy-MM-dd").parse(date);
                java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
                st.setDate(4, sqlDate);

                int data = st.executeUpdate();
                if (data > 0) {
                	  out.println("<script type=\"text/javascript\">");
                      out.println("alert('Add Employee successfully');");
                      out.println("window.location.href='employee.jsp';");
                      out.println("</script>");
                } else {
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Failed to add employee');");
                    out.println("window.location.href='AddEmployee.jsp';");
                    out.println("</script>");
                }
        		
        	}
        	catch(Exception e)
        	{
        		e.printStackTrace();
        	}
       	 }
        	
        conn.close();
        	
      } catch (Exception e) {
           e.printStackTrace();
      }
        	
        
        
%>
