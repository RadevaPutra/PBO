<%@ page import="Models.komentar" %>
    <%@ page import="java.util.List" %>

        <%! // Reusable comment section method public void renderCommentSection(JspWriter out, String topik, String
            pageRedirect) throws Exception { List<Models.komentar> komentarList =
            controller.komentarcontroller.getKomentarByTopik(topik);
            %>
            <div class="content-box" style="margin-top: 30px;">
                <h3 style="color: #2c3e50; margin-bottom: 20px; display: flex; align-items: center; gap: 10px;">
                    💬 <span>Diskusi Komunitas - <%=topik %></span>
                </h3>

                <!-- Comment Form -->
                <div style="background: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 25px;">
                    <form action="komentar" method="POST">
                        <input type="hidden" name="action" value="tambah">
                        <input type="hidden" name="topik_pesawat" value="<%=topik %>">
                        <input type="hidden" name="redirectPage" value="<%=pageRedirect %>">

                        <label style="font-weight: bold; display: block; margin-bottom: 10px;">Bagikan pendapat
                            Anda:</label>
                        <textarea name="isi_komentar"
                            style="width: 100%; padding: 12px; border: 2px solid #e0e0e0; border-radius: 6px; font-family: inherit; resize: vertical;"
                            rows="4" placeholder="Tulis komentar Anda..." required></textarea>

                        <div style="margin-top: 12px; display: flex; justify-content: flex-end;">
                            <button type="submit"
                                style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 10px 25px; border: none; border-radius: 6px; font-weight: bold; cursor: pointer; transition: transform 0.2s;">
                                📤 Kirim Komentar
                            </button>
                        </div>
                    </form>
                </div>

                <!-- Comments List -->
                <div>
                    <h4 style="color: #555; margin-bottom: 15px;">💭 Komentar Terbaru:</h4>
                    <% if (komentarList !=null && !komentarList.isEmpty()) { for (Models.komentar k : komentarList) { %>
                        <div
                            style="background: white; padding: 15px; border-radius: 8px; margin-bottom: 12px; border-left: 4px solid #667eea; box-shadow: 0 2px 8px rgba(0,0,0,0.05);">
                            <div style="display: flex; justify-content: space-between; margin-bottom: 8px;">
                                <span style="font-weight: bold; color: #667eea;">👤 <%= k.getUsername() %></span>
                                <span style="color: #999; font-size: 0.85em;">🕒 <%= k.getTanggalPost() %></span>
                            </div>
                            <p style="margin: 0; color: #555; line-height: 1.6;">
                                <%= k.getIsiKomentar() %>
                            </p>
                        </div>
                        <% } } else { %>
                            <div
                                style="text-align: center; padding: 30px; color: #999; background: #f8f9fa; border-radius: 8px;">
                                <p style="margin: 0; font-size: 1.1em;">📝 Belum ada komentar.</p>
                                <p style="margin: 5px 0 0 0;">Jadilah yang pertama berkomentar!</p>
                            </div>
                            <% } %>
                </div>
            </div>
            <% } %>