package controller;

import Models.User;
import Models.Pesawat;
import Models.PesawatDao;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "WebController", urlPatterns = { "/web" })
public class WebController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Validasi Session (Keamanan Utama)
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("index.jsp?error=Silakan_login_terlebih_dahulu");
            return;
        }

        // 2. Ambil Parameter Navigasi
        String page = request.getParameter("page");
        String type = request.getParameter("type"); // misal: tempur, kargo
        String sub = request.getParameter("sub"); // misal: pesawat_jet

        // 3. NORMALISASI LOGIKA (Kunci agar tidak stuck di home)
        // Jika ada parameter 'type', kita paksa sistem menganggap halaman adalah
        // 'kategori'
        if (type != null && !type.isEmpty()) {
            page = "kategori";
            type = type.toLowerCase();
        } else if (page == null || page.isEmpty()) {
            page = "home";
        }

        PesawatDao pesawatDao = new PesawatDao();
        List<Pesawat> listPesawat = new ArrayList<>();

        try {
            if ("home".equals(page)) {
                listPesawat = pesawatDao.getAllPesawat();

            } else if ("kategori".equals(page)) {
                // Proteksi jika masuk kategori tapi type kosong
                if (type == null || type.isEmpty()) {
                    type = "komersial";
                }

                // Logika Filter Data: Cari berdasarkan Sub-Kategori atau Kategori Utama
                if (sub != null && !sub.isEmpty()) {
                    // Mengubah 'pesawat_jet' (URL) menjadi 'pesawat jet' (Database)
                    String searchKeyword = sub.replace("_", " ");
                    listPesawat = pesawatDao.getPesawatByKategori(searchKeyword);
                } else {
                    listPesawat = pesawatDao.getPesawatByKategori(type);
                }

                // KIRIM ATRIBUT IDENTITAS (Penting untuk UI di Konten.jsp)
                request.setAttribute("currentKategori", type);
                request.setAttribute("currentSub", sub);
            }

            // 5. KIRIM DATA KE JSP (Dipindahkan ke luar blok try-catch)
            // request.setAttribute("activePage", page);
            // request.setAttribute("listPesawat", listPesawat);

        } catch (SQLException ex) {
            Logger.getLogger(WebController.class.getName()).log(Level.SEVERE, "Database Error", ex);
            request.setAttribute("errorMessage", "Gagal mengambil data dari database.");
            // listPesawat akan tetap kosong (sudah diinisialisasi di line 49)
        }

        // 5. KIRIM DATA KE JSP (Moved outside try-catch to ensure execution)
        request.setAttribute("activePage", page); // Memberitahu Konten.jsp halaman mana yang aktif
        request.setAttribute("listPesawat", listPesawat);

        // 6. Forward ke View
        request.getRequestDispatcher("Konten.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}