<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Models.User"%>
<%@page import="Models.Pesawat"%>

<%
    // --- 1. KEAMANAN SESSION ---
    User user = (User) session.getAttribute("user");
    if (user == null || !user.getRole().equalsIgnoreCase("admin")) {
        response.sendRedirect("index.jsp");
        return;
    }

    // --- 2. LOGIKA MODE & JUDUL ---
    String mode = request.getParameter("mode");
    if (mode == null || mode.isEmpty()) {
        mode = "tambah";
    }
    
    String title = mode.equals("edit") ? "Sunting Data Pesawat" : "Tambah Pesawat Baru";
    String infoText = mode.equals("edit") ? "Anda sedang mengedit data ID: " + request.getParameter("id") : "Silakan isi form untuk menambah data baru.";

    // --- 3. PERSIAPAN VARIABEL DATA (Default Kosong) ---
    String idVal = "";
    String kodeVal = "";
    String namaVal = "";
    String operatorVal = "";
    String tanggalVal = "";
    String kategoriVal = "";
    String tipeMesinVal = "";
    String pabrikanVal = "";
    String kecepatanVal = "";
    String tahunVal = "";
    String negaraVal = "";

    // --- 4. POPULASI DATA JIKA EDIT ---
    if (mode.equals("edit")) {
        // Coba ambil dari Objek (jika dikirim dari Controller)
        Pesawat p = (Pesawat) request.getAttribute("pesawatData");
        
        if (p != null) {
            idVal = String.valueOf(p.getID_Pesawat());
            kodeVal = p.getKodePesawat();
            namaVal = p.getJenisPesawat();
            operatorVal = p.getNamaOperator();
            tanggalVal = p.getTanggalPengiriman();
            kategoriVal = p.getKategori();
            tipeMesinVal = p.getTipe_mesin();
            pabrikanVal = p.getPabrikan();
            kecepatanVal = p.getKecepatan_maks();
            tahunVal = String.valueOf(p.getTahun_produksi());
            negaraVal = p.getNegara_asal();
        } else {
            // Fallback: Ambil dari URL Parameter (jika dikirim dari Dashboard link panjang)
            idVal = request.getParameter("id");
            kodeVal = request.getParameter("kode");
            namaVal = request.getParameter("nama");
            
            // Ambil parameter opsional (gunakan ternary operator untuk keamanan)
            operatorVal = (request.getParameter("operator") != null) ? request.getParameter("operator") : "";
            tanggalVal = (request.getParameter("tanggal") != null) ? request.getParameter("tanggal") : "";
            kategoriVal = request.getParameter("kategori");
            tipeMesinVal = (request.getParameter("tipemesin") != null) ? request.getParameter("tipemesin") : "";
            pabrikanVal = request.getParameter("pabrikan");
            kecepatanVal = (request.getParameter("kecepatan") != null) ? request.getParameter("kecepatan") : "";
            tahunVal = request.getParameter("tahun");
            negaraVal = request.getParameter("negara");
        }
    }

    // --- 5. BERSIHKAN NULL (Agar tidak error "null" di text field) ---
    if (idVal == null) idVal = "";
    if (kodeVal == null) kodeVal = "";
    if (namaVal == null) namaVal = "";
    if (operatorVal == null) operatorVal = "";
    if (tanggalVal == null) tanggalVal = "";
    if (kategoriVal == null) kategoriVal = "";
    if (tipeMesinVal == null) tipeMesinVal = "";
    if (pabrikanVal == null) pabrikanVal = "";
    if (kecepatanVal == null) kecepatanVal = "";
    if (tahunVal == null || tahunVal.equals("0")) tahunVal = "";
    if (negaraVal == null) negaraVal = "";
%>

<!DOCTYPE html>
<html>
<head>
    <title><%= title %> - Admin WikiAir</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f0f2f5; margin: 0; padding: 40px; display: flex; justify-content: center; }
        .container { width: 100%; max-width: 600px; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08); }
        h2 { margin-top: 0; color: #2c3e50; border-bottom: 2px solid #3498db; padding-bottom: 15px; margin-bottom: 20px; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; font-weight: 600; color: #555; font-size: 0.95em; }
        input[type="text"], input[type="number"], input[type="date"], select { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 6px; box-sizing: border-box; font-size: 15px; transition: 0.3s; }
        input:focus, select:focus { border-color: #3498db; outline: none; box-shadow: 0 0 5px rgba(52, 152, 219, 0.2); }
        .info-text { background: #e3f2fd; color: #0c5460; padding: 12px; border-radius: 6px; font-size: 0.9em; margin-bottom: 25px; border-left: 5px solid #2196f3; }
        
        .btn-submit { background-color: #27ae60; color: white; padding: 12px 25px; border: none; border-radius: 6px; cursor: pointer; font-size: 16px; font-weight: bold; transition: 0.3s; width: 100%; margin-top: 10px; }
        .btn-submit:hover { background-color: #219150; transform: translateY(-2px); }
        
        .btn-cancel { display: block; text-align: center; margin-top: 15px; text-decoration: none; color: #7f8c8d; font-size: 0.9em; }
        .btn-cancel:hover { color: #34495e; text-decoration: underline; }
    </style>
</head>
<body>

<div class="container">
    <h2><%= title %></h2>
    <div class="info-text"><%= infoText %></div>

    <form action="pesawat" method="POST">
        <input type="hidden" name="action" value="<%= mode %>">
        
        <% if (mode.equals("edit")) { %>
            <input type="hidden" name="id_pesawat" value="<%= idVal %>">
            <div class="form-group">
                <label>ID Pesawat (Read Only):</label>
                <input type="text" value="<%= idVal %>" disabled style="background-color: #f8f9fa; color: #999;">
            </div>
        <% } %>

        <div class="form-group">
            <label>Kode Pesawat:</label>
            <input type="text" id="kode_pesawat" name="kode_pesawat" value="<%= kodeVal %>" placeholder="Contoh: B777-300ER" required>
            <div id="kode_error" style="color: #e74c3c; font-size: 0.9em; margin-top: 5px; display: none;">
                ⚠️ Kode pesawat sudah terdaftar! Silakan gunakan kode lain.
            </div>
        </div>

        <div class="form-group">
            <label>Nama Pesawat / Jenis:</label>
            <input type="text" name="nama_pesawat" value="<%= namaVal %>" placeholder="Contoh: Boeing 777-300ER" required>
        </div>

        <div class="form-group">
            <label>Nama Operator:</label>
            <input type="text" name="nama_operator" value="<%= operatorVal %>" placeholder="Contoh: Singapore Airlines">
        </div>

        <div class="form-group">
            <label>Tanggal Pengiriman:</label>
            <input type="date" name="tanggal_pengiriman" value="<%= tanggalVal %>">
        </div>

        <div class="form-group">
            <label>Kategori Utama:</label>
            <select name="tipe_pesawat" required>
                <option value="">-- Pilih Kategori --</option>
                <option value="Komersial" <%= "Komersial".equalsIgnoreCase(kategoriVal) ? "selected" : "" %>>Pesawat Komersial</option>
                <option value="Tempur" <%= "Tempur".equalsIgnoreCase(kategoriVal) ? "selected" : "" %>>Pesawat Tempur</option>
                <option value="Kargo" <%= "Kargo".equalsIgnoreCase(kategoriVal) ? "selected" : "" %>>Pesawat Kargo</option>
            </select>
        </div>

        <div class="form-group">
            <label>Tipe Mesin:</label>
            <input type="text" name="tipe_mesin" value="<%= tipeMesinVal %>" placeholder="Contoh: GE90-115B">
        </div>

        <div class="form-group">
            <label>Pabrikan:</label>
            <input type="text" name="pabrikan" value="<%= pabrikanVal %>" placeholder="Contoh: Boeing" required>
        </div>

        <div class="form-group">
            <label>Kecepatan Maksimal:</label>
            <input type="text" name="kecepatan_maks" value="<%= kecepatanVal %>" placeholder="Contoh: 905 km/h">
        </div>

        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
            <div class="form-group">
                <label>Tahun Produksi:</label>
                <input type="number" name="tahun" value="<%= tahunVal %>" placeholder="2023" required>
            </div>
            <div class="form-group">
                <label>Negara Asal:</label>
                <input type="text" name="negara" value="<%= negaraVal %>" placeholder="Contoh: USA" required>
            </div>
        </div>

        <button type="submit" class="btn-submit">
            <%= mode.equals("edit") ? "💾 Simpan Perubahan" : "🚀 Tambah Data" %>
        </button>
        <a href="pesawat?action=admin_view" class="btn-cancel">Batalkan</a>
    </form>
</div>

<script>
    // Real-time duplicate code check
    const isEditMode = <%= mode.equals("edit") ? "true" : "false" %>;
    // Pastikan idVal ada nilainya untuk mencegah syntax error di JS
    const currentId = <%= (idVal != null && !idVal.isEmpty()) ? idVal : "null" %>;

    const kodeInput = document.getElementById('kode_pesawat');
    const errorDiv = document.getElementById('kode_error');
    const submitBtn = document.querySelector('.btn-submit');
    let checkTimeout;

    if (kodeInput) {
        kodeInput.addEventListener('input', function () {
            clearTimeout(checkTimeout);
            const kode = this.value.trim();

            if (kode === '') {
                errorDiv.style.display = 'none';
                kodeInput.style.borderColor = '#ddd';
                kodeInput.style.boxShadow = 'none';
                submitBtn.disabled = false;
                submitBtn.style.opacity = '1';
                submitBtn.style.cursor = 'pointer';
                return;
            }

            checkTimeout = setTimeout(function () {
                let url = 'pesawat?action=check_duplicate&kode=' + encodeURIComponent(kode);
                if (isEditMode && currentId) {
                    url += '&current_id=' + currentId;
                }

                fetch(url)
                    .then(response => response.json())
                    .then(data => {
                        if (data.exists) {
                            errorDiv.style.display = 'block';
                            kodeInput.style.borderColor = '#e74c3c';
                            kodeInput.style.boxShadow = '0 0 5px rgba(231, 76, 60, 0.3)';
                            submitBtn.disabled = true;
                            submitBtn.style.opacity = '0.5';
                            submitBtn.style.cursor = 'not-allowed';
                        } else {
                            errorDiv.style.display = 'none';
                            kodeInput.style.borderColor = '#27ae60';
                            kodeInput.style.boxShadow = '0 0 5px rgba(39, 174, 96, 0.3)';
                            submitBtn.disabled = false;
                            submitBtn.style.opacity = '1';
                            submitBtn.style.cursor = 'pointer';
                        }
                    })
                    .catch(error => {
                        console.error('Error checking duplicate:', error);
                        // Optional: Jangan block submit jika server error (atau tampilkan pesan error lain)
                    });
            }, 500);
        });
    }

    // Prevent form submission if duplicate detected (double check)
    document.querySelector('form').addEventListener('submit', function (e) {
        if (submitBtn.disabled) {
            e.preventDefault();
            alert('⚠️ Kode pesawat sudah terdaftar! Silakan gunakan kode yang berbeda.');
            return false;
        }
    });
</script>

</body>
</html>