package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class register extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String contactNo = request.getParameter("number");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        PrintWriter out = response.getWriter();
        response.setContentType("text/html;charset=UTF-8");

        try {
            Connection conn = DBconnection.getConnection();
            PreparedStatement checkStmt = conn.prepareStatement("SELECT * FROM users WHERE Email = ?");
            checkStmt.setString(1, email);
            ResultSet resultSet = checkStmt.executeQuery();

            if (resultSet.next()) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('The user already exists');");
                out.println("window.location.href='register.jsp';");
                out.println("</script>");
            } 
            else 
            {
            	try {
            		PreparedStatement insertStmt = conn.prepareStatement("INSERT INTO users (username, password, ContactNo, Email, Address) VALUES (?, ?, ?, ?, ?)");
                    insertStmt.setString(1, username);
                    insertStmt.setString(2, password);
                    insertStmt.setString(3, contactNo);
                    insertStmt.setString(4, email);
                    insertStmt.setString(5, address);
                    int data=insertStmt.executeUpdate();
                    if(data>0) {
                    	out.println("<script type=\"text/javascript\">");
                        out.println("alert('Registration successful. Please login.');");
                        out.println("window.location.href='login.jsp';");
                        out.println("</script>");
                    }else {
                    	out.println("<script type=\"text/javascript\">");
                        out.println("alert('Registration failed');");
                        out.println("window.location.href='register.jsp';");
                        out.println("</script>");
                    }
                   
          
            	}catch(Exception e) {
            		e.printStackTrace();
            	}
                
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp");
        }
    }
}
