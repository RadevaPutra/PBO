<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login - WikiAir (DEBUG MODE)</title>

        <style>
            .overlay {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.4);
                z-index: -1;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                padding: 0;
                background: url('img/Museum.jpg') no-repeat center center fixed;
                background-size: cover;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                color: white;
            }

            .login-container {
                max-width: 400px;
                width: 90%;
                background: rgba(30, 30, 30, 0.85);
                padding: 40px;
                border-radius: 15px;
                z-index: 10;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.5);
                text-align: center;
            }

            .logo {
                font-size: 1.8em;
                font-weight: bold;
                margin-bottom: 20px;
                color: #A080FF;
            }

            .main-title {
                font-size: 2.2em;
                font-weight: 300;
                margin-bottom: 30px;
                letter-spacing: 5px;
                text-transform: uppercase;
                border-bottom: 1px solid rgba(255, 255, 255, 0.2);
                padding-bottom: 10px;
            }

            .input-group {
                margin-bottom: 25px;
                text-align: left;
            }

            .input-group label {
                display: block;
                margin-bottom: 8px;
                font-size: 0.9em;
                color: #ccc;
            }

            .input-group input {
                width: 100%;
                padding: 12px 0;
                border: none;
                border-bottom: 2px solid #A080FF;
                background: transparent;
                color: white;
                font-size: 1.1em;
                outline: none;
            }

            .btn-login {
                width: 100%;
                padding: 15px;
                margin-top: 20px;
                border: none;
                border-radius: 8px;
                font-size: 1.1em;
                font-weight: bold;
                cursor: pointer;
                background-image: linear-gradient(to right, #6A1B9A 0%, #A080FF 100%);
                color: white;
                transition: transform 0.2s ease;
            }

            .btn-login:hover {
                transform: scale(1.02);
                background-image: linear-gradient(to right, #A080FF 0%, #6A1B9A 100%);
            }

            .alert {
                padding: 12px;
                margin-bottom: 20px;
                border-radius: 5px;
                font-weight: bold;
                font-size: 0.9em;
            }

            .alert-error {
                background-color: rgba(255, 0, 0, 0.7);
                color: white;
            }

            .alert-success {
                background-color: rgba(0, 200, 80, 0.8);
                color: white;
            }

            .register-link {
                margin-top: 25px;
                font-size: 0.9em;
                color: #ccc;
            }

            .register-link a {
                color: #A080FF;
                text-decoration: none;
                font-weight: bold;
            }

            .register-link a:hover {
                text-decoration: underline;
            }
        </style>
    </head>

    <body>
        <div class="overlay"></div>

        <div class="login-container">
            <div class="logo">✈️ WikiAir</div>
            <div class="main-title">LOGIN</div>

            <% String status=request.getParameter("status"); String error=request.getParameter("error"); if
                (error==null) { error=(String) request.getAttribute("error"); } if (error !=null) { %>
                <div class="alert alert-error">
                    Error: <%= error.replace("_", " " ) %>
                </div>
                <% } if ("success".equals(status)) { %>
                    <div class="alert alert-success">
                        Registrasi Berhasil! Silakan Login.
                    </div>
                    <% } %>

                        <form action="login" method="POST">
                            <div class="input-group">
                                <label for="username">Username</label>
                                <input type="text" id="username" name="username" required autocomplete="off">
                            </div>

                            <div class="input-group">
                                <label for="password">Password</label>
                                <input type="password" id="password" name="password" required>
                            </div>

                            <button type="submit" class="btn-login">LOGIN</button>
                        </form>

                        <div class="register-link">
                            Belum punya akun?
                            <%-- PERBAIKAN: Link diganti menjadi register.jsp --%>
                                <a href="register.jsp">Register di sini</a>
                        </div>
        </div>
    </body>

    </html>