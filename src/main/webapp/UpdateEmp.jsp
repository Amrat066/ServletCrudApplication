<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat, Servlets.DBconnection" %>

<%
    // Check if form is submitted
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String designation = request.getParameter("designation");
        String salary = request.getParameter("salary");
        String hireDate = request.getParameter("hireDate");

        // Update the data in the database
        try {
            Connection conn = DBconnection.getConnection();
            String sql = "UPDATE employees SET name=?, designation=?, salary=?, hire_date=? WHERE id=?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, designation);
            pstmt.setString(3, salary);
            pstmt.setString(4, hireDate);
            pstmt.setInt(5, id);

            int rowsUpdated = pstmt.executeUpdate();

            if (rowsUpdated > 0) {
                response.sendRedirect("employee.jsp");
            } else {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Failed to update employee');");
                out.println("window.location.href='updateEmp.jsp?id=" + id + "';");
                out.println("</script>");
            }

            conn.close();
        } catch (SQLException e) {
            // Handle database error, display message, or redirect back to update form
            e.printStackTrace();
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Database error');");
            out.println("window.location.href='updateEmp.jsp?id=" + id + "';");
            out.println("</script>");
        }
    } else {
        
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Employee ID is missing');");
            out.println("window.location.href='employee.jsp';");
            out.println("</script>");
        } else {
            int id = Integer.parseInt(idParam);

            try {
                Connection conn = DBconnection.getConnection();
                PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM employees WHERE id=?");
                pstmt.setInt(1, id);
                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
                    String name = rs.getString("name");
                    String designation = rs.getString("designation");
                    String salary = rs.getString("salary");
                    Date hireDate = rs.getDate("hire_date");

                    request.setAttribute("id", id);
                    request.setAttribute("name", name);
                    request.setAttribute("designation", designation);
                    request.setAttribute("salary", salary);
                    request.setAttribute("hireDate", hireDate);
                } else {
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Employee not found');");
                    out.println("window.location.href='employee.jsp';");
                    out.println("</script>");
                }

                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Database error');");
                out.println("window.location.href='employee.jsp';");
                out.println("</script>");
            }
        }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Employee</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-12 col-md-8 col-lg-6">
                <h1 class="text-center mb-4">Update Employee</h1>
                <form action="UpdateEmp.jsp" method="post">
                    <input type="hidden" name="id" value="<%= request.getAttribute("id") %>">
                    <div class="form-group">
                        <input type="text" class="form-control" name="name" value="<%= request.getAttribute("name") %>" placeholder="Enter name" required>
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control" name="designation" value="<%= request.getAttribute("designation") %>" placeholder="Enter designation" required>
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control" name="salary" value="<%= request.getAttribute("salary") %>" placeholder="Enter salary" required>
                    </div>
                    <div class="form-group">
                        <input type="date" class="form-control" name="hireDate" value="<%= new SimpleDateFormat("yyyy-MM-dd").format(request.getAttribute("hireDate"))%>" placeholder="Enter hire date" required>
                    </div>
                    <button type="submit" class="btn btn-primary btn-block">Update</button>
                </form>
            </div>
        </div>
    </div>
    <!-- Bootstrap JS -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
<%
    }
%>
