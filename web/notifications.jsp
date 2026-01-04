<% 
    // Notification Messages Section
    String msg = request.getParameter("msg"); 
    
    if ("Duplicate_Kode".equals(msg)) { 
        String kode = request.getParameter("kode"); 
%>
    <div style="background-color: #f8d7da; color: #721c24; padding: 15px; border-radius: 5px; margin-bottom: 20px; border-left: 5px solid #f5c6cb;">
        <strong>?? Error:</strong> Kode Pesawat <strong><%= (kode != null) ? kode : "" %></strong> sudah ada di database! Silakan gunakan kode yang berbeda.
    </div>
<% 
    } else if ("Insert_Sukses".equals(msg) || "success_insert".equals(msg)) { 
%>
    <div style="background-color: #d4edda; color: #155724; padding: 15px; border-radius: 5px; margin-bottom: 20px; border-left: 5px solid #c3e6cb;">
        <strong>? Sukses:</strong> Data pesawat berhasil ditambahkan!
    </div>
<% 
    } else if ("Update_Sukses".equals(msg) || "success_update".equals(msg)) { 
%>
    <div style="background-color: #d1ecf1; color: #0c5460; padding: 15px; border-radius: 5px; margin-bottom: 20px; border-left: 5px solid #bee5eb;">
        <strong>? Sukses:</strong> Data pesawat berhasil diperbarui!
    </div>
<% 
    } else if ("Delete_Sukses".equals(msg) || "success_delete".equals(msg)) { 
%>
    <div style="background-color: #fff3cd; color: #856404; padding: 15px; border-radius: 5px; margin-bottom: 20px; border-left: 5px solid #ffeeba;">
        <strong>?? Sukses:</strong> Data pesawat berhasil dihapus.
    </div>
<% 
    } 
%>