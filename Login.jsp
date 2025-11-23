<%-- 
    Document   : Login
    Created on : 23 Nov 2025, 12.39.41
    Author     : radev
--%>

<form action="LoginControl" method="post">
    
   
    <%
        
        String message = (String) request.getAttribute("message");
        if (message != null) {
            boolean isSuccess = (Boolean) request.getAttribute("isLoginSuccess");
    %>
           
            <p style="color: <%= isSuccess ? "green" : "red" %>;"><%= message %></p>
    <%
        }
    %>

    <label for="email">Email address</label><br>
    <input type="email" id="email" name="email" placeholder="Email address" required><br><br>

    <label for="password">Password</label><br>
    <input type="password" id="password" name="password" placeholder="Password" required><br><br>

   <button type="submit" class="blue-button">Login</button>
</form>