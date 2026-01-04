<%@ page import="java.sql.*" %>
    <html>

    <body>
        <h2>Test MySQL Driver Load</h2>
        <% try { Class.forName("com.mysql.cj.jdbc.Driver"); out.println("<h3 style='color:green'>Driver Loaded
            Successfully!</h3>");
            out.println("<p>Library MySQL terbaca dengan baik.</p>");
            } catch (ClassNotFoundException e) {
            out.println("<h3 style='color:red'>Driver NOT Found!</h3>");
            out.println("<p>Tomcat tidak bisa menemukan 'mysql-connector-j.jar' di WEB-INF/lib.</p>");
            e.printStackTrace(new java.io.PrintWriter(out));
            } catch (Exception e) {
            out.println("<h3 style='color:orange'>Other Error</h3>");
            e.printStackTrace(new java.io.PrintWriter(out));
            }
            %>
    </body>

    </html>