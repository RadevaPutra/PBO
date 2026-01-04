<%@ page import="java.sql.*" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <html>

        <head>
            <title>Test Koneksi</title>
        </head>

        <body>
            <h2>Check DB (Port 3307)</h2>
            <% try { Class.forName("com.mysql.cj.jdbc.Driver"); String
                url="jdbc:mysql://127.0.0.1:3307/projek_uas_baru?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC"
                ; Connection conn=DriverManager.getConnection(url, "root" , "" ); out.print("<h3 style='color:green'>");
                out.print("KONEKSI SUKSES!");
                out.println("</h3>");
                conn.close();
                } catch (Exception e) {
                out.print("<h3 style='color:red'>");
                    out.print("KONEKSI GAGAL!");
                    out.println("</h3>");
                out.println("<p>" + e.toString() + "</p>");
                e.printStackTrace(new java.io.PrintWriter(out));
                }
                %>
        </body>

        </html>