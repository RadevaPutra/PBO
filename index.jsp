<%-- 
    Document   : Index
    Created on : 22 Nov 2025, 22.44.08
    Author     : radev
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TP Mod 11</title>
        <style>
            .navbar {
                display: flex;
                gap: 10px;
                padding-bottom: 5px;
                border-bottom: 2px solid black;
            }
            .nav-link {
                text-decoration: none;
                color: #007bff;
                padding: 5px 10px;
            }
            .active {
                border-bottom: 2px solid black;
                font-weight: bold;
                color: black;
            }
            .blue-button {
                background-color: #007bff; 
                color: white; 
                border: none;
                padding: 10px 15px;
                border-radius: 5px;
                cursor: pointer;
            }
            .blue-button:hover {
                background-color: #0056b3; 
            }
        </style>
    </head>
    <body>
        
        <h1>TP Mod 11</h1>

        <%
            
            String p = request.getParameter("page");
            
            
            if (p == null) {
                p = "login";
            }
        %>
        
        <div class="navbar">
            <% 
                String loginClass = p.equals("login") ? "nav-link active" : "nav-link";
                String registerClass = p.equals("register") ? "nav-link active" : "nav-link";
            %>
            <a class="<%= loginClass %>" href="index.jsp?page=login">Login</a>

            <a class="<%= registerClass %>" href="index.jsp?page=register">Register</a>
        </div>
        
        <br>
        
        <% if (p.equals("login")) { %>
            <jsp:include page="Login.jsp" flush="false"></jsp:include>
        <% } else { %>
            <jsp:include page="Register.jsp" flush="false"></jsp:include>
        <% } %>

    </body>
</html>