<%-- 
    Document   : Register
    Created on : 23 Nov 2025, 12.39.50
    Author     : radev
--%>

<form action="RegisterControl" method="post">
    
    
    <%
        String message = (String) request.getAttribute("message");
        if (message != null) {
            boolean isSuccess = (Boolean) request.getAttribute("isRegisterSuccess");
    %>
            <p style="color: <%= isSuccess ? "green" : "red" %>;"><%= message %></p>
    <%
        }
    %>

    <label for="email_reg">Email address</label><br>
    <input type="email" id="email_reg" name="email" placeholder="Email address" required><br><br>

    <label for="password_reg">Password</label><br>
    <input type="password" id="password_reg" name="password" placeholder="Password" required><br><br>

    <label for="confirm_password_reg">Confirm Password</label><br>
    <input type="password" id="confirm_password_reg" name="confirm_password" placeholder="Confirm Password" required><br><br>

    <button type="submit" class="blue-button">Register</button>
</form>
