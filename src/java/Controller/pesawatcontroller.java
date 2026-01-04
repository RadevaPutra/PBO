package controller;

import Models.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "Pesawatcontroller", urlPatterns = { "/pesawat" })
public class pesawatcontroller extends HttpServlet {

    private PesawatDao pesawatDAO;

    @Override
    public void init() {
        pesawatDAO = new PesawatDao();
    }

    // =========================
    // ========== GET ==========
    // =========================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String page = request.getParameter("page");
        String sub = request.getParameter("sub");
        String action = request.getParameter("action");

        // =============================
        // 1. USER (WikiAir / Kategori)
        // =============================
        if ("kategori".equalsIgnoreCase(page)) {
            handleUserKategori(request, response, sub);
            return;
        }

        // =============================
        // 2. ADMIN (CRUD & Dashboard)
        // =============================
        HttpSession session = request.getSession(false);
        User loggedInUser = (session != null) ? (User) session.getAttribute("user") : null;

        if (action != null) {
            // Proteksi admin
            if (loggedInUser == null ||
                    !"admin".equalsIgnoreCase(loggedInUser.getRole())) {
                response.sendRedirect("index.jsp?error=Akses_ditolak");
                return;
            }

            handleAdminActions(request, response, action);

        } else {
            // Default halaman user
            request.setAttribute("activePage", "home");
            request.getRequestDispatcher("home.jsp").forward(request, response);
        }
    }

    // =========================
    // ========== POST =========
    // =========================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if ("tambah".equals(action)) {
                insertPesawat(request, response);
            } else if ("edit".equals(action)) {
                updatePesawat(request, response);
            } else {
                response.sendRedirect("pesawat?action=admin_view");
            }
        } catch (SQLException ex) {
            Logger.getLogger(pesawatcontroller.class.getName())
                    .log(Level.SEVERE, null, ex);
            throw new ServletException(ex);
        }
    }

    // ===================================================
    // ================== USER SECTION ===================
    // ===================================================
    private void handleUserKategori(HttpServletRequest request,
            HttpServletResponse response, String sub)
            throws ServletException, IOException {

        List<Pesawat> list = null;

        try {
            String jenis = request.getParameter("jenis"); // Airbus A350
            String kategori = request.getParameter("type"); // Komersial

            if (jenis != null && !jenis.isEmpty()) {
                // 🔥 FILTER JENIS PESAWAT (Airbus A350)
                list = pesawatDAO.getPesawatByJenis(jenis);

            } else if (sub != null && !sub.isEmpty()) {
                String keyword = sub.replace("_", " ");
                list = pesawatDAO.getPesawatByKategori(keyword);

            } else if (kategori != null && !kategori.isEmpty()) {
                list = pesawatDAO.getPesawatByKategori(kategori);

            } else {
                list = pesawatDAO.getAllPesawat();
            }

            request.setAttribute("listPesawat", list);
            request.setAttribute("activePage", "kategori");
            request.getRequestDispatcher("home.jsp").forward(request, response);

        } catch (SQLException ex) {
            Logger.getLogger(pesawatcontroller.class.getName())
                    .log(Level.SEVERE, null, ex);
        }
    }

    // ===================================================
    // ================== ADMIN SECTION ==================
    // ===================================================
    private void handleAdminActions(HttpServletRequest request,
            HttpServletResponse response, String action)
            throws ServletException, IOException {

        try {
            switch (action) {
                case "new":
                    showNewForm(request, response);
                    break;

                case "edit":
                    showEditForm(request, response);
                    break;

                case "delete":
                    deletePesawat(request, response);
                    break;

                case "check_duplicate":
                    checkDuplicateKode(request, response);
                    break;

                case "admin_view":
                default:
                    listPesawatAdmin(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    // =========================
    // ===== ADMIN HELPERS =====
    // =========================
    private void listPesawatAdmin(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        List<Pesawat> listPesawat = pesawatDAO.getAllPesawat();
        request.setAttribute("listPesawat", listPesawat);
        request.getRequestDispatcher("admin_dashboard.jsp")
                .forward(request, response);
    }

    private void showNewForm(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("Form_Pesawat.jsp")
                .forward(request, response);
    }

    private void showEditForm(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        Pesawat pesawat = pesawatDAO.getPesawatById(id);
        request.setAttribute("pesawatData", pesawat); // Changed from "pesawat" to "pesawatData"
        request.setAttribute("mode", "edit"); // Add mode parameter explicitly
        request.getRequestDispatcher("Form_Pesawat.jsp")
                .forward(request, response);
    }

    // AJAX endpoint untuk check duplikat kode real-time
    private void checkDuplicateKode(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {

        String kode = request.getParameter("kode");
        String currentIdParam = request.getParameter("current_id");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        boolean exists = false;
        if (kode != null && !kode.trim().isEmpty()) {
            // If current_id provided (edit mode), exclude that ID from check
            if (currentIdParam != null && !currentIdParam.isEmpty()) {
                int currentId = Integer.parseInt(currentIdParam);
                exists = pesawatDAO.isKodePesawatExistsExcludingId(kode.trim(), currentId);
            } else {
                // Tambah mode - check all records
                exists = pesawatDAO.isKodePesawatExists(kode.trim());
            }
        }

        // Return JSON response
        String json = "{\"exists\": " + exists + "}";
        response.getWriter().write(json);
    }

    private void insertPesawat(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {

        Pesawat p = createPesawatFromRequest(request);

        // Check if kodePesawat already exists
        String kodePesawat = p.getKodePesawat();

        // Debug logging
        System.out.println("=== INSERT VALIDATION ===");
        System.out.println("Kode Pesawat: " + kodePesawat);

        // Validate not null/empty
        if (kodePesawat == null || kodePesawat.trim().isEmpty()) {
            System.out.println("ERROR: Kode pesawat kosong!");
            response.sendRedirect("pesawat?action=admin_view&msg=Empty_Kode");
            return;
        }

        // Check duplicate
        boolean isDuplicate = pesawatDAO.isKodePesawatExists(kodePesawat.trim());
        System.out.println("Is Duplicate? " + isDuplicate);

        if (isDuplicate) {
            // Redirect with error message if duplicate found
            System.out.println("DUPLIKAT TERDETEKSI! Redirect dengan error...");
            response.sendRedirect("pesawat?action=admin_view&msg=Duplicate_Kode&kode=" + kodePesawat.trim());
            return;
        }

        System.out.println("Validation passed, inserting data...");
        pesawatDAO.insertPesawat(p); // Now using full insertPesawat with all fields
        response.sendRedirect("pesawat?action=admin_view&msg=Insert_Sukses");
    }

    private void updatePesawat(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {

        int id = Integer.parseInt(request.getParameter("id_pesawat"));

        // Get existing data from database
        Pesawat existingData = pesawatDAO.getPesawatById(id);

        if (existingData == null) {
            response.sendRedirect("pesawat?action=admin_view&msg=Data_Not_Found");
            return;
        }

        // Create Pesawat object with partial update logic
        Pesawat p = createPesawatFromRequestPartial(request, existingData);
        p.setId(id);

        pesawatDAO.updatePesawat(p);
        response.sendRedirect("pesawat?action=admin_view&msg=Update_Sukses");
    }

    private void deletePesawat(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        pesawatDAO.deletePesawat(id);
        response.sendRedirect("pesawat?action=admin_view&msg=Delete_Sukses");
    }

    // =========================
    // ===== OBJECT BUILDER ====
    // =========================
    private Pesawat createPesawatFromRequest(HttpServletRequest request) {

        String kodePesawat = request.getParameter("kode_pesawat");
        String namaPesawat = request.getParameter("nama_pesawat");
        String namaOperator = request.getParameter("nama_operator");
        String tanggalPengiriman = request.getParameter("tanggal_pengiriman");
        String kategori = request.getParameter("tipe_pesawat");
        String tipeMesin = request.getParameter("tipe_mesin");
        String pabrikan = request.getParameter("pabrikan");
        String kecepatanMaks = request.getParameter("kecepatan_maks");
        int tahun = Integer.parseInt(request.getParameter("tahun"));
        String negara = request.getParameter("negara");

        Pesawat p = new Pesawat();
        p.setKodePesawat(kodePesawat);
        p.setJenisPesawat(namaPesawat);
        p.setNamaOperator(namaOperator);
        p.setTanggalPengiriman(tanggalPengiriman);
        p.setKategori(kategori);
        p.setTipe_mesin(tipeMesin);
        p.setPabrikan(pabrikan);
        p.setKecepatan_maks(kecepatanMaks);
        p.setTahun_produksi(tahun);
        p.setNegara_asal(negara);

        return p;
    }

    /**
     * Create Pesawat object with partial update logic
     * If a field is empty/null, use the existing value from database
     */
    private Pesawat createPesawatFromRequestPartial(HttpServletRequest request, Pesawat existing) {

        String kodePesawat = request.getParameter("kode_pesawat");
        String namaPesawat = request.getParameter("nama_pesawat");
        String namaOperator = request.getParameter("nama_operator");
        String tanggalPengiriman = request.getParameter("tanggal_pengiriman");
        String kategori = request.getParameter("tipe_pesawat");
        String tipeMesin = request.getParameter("tipe_mesin");
        String pabrikan = request.getParameter("pabrikan");
        String kecepatanMaks = request.getParameter("kecepatan_maks");
        String tahunStr = request.getParameter("tahun");
        String negara = request.getParameter("negara");

        Pesawat p = new Pesawat();

        // Use new value if not empty, otherwise keep existing
        p.setKodePesawat(isNotEmpty(kodePesawat) ? kodePesawat : existing.getKodePesawat());
        p.setJenisPesawat(isNotEmpty(namaPesawat) ? namaPesawat : existing.getJenisPesawat());
        p.setNamaOperator(isNotEmpty(namaOperator) ? namaOperator : existing.getNamaOperator());
        p.setTanggalPengiriman(isNotEmpty(tanggalPengiriman) ? tanggalPengiriman : existing.getTanggalPengiriman());
        p.setKategori(isNotEmpty(kategori) ? kategori : existing.getKategori());
        p.setTipe_mesin(isNotEmpty(tipeMesin) ? tipeMesin : existing.getTipe_mesin());
        p.setPabrikan(isNotEmpty(pabrikan) ? pabrikan : existing.getPabrikan());
        p.setKecepatan_maks(isNotEmpty(kecepatanMaks) ? kecepatanMaks : existing.getKecepatan_maks());

        // Special handling for tahun (integer)
        if (isNotEmpty(tahunStr)) {
            try {
                p.setTahun_produksi(Integer.parseInt(tahunStr));
            } catch (NumberFormatException e) {
                p.setTahun_produksi(existing.getTahun_produksi());
            }
        } else {
            p.setTahun_produksi(existing.getTahun_produksi());
        }

        p.setNegara_asal(isNotEmpty(negara) ? negara : existing.getNegara_asal());

        return p;
    }

    /**
     * Helper: Check if string is not null and not empty
     */
    private boolean isNotEmpty(String str) {
        return str != null && !str.trim().isEmpty();
    }
}
