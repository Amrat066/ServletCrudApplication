<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="Servlets.DBconnection"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Employee Data</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
    	.center {
				  margin: auto;
				  width: 90%;
				  padding: 10px;
				}
    </style>
</head>
<body>
    <div class="container center ">
       <h3>Employee List</h3>
	<div class="table-responsive">
	<a href="AddEmployee.jsp"><button type="submit" class="btn btn-primary float-right">Add Employee</button></a>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Designation</th>
                <th>Salary</th>
                <th>Hire Date</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% 

                try {
                    Connection conn = DBconnection.getConnection();
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM employees");
                    while(rs.next()) {
            %>
                        <tr>
                            <td><%= rs.getInt("id") %></td>
                            <td><%= rs.getString("name") %></td>
                            <td><%= rs.getString("designation") %></td>
                            <td><%= rs.getDouble("salary") %></td>
                            <td><%= rs.getDate("hire_date") %></td>
                            <td>
                                <form action="employee" method="post">
									<div class="d-grid gap-2 d-md-block">
									  <a href="UpdateEmp.jsp?id=<%=rs.getInt("id")%>"><button class="btn btn-primary" type="button" onclick="return confirm('Are you sure you want to update this Employee?');">Update</button></a>
									  <a href="DeleteEmp.jsp?id=<%=rs.getInt("id")%>"><button type="button" class="btn btn-danger" onclick="return confirm('Are you sure you want to Delete this Employee?');">Delete</button></a>
									  
									</div>                             
								 </form>
                            </td>
                        </tr>
            <% 
                    }
                    conn.close();
                } catch(SQLException e) {
                    e.printStackTrace();
                }
            %>
        </tbody>
    </table>
</div>

    </div>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
