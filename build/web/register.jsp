<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Register - WikiAir</title>
    <style>
        /* --- CSS: OVERLAY HITAM --- */
        .overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: -1;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background: url('img/Bandara.jpg') no-repeat center center fixed;
            background-size: cover;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            color: white;
            overflow: hidden;
        }

        .container {
            max-width: 400px;
            width: 90%;
            background: rgba(30, 30, 30, 0.85);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.5);
            text-align: center;
            z-index: 10;
        }

        .logo {
            font-size: 1.8em;
            font-weight: bold;
            margin-bottom: 10px;
            color: #A080FF;
        }

        .main-title {
            font-size: 1.5em;
            font-weight: 300;
            margin-bottom: 30px;
            text-transform: uppercase;
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            padding-bottom: 10px;
        }

        .input-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .input-group label {
            display: block;
            margin-bottom: 5px;
            font-size: 0.9em;
            color: #ccc;
        }

        .input-group input[type="text"],
        .input-group input[type="password"] {
            width: 100%;
            padding: 10px 0;
            border: none;
            border-bottom: 2px solid #A080FF;
            background: transparent;
            color: white;
            font-size: 1em;
            outline: none;
            box-sizing: border-box;
        }

        .btn-register {
            width: 100%;
            padding: 12px;
            margin-top: 20px;
            border: none;
            border-radius: 8px;
            font-size: 1.1em;
            font-weight: bold;
            cursor: pointer;
            background-image: linear-gradient(to right, #6A1B9A 0%, #A080FF 100%);
            color: white;
            transition: transform 0.2s;
        }

        .btn-register:hover {
            transform: scale(1.02);
            background-image: linear-gradient(to right, #A080FF 0%, #6A1B9A 100%);
        }

        .alert-error {
            background-color: rgba(220, 53, 69, 0.8);
            color: white;
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 5px;
            font-size: 0.9em;
        }

        .login-link {
            margin-top: 20px;
            font-size: 0.9em;
            color: #ccc;
        }

        .login-link a {
            color: #A080FF;
            text-decoration: none;
            font-weight: bold;
        }

        .login-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>

    <div class="overlay"></div>

    <div class="container">
        <div class="logo">✈️ WikiAir</div>
        <div class="main-title">REGISTER</div>

        <% 
            // LOGIKA MENAMPILKAN PESAN ERROR
            // Cek apakah ada error dari request attribute (controller) atau parameter URL
            String error = (String) request.getAttribute("error");
            
            if (error == null) {
                error = request.getParameter("error");
            }
            
            // Jika ada error, tampilkan alert
            if (error != null && !error.isEmpty()) { 
        %>
            <div class="alert-error">
                <%= error.replace("_", " ") %>
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/register" method="POST">
            <div class="input-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" placeholder="Choose a username" required>
            </div>

            <div class="input-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Create a password" required>
            </div>

            <button type="submit" class="btn-register">Buat Akun</button>
        </form>

        <div class="login-link">
            Sudah memiliki akun? 
            <a href="index.jsp">Login di sini</a>
        </div>
    </div>

</body>
</html>