<%-- 
    Document   : registrasi
    Created on : 21 Nov 2025, 20.58.15
    Author     : radev
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>✈️ Buat Akun - Arsip Pesawat Global</title>
    <style>
        body { 
            font-family: sans-serif; 
            background-color: #f8f9fa; 
            margin: 0; 
            padding: 20px; 
        }
        .container { 
            max-width: 500px; 
            margin: 50px auto; 
            padding: 30px; 
            background: white; 
            border: 1px solid #a2a9b1; 
            box-shadow: 0 0 10px rgba(0,0,0,0.1); 
        }
        h2 { 
            border-bottom: 1px solid #a2a9b1; 
            padding-bottom: 10px; 
            color: #007bff; 
        }
        input[type="text"], input[type="password"], select { 
            width: 100%; 
            padding: 10px; 
            margin: 8px 0; 
            box-sizing: border-box; 
            border: 1px solid #ced4da; 
        }
        button { 
            background-color: #007bff; 
            color: white; 
            padding: 10px 15px; 
            border: none; 
            cursor: pointer; 
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>🛠️ Pendaftaran Pengguna</h2>
        
        <% 
            String errorMsg = (String) request.getAttribute("error");
            if (errorMsg != null) out.println("<p style='color:red; font-weight: bold;'>Error: " + errorMsg + "</p>");
        %>

        <form action="register" method="POST">
            <input type="hidden" name="action" value="register">
            
            <label for="username">Nama Pengguna:</label>
            <input type="text" id="username" name="username" placeholder="Masukkan nama unik" required>
            
            <label for="password">Kata Sandi:</label>
            <input type="password" id="password" name="password" required>
            
            <label for="role">Pilih Peran:</label>
            <select id="role" name="role">
                <option value="user">Pembaca/Komentator (User)</option>
                <option value="admin">Editor/Kontributor (Admin)</option>
            </select><br><br>
            
            <button type="submit">Buat Akun Ensiklopedia</button>
        </form>

        <hr style="margin-top: 20px;">
        <p>Sudah memiliki akun? Kembali ke <a href="index.jsp">Halaman Login</a></p>
    </div>
</body>
</html>
