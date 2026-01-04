<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@page import="java.util.List" %>
        <%@page import="Models.Pesawat" %>
            <%@page import="Models.komentar" %>
                <%@page import="Models.User" %>
                    <%@page import="controller.komentarcontroller" %>

                        <% User loggedInUser=(User) session.getAttribute("user"); List<Pesawat> listPesawat = (List
                            <Pesawat>) request.getAttribute("listPesawat");

                                String activePage = (String) request.getAttribute("activePage");
                                if (activePage == null || activePage.isEmpty()) {
                                activePage = "home";
                                }
                                String currentKategori = (String) request.getAttribute("currentKategori");
                                String currentSub = (String) request.getAttribute("currentSub");
                                if (activePage.equals("kategori") && (currentKategori == null
                                || currentKategori.isEmpty())) {
                                currentKategori = "komersial";
                                }
                                String displaySub = (currentSub != null) ? currentSub.replace("_", " ") : "";
                                String tableTitle = (currentKategori != null) ? "DATA " + currentKategori.toUpperCase()
                                + (displaySub.isEmpty() ? "" : " - " + displaySub.toUpperCase()) : "";
                                String
                                topikAktif = (!displaySub.isEmpty()) ? displaySub : (currentKategori != null
                                ? currentKategori : "Umum");
                                %>

                                <!DOCTYPE html>
                                <html>

                                <head>
                                    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                                    <title>WikiAir - Dashboard Penerbangan</title>
                                    <style>
                                        body {
                                            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                                            background-color: #f0f2f5;
                                            margin: 0;
                                        }

                                        .header {
                                            background-color: #1a1a1a;
                                            color: white;
                                            padding: 15px 50px;
                                            display: flex;
                                            justify-content: space-between;
                                            align-items: center;
                                            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
                                            position: sticky;
                                            top: 0;
                                            z-index: 1000;
                                        }

                                        .header a {
                                            color: #ccc;
                                            text-decoration: none;
                                            margin-left: 25px;
                                            font-weight: 600;
                                            transition: 0.3s;
                                            position: relative;
                                            padding-bottom: 5px;
                                        }

                                        .header a.active {
                                            color: #ffcc00;
                                            font-weight: 700;
                                        }

                                        .header a.active::after {
                                            content: '';
                                            position: absolute;
                                            bottom: 0;
                                            left: 0;
                                            width: 100%;
                                            height: 3px;
                                            background: linear-gradient(90deg, #ffcc00, #ffd700);
                                            border-radius: 2px;
                                            box-shadow: 0 2px 8px rgba(255, 204, 0, 0.6);
                                        }

                                        .header a.active::before {
                                            content: '▸';
                                            position: absolute;
                                            left: -15px;
                                            color: #ffcc00;
                                            animation: blink 1.5s infinite;
                                        }

                                        @keyframes blink {

                                            0%,
                                            100% {
                                                opacity: 1;
                                            }

                                            50% {
                                                opacity: 0.3;
                                            }
                                        }

                                        .header a:hover {
                                            color: #fff;
                                            transform: translateY(-2px);
                                        }

                                        /* Dropdown Menu Styling */
                                        nav {
                                            display: flex;
                                            align-items: center;
                                            position: relative;
                                        }

                                        .dropdown {
                                            position: relative;
                                            display: inline-block;
                                        }

                                        .dropdown-content {
                                            display: none;
                                            position: absolute;
                                            top: 100%;
                                            left: 0;
                                            background-color: #2c2c2c;
                                            min-width: 200px;
                                            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.5);
                                            z-index: 2000;
                                            border-radius: 8px;
                                            overflow: hidden;
                                            animation: slideDown 0.3s ease;
                                        }

                                        @keyframes slideDown {
                                            from {
                                                opacity: 0;
                                                transform: translateY(-10px);
                                            }

                                            to {
                                                opacity: 1;
                                                transform: translateY(0);
                                            }
                                        }

                                        .dropdown-content a {
                                            color: #ccc;
                                            padding: 14px 20px;
                                            text-decoration: none;
                                            display: block;
                                            margin: 0;
                                            transition: all 0.2s ease;
                                            border-left: 3px solid transparent;
                                        }

                                        .dropdown-content a:hover {
                                            background-color: #3a3a3a;
                                            color: #ffcc00;
                                            border-left-color: #ffcc00;
                                            padding-left: 25px;
                                        }

                                        .dropdown:hover .dropdown-content {
                                            display: block;
                                        }

                                        .dropbtn {
                                            cursor: pointer;
                                            display: flex;
                                            align-items: center;
                                            gap: 5px;
                                        }

                                        .dropbtn::after {
                                            content: '▼';
                                            font-size: 0.7em;
                                            transition: transform 0.3s ease;
                                        }

                                        .dropdown a.active.dropbtn::before {
                                            content: '▸';
                                            position: absolute;
                                            left: -15px;
                                            color: #ffcc00;
                                            animation: blink 1.5s infinite;
                                        }

                                        .dropdown a.active.dropbtn::after {
                                            color: #ffcc00;
                                        }

                                        .dropdown:hover .dropbtn::after {
                                            transform: rotate(180deg);
                                        }

                                        .logo-text {
                                            font-size: 1.8em;
                                            font-weight: bold;
                                            color: white;
                                            letter-spacing: 1px;
                                        }

                                        .main-content {
                                            display: flex;
                                            max-width: 1400px;
                                            margin: 30px auto;
                                            padding: 0 20px;
                                            gap: 30px;
                                        }

                                        .content-left {
                                            flex: 3;
                                        }

                                        .sidebar-right {
                                            flex: 1;
                                        }

                                        .content-box,
                                        .sidebar-box {
                                            background: white;
                                            padding: 25px;
                                            border-radius: 8px;
                                            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
                                            margin-bottom: 25px;
                                        }

                                        .dashboard-header {
                                            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                                            -webkit-background-clip: text;
                                            -webkit-text-fill-color: transparent;
                                            background-clip: text;
                                            display: inline-block;
                                            padding-bottom: 12px;
                                            margin-bottom: 30px;
                                            font-weight: 800;
                                            font-size: 2.5em;
                                            position: relative;
                                            animation: slideInLeft 0.6s ease;
                                        }

                                        .dashboard-header::after {
                                            content: '';
                                            position: absolute;
                                            bottom: 0;
                                            left: 0;
                                            width: 100%;
                                            height: 4px;
                                            background: linear-gradient(90deg, #667eea, #764ba2, #ffd700);
                                            border-radius: 2px;
                                            animation: expandWidth 0.8s ease 0.3s both;
                                        }

                                        @keyframes slideInLeft {
                                            from {
                                                opacity: 0;
                                                transform: translateX(-30px);
                                            }

                                            to {
                                                opacity: 1;
                                                transform: translateX(0);
                                            }
                                        }

                                        @keyframes expandWidth {
                                            from {
                                                width: 0;
                                            }

                                            to {
                                                width: 100%;
                                            }
                                        }

                                        /* Breaking News Styles */
                                        .breaking-news {
                                            background: #1a1a1a;
                                            color: white;
                                            padding: 15px;
                                            border-radius: 8px;
                                            margin-bottom: 25px;
                                            display: flex;
                                            align-items: center;
                                            gap: 15px;
                                            overflow: hidden;
                                        }

                                        .breaking-tag {
                                            background: #ff4444;
                                            padding: 4px 12px;
                                            border-radius: 4px;
                                            font-weight: bold;
                                            font-size: 0.8em;
                                            animation: pulse 1.5s infinite;
                                            flex-shrink: 0;
                                        }

                                        /* ===== ENHANCED NEWS GRID WITH ANIMATIONS ===== */
                                        .news-grid {
                                            display: grid;
                                            grid-template-columns: 1fr 1fr;
                                            gap: 25px;
                                            animation: fadeInGrid 0.8s ease;
                                        }

                                        @keyframes fadeInGrid {
                                            from {
                                                opacity: 0;
                                                transform: scale(0.95);
                                            }

                                            to {
                                                opacity: 1;
                                                transform: scale(1);
                                            }
                                        }

                                        .news-card {
                                            border: none;
                                            border-radius: 16px;
                                            overflow: hidden;
                                            background: linear-gradient(to bottom, #ffffff 0%, #f8f9fa 100%);
                                            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
                                            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
                                            position: relative;
                                            cursor: pointer;
                                        }

                                        .news-card::before {
                                            content: '';
                                            position: absolute;
                                            top: 0;
                                            left: -100%;
                                            width: 100%;
                                            height: 100%;
                                            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
                                            transition: left 0.6s;
                                        }

                                        .news-card:hover::before {
                                            left: 100%;
                                        }

                                        .news-card:hover {
                                            transform: translateY(-10px) scale(1.02);
                                            box-shadow: 0 16px 40px rgba(102, 126, 234, 0.25);
                                        }

                                        .news-img {
                                            width: 100%;
                                            height: 220px;
                                            object-fit: cover;
                                            transition: transform 0.5s ease;
                                            filter: brightness(0.95);
                                        }

                                        .news-card:hover .news-img {
                                            transform: scale(1.1);
                                            filter: brightness(1.05);
                                        }

                                        .news-content {
                                            padding: 15px;
                                        }

                                        .news-tag {
                                            display: inline-block;
                                            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                                            color: white;
                                            padding: 5px 12px;
                                            font-size: 0.7em;
                                            border-radius: 20px;
                                            font-weight: 700;
                                            text-transform: uppercase;
                                            margin-bottom: 12px;
                                            box-shadow: 0 2px 8px rgba(102, 126, 234, 0.3);
                                            letter-spacing: 0.5px;
                                            animation: fadeInDown 0.6s ease;
                                        }

                                        @keyframes fadeInDown {
                                            from {
                                                opacity: 0;
                                                transform: translateY(-10px);
                                            }

                                            to {
                                                opacity: 1;
                                                transform: translateY(0);
                                            }
                                        }

                                        .news-title {
                                            font-size: 1.15em;
                                            font-weight: bold;
                                            margin-bottom: 8px;
                                            color: #1a1a1a;
                                            line-height: 1.4;
                                        }

                                        .news-desc {
                                            font-size: 0.9em;
                                            color: #666;
                                            line-height: 1.5;
                                        }

                                        /* About Page Styles */
                                        .about-hero {
                                            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('https://images.unsplash.com/photo-1569154941061-e231b4725ef1?auto=format&fit=crop&w=1200');
                                            background-size: cover;
                                            background-position: center;
                                            color: white;
                                            padding: 70px 40px;
                                            border-radius: 8px;
                                            text-align: center;
                                            margin-bottom: 30px;
                                        }

                                        .about-feature {
                                            display: grid;
                                            grid-template-columns: 1fr 1fr;
                                            gap: 20px;
                                            margin-top: 30px;
                                        }

                                        .feature-item {
                                            background: #f8f9fa;
                                            padding: 20px;
                                            border-radius: 8px;
                                            border-left: 5px solid #ffcc00;
                                            transition: 0.3s;
                                        }

                                        .feature-item:hover {
                                            background: #fff;
                                            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                                        }

                                        /* Utility & Table */
                                        .large-image {
                                            width: 100%;
                                            height: 450px;
                                            object-fit: cover;
                                            border-radius: 8px;
                                            margin-bottom: 20px;
                                        }

                                        /* Horizontal Category Tabs */
                                        .category-tabs {
                                            display: flex;
                                            gap: 15px;
                                            margin-bottom: 30px;
                                            padding: 0;
                                            border-bottom: 3px solid #e9ecef;
                                            animation: fadeIn 0.5s ease;
                                        }

                                        .category-tab {
                                            padding: 15px 30px;
                                            background: transparent;
                                            color: #666;
                                            text-decoration: none;
                                            border-bottom: 3px solid transparent;
                                            margin-bottom: -3px;
                                            transition: all 0.3s ease;
                                            font-weight: 600;
                                            font-size: 1.05em;
                                            display: flex;
                                            align-items: center;
                                            gap: 8px;
                                            position: relative;
                                        }

                                        .category-tab::before {
                                            content: '';
                                            position: absolute;
                                            bottom: -3px;
                                            left: 0;
                                            width: 0;
                                            height: 3px;
                                            background: linear-gradient(90deg, #667eea, #764ba2);
                                            transition: width 0.3s ease;
                                        }

                                        .category-tab:hover {
                                            color: #667eea;
                                            transform: translateY(-2px);
                                        }

                                        .category-tab:hover::before {
                                            width: 100%;
                                        }

                                        .category-tab.active-tab {
                                            color: #667eea;
                                            border-bottom-color: #667eea;
                                            font-weight: 700;
                                        }

                                        .category-tab.active-tab::before {
                                            width: 100%;
                                        }

                                        /* ===== MODERN TABLE STYLING WITH ANIMATIONS ===== */
                                        .data-table {
                                            width: 100%;
                                            border-collapse: collapse;
                                            background: white;
                                            border-radius: 12px;
                                            overflow: hidden;
                                            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
                                            animation: fadeInUp 0.6s ease;
                                        }

                                        @keyframes fadeInUp {
                                            from {
                                                opacity: 0;
                                                transform: translateY(30px);
                                            }

                                            to {
                                                opacity: 1;
                                                transform: translateY(0);
                                            }
                                        }

                                        .data-table th {
                                            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                                            color: white;
                                            padding: 18px 15px;
                                            text-align: left;
                                            font-weight: 600;
                                            text-transform: uppercase;
                                            font-size: 0.85em;
                                            letter-spacing: 0.5px;
                                            position: relative;
                                        }

                                        .data-table th::after {
                                            content: '';
                                            position: absolute;
                                            bottom: 0;
                                            left: 0;
                                            right: 0;
                                            height: 3px;
                                            background: linear-gradient(90deg, #ffd700, #ff6b6b, #4ecdc4);
                                            background-size: 200% 100%;
                                            animation: shimmer 3s linear infinite;
                                        }

                                        @keyframes shimmer {
                                            0% {
                                                background-position: -200% 0;
                                            }

                                            100% {
                                                background-position: 200% 0;
                                            }
                                        }

                                        .data-table td {
                                            padding: 16px 15px;
                                            border-bottom: 1px solid #f0f0f0;
                                            color: #2c3e50;
                                            font-size: 0.95em;
                                            transition: all 0.3s ease;
                                        }

                                        /* Zebra striping dengan warna modern */
                                        .data-table tbody tr:nth-child(even) {
                                            background: linear-gradient(to right, #f8f9fa 0%, #ffffff 100%);
                                        }

                                        /* Hover effect yang menarik */
                                        .data-table tbody tr {
                                            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                                            cursor: pointer;
                                            animation: fadeIn 0.5s ease backwards;
                                        }

                                        .data-table tbody tr:nth-child(1) {
                                            animation-delay: 0.1s;
                                        }

                                        .data-table tbody tr:nth-child(2) {
                                            animation-delay: 0.2s;
                                        }

                                        .data-table tbody tr:nth-child(3) {
                                            animation-delay: 0.3s;
                                        }

                                        .data-table tbody tr:nth-child(4) {
                                            animation-delay: 0.4s;
                                        }

                                        .data-table tbody tr:nth-child(5) {
                                            animation-delay: 0.5s;
                                        }

                                        @keyframes fadeIn {
                                            from {
                                                opacity: 0;
                                                transform: translateX(-20px);
                                            }

                                            to {
                                                opacity: 1;
                                                transform: translateX(0);
                                            }
                                        }

                                        .data-table tbody tr:hover {
                                            background: linear-gradient(135deg, #667eea15 0%, #764ba215 100%);
                                            transform: scale(1.02);
                                            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.15);
                                            position: relative;
                                            z-index: 10;
                                        }

                                        .data-table tbody tr:hover td {
                                            color: #667eea;
                                            font-weight: 500;
                                        }

                                        .data-table tbody tr:hover td:first-child {
                                            color: #764ba2;
                                            font-weight: 700;
                                            transform: scale(1.1);
                                        }

                                        /* First column (Kode) styling */
                                        .data-table td:first-child {
                                            font-weight: 600;
                                            color: #667eea;
                                            font-family: 'Courier New', monospace;
                                        }

                                        /* Responsive adjustments */
                                        @media (max-width: 768px) {

                                            .data-table th,
                                            .data-table td {
                                                padding: 12px 8px;
                                                font-size: 0.85em;
                                            }
                                        }

                                        /* ===== MODERN DROPDOWN & INPUT STYLING ===== */
                                        #unitSelector {
                                            width: 100%;
                                            padding: 14px 20px;
                                            border: 2px solid #e0e0e0;
                                            border-radius: 10px;
                                            font-size: 15px;
                                            color: #2c3e50;
                                            background: linear-gradient(to bottom, #ffffff 0%, #f8f9fa 100%);
                                            cursor: pointer;
                                            transition: all 0.3s ease;
                                            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
                                            font-weight: 500;
                                        }

                                        #unitSelector:hover {
                                            border-color: #667eea;
                                            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.2);
                                            transform: translateY(-2px);
                                        }

                                        #unitSelector:focus {
                                            outline: none;
                                            border-color: #764ba2;
                                            box-shadow: 0 0 0 4px rgba(118, 75, 162, 0.1);
                                        }

                                        #unitSelector option {
                                            padding: 10px;
                                            background: white;
                                        }

                                        label[for="unitSelector"] {
                                            font-weight: 600;
                                            color: #2c3e50;
                                            font-size: 14px;
                                            margin-bottom: 8px;
                                            display: block;
                                            letter-spacing: 0.3px;
                                        }

                                        #searchInput {
                                            width: 100%;
                                            padding: 14px 20px 14px 45px;
                                            margin: 0 0 20px 0;
                                            border: 2px solid #e0e0e0;
                                            border-radius: 10px;
                                            font-size: 15px;
                                            transition: all 0.3s ease;
                                            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
                                            background: linear-gradient(to bottom, #ffffff 0%, #f8f9fa 100%);
                                            font-family: inherit;
                                        }

                                        #searchInput:focus {
                                            outline: none;
                                            border-color: #667eea;
                                            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.2), 0 0 0 4px rgba(102, 126, 234, 0.1);
                                            transform: translateY(-2px);
                                        }

                                        #searchInput::placeholder {
                                            color: #95a5a6;
                                            font-style: italic;
                                        }

                                        /* Category title styling */
                                        .kategori-title {
                                            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                                            -webkit-background-clip: text;
                                            -webkit-text-fill-color: transparent;
                                            background-clip: text;
                                            font-weight: 700;
                                            font-size: 2em;
                                            margin-bottom: 10px;
                                            animation: slideIn 0.5s ease;
                                        }

                                        @keyframes slideIn {
                                            from {
                                                opacity: 0;
                                                transform: translateX(-30px);
                                            }

                                            to {
                                                opacity: 1;
                                                transform: translateX(0);
                                            }
                                        }

                                        .airplane-card img {
                                            width: 100%;
                                            height: auto;
                                            object-fit: cover;
                                            border-bottom: 3px solid #ffc107;
                                            /* Garis kuning seperti di gambar */
                                        }

                                        @keyframes pulse {
                                            0% {
                                                opacity: 1;
                                            }

                                            50% {
                                                opacity: 0.6;
                                            }

                                            100% {
                                                opacity: 1;
                                            }
                                        }

                                        /* --- DASHBOARD ENHANCEMENTS --- */
                                        .stat-row {
                                            display: flex;
                                            gap: 20px;
                                            margin-bottom: 25px;
                                        }

                                        .stat-card {
                                            flex: 1;
                                            background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
                                            padding: 20px;
                                            border-radius: 12px;
                                            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
                                            text-align: center;
                                            border-bottom: 4px solid #3498db;
                                            transition: transform 0.3s ease;
                                        }

                                        .stat-card:hover {
                                            transform: translateY(-5px);
                                        }

                                        .stat-number {
                                            font-size: 2em;
                                            font-weight: bold;
                                            color: #2c3e50;
                                            display: block;
                                        }

                                        .stat-label {
                                            color: #7f8c8d;
                                            font-size: 0.9em;
                                            text-transform: uppercase;
                                            letter-spacing: 1px;
                                        }

                                        .quick-links {
                                            display: flex;
                                            justify-content: space-around;
                                            margin-bottom: 30px;
                                            background: white;
                                            padding: 20px;
                                            border-radius: 12px;
                                            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.03);
                                        }

                                        .quick-link-item {
                                            text-align: center;
                                            text-decoration: none;
                                            color: #333;
                                            transition: 0.3s;
                                        }

                                        .quick-link-item:hover {
                                            color: #007bff;
                                        }

                                        .quick-icon {
                                            width: 60px;
                                            height: 60px;
                                            background: #e3f2fd;
                                            border-radius: 50%;
                                            display: flex;
                                            align-items: center;
                                            justify-content: center;
                                            font-size: 1.5em;
                                            margin: 0 auto 10px;
                                            transition: 0.3s;
                                        }

                                        .quick-link-item:hover .quick-icon {
                                            background: #007bff;
                                            color: white;
                                            transform: rotate(10deg);
                                        }

                                        .news-card-link {
                                            text-decoration: none;
                                            color: inherit;
                                            display: block;
                                        }

                                        .news-card {
                                            transition: transform 0.3s, box-shadow 0.3s;
                                            cursor: pointer;
                                        }

                                        .news-card:hover {
                                            transform: translateY(-5px);
                                            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
                                        }

                                        .news-img-overlay {
                                            position: absolute;
                                            top: 0;
                                            left: 0;
                                            right: 0;
                                            bottom: 0;
                                            background: rgba(0, 0, 0, 0.0);
                                            transition: 0.3s;
                                        }

                                        .news-card:hover .news-img-overlay {
                                            background: rgba(0, 0, 0, 0.1);
                                        }

                                        .newsletter-section {
                                            background: linear-gradient(135deg, #2c3e50 0%, #3498db 100%);
                                            padding: 40px;
                                            border-radius: 15px;
                                            color: white;
                                            text-align: center;
                                            margin-top: 40px;
                                            position: relative;
                                            overflow: hidden;
                                        }

                                        .newsletter-input {
                                            padding: 12px 20px;
                                            width: 60%;
                                            border: none;
                                            border-radius: 30px;
                                            outline: none;
                                            font-size: 1em;
                                            margin-top: 15px;
                                        }

                                        .newsletter-btn {
                                            background: #ffcc00;
                                            color: #333;
                                            border: none;
                                            padding: 12px 30px;
                                            border-radius: 30px;
                                            font-weight: bold;
                                            cursor: pointer;
                                            margin-left: -50px;
                                            transition: 0.3s;
                                        }

                                        .newsletter-btn:hover {
                                            background: #e6b800;
                                            transform: scale(1.05);
                                        }

                                        /* ===== UX ENHANCEMENTS ===== */

                                        /* Breadcrumb Navigation */
                                        .breadcrumb {
                                            display: flex;
                                            align-items: center;
                                            gap: 10px;
                                            padding: 15px 0;
                                            margin-bottom: 25px;
                                            font-size: 14px;
                                            animation: fadeIn 0.4s ease;
                                            background: rgba(102, 126, 234, 0.05);
                                            padding: 12px 20px;
                                            border-radius: 8px;
                                        }

                                        .breadcrumb-item {
                                            color: #667eea;
                                            font-weight: 600;
                                        }

                                        .breadcrumb-item.active {
                                            color: #2c3e50;
                                        }

                                        .breadcrumb-separator {
                                            color: #ccc;
                                            margin: 0 5px;
                                        }

                                        /* Section Headers */
                                        .section-header {
                                            text-align: center;
                                            margin: 50px 0 35px;
                                            animation: fadeInUp 0.6s ease;
                                        }

                                        .section-title {
                                            font-size: 2.2em;
                                            font-weight: 800;
                                            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                                            -webkit-background-clip: text;
                                            -webkit-text-fill-color: transparent;
                                            background-clip: text;
                                            margin-bottom: 12px;
                                            letter-spacing: -0.5px;
                                        }

                                        .section-desc {
                                            font-size: 1.1em;
                                            color: #7f8c8d;
                                            max-width: 650px;
                                            margin: 0 auto;
                                            line-height: 1.6;
                                        }

                                        /* Category Grid (UX-optimized) */
                                        .category-grid {
                                            display: grid;
                                            grid-template-columns: repeat(3, 1fr);
                                            gap: 25px;
                                            margin-bottom: 50px;
                                        }

                                        .category-card {
                                            background: linear-gradient(to bottom, #ffffff 0%, #f9fafb 100%);
                                            padding: 40px 30px;
                                            border-radius: 16px;
                                            text-decoration: none;
                                            color: #2c3e50;
                                            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
                                            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                                            border: 2px solid transparent;
                                            position: relative;
                                            overflow: hidden;
                                            text-align: center;
                                            display: block;
                                        }

                                        .category-card::before {
                                            content: '';
                                            position: absolute;
                                            top: 0;
                                            left: 0;
                                            width: 100%;
                                            height: 4px;
                                            background: linear-gradient(90deg, #667eea, #764ba2);
                                            transform: scaleX(0);
                                            transition: transform 0.4s ease;
                                        }

                                        .category-card:hover::before {
                                            transform: scaleX(1);
                                        }

                                        .category-card:hover {
                                            transform: translateY(-10px);
                                            box-shadow: 0 15px 40px rgba(102, 126, 234, 0.25);
                                            border-color: rgba(102, 126, 234, 0.3);
                                        }

                                        .category-icon {
                                            font-size: 4em;
                                            margin-bottom: 20px;
                                            display: block;
                                            animation: bounce 2s infinite;
                                        }

                                        @keyframes bounce {

                                            0%,
                                            100% {
                                                transform: translateY(0);
                                            }

                                            50% {
                                                transform: translateY(-10px);
                                            }
                                        }

                                        .category-card:hover .category-icon {
                                            animation: none;
                                            transform: scale(1.1);
                                        }

                                        .category-card h3 {
                                            font-size: 1.5em;
                                            font-weight: 700;
                                            margin-bottom: 12px;
                                            color: #2c3e50;
                                        }

                                        .category-card p {
                                            font-size: 0.95em;
                                            color: #7f8c8d;
                                            line-height: 1.7;
                                            margin-bottom: 20px;
                                        }

                                        .card-arrow {
                                            display: inline-block;
                                            font-size: 1.8em;
                                            color: #667eea;
                                            transition: transform 0.3s ease;
                                            font-weight: bold;
                                        }

                                        .category-card:hover .card-arrow {
                                            transform: translateX(10px);
                                            color: #764ba2;
                                        }

                                        /* Enhanced Stats */
                                        .stats-grid {
                                            display: grid;
                                            grid-template-columns: repeat(4, 1fr);
                                            gap: 20px;
                                            margin-bottom: 50px;
                                        }

                                        .stat-item {
                                            background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
                                            padding: 35px 25px;
                                            border-radius: 14px;
                                            text-align: center;
                                            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.06);
                                            transition: all 0.3s ease;
                                            border-bottom: 4px solid transparent;
                                            position: relative;
                                            overflow: hidden;
                                        }

                                        .stat-item::before {
                                            content: '';
                                            position: absolute;
                                            top: 0;
                                            left: 0;
                                            width: 100%;
                                            height: 100%;
                                            background: linear-gradient(135deg, rgba(102, 126, 234, 0.05), rgba(118, 75, 162, 0.05));
                                            opacity: 0;
                                            transition: opacity 0.3s ease;
                                        }

                                        .stat-item:hover::before {
                                            opacity: 1;
                                        }

                                        .stat-item:nth-child(1) {
                                            border-bottom-color: #667eea;
                                        }

                                        .stat-item:nth-child(2) {
                                            border-bottom-color: #764ba2;
                                        }

                                        .stat-item:nth-child(3) {
                                            border-bottom-color: #f39c12;
                                        }

                                        .stat-item:nth-child(4) {
                                            border-bottom-color: #e74c3c;
                                        }

                                        .stat-item:hover {
                                            transform: translateY(-8px);
                                            box-shadow: 0 12px 35px rgba(0, 0, 0, 0.15);
                                        }

                                        .stat-icon {
                                            font-size: 3em;
                                            margin-bottom: 15px;
                                            display: block;
                                            position: relative;
                                            z-index: 1;
                                        }

                                        .stat-value {
                                            font-size: 2.8em;
                                            font-weight: 800;
                                            color: #2c3e50;
                                            display: block;
                                            margin-bottom: 8px;
                                            position: relative;
                                            z-index: 1;
                                        }

                                        .stat-label {
                                            font-size: 0.95em;
                                            color: #7f8c8d;
                                            text-transform: uppercase;
                                            letter-spacing: 0.8px;
                                            font-weight: 600;
                                            position: relative;
                                            z-index: 1;
                                        }

                                        /* CTA Buttons */
                                        .btn-primary,
                                        .btn-secondary {
                                            display: inline-block;
                                            padding: 16px 35px;
                                            border-radius: 10px;
                                            font-weight: 700;
                                            text-decoration: none;
                                            transition: all 0.3s ease;
                                            font-size: 1.05em;
                                            margin: 0 10px;
                                            text-transform: uppercase;
                                            letter-spacing: 0.5px;
                                        }

                                        .btn-primary {
                                            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                                            color: white;
                                            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.35);
                                        }

                                        .btn-primary:hover {
                                            transform: translateY(-4px);
                                            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.45);
                                        }

                                        .btn-secondary {
                                            background: transparent;
                                            color: #667eea;
                                            border: 2px solid #667eea;
                                        }

                                        .btn-secondary:hover {
                                            background: #95a5a6;
                                            transform: translateY(-3px);
                                            box-shadow: 0 8px 25px rgba(149, 165, 166, 0.4);
                                        }

                                        /* Statistics Progress Bars */
                                        .stat-chart {
                                            margin: 20px 0;
                                        }

                                        .stat-chart-label {
                                            display: flex;
                                            justify-content: space-between;
                                            margin-bottom: 8px;
                                            font-size: 0.9em;
                                        }

                                        .stat-chart-label-text {
                                            font-weight: 600;
                                            color: #2c3e50;
                                        }

                                        .stat-chart-value {
                                            font-weight: 700;
                                            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                                            -webkit-background-clip: text;
                                            -webkit-text-fill-color: transparent;
                                            background-clip: text;
                                        }

                                        .progress-bar-bg {
                                            width: 100%;
                                            height: 12px;
                                            background: #e9ecef;
                                            border-radius: 10px;
                                            overflow: hidden;
                                            box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.1);
                                        }

                                        .progress-bar-fill {
                                            height: 100%;
                                            background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
                                            border-radius: 10px;
                                            transition: width 1.5s cubic-bezier(0.4, 0, 0.2, 1);
                                            position: relative;
                                            width: 0;
                                            animation: fillBar 2s ease-out forwards;
                                        }

                                        .progress-bar-fill::after {
                                            content: '';
                                            position: absolute;
                                            top: 0;
                                            left: 0;
                                            right: 0;
                                            bottom: 0;
                                            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
                                            animation: shimmerBar 2s infinite;
                                        }

                                        @keyframes fillBar {
                                            from {
                                                width: 0;
                                            }
                                        }

                                        @keyframes shimmerBar {
                                            0% {
                                                transform: translateX(-100%);
                                            }

                                            100% {
                                                transform: translateX(100%);
                                            }
                                        }

                                        .stat-chart:nth-child(2) .progress-bar-fill {
                                            background: linear-gradient(90deg, #f39c12 0%, #e74c3c 100%);
                                            animation-delay: 0.2s;
                                        }

                                        .stat-chart:nth-child(3) .progress-bar-fill {
                                            background: linear-gradient(90deg, #2ecc71 0%, #27ae60 100%);
                                            animation-delay: 0.4s;
                                        }

                                        /* Responsive */
                                        @media (max-width: 992px) {
                                            .category-grid {
                                                grid-template-columns: repeat(2, 1fr);
                                            }

                                            .stats-grid {
                                                grid-template-columns: repeat(2, 1fr);
                                            }
                                        }

                                        @media (max-width: 768px) {

                                            .category-grid,
                                            .stats-grid {
                                                grid-template-columns: 1fr;
                                            }

                                            .section-title {
                                                font-size: 1.8em;
                                            }

                                            .btn-primary,
                                            .btn-secondary {
                                                display: block;
                                                margin: 10px 0;
                                            }
                                        }
                                    </style>
                                </head>

                                <body>

                                    <div class="header">
                                        <div class="logo-text">✈️ WikiAir</div>
                                        <nav>
                                            <% if (loggedInUser !=null) {%>
                                                <% String homeStyle=activePage.equals("home")
                                                    ? "color: #ffcc00; font-weight: 700; border-bottom: 3px solid #ffcc00; padding-bottom: 5px;"
                                                    : "" ; String kategoriStyle=activePage.equals("kategori")
                                                    ? "color: #ffcc00; font-weight: 700;" : "" ; String
                                                    aboutStyle=activePage.equals("about")
                                                    ? "color: #ffcc00; font-weight: 700; border-bottom: 3px solid #ffcc00; padding-bottom: 5px;"
                                                    : "" ; %>
                                                    <a href="web?page=home" class="<%= activePage.equals(" home")
                                                        ? "active" : "" %>"
                                                        style="<%= homeStyle %>"><%= activePage.equals("home") ? "▸ "
                                                                : "" %>HOME</a>

                                                    <!-- Dropdown Menu untuk Kategori -->
                                                    <div class="dropdown">
                                                        <a class="<%= activePage.equals(" kategori") ? "active" : "" %>
                                                            dropbtn"
                                                            style="<%= kategoriStyle %>"><%=
                                                                    activePage.equals("kategori") ? "▸ " : "" %>
                                                                    KATEGORI</a>
                                                        <div class="dropdown-content">
                                                            <a href="web?page=kategori&type=komersial">✈️ Pesawat
                                                                Komersial</a>
                                                            <a href="web?page=kategori&type=tempur">⚔️ Pesawat
                                                                Tempur</a>
                                                            <a href="web?page=kategori&type=kargo">📦 Pesawat Kargo</a>
                                                        </div>
                                                    </div>

                                                    <a href="web?page=about" class="<%= activePage.equals(" about")
                                                        ? "active" : "" %>"
                                                        style="<%= aboutStyle %>"><%= activePage.equals("about") ? "▸ "
                                                                : "" %>ABOUT</a>
                                                    <a href="login?action=logout" style="color: #ff4444;">LOGOUT</a>
                                                    <% } %>
                                        </nav>
                                    </div>

                                    <div class="main-content">
                                        <div class="content-left">
                                            <% if (activePage.equals("home")) { %>
                                                <div class="content-box">
                                                    <h2 class="dashboard-header">Aviation Dashboard</h2>

                                                    <!-- 1. QUICK STATS ROW -->
                                                    <div class="stat-row">
                                                        <div class="stat-card">
                                                            <span class="stat-number">1,245</span>
                                                            <span class="stat-label">Total Armada</span>
                                                        </div>
                                                        <div class="stat-card">
                                                            <span class="stat-number">18</span>
                                                            <span class="stat-label">Maskapai Partner</span>
                                                        </div>
                                                        <div class="stat-card">
                                                            <span class="stat-number">42</span>
                                                            <span class="stat-label">Negara Asal</span>
                                                        </div>
                                                    </div>

                                                </div>

                                                <!-- STATISTIK WIKIAIR - VISUAL CHARTS -->
                                                <div class="content-box"
                                                    style="background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%); border-left: 5px solid #667eea;">
                                                    <h3
                                                        style="margin-top: 0; font-size: 1.3em; color: #2c3e50; margin-bottom: 25px; display: flex; align-items: center; gap: 10px;">
                                                        <span style="font-size: 1.5em;">📊</span> Statistik WikiAir
                                                        Real-Time
                                                    </h3>

                                                    <div
                                                        style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 30px;">
                                                        <!-- Chart 1: Total Data Pesawat -->
                                                        <div class="stat-chart">
                                                            <div class="stat-chart-label">
                                                                <span class="stat-chart-label-text">✈️ Total Data
                                                                    Pesawat</span>
                                                                <span class="stat-chart-value">1,245 unit</span>
                                                            </div>
                                                            <div class="progress-bar-bg">
                                                                <div class="progress-bar-fill" style="width: 85%;">
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <!-- Chart 2: Kontribusi Diskusi -->
                                                        <div class="stat-chart">
                                                            <div class="stat-chart-label">
                                                                <span class="stat-chart-label-text">💬 Kontribusi
                                                                    Diskusi</span>
                                                                <span class="stat-chart-value">890 topik</span>
                                                            </div>
                                                            <div class="progress-bar-bg">
                                                                <div class="progress-bar-fill" style="width: 62%;">
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <!-- Chart 3: Artikel Bulan Ini -->
                                                        <div class="stat-chart">
                                                            <div class="stat-chart-label">
                                                                <span class="stat-chart-label-text">📝 Artikel Bulan
                                                                    Ini</span>
                                                                <span class="stat-chart-value">156 artikel</span>
                                                            </div>
                                                            <div class="progress-bar-bg">
                                                                <div class="progress-bar-fill" style="width: 45%;">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="content-box">

                                                    <!-- 2. QUICK LINKS -->
                                                    <div class="quick-links">
                                                        <a href="web?page=kategori&type=komersial"
                                                            class="quick-link-item">
                                                            <div class="quick-icon">✈️</div>
                                                            <span>Komersial</span>
                                                        </a>
                                                        <a href="web?page=kategori&type=tempur" class="quick-link-item">
                                                            <div class="quick-icon">⚔️</div>
                                                            <span>Tempur</span>
                                                        </a>
                                                        <a href="web?page=kategori&type=kargo" class="quick-link-item">
                                                            <div class="quick-icon">📦</div>
                                                            <span>Kargo</span>
                                                        </a>
                                                        <a href="web?page=about" class="quick-link-item">
                                                            <div class="quick-icon">📖</div>
                                                            <span>Edukasi</span>
                                                        </a>
                                                    </div>

                                                    <div class="breaking-news">
                                                        <div class="breaking-tag">BREAKING</div>
                                                        <marquee behavior="scroll" direction="left" scrollamount="6">
                                                            🚀 Rolls-Royce Sukses Uji Coba Mesin UltraFan dengan Bahan
                                                            Bakar 100% SAF | ✈️ Airbus Memperkenalkan Desain Pesawat
                                                            Bertenaga Hidrogen 'ZEROe' | 🔋 Pesawat Listrik Alice
                                                            Selesaikan Penerbangan Perdana...
                                                        </marquee>
                                                    </div>

                                                    <!-- 3. CLICKABLE NEWS GRID -->
                                                    <div class="news-grid">
                                                        <!-- News Item 1 -->
                                                        <a href="web?page=news&id=ultrafan" class="news-card-link">
                                                            <div class="news-card">
                                                                <div
                                                                    style="position: relative; overflow: hidden; border-radius: 8px 8px 0 0;">
                                                                    <img src="img/jetEngine.jpg" class="news-img"
                                                                        alt="Jet Engine">
                                                                    <div class="news-img-overlay"></div>
                                                                </div>
                                                                <div class="news-content">
                                                                    <span class="news-tag"
                                                                        style="background: #28a745;">Tech
                                                                        Breakthrough</span>
                                                                    <div class="news-title">Uji Coba Mesin Ultra-Fan
                                                                        Terbesar</div>
                                                                    <p class="news-desc">Rolls-Royce baru saja
                                                                        menyelesaikan pengujian darat untuk UltraFan,
                                                                        mesin turbofan terbesar dan paling efisien di
                                                                        dunia saat ini.</p>
                                                                </div>
                                                            </div>
                                                        </a>

                                                        <!-- News Item 2 -->
                                                        <a href="web?page=news&id=overture" class="news-card-link">
                                                            <div class="news-card">
                                                                <div
                                                                    style="position: relative; overflow: hidden; border-radius: 8px 8px 0 0;">
                                                                    <img src="img/supersonic.jpg" class="news-img"
                                                                        alt="Supersonic Jet">
                                                                    <div class="news-img-overlay"></div>
                                                                </div>
                                                                <div class="news-content">
                                                                    <span class="news-tag">Trending Now</span>
                                                                    <div class="news-title">Overture: Masa Depan
                                                                        Supersonik</div>
                                                                    <p class="news-desc">Boom Supersonic menghidupkan
                                                                        kembali impian terbang secepat suara. Pesawat
                                                                        'Overture' diklaim mampu terbang lintas benua 2x
                                                                        lebih cepat.</p>
                                                                </div>
                                                            </div>
                                                        </a>
                                                    </div>

                                                    <!-- 4. NEWSLETTER SECTION -->
                                                    <div class="newsletter-section">
                                                        <h3 style="margin: 0; font-size: 1.5em;">📩 Berlangganan Buletin
                                                            WikiAir</h3>
                                                        <p style="opacity: 0.9; margin: 10px 0 20px;">Dapatkan update
                                                            mingguan mengenai teknologi aviasi terbaru langsung di inbox
                                                            Anda.</p>
                                                        <form action="#" method="get" style="position: relative;">
                                                            <input type="email" class="newsletter-input"
                                                                placeholder="Masukkan alamat email Anda..." required>
                                                            <button type="submit"
                                                                class="newsletter-btn">Subscribe</button>
                                                        </form>
                                                    </div>

                                                </div>

                                                <!-- COMMENT SECTION - HOME PAGE -->
                                                <% String homeTopik="Home - WikiAir" ; List<Models.komentar>
                                                    homeKomentar =
                                                    controller.komentarcontroller.getKomentarByTopik(homeTopik);
                                                    %>
                                                    <div class="content-box" style="margin-top: 30px;">
                                                        <h3
                                                            style="color: #2c3e50; margin-bottom: 20px; display: flex; align-items: center; gap: 10px;">
                                                            💬 <span>Diskusi Komunitas</span>
                                                        </h3>

                                                        <div
                                                            style="background: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 25px;">
                                                            <form action="komentar" method="POST">
                                                                <input type="hidden" name="action" value="tambah">
                                                                <input type="hidden" name="topik_pesawat"
                                                                    value="<%= homeTopik %>">

                                                                <label
                                                                    style="font-weight: bold; display: block; margin-bottom: 10px;">Bagikan
                                                                    pendapat Anda tentang WikiAir:</label>
                                                                <textarea name="isi_komentar"
                                                                    style="width: 100%; padding: 12px; border: 2px solid #e0e0e0; border-radius: 6px; font-family: inherit; resize: vertical;"
                                                                    rows="4" placeholder="Tulis komentar Anda..."
                                                                    required></textarea>

                                                                <div
                                                                    style="margin-top: 12px; display: flex; justify-content: flex-end;">
                                                                    <button type="submit"
                                                                        style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 10px 25px; border: none; border-radius: 6px; font-weight: bold; cursor: pointer;">
                                                                        📤 Kirim Komentar
                                                                    </button>
                                                                </div>
                                                            </form>
                                                        </div>

                                                        <div>
                                                            <h4 style="color: #555; margin-bottom: 15px;">💭 Komentar
                                                                Terbaru:</h4>
                                                            <% if (homeKomentar !=null && !homeKomentar.isEmpty()) { for
                                                                (Models.komentar k : homeKomentar) { %>
                                                                <div
                                                                    style="background: white; padding: 15px; border-radius: 8px; margin-bottom: 12px; border-left: 4px solid #667eea; box-shadow: 0 2px 8px rgba(0,0,0,0.05);">
                                                                    <div
                                                                        style="display: flex; justify-content: space-between; margin-bottom: 8px;">
                                                                        <span
                                                                            style="font-weight: bold; color: #667eea;">👤
                                                                            <%= k.getUsername() %>
                                                                        </span>
                                                                        <span style="color: #999; font-size: 0.85em;">🕒
                                                                            <%= k.getTanggalPost() %>
                                                                        </span>
                                                                    </div>
                                                                    <p
                                                                        style="margin: 0; color: #555; line-height: 1.6;">
                                                                        <%= k.getIsiKomentar() %>
                                                                    </p>
                                                                </div>
                                                                <% } } else { %>
                                                                    <div
                                                                        style="text-align: center; padding: 30px; color: #999; background: #f8f9fa; border-radius: 8px;">
                                                                        <p style="margin: 0;">📝 Belum ada komentar.
                                                                            Jadilah yang pertama!</p>
                                                                    </div>
                                                                    <% } %>
                                                        </div>
                                                    </div>

                                                    <%} else if (activePage.equals("about")) { %>
                                                        <!-- ABOUT PAGE - ENHANCED VERSION -->
                                                        <style>
                                                            /* About Hero Section */
                                                            .about-hero-modern {
                                                                background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
                                                                color: white;
                                                                padding: 60px 40px;
                                                                border-radius: 15px;
                                                                text-align: center;
                                                                margin-bottom: 40px;
                                                                position: relative;
                                                                overflow: hidden;
                                                                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
                                                            }

                                                            .about-hero-modern::before {
                                                                content: '✈️';
                                                                position: absolute;
                                                                font-size: 200px;
                                                                opacity: 0.05;
                                                                right: -50px;
                                                                top: -50px;
                                                            }

                                                            .about-hero-modern h1 {
                                                                margin: 0;
                                                                font-size: 2.8em;
                                                                font-weight: bold;
                                                                text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
                                                            }

                                                            .about-hero-modern p {
                                                                color: #ffd700;
                                                                font-size: 1.3em;
                                                                margin-top: 10px;
                                                            }

                                                            /* Feature Cards Grid */
                                                            .feature-cards-grid {
                                                                display: grid;
                                                                grid-template-columns: repeat(2, 1fr);
                                                                gap: 25px;
                                                                margin-top: 30px;
                                                            }

                                                            /* Modern Clickable Feature Card */
                                                            .feature-card-link {
                                                                text-decoration: none;
                                                                color: inherit;
                                                                display: block;
                                                            }

                                                            .feature-card-modern {
                                                                background: white;
                                                                border-radius: 12px;
                                                                overflow: hidden;
                                                                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
                                                                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                                                                cursor: pointer;
                                                                position: relative;
                                                            }

                                                            .feature-card-modern:hover {
                                                                transform: translateY(-8px);
                                                                box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15);
                                                            }

                                                            .feature-card-image {
                                                                width: 100%;
                                                                height: 180px;
                                                                object-fit: cover;
                                                                transition: transform 0.5s ease;
                                                            }

                                                            .feature-card-modern:hover .feature-card-image {
                                                                transform: scale(1.1);
                                                            }

                                                            .feature-card-content {
                                                                padding: 25px;
                                                            }

                                                            .feature-card-icon {
                                                                font-size: 2.5em;
                                                                margin-bottom: 15px;
                                                                display: inline-block;
                                                                animation: float 3s ease-in-out infinite;
                                                            }

                                                            @keyframes float {

                                                                0%,
                                                                100% {
                                                                    transform: translateY(0);
                                                                }

                                                                50% {
                                                                    transform: translateY(-10px);
                                                                }
                                                            }

                                                            .feature-card-title {
                                                                font-size: 1.3em;
                                                                font-weight: bold;
                                                                color: #2c3e50;
                                                                margin-bottom: 12px;
                                                            }

                                                            .feature-card-desc {
                                                                font-size: 0.95em;
                                                                color: #666;
                                                                line-height: 1.6;
                                                            }

                                                            .feature-badge {
                                                                position: absolute;
                                                                top: 15px;
                                                                right: 15px;
                                                                background: rgba(255, 255, 255, 0.95);
                                                                padding: 6px 12px;
                                                                border-radius: 20px;
                                                                font-size: 0.75em;
                                                                font-weight: bold;
                                                                color: #667eea;
                                                                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
                                                            }

                                                            @media (max-width: 768px) {
                                                                .feature-cards-grid {
                                                                    grid-template-columns: 1fr;
                                                                }
                                                            }
                                                        </style>

                                                        <div class="content-box">
                                                            <!-- Hero Section -->
                                                            <div class="about-hero-modern">
                                                                <h1>WikiAir 360: Encyclopedia</h1>
                                                                <p>Platform Terpadu Informasi Kedirgantaraan Dunia</p>
                                                            </div>

                                                            <!-- Intro Text -->
                                                            <h3 style="color: #2c3e50; margin-bottom: 15px;">Apa itu
                                                                WikiAir?</h3>
                                                            <p
                                                                style="line-height: 1.8; color: #555; font-size: 1.05em;">
                                                                WikiAir adalah platform ensiklopedia digital modern yang
                                                                dirancang khusus untuk
                                                                menyajikan data akurat mengenai berbagai unit pesawat
                                                                dari seluruh dunia. Kami
                                                                berkomitmen untuk menyediakan sumber edukasi yang
                                                                interaktif bagi antusias
                                                                penerbangan dan profesional kedirgantaraan.
                                                            </p>

                                                            <!-- Feature Cards Grid -->
                                                            <div class="feature-cards-grid">
                                                                <!-- Card 1: Catalog -->
                                                                <a href="web?page=kategori" class="feature-card-link">
                                                                    <div class="feature-card-modern">
                                                                        <span class="feature-badge">Explore Now</span>
                                                                        <img src="img/boeing787.jpeg"
                                                                            alt="Aircraft Catalog"
                                                                            class="feature-card-image">
                                                                        <div class="feature-card-content">
                                                                            <div class="feature-card-icon">🔍</div>
                                                                            <div class="feature-card-title">Katalog
                                                                                Spesifikasi Lengkap</div>
                                                                            <p class="feature-card-desc">
                                                                                Data teknis mulai dari pabrikan,
                                                                                operator, hingga jenis mesin dari
                                                                                berbagai
                                                                                kategori pesawat komersial, tempur, dan
                                                                                kargo.
                                                                            </p>
                                                                        </div>
                                                                    </div>
                                                                </a>

                                                                <!-- Card 2: Updates -->
                                                                <a href="web?page=home#news" class="feature-card-link">
                                                                    <div class="feature-card-modern">
                                                                        <span class="feature-badge">Latest News</span>
                                                                        <img src="img/f-35.jpeg" alt="Global Updates"
                                                                            class="feature-card-image">
                                                                        <div class="feature-card-content">
                                                                            <div class="feature-card-icon">📡</div>
                                                                            <div class="feature-card-title">Update Tren
                                                                                Global</div>
                                                                            <p class="feature-card-desc">
                                                                                Informasi terkini mengenai teknologi
                                                                                mesin hidrogen, pesawat listrik,
                                                                                dan inovasi kabin terbaru dari industri
                                                                                aviasi global.
                                                                            </p>
                                                                        </div>
                                                                    </div>
                                                                </a>

                                                                <!-- Card 3: Community -->
                                                                <a href="web?page=discussion" class="feature-card-link">
                                                                    <div class="feature-card-modern">
                                                                        <span class="feature-badge">Join Now</span>
                                                                        <img src="img/antonov.jpeg"
                                                                            alt="Community Discussion"
                                                                            class="feature-card-image">
                                                                        <div class="feature-card-content">
                                                                            <div class="feature-card-icon">💬</div>
                                                                            <div class="feature-card-title">Diskusi
                                                                                Komunitas</div>
                                                                            <p class="feature-card-desc">
                                                                                Ruang interaksi bagi pengguna untuk
                                                                                berdiskusi mengenai topik-topik
                                                                                dirgantara favorit mereka dengan sesama
                                                                                enthusiast.
                                                                            </p>
                                                                        </div>
                                                                    </div>
                                                                </a>

                                                                <!-- Card 4: Fleet Management -->
                                                                <a href="web?page=kategori&type=komersial"
                                                                    class="feature-card-link">
                                                                    <div class="feature-card-modern">
                                                                        <span class="feature-badge">View Data</span>
                                                                        <img src="img/supersonic.jpg"
                                                                            alt="Fleet Management"
                                                                            class="feature-card-image">
                                                                        <div class="feature-card-content">
                                                                            <div class="feature-card-icon">📊</div>
                                                                            <div class="feature-card-title">Manajemen
                                                                                Armada</div>
                                                                            <p class="feature-card-desc">
                                                                                Pengelompokan data yang sistematis
                                                                                antara pesawat Komersial, Tempur,
                                                                                dan Kargo untuk analisis mendalam.
                                                                            </p>
                                                                        </div>
                                                                    </div>
                                                                </a>
                                                            </div>
                                                        </div>

                                                        <!-- COMMENT SECTION - ABOUT PAGE -->
                                                        <% String aboutTopik="About - WikiAir" ; List<Models.komentar>
                                                            aboutKomentar =
                                                            controller.komentarcontroller.getKomentarByTopik(aboutTopik);
                                                            %>
                                                            <div class="content-box" style="margin-top: 30px;">
                                                                <h3
                                                                    style="color: #2c3e50; margin-bottom: 20px; display: flex; align-items: center; gap: 10px;">
                                                                    💬 <span>Feedback tentang WikiAir</span>
                                                                </h3>

                                                                <div
                                                                    style="background: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 25px;">
                                                                    <form action="komentar" method="POST">
                                                                        <input type="hidden" name="action"
                                                                            value="tambah">
                                                                        <input type="hidden" name="topik_pesawat"
                                                                            value="<%= aboutTopik %>">

                                                                        <label
                                                                            style="font-weight: bold; display: block; margin-bottom: 10px;">Apa
                                                                            pendapat Anda tentang platform ini?</label>
                                                                        <textarea name="isi_komentar"
                                                                            style="width: 100%; padding: 12px; border: 2px solid #e0e0e0; border-radius: 6px; font-family: inherit; resize: vertical;"
                                                                            rows="4"
                                                                            placeholder="Bagikan saran dan masukan Anda..."
                                                                            required></textarea>

                                                                        <div
                                                                            style="margin-top: 12px; display: flex; justify-content: flex-end;">
                                                                            <button type="submit"
                                                                                style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 10px 25px; border: none; border-radius: 6px; font-weight: bold; cursor: pointer;">
                                                                                📤 Kirim Feedback
                                                                            </button>
                                                                        </div>
                                                                    </form>
                                                                </div>

                                                                <div>
                                                                    <h4 style="color: #555; margin-bottom: 15px;">💭
                                                                        Feedback Pengguna:</h4>
                                                                    <% if (aboutKomentar !=null &&
                                                                        !aboutKomentar.isEmpty()) { for (Models.komentar
                                                                        k : aboutKomentar) { %>
                                                                        <div
                                                                            style="background: white; padding: 15px; border-radius: 8px; margin-bottom: 12px; border-left: 4px solid #667eea; box-shadow: 0 2px 8px rgba(0,0,0,0.05);">
                                                                            <div
                                                                                style="display: flex; justify-content: space-between; margin-bottom: 8px;">
                                                                                <span
                                                                                    style="font-weight: bold; color: #667eea;">👤
                                                                                    <%= k.getUsername() %>
                                                                                </span>
                                                                                <span
                                                                                    style="color: #999; font-size: 0.85em;">🕒
                                                                                    <%= k.getTanggalPost() %>
                                                                                </span>
                                                                            </div>
                                                                            <p
                                                                                style="margin: 0; color: #555; line-height: 1.6;">
                                                                                <%= k.getIsiKomentar() %>
                                                                            </p>
                                                                        </div>
                                                                        <% } } else { %>
                                                                            <div
                                                                                style="text-align: center; padding: 30px; color: #999; background: #f8f9fa; border-radius: 8px;">
                                                                                <p style="margin: 0;">✨ Belum ada
                                                                                    feedback. Bagikan pendapat Anda!</p>
                                                                            </div>
                                                                            <% } %>
                                                                </div>
                                                            </div>

                                                            <%} else if (activePage.equals("discussion")) { // Community
                                                                String topik=request.getParameter("topik"); if
                                                                (topik==null || topik.isEmpty()) { topik="Umum" ; } %>
                                                                <!-- DISCUSSION PAGE -->
                                                                <style>
                                                                    .discussion-hero {
                                                                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                                                                        color: white;
                                                                        padding: 40px;
                                                                        border-radius: 15px;
                                                                        text-align: center;
                                                                        margin-bottom: 30px;
                                                                    }

                                                                    .discussion-hero h1 {
                                                                        margin: 0 0 10px 0;
                                                                        font-size: 2.2em;
                                                                    }

                                                                    .topic-cards {
                                                                        display: grid;
                                                                        grid-template-columns: repeat(3, 1fr);
                                                                        gap: 20px;
                                                                        margin-bottom: 30px;
                                                                    }

                                                                    .topic-card {
                                                                        background: white;
                                                                        padding: 25px;
                                                                        border-radius: 12px;
                                                                        text-align: center;
                                                                        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
                                                                        transition: all 0.3s;
                                                                        cursor: pointer;
                                                                        text-decoration: none;
                                                                        color: inherit;
                                                                        border: 2px solid transparent;
                                                                    }

                                                                    .topic-card:hover {
                                                                        transform: translateY(-5px);
                                                                        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
                                                                        border-color: #667eea;
                                                                    }

                                                                    .topic-card.active {
                                                                        border-color: #667eea;
                                                                        background: linear-gradient(135deg, #f8f9ff 0%, #fff 100%);
                                                                    }

                                                                    .topic-icon {
                                                                        font-size: 3em;
                                                                        margin-bottom: 15px;
                                                                    }

                                                                    .topic-title {
                                                                        font-size: 1.2em;
                                                                        font-weight: bold;
                                                                        color: #2c3e50;
                                                                        margin-bottom: 8px;
                                                                    }

                                                                    .topic-count {
                                                                        color: #999;
                                                                        font-size: 0.9em;
                                                                    }

                                                                    .comment-form-modern {
                                                                        background: white;
                                                                        padding: 30px;
                                                                        border-radius: 12px;
                                                                        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
                                                                        margin-bottom: 30px;
                                                                    }

                                                                    .comment-input-modern {
                                                                        width: 100%;
                                                                        padding: 15px;
                                                                        border: 2px solid #e0e0e0;
                                                                        border-radius: 8px;
                                                                        font-family: inherit;
                                                                        font-size: 1em;
                                                                        resize: vertical;
                                                                        transition: border-color 0.3s;
                                                                    }

                                                                    .comment-input-modern:focus {
                                                                        outline: none;
                                                                        border-color: #667eea;
                                                                    }

                                                                    .btn-submit-comment {
                                                                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                                                                        color: white;
                                                                        padding: 12px 30px;
                                                                        border: none;
                                                                        border-radius: 8px;
                                                                        font-weight: bold;
                                                                        cursor: pointer;
                                                                        transition: transform 0.2s;
                                                                    }

                                                                    .btn-submit-comment:hover {
                                                                        transform: scale(1.05);
                                                                    }

                                                                    .comment-card-modern {
                                                                        background: white;
                                                                        padding: 20px;
                                                                        border-radius: 12px;
                                                                        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
                                                                        margin-bottom: 15px;
                                                                        border-left: 4px solid #667eea;
                                                                    }

                                                                    .comment-header {
                                                                        display: flex;
                                                                        justify-content: space-between;
                                                                        align-items: center;
                                                                        margin-bottom: 12px;
                                                                    }

                                                                    .comment-author {
                                                                        font-weight: bold;
                                                                        color: #667eea;
                                                                        font-size: 1.1em;
                                                                    }

                                                                    .comment-date {
                                                                        color: #999;
                                                                        font-size: 0.85em;
                                                                    }

                                                                    .comment-body {
                                                                        color: #555;
                                                                        line-height: 1.6;
                                                                    }

                                                                    @media (max-width: 768px) {
                                                                        .topic-cards {
                                                                            grid-template-columns: 1fr;
                                                                        }
                                                                    }
                                                                </style>

                                                                <div class="content-box">
                                                                    <!-- Hero Section -->
                                                                    <div class="discussion-hero">
                                                                        <h1>💬 Diskusi Komunitas WikiAir</h1>
                                                                        <p>Bergabunglah dengan diskusi seputar dunia
                                                                            penerbangan
                                                                        </p>
                                                                    </div>

                                                                    <!-- Topic Cards -->
                                                                    <div class="topic-cards">
                                                                        <a href="web?page=discussion&topik=Komersial"
                                                                            class="topic-card <%= "Komersial".equals(topik) ? "active" : ""
                                                                            %>">
                                                                            <div class="topic-icon">✈️</div>
                                                                            <div class="topic-title">Pesawat Komersial
                                                                            </div>
                                                                            <div class="topic-count">Diskusi tentang
                                                                                A350,
                                                                                B787,
                                                                                dan lainnya</div>
                                                                        </a>

                                                                        <a href="web?page=discussion&topik=Tempur"
                                                                            class="topic-card <%= "Tempur".equals(topik) ? "active" : "" %>">
                                                                            <div class="topic-icon">⚔️</div>
                                                                            <div class="topic-title">Pesawat Tempur
                                                                            </div>
                                                                            <div class="topic-count">Diskusi tentang
                                                                                F-35,
                                                                                Su-27, dan lainnya</div>
                                                                        </a>

                                                                        <a href="web?page=discussion&topik=Kargo"
                                                                            class="topic-card <%= " Kargo".equals(topik)
                                                                            ? "active" : "" %>">
                                                                            <div class="topic-icon">📦</div>
                                                                            <div class="topic-title">Pesawat Kargo</div>
                                                                            <div class="topic-count">Diskusi tentang
                                                                                An-124,
                                                                                C-130, dll</div>
                                                                        </a>
                                                                    </div>

                                                                    <!-- Comment Form -->
                                                                    <div class="comment-form-modern">
                                                                        <h3 style="margin-top: 0; color: #2c3e50;">💭
                                                                            Bagikan
                                                                            Pendapat Anda - Topik: <%= topik %>
                                                                        </h3>
                                                                        <form action="komentar" method="POST">
                                                                            <input type="hidden" name="action"
                                                                                value="tambah">
                                                                            <input type="hidden" name="topik_pesawat"
                                                                                value="<%= topik %>">
                                                                            <input type="hidden" name="redirectPage"
                                                                                value="discussion">

                                                                            <textarea name="isi_komentar"
                                                                                class="comment-input-modern" rows="5"
                                                                                placeholder="Tulis komentar Anda di sini..."
                                                                                required></textarea>

                                                                            <div
                                                                                style="margin-top: 15px; display: flex; justify-content: flex-end;">
                                                                                <button type="submit"
                                                                                    class="btn-submit-comment">📤 Kirim
                                                                                    Komentar</button>
                                                                            </div>
                                                                        </form>
                                                                    </div>

                                                                    <!-- Comments List -->
                                                                    <div>
                                                                        <h3
                                                                            style="color: #2c3e50; margin-bottom: 20px;">
                                                                            📝
                                                                            Komentar Terbaru</h3>
                                                                        <% // Import komentar controller
                                                                            List<Models.komentar> listKomentar =
                                                                            controller.komentarcontroller.getKomentarByTopik(topik);
                                                                            if (listKomentar != null &&
                                                                            !listKomentar.isEmpty())
                                                                            {
                                                                            for (Models.komentar k : listKomentar) {
                                                                            %>
                                                                            <div class="comment-card-modern">
                                                                                <div class="comment-header">
                                                                                    <span class="comment-author">👤
                                                                                        <%= k.getUsername() %>
                                                                                    </span>
                                                                                    <span class="comment-date">🕒
                                                                                        <%= k.getTanggalPost() %>
                                                                                    </span>
                                                                                </div>
                                                                                <div class="comment-body">
                                                                                    <%= k.getIsiKomentar() %>
                                                                                </div>
                                                                            </div>
                                                                            <% } } else { %>
                                                                                <div
                                                                                    style="text-align: center; padding: 40px; color: #999;">
                                                                                    <p style="font-size: 1.2em;">💬
                                                                                        Belum
                                                                                        ada
                                                                                        komentar untuk topik <%= topik
                                                                                            %>
                                                                                    </p>
                                                                                    <p>Jadilah yang pertama
                                                                                        berkomentar!
                                                                                    </p>
                                                                                </div>
                                                                                <% } %>
                                                                    </div>
                                                                </div>

                                                                <%-- Bagian Halaman Kategori --%>
                                                                    <%-- Bagian Halaman Kategori --%>
                                                                        <% } else if (activePage.equals("news")) {
                                                                            String newsId=request.getParameter("id");
                                                                            String newsTitle="News Not Found" ; String
                                                                            newsImage="img/default.jpg" ; String
                                                                            newsBody="Content not available." ; String
                                                                            newsDate="Today" ; String newsTag="Update" ;
                                                                            if ("ultrafan".equals(newsId)) {
                                                                            newsTitle="Rolls-Royce Sukses Uji Coba Mesin UltraFan Terbesar"
                                                                            ; newsImage="img/jetEngine.jpg" ;
                                                                            newsTag="Tech Breakthrough" ;
                                                                            newsDate="24 Dec 2025" ;
                                                                            newsBody="<p><strong>Rolls-Royce UltraFan Engine</strong></p><p>Rolls-Royce has successfully completed ground testing of the UltraFan technology demonstrator, the world's largest aero-engine with a 140-inch fan diameter.</p><p>This revolutionary engine offers 25% better fuel efficiency and is compatible with 100% Sustainable Aviation Fuel (SAF).</p>"
                                                                            ; } else if ("overture".equals(newsId)) {
                                                                            newsTitle="Boom Supersonic: Overture Membawa Kembali Era Kecepatan"
                                                                            ; newsImage="img/supersonic.jpg" ;
                                                                            newsTag="Trending Now" ;
                                                                            newsDate="23 Dec 2025" ;
                                                                            newsBody="<p><strong>Denver, Colorado</strong> - Boom Supersonic semakin dekat untuk merealisasikan penerbangan komersial supersonik yang berkelanjutan. Pesawat andalan mereka, 'Overture', kini memasuki fase produksi awal.</p>"
                                                                            + "<p>Overture dirancang untuk terbang dengan kecepatan Mach 1.7, dua kali lebih cepat dari pesawat komersial saat ini. Artinya, penerbangan dari New York ke London hanya akan memakan waktu 3,5 jam.</p>"
                                                                            + "<p>Berbeda dengan Concorde, Overture dijanjikan akan ramah lingkungan dengan beroperasi menggunakan 100% SAF (Sustainable Aviation Fuel) dan memiliki mesin yang jauh lebih senyap berkat teknologi pengurangan kebisingan terbaru.</p>"
                                                                            ; } %>
                                                                            <div class="content-box">
                                                                                <a href="web?page=home"
                                                                                    style="display: inline-block; margin-bottom: 20px; color: #666; text-decoration: none;">&larr;
                                                                                    Kembali ke Dashboard</a>

                                                                                <div class="news-detail-header"
                                                                                    style="margin-bottom: 30px;">
                                                                                    <span class="news-tag"
                                                                                        style="background: #3498db; display: inline-block; margin-bottom: 10px;">
                                                                                        <%= newsTag %>
                                                                                    </span>
                                                                                    <h1
                                                                                        style="font-size: 2.2em; color: #2c3e50; margin: 0 0 10px;">
                                                                                        <%= newsTitle %>
                                                                                    </h1>
                                                                                    <span
                                                                                        style="color: #999; font-size: 0.9em;">Dipublikasikan
                                                                                        pada <%= newsDate %></span>
                                                                                </div>

                                                                                <div class="news-detail-image"
                                                                                    style="margin-bottom: 30px; border-radius: 12px; overflow: hidden; box-shadow: 0 10px 30px rgba(0,0,0,0.1);">
                                                                                    <img src="<%= newsImage %>"
                                                                                        style="width: 100%; display: block;"
                                                                                        alt="<%= newsTitle %>">
                                                                                </div>

                                                                                <div class="news-detail-body"
                                                                                    style="font-size: 1.1em; line-height: 1.8; color: #444;">
                                                                                    <%= newsBody %>
                                                                                </div>

                                                                                <hr
                                                                                    style="margin: 40px 0; border: 0; border-top: 1px solid #eee;">

                                                                                <h4 style="margin-bottom: 15px;">Baca
                                                                                    Juga:
                                                                                </h4>
                                                                                <div class="quick-links"
                                                                                    style="box-shadow: none; padding: 0; background: transparent;">
                                                                                    <a href="#" class="news-card-link"
                                                                                        style="flex: 1; margin-right: 15px;">
                                                                                        <div class="news-card"
                                                                                            style="padding: 15px; background: white; border-radius: 8px;">
                                                                                            <strong>Kategori Pesawat
                                                                                                Tempur</strong>
                                                                                            <p
                                                                                                style="font-size: 0.8em; margin: 5px 0 0;">
                                                                                                Lihat spesifikasi
                                                                                                alutsista
                                                                                                terbaru.</p>
                                                                                        </div>
                                                                                    </a>
                                                                                    <a href="#" class="news-card-link"
                                                                                        style="flex: 1;">
                                                                                        <div class="news-card"
                                                                                            style="padding: 15px; background: white; border-radius: 8px;">
                                                                                            <strong>Teknologi
                                                                                                Hijau</strong>
                                                                                            <p
                                                                                                style="font-size: 0.8em; margin: 5px 0 0;">
                                                                                                Masa depan penerbangan
                                                                                                ramah
                                                                                                lingkungan.</p>
                                                                                        </div>
                                                                                    </a>
                                                                                </div>
                                                                            </div>

                                                                            <!-- COMMENT SECTION - NEWS PAGE -->
                                                                            <% String newsTopik="News - " + (newsId
                                                                                !=null ? newsId : "General" );
                                                                                List<Models.komentar> newsKomentar =
                                                                                controller.komentarcontroller.getKomentarByTopik(newsTopik);
                                                                                %>
                                                                                <div class="content-box"
                                                                                    style="margin-top: 40px; border-top: 3px solid #667eea; padding-top: 40px;">
                                                                                    <h3
                                                                                        style="color: #2c3e50; margin-bottom: 25px; display: flex; align-items: center; gap: 10px; font-size: 1.5em;">
                                                                                        💬 <span>Diskusi Artikel</span>
                                                                                    </h3>

                                                                                    <div
                                                                                        style="background: #f8f9fa; padding: 25px; border-radius: 10px; margin-bottom: 30px;">
                                                                                        <form action="komentar"
                                                                                            method="POST">
                                                                                            <input type="hidden"
                                                                                                name="action"
                                                                                                value="tambah">
                                                                                            <input type="hidden"
                                                                                                name="topik_pesawat"
                                                                                                value="<%= newsTopik %>">

                                                                                            <label
                                                                                                style="font-weight: 600; display: block; margin-bottom: 12px; color: #2c3e50;">Apa
                                                                                                pendapat Anda tentang
                                                                                                artikel ini?</label>
                                                                                            <textarea
                                                                                                name="isi_komentar"
                                                                                                style="width: 100%; padding: 15px; border: 2px solid #e0e0e0; border-radius: 8px; font-family: inherit; font-size: 1em; resize: vertical;"
                                                                                                rows="5"
                                                                                                placeholder="Bagikan tanggapan Anda..."
                                                                                                required></textarea>

                                                                                            <div
                                                                                                style="margin-top: 15px; display: flex; justify-content: flex-end;">
                                                                                                <button type="submit"
                                                                                                    style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 12px 30px; border: none; border-radius: 8px; font-weight: bold; font-size: 1em; cursor: pointer; box-shadow: 0 4px 10px rgba(102, 126, 234, 0.3);">
                                                                                                    📤 Kirim Komentar
                                                                                                </button>
                                                                                            </div>
                                                                                        </form>
                                                                                    </div>

                                                                                    <div>
                                                                                        <h4
                                                                                            style="color: #555; margin-bottom: 20px; font-size: 1.2em;">
                                                                                            💭 Komentar Pembaca:</h4>
                                                                                        <% if (newsKomentar !=null &&
                                                                                            !newsKomentar.isEmpty()) {
                                                                                            for (Models.komentar k :
                                                                                            newsKomentar) { %>
                                                                                            <div
                                                                                                style="background: white; padding: 20px; border-radius: 10px; margin-bottom: 15px; border-left: 5px solid #667eea; box-shadow: 0 3px 10px rgba(0,0,0,0.06);">
                                                                                                <div
                                                                                                    style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px;">
                                                                                                    <span
                                                                                                        style="font-weight: 700; color: #667eea; font-size: 1.05em;">👤
                                                                                                        <%= k.getUsername()
                                                                                                            %>
                                                                                                    </span>
                                                                                                    <span
                                                                                                        style="color: #aaa; font-size: 0.9em;">🕒
                                                                                                        <%= k.getTanggalPost()
                                                                                                            %>
                                                                                                    </span>
                                                                                                </div>
                                                                                                <p
                                                                                                    style="margin: 0; color: #555; line-height: 1.7; font-size: 1.02em;">
                                                                                                    <%= k.getIsiKomentar()
                                                                                                        %>
                                                                                                </p>
                                                                                            </div>
                                                                                            <% } } else { %>
                                                                                                <div
                                                                                                    style="text-align: center; padding: 40px; color: #999; background: #f8f9fa; border-radius: 10px;">
                                                                                                    <p
                                                                                                        style="margin: 0; font-size: 1.15em;">
                                                                                                        📝 Belum ada
                                                                                                        komentar untuk
                                                                                                        artikel ini.</p>
                                                                                                    <p
                                                                                                        style="margin: 8px 0 0 0; font-size: 0.95em;">
                                                                                                        Jadilah yang
                                                                                                        pertama
                                                                                                        memberikan
                                                                                                        pendapat Anda!
                                                                                                    </p>
                                                                                                </div>
                                                                                                <% } %>
                                                                                    </div>
                                                                                </div>

                                                                                <% } else if
                                                                                    ("kategori".equals(activePage)) {
                                                                                    String
                                                                                    displayKategori=(currentKategori
                                                                                    !=null &&
                                                                                    !currentKategori.isEmpty()) ?
                                                                                    currentKategori.toUpperCase()
                                                                                    : "KOMERSIAL" ; %>
                                                                                    <div class="content-box">
                                                                                        <%-- 1. Judul Dinamis dengan
                                                                                            Penanganan Null --%>
                                                                                            <h3 class="dashboard-header"
                                                                                                style="text-transform: uppercase; font-weight: bold; border-bottom: 2px solid #3498db; padding-bottom: 10px; margin-bottom: 20px;">
                                                                                                DATA PESAWAT <%=
                                                                                                    displayKategori %>
                                                                                                    <% if
                                                                                                        (!displaySub.isEmpty())
                                                                                                        { %>
                                                                                                        <span
                                                                                                            style="color: #7f8c8d;">
                                                                                                            -
                                                                                                            <%= displaySub
                                                                                                                %>
                                                                                                        </span>
                                                                                                        <% } %>
                                                                                            </h3>


                                                                                            <%-- 2. Logika Gambar Utama
                                                                                                --%>
                                                                                                <div class="image-container"
                                                                                                    style="margin-bottom: 25px; text-align: center;">
                                                                                                    <% String
                                                                                                        imageUrl="https://images.unsplash.com/photo-1569154941061-e231b4725ef1?w=1200"
                                                                                                        ; if
                                                                                                        ("tempur".equalsIgnoreCase(currentKategori))
                                                                                                        {
                                                                                                        imageUrl="https://images.unsplash.com/photo-1517976384346-3136801d605d?w=1200"
                                                                                                        ; if
                                                                                                        ("pesawat_jet".equals(currentSub))
                                                                                                        {
                                                                                                        imageUrl="https://images.unsplash.com/photo-1527482823611-664429938360?w=1200"
                                                                                                        ; } else if
                                                                                                        ("pesawat_bomber".equals(currentSub))
                                                                                                        {
                                                                                                        imageUrl="https://images.unsplash.com/photo-1516738901171-8eb4fc13bd20?w=1200"
                                                                                                        ; } else if
                                                                                                        ("pesawat_tempur_sergap".equals(currentSub))
                                                                                                        {
                                                                                                        imageUrl="https://images.unsplash.com/photo-1470218091926-22a08a325802?w=1200"
                                                                                                        ; } } else if
                                                                                                        ("kargo".equalsIgnoreCase(currentKategori))
                                                                                                        {
                                                                                                        imageUrl="img/boeing737.jpeg"
                                                                                                        ; if
                                                                                                        ("Boeing_737-800F".equals(currentSub))
                                                                                                        {
                                                                                                        imageUrl="img/boeing737.jpeg"
                                                                                                        ; } else if
                                                                                                        ("Airbus_A321F".equals(currentSub))
                                                                                                        {
                                                                                                        imageUrl="img/airbusa321f.jpeg"
                                                                                                        ; } else if
                                                                                                        ("Antonov_An-124".equals(currentSub))
                                                                                                        {
                                                                                                        imageUrl="img/antonov.jpeg"
                                                                                                        ; } } else {
                                                                                                        imageUrl="https://images.unsplash.com/photo-1544016768-982d1554f0b9?w=1200"
                                                                                                        ; if
                                                                                                        ("penumpang".equals(currentSub))
                                                                                                        {
                                                                                                        imageUrl="https://images.unsplash.com/photo-1520437358207-323b43b50729?w=1200"
                                                                                                        ; } else if
                                                                                                        ("private_jet".equals(currentSub))
                                                                                                        {
                                                                                                        imageUrl="https://images.unsplash.com/photo-1542296332-2b4473faf563?w=1200"
                                                                                                        ; } } %>
                                                                                                        <img src="<%= imageUrl %>"
                                                                                                            alt="Foto Unit Pesawat"
                                                                                                            class="large-image"
                                                                                                            style="width: 100%; height: 380px; object-fit: cover; border-radius: 12px; box-shadow: 0 6px 15px rgba(0,0,0,0.15); transition: 0.3s;">
                                                                                                </div>

                                                                                                <%-- 3. Tombol Navigasi
                                                                                                    Sub-Unit Dinamis
                                                                                                    --%>
                                                                                                    <div class="unit-selector"
                                                                                                        style="text-align: center; background: #fdfdfd; padding: 20px; border-radius: 10px; border: 1px solid #eee; margin-bottom: 20px;">
                                                                                                        <p
                                                                                                            style="margin-bottom: 15px; font-weight: 600; color: #2c3e50;">
                                                                                                            Pilih Jenis
                                                                                                            Unit
                                                                                                            Pesawat
                                                                                                            <%=(currentKategori
                                                                                                                !=null)
                                                                                                                ?
                                                                                                                currentKategori.substring(0,
                                                                                                                1).toUpperCase()
                                                                                                                +
                                                                                                                currentKategori.substring(1).toLowerCase()
                                                                                                                : "Komersial"
                                                                                                                %>
                                                                                                                :
                                                                                                        </p>

                                                                                                        <%-- Keterangan
                                                                                                            Halaman --%>
                                                                                                            <div
                                                                                                                style="text-align: center; color: #7f8c8d; font-size: 0.95em; background: #fff; padding: 10px; border-radius: 5px;">
                                                                                                                Menampilkan
                                                                                                                data
                                                                                                                untuk
                                                                                                                kategori
                                                                                                                <strong>
                                                                                                                    <%= (currentKategori
                                                                                                                        !=null)
                                                                                                                        ?
                                                                                                                        currentKategori.toUpperCase()
                                                                                                                        : "KOMERSIAL"
                                                                                                                        %>
                                                                                                                </strong>
                                                                                                                <% if
                                                                                                                    (currentSub
                                                                                                                    !=null
                                                                                                                    &&
                                                                                                                    !currentSub.isEmpty())
                                                                                                                    {%>
                                                                                                                    -
                                                                                                                    Jenis
                                                                                                                    Unit:
                                                                                                                    <strong>
                                                                                                                        <%= currentSub.replace("_", " "
                                                                                                                            ).toUpperCase()%>
                                                                                                                    </strong>
                                                                                                                    <% } else
                                                                                                                        {
                                                                                                                        %>
                                                                                                                        (Semua
                                                                                                                        Unit)
                                                                                                                        <% }
                                                                                                                            %>
                                                                                                            </div>
                                                                                                    </div>
                                                                                                    <% } %>

                                                                                                        <!-- Kategori Main Content Part 2 Start -->
                                                                                                        <% if
                                                                                                            (activePage.equals("kategori"))
                                                                                                            {%>
                                                                                                            <div>
                                                                                                                <div
                                                                                                                    class="content-box">
                                                                                                                    <!-- Horizontal Category Tabs -->
                                                                                                                    <div
                                                                                                                        class="category-tabs">
                                                                                                                        <a href="web?page=kategori&type=komersial"
                                                                                                                            class="category-tab <%= "komersial".equals(currentKategori)
                                                                                                                            ? "active-tab"
                                                                                                                            : ""
                                                                                                                            %>">
                                                                                                                            <span>✈️</span>
                                                                                                                            Pesawat
                                                                                                                            Komersial
                                                                                                                        </a>
                                                                                                                        <a href="web?page=kategori&type=tempur"
                                                                                                                            class="category-tab <%= "tempur".equals(currentKategori)
                                                                                                                            ? "active-tab"
                                                                                                                            : ""
                                                                                                                            %>">
                                                                                                                            <span>⚔️</span>
                                                                                                                            Pesawat
                                                                                                                            Tempur
                                                                                                                        </a>
                                                                                                                        <a href="web?page=kategori&type=kargo"
                                                                                                                            class="category-tab <%= "kargo".equals(currentKategori)
                                                                                                                            ? "active-tab"
                                                                                                                            : ""
                                                                                                                            %>">
                                                                                                                            <span>📦</span>
                                                                                                                            Pesawat
                                                                                                                            Kargo
                                                                                                                        </a>
                                                                                                                    </div>

                                                                                                                    <h3
                                                                                                                        class="dashboard-header">
                                                                                                                        <%=
                                                                                                                            tableTitle%>
                                                                                                                    </h3>

                                                                                                                    <%-- LOGIKA
                                                                                                                        DESKRIPSI
                                                                                                                        DINAMIS
                                                                                                                        --%>
                                                                                                                        <% String
                                                                                                                            deskripsiPesawat=""
                                                                                                                            ;
                                                                                                                            if
                                                                                                                            ("Airbus_A350".equals(currentSub))
                                                                                                                            {
                                                                                                                            deskripsiPesawat="<strong>Airbus A350 XWB</strong> adalah keluarga pesawat jet berbadan lebar jarak jauh yang dikembangkan oleh Airbus. Pesawat ini dikenal dengan efisiensi bahan bakarnya yang tinggi berkat penggunaan material komposit serat karbon canggih pada badan dan sayapnya. A350 menawarkan kenyamanan kabin superior dengan kelembapan udara yang lebih tinggi dan tekanan kabin yang lebih rendah."
                                                                                                                            ;
                                                                                                                            }
                                                                                                                            else
                                                                                                                            if
                                                                                                                            ("Boeing_787".equals(currentSub))
                                                                                                                            {
                                                                                                                            deskripsiPesawat="<strong>Boeing 787 Dreamliner</strong> adalah pesawat jet berbadan lebar revolusioner yang mengutamakan efisiensi dan kenyamanan penumpang. Dengan jendela kabin terbesar di industri dan sistem pencahayaan LED dinamis, 787 dirancang untuk mengurangi jetlag dan memberikan pengalaman terbang yang tak tertandingi."
                                                                                                                            ;
                                                                                                                            }
                                                                                                                            else
                                                                                                                            if
                                                                                                                            ("Airbus_A380".equals(currentSub))
                                                                                                                            {
                                                                                                                            deskripsiPesawat="<strong>Airbus A380</strong> adalah pesawat penumpang terbesar di dunia, sebuah keajaiban teknik dengan dek ganda penuh. Pesawat raksasa ini mampu mengangkut lebih dari 500 penumpang dalam konfigurasi tiga kelas standar, menawarkan kemewahan dan ruang yang belum pernah ada sebelumnya di angkasa."
                                                                                                                            ;
                                                                                                                            }
                                                                                                                            else
                                                                                                                            if
                                                                                                                            ("F-35".equals(currentSub))
                                                                                                                            {
                                                                                                                            deskripsiPesawat="<strong>Lockheed Martin F-35 Lightning II</strong> adalah pesawat tempur siluman multiperan generasi ke-5 yang paling canggih di dunia. Menggabungkan kemampuan siluman mutakhir, kecepatan supersonik, dan kelincahan ekstrem, F-35 dirancang untuk mendominasi pertempuran udara dan serangan darat."
                                                                                                                            ;
                                                                                                                            }
                                                                                                                            else
                                                                                                                            if
                                                                                                                            ("Sukhoi_Su-27SK".equals(currentSub))
                                                                                                                            {
                                                                                                                            deskripsiPesawat="<strong>Sukhoi Su-27SK</strong> adalah varian ekspor dari pesawat tempur superioritas udara legendaris Rusia. Dikenal dengan manuverabilitas supernya (cobra maneuver), pesawat ini memiliki jangkauan jarak jauh dan kemampuan membawa muatan senjata berat."
                                                                                                                            ;
                                                                                                                            }
                                                                                                                            else
                                                                                                                            if
                                                                                                                            ("Lockheed_F-117A".equals(currentSub))
                                                                                                                            {
                                                                                                                            deskripsiPesawat="<strong>F-117A Nighthawk</strong> adalah pesawat operasional pertama di dunia yang dirancang sepenuhnya berdasarkan teknologi siluman (stealth). Bentuknya yang unik dirancang untuk memantulkan gelombang radar, menjadikannya hampir tak terlihat oleh sistem pertahanan musuh."
                                                                                                                            ;
                                                                                                                            }
                                                                                                                            else
                                                                                                                            if
                                                                                                                            ("Boeing_737-800F".equals(currentSub))
                                                                                                                            {
                                                                                                                            deskripsiPesawat="<strong>Boeing 737-800BCF (Boeing Converted Freighter)</strong> adalah tulang punggung logistik kargo jarak menengah. Pesawat ini menawarkan efisiensi operasional tinggi dan kapasitas angkut yang fleksibel, menjadikannya pilihan utama bagi maskapai kargo ekspres global."
                                                                                                                            ;
                                                                                                                            }
                                                                                                                            else
                                                                                                                            if
                                                                                                                            ("Airbus_A321F".equals(currentSub))
                                                                                                                            {
                                                                                                                            deskripsiPesawat="<strong>Airbus A321P2F (Passenger to Freighter)</strong> adalah solusi kargo modern yang menawarkan kapasitas volume terbaik di kelasnya. Dengan kemampuan memuat kontainer di dek utama dan dek bawah, pesawat ini sangat efisien untuk operasi logistik e-commerce."
                                                                                                                            ;
                                                                                                                            }
                                                                                                                            else
                                                                                                                            if
                                                                                                                            ("Antonov_An-124".equals(currentSub))
                                                                                                                            {
                                                                                                                            deskripsiPesawat="<strong>Antonov An-124 Ruslan</strong> adalah salah satu pesawat kargo militer strategis terbesar di dunia. Dengan kemampuan membuka hidung pesawat (nose cargo door) untuk memuat kargo berukuran raksasa, An-124 sering digunakan untuk misi kemanusiaan dan pengangkutan alat berat."
                                                                                                                            ;
                                                                                                                            }
                                                                                                                            %>
                                                                                                                            <% if
                                                                                                                                (!deskripsiPesawat.isEmpty())
                                                                                                                                {
                                                                                                                                %>
                                                                                                                                <div class="description-box"
                                                                                                                                    style="background: #fff; padding: 25px; border-radius: 10px; margin-bottom: 25px; border-left: 6px solid #ffcc00; box-shadow: 0 4px 15px rgba(0,0,0,0.05);">
                                                                                                                                    <h4
                                                                                                                                        style="margin-top: 0; color: #2c3e50; font-size: 1.2em; margin-bottom: 10px;">
                                                                                                                                        📖
                                                                                                                                        Mengenal
                                                                                                                                        Lebih
                                                                                                                                        Dekat
                                                                                                                                    </h4>
                                                                                                                                    <p
                                                                                                                                        style="color: #555; line-height: 1.7; font-size: 1.05em; margin: 0;">
                                                                                                                                        <%= deskripsiPesawat
                                                                                                                                            %>
                                                                                                                                    </p>
                                                                                                                                </div>
                                                                                                                                <% }
                                                                                                                                    %>

                                                                                                                                    <!-- Unit Selector - Moved here from sidebar -->
                                                                                                                                    <div
                                                                                                                                        style="margin-bottom: 20px;">
                                                                                                                                        <label
                                                                                                                                            for="unitSelector"
                                                                                                                                            style="display:block; font-weight:bold; margin-bottom:8px; color:#2c3e50;">Pilih
                                                                                                                                            Jenis
                                                                                                                                            Unit:</label>
                                                                                                                                        <select
                                                                                                                                            id="unitSelector"
                                                                                                                                            onchange="location.href = this.value;"
                                                                                                                                            style="width:100%; padding: 12px; border: 1px solid #ccc; border-radius: 4px; font-size: 14px;">
                                                                                                                                            <option
                                                                                                                                                value="web?page=kategori&type=<%= currentKategori != null ? currentKategori : "komersial"
                                                                                                                                                %>
                                                                                                                                                ">--
                                                                                                                                                Semua
                                                                                                                                                Unit
                                                                                                                                                --
                                                                                                                                            </option>
                                                                                                                                            <% if
                                                                                                                                                ("komersial".equals(currentKategori))
                                                                                                                                                {%>
                                                                                                                                                <option
                                                                                                                                                    value="web?page=kategori&type=komersial&sub=Airbus_A350"
                                                                                                                                                    <%="Airbus_A350"
                                                                                                                                                    .equals(currentSub)
                                                                                                                                                    ? "selected"
                                                                                                                                                    : ""
                                                                                                                                                    %>
                                                                                                                                                    >Airbus
                                                                                                                                                    A350
                                                                                                                                                </option>
                                                                                                                                                <option
                                                                                                                                                    value="web?page=kategori&type=komersial&sub=Boeing_787"
                                                                                                                                                    <%="Boeing_787"
                                                                                                                                                    .equals(currentSub)
                                                                                                                                                    ? "selected"
                                                                                                                                                    : ""
                                                                                                                                                    %>
                                                                                                                                                    >Boeing
                                                                                                                                                    787
                                                                                                                                                </option>
                                                                                                                                                <option
                                                                                                                                                    value="web?page=kategori&type=komersial&sub=Airbus_A380"
                                                                                                                                                    <%="Airbus_A380"
                                                                                                                                                    .equals(currentSub)
                                                                                                                                                    ? "selected"
                                                                                                                                                    : ""
                                                                                                                                                    %>
                                                                                                                                                    >Airbus
                                                                                                                                                    A380
                                                                                                                                                </option>
                                                                                                                                                <% } else
                                                                                                                                                    if
                                                                                                                                                    ("tempur".equals(currentKategori))
                                                                                                                                                    {%>
                                                                                                                                                    <option
                                                                                                                                                        value="web?page=kategori&type=tempur&sub=F-35"
                                                                                                                                                        <%="F-35"
                                                                                                                                                        .equals(currentSub)
                                                                                                                                                        ? "selected"
                                                                                                                                                        : ""
                                                                                                                                                        %>
                                                                                                                                                        >F-35
                                                                                                                                                        Lightning
                                                                                                                                                        II
                                                                                                                                                    </option>
                                                                                                                                                    <option
                                                                                                                                                        value="web?page=kategori&type=tempur&sub=Sukhoi_Su-27SK"
                                                                                                                                                        <%="Sukhoi_Su-27SK"
                                                                                                                                                        .equals(currentSub)
                                                                                                                                                        ? "selected"
                                                                                                                                                        : ""
                                                                                                                                                        %>
                                                                                                                                                        >Sukhoi
                                                                                                                                                        Su-27SK
                                                                                                                                                    </option>
                                                                                                                                                    <option
                                                                                                                                                        value="web?page=kategori&type=tempur&sub=Lockheed_F-117A"
                                                                                                                                                        <%="Lockheed_F-117A"
                                                                                                                                                        .equals(currentSub)
                                                                                                                                                        ? "selected"
                                                                                                                                                        : ""
                                                                                                                                                        %>
                                                                                                                                                        >Lockheed
                                                                                                                                                        F-117A
                                                                                                                                                    </option>
                                                                                                                                                    <% } else
                                                                                                                                                        if
                                                                                                                                                        ("kargo".equals(currentKategori))
                                                                                                                                                        {%>
                                                                                                                                                        <option
                                                                                                                                                            value="web?page=kategori&type=kargo&sub=Boeing_737-800F"
                                                                                                                                                            <%="Boeing_737-800F"
                                                                                                                                                            .equals(currentSub)
                                                                                                                                                            ? "selected"
                                                                                                                                                            : ""
                                                                                                                                                            %>
                                                                                                                                                            >Boeing
                                                                                                                                                            737-800F
                                                                                                                                                        </option>
                                                                                                                                                        <option
                                                                                                                                                            value="web?page=kategori&type=kargo&sub=Airbus_A321F"
                                                                                                                                                            <%="Airbus_A321F"
                                                                                                                                                            .equals(currentSub)
                                                                                                                                                            ? "selected"
                                                                                                                                                            : ""
                                                                                                                                                            %>
                                                                                                                                                            >Airbus
                                                                                                                                                            A321F
                                                                                                                                                        </option>
                                                                                                                                                        <option
                                                                                                                                                            value="web?page=kategori&type=kargo&sub=Antonov_An-124"
                                                                                                                                                            <%="Antonov_An-124"
                                                                                                                                                            .equals(currentSub)
                                                                                                                                                            ? "selected"
                                                                                                                                                            : ""
                                                                                                                                                            %>
                                                                                                                                                            >Antonov
                                                                                                                                                            An-124
                                                                                                                                                        </option>
                                                                                                                                                        <% }
                                                                                                                                                            %>
                                                                                                                                        </select>
                                                                                                                                    </div>

                                                                                                                                    <input
                                                                                                                                        type="text"
                                                                                                                                        id="searchInput"
                                                                                                                                        onkeyup="searchTable()"
                                                                                                                                        placeholder="Cari data pesawat..."
                                                                                                                                        style="width: 100%; padding: 12px 20px; margin: 0 0 20px 0; display: inline-block; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box;">
                                                                                                                                    <table
                                                                                                                                        class="data-table">
                                                                                                                                        <thead>
                                                                                                                                            <tr>
                                                                                                                                                <th onclick="sortTable(0)"
                                                                                                                                                    style="cursor:pointer">
                                                                                                                                                    Kode
                                                                                                                                                    &#x21C5;
                                                                                                                                                </th>
                                                                                                                                                <th onclick="sortTable(1)"
                                                                                                                                                    style="cursor:pointer">
                                                                                                                                                    Jenis
                                                                                                                                                    Pesawat
                                                                                                                                                    &#x21C5;
                                                                                                                                                </th>
                                                                                                                                                <th onclick="sortTable(2)"
                                                                                                                                                    style="cursor:pointer">
                                                                                                                                                    Operator
                                                                                                                                                    &#x21C5;
                                                                                                                                                </th>
                                                                                                                                                <th onclick="sortTable(3)"
                                                                                                                                                    style="cursor:pointer">
                                                                                                                                                    Mesin
                                                                                                                                                    &#x21C5;
                                                                                                                                                </th>
                                                                                                                                                <th onclick="sortTable(4)"
                                                                                                                                                    style="cursor:pointer">
                                                                                                                                                    Pabrikan
                                                                                                                                                    &#x21C5;
                                                                                                                                                </th>
                                                                                                                                                <th onclick="sortTable(5)"
                                                                                                                                                    style="cursor:pointer">
                                                                                                                                                    Tahun
                                                                                                                                                    &#x21C5;
                                                                                                                                                </th>
                                                                                                                                                <th onclick="sortTable(6)"
                                                                                                                                                    style="cursor:pointer">
                                                                                                                                                    Negara
                                                                                                                                                    &#x21C5;
                                                                                                                                                </th>
                                                                                                                                            </tr>
                                                                                                                                        </thead>
                                                                                                                                        <tbody>
                                                                                                                                            <!-- Boeing 787 - Komersial -->
                                                                                                                                            <% if
                                                                                                                                                ("komersial".equals(currentKategori)
                                                                                                                                                &&
                                                                                                                                                (currentSub==null
                                                                                                                                                ||
                                                                                                                                                currentSub.isEmpty()
                                                                                                                                                || "Boeing_787"
                                                                                                                                                .equals(currentSub)))
                                                                                                                                                {
                                                                                                                                                %>
                                                                                                                                                <tr>
                                                                                                                                                    <td>JA873A
                                                                                                                                                    </td>
                                                                                                                                                    <td>Boeing
                                                                                                                                                        787-9
                                                                                                                                                        Dreamliner
                                                                                                                                                    </td>
                                                                                                                                                    <td>All
                                                                                                                                                        Nippon
                                                                                                                                                        Airways
                                                                                                                                                    </td>
                                                                                                                                                    <td>GEnx-1B
                                                                                                                                                    </td>
                                                                                                                                                    <td>Boeing
                                                                                                                                                    </td>
                                                                                                                                                    <td>2014
                                                                                                                                                    </td>
                                                                                                                                                    <td>Jepang
                                                                                                                                                    </td>
                                                                                                                                                </tr>
                                                                                                                                                <% }
                                                                                                                                                    %>

                                                                                                                                                    <!-- Airbus A350 - Komersial -->
                                                                                                                                                    <% if
                                                                                                                                                        ("komersial".equals(currentKategori)
                                                                                                                                                        &&
                                                                                                                                                        (currentSub==null
                                                                                                                                                        ||
                                                                                                                                                        currentSub.isEmpty()
                                                                                                                                                        || "Airbus_A350"
                                                                                                                                                        .equals(currentSub)))
                                                                                                                                                        {
                                                                                                                                                        %>
                                                                                                                                                        <tr>
                                                                                                                                                            <td>F-WNZF
                                                                                                                                                            </td>
                                                                                                                                                            <td>Airbus
                                                                                                                                                                A350-900
                                                                                                                                                            </td>
                                                                                                                                                            <td>Airbus
                                                                                                                                                                Test
                                                                                                                                                                Fleet
                                                                                                                                                            </td>
                                                                                                                                                            <td>Trent
                                                                                                                                                                XWB
                                                                                                                                                            </td>
                                                                                                                                                            <td>Airbus
                                                                                                                                                            </td>
                                                                                                                                                            <td>2013
                                                                                                                                                            </td>
                                                                                                                                                            <td>Prancis
                                                                                                                                                            </td>
                                                                                                                                                        </tr>
                                                                                                                                                        <tr>
                                                                                                                                                            <td>9V-SMC
                                                                                                                                                            </td>
                                                                                                                                                            <td>Airbus
                                                                                                                                                                A350-900
                                                                                                                                                            </td>
                                                                                                                                                            <td>Singapore
                                                                                                                                                                Airlines
                                                                                                                                                            </td>
                                                                                                                                                            <td>Trent
                                                                                                                                                                XWB
                                                                                                                                                            </td>
                                                                                                                                                            <td>Airbus
                                                                                                                                                            </td>
                                                                                                                                                            <td>2016
                                                                                                                                                            </td>
                                                                                                                                                            <td>Singapura
                                                                                                                                                            </td>
                                                                                                                                                        </tr>
                                                                                                                                                        <tr>
                                                                                                                                                            <td>A7-ALA
                                                                                                                                                            </td>
                                                                                                                                                            <td>Airbus
                                                                                                                                                                A350-900
                                                                                                                                                            </td>
                                                                                                                                                            <td>Qatar
                                                                                                                                                                Airways
                                                                                                                                                            </td>
                                                                                                                                                            <td>Trent
                                                                                                                                                                XWB
                                                                                                                                                            </td>
                                                                                                                                                            <td>Airbus
                                                                                                                                                            </td>
                                                                                                                                                            <td>2014
                                                                                                                                                            </td>
                                                                                                                                                            <td>Qatar
                                                                                                                                                            </td>
                                                                                                                                                        </tr>
                                                                                                                                                        <% }
                                                                                                                                                            %>

                                                                                                                                                            <!-- Airbus A380 - Komersial -->
                                                                                                                                                            <% if
                                                                                                                                                                ("komersial".equals(currentKategori)
                                                                                                                                                                &&
                                                                                                                                                                (currentSub==null
                                                                                                                                                                ||
                                                                                                                                                                currentSub.isEmpty()
                                                                                                                                                                || "Airbus_A380"
                                                                                                                                                                .equals(currentSub)))
                                                                                                                                                                {
                                                                                                                                                                %>
                                                                                                                                                                <tr>
                                                                                                                                                                    <td>A6-EEO
                                                                                                                                                                    </td>
                                                                                                                                                                    <td>Airbus
                                                                                                                                                                        A380-800
                                                                                                                                                                    </td>
                                                                                                                                                                    <td>Emirates
                                                                                                                                                                    </td>
                                                                                                                                                                    <td>GP7200
                                                                                                                                                                    </td>
                                                                                                                                                                    <td>Airbus
                                                                                                                                                                    </td>
                                                                                                                                                                    <td>2012
                                                                                                                                                                    </td>
                                                                                                                                                                    <td>UEA
                                                                                                                                                                    </td>
                                                                                                                                                                </tr>
                                                                                                                                                                <% }
                                                                                                                                                                    %>

                                                                                                                                                                    <!-- F-35 - Tempur -->
                                                                                                                                                                    <% if
                                                                                                                                                                        ("tempur".equals(currentKategori)
                                                                                                                                                                        &&
                                                                                                                                                                        (currentSub==null
                                                                                                                                                                        ||
                                                                                                                                                                        currentSub.isEmpty()
                                                                                                                                                                        || "F-35"
                                                                                                                                                                        .equals(currentSub)))
                                                                                                                                                                        {
                                                                                                                                                                        %>
                                                                                                                                                                        <tr>
                                                                                                                                                                            <td>AF-01
                                                                                                                                                                            </td>
                                                                                                                                                                            <td>F-35A
                                                                                                                                                                                Lightning
                                                                                                                                                                                II
                                                                                                                                                                            </td>
                                                                                                                                                                            <td>US
                                                                                                                                                                                Air
                                                                                                                                                                                Force
                                                                                                                                                                            </td>
                                                                                                                                                                            <td>P&W
                                                                                                                                                                                F135
                                                                                                                                                                            </td>
                                                                                                                                                                            <td>Lockheed
                                                                                                                                                                                Martin
                                                                                                                                                                            </td>
                                                                                                                                                                            <td>2006
                                                                                                                                                                            </td>
                                                                                                                                                                            <td>Amerika
                                                                                                                                                                                Serikat
                                                                                                                                                                            </td>
                                                                                                                                                                        </tr>
                                                                                                                                                                        <% }
                                                                                                                                                                            %>

                                                                                                                                                                            <!-- Sukhoi Su-27SK - Tempur -->
                                                                                                                                                                            <% if
                                                                                                                                                                                ("tempur".equals(currentKategori)
                                                                                                                                                                                &&
                                                                                                                                                                                (currentSub==null
                                                                                                                                                                                ||
                                                                                                                                                                                currentSub.isEmpty()
                                                                                                                                                                                || "Sukhoi_Su-27SK"
                                                                                                                                                                                .equals(currentSub)))
                                                                                                                                                                                {
                                                                                                                                                                                %>
                                                                                                                                                                                <tr>
                                                                                                                                                                                    <td>TS-2701
                                                                                                                                                                                    </td>
                                                                                                                                                                                    <td>Sukhoi
                                                                                                                                                                                        Su-27SK
                                                                                                                                                                                    </td>
                                                                                                                                                                                    <td>TNI
                                                                                                                                                                                        Angkatan
                                                                                                                                                                                        Udara
                                                                                                                                                                                    </td>
                                                                                                                                                                                    <td>Lyulka
                                                                                                                                                                                        AL-31F
                                                                                                                                                                                    </td>
                                                                                                                                                                                    <td>Sukhoi
                                                                                                                                                                                    </td>
                                                                                                                                                                                    <td>2003
                                                                                                                                                                                    </td>
                                                                                                                                                                                    <td>Rusia
                                                                                                                                                                                    </td>
                                                                                                                                                                                </tr>
                                                                                                                                                                                <% }
                                                                                                                                                                                    %>

                                                                                                                                                                                    <!-- Lockheed F-117A - Tempur -->
                                                                                                                                                                                    <% if
                                                                                                                                                                                        ("tempur".equals(currentKategori)
                                                                                                                                                                                        &&
                                                                                                                                                                                        (currentSub==null
                                                                                                                                                                                        ||
                                                                                                                                                                                        currentSub.isEmpty()
                                                                                                                                                                                        || "Lockheed_F-117A"
                                                                                                                                                                                        .equals(currentSub)))
                                                                                                                                                                                        {
                                                                                                                                                                                        %>
                                                                                                                                                                                        <tr>
                                                                                                                                                                                            <td>82-0806
                                                                                                                                                                                            </td>
                                                                                                                                                                                            <td>F-117A
                                                                                                                                                                                                Nighthawk
                                                                                                                                                                                            </td>
                                                                                                                                                                                            <td>US
                                                                                                                                                                                                Air
                                                                                                                                                                                                Force
                                                                                                                                                                                            </td>
                                                                                                                                                                                            <td>GE
                                                                                                                                                                                                F404
                                                                                                                                                                                            </td>
                                                                                                                                                                                            <td>Lockheed
                                                                                                                                                                                                Martin
                                                                                                                                                                                            </td>
                                                                                                                                                                                            <td>1982
                                                                                                                                                                                            </td>
                                                                                                                                                                                            <td>Amerika
                                                                                                                                                                                                Serikat
                                                                                                                                                                                            </td>
                                                                                                                                                                                        </tr>
                                                                                                                                                                                        <% }
                                                                                                                                                                                            %>

                                                                                                                                                                                            <!-- Boeing 737-800F - Kargo -->
                                                                                                                                                                                            <% if
                                                                                                                                                                                                ("kargo".equals(currentKategori)
                                                                                                                                                                                                &&
                                                                                                                                                                                                (currentSub==null
                                                                                                                                                                                                ||
                                                                                                                                                                                                currentSub.isEmpty()
                                                                                                                                                                                                || "Boeing_737-800F"
                                                                                                                                                                                                .equals(currentSub)))
                                                                                                                                                                                                {
                                                                                                                                                                                                %>
                                                                                                                                                                                                <tr>
                                                                                                                                                                                                    <td>N858AZ
                                                                                                                                                                                                    </td>
                                                                                                                                                                                                    <td>Boeing
                                                                                                                                                                                                        737-800F
                                                                                                                                                                                                    </td>
                                                                                                                                                                                                    <td>Amazon
                                                                                                                                                                                                        Air
                                                                                                                                                                                                    </td>
                                                                                                                                                                                                    <td>CFM56-7B
                                                                                                                                                                                                    </td>
                                                                                                                                                                                                    <td>Boeing
                                                                                                                                                                                                    </td>
                                                                                                                                                                                                    <td>2018
                                                                                                                                                                                                    </td>
                                                                                                                                                                                                    <td>Amerika
                                                                                                                                                                                                        Serikat
                                                                                                                                                                                                    </td>
                                                                                                                                                                                                </tr>
                                                                                                                                                                                                <% }
                                                                                                                                                                                                    %>

                                                                                                                                                                                                    <!-- Airbus A321F - Kargo -->
                                                                                                                                                                                                    <% if
                                                                                                                                                                                                        ("kargo".equals(currentKategori)
                                                                                                                                                                                                        &&
                                                                                                                                                                                                        (currentSub==null
                                                                                                                                                                                                        ||
                                                                                                                                                                                                        currentSub.isEmpty()
                                                                                                                                                                                                        || "Airbus_A321F"
                                                                                                                                                                                                        .equals(currentSub)))
                                                                                                                                                                                                        {
                                                                                                                                                                                                        %>
                                                                                                                                                                                                        <tr>
                                                                                                                                                                                                            <td>D-AEUC
                                                                                                                                                                                                            </td>
                                                                                                                                                                                                            <td>Airbus
                                                                                                                                                                                                                A321-200P2F
                                                                                                                                                                                                            </td>
                                                                                                                                                                                                            <td>Lufthansa
                                                                                                                                                                                                                Cargo
                                                                                                                                                                                                            </td>
                                                                                                                                                                                                            <td>IAE
                                                                                                                                                                                                                V2500
                                                                                                                                                                                                            </td>
                                                                                                                                                                                                            <td>Airbus
                                                                                                                                                                                                            </td>
                                                                                                                                                                                                            <td>2021
                                                                                                                                                                                                            </td>
                                                                                                                                                                                                            <td>Jerman
                                                                                                                                                                                                            </td>
                                                                                                                                                                                                        </tr>
                                                                                                                                                                                                        <% }
                                                                                                                                                                                                            %>

                                                                                                                                                                                                            <!-- Antonov An-124 - Kargo -->
                                                                                                                                                                                                            <% if
                                                                                                                                                                                                                ("kargo".equals(currentKategori)
                                                                                                                                                                                                                &&
                                                                                                                                                                                                                (currentSub==null
                                                                                                                                                                                                                ||
                                                                                                                                                                                                                currentSub.isEmpty()
                                                                                                                                                                                                                || "Antonov_An-124"
                                                                                                                                                                                                                .equals(currentSub)))
                                                                                                                                                                                                                {
                                                                                                                                                                                                                %>
                                                                                                                                                                                                                <tr>
                                                                                                                                                                                                                    <td>UR-82007
                                                                                                                                                                                                                    </td>
                                                                                                                                                                                                                    <td>Antonov
                                                                                                                                                                                                                        An-124
                                                                                                                                                                                                                        Ruslan
                                                                                                                                                                                                                    </td>
                                                                                                                                                                                                                    <td>Antonov
                                                                                                                                                                                                                        Airlines
                                                                                                                                                                                                                    </td>
                                                                                                                                                                                                                    <td>Progress
                                                                                                                                                                                                                        D-18T
                                                                                                                                                                                                                    </td>
                                                                                                                                                                                                                    <td>Antonov
                                                                                                                                                                                                                    </td>
                                                                                                                                                                                                                    <td>1982
                                                                                                                                                                                                                    </td>
                                                                                                                                                                                                                    <td>Ukraina
                                                                                                                                                                                                                    </td>
                                                                                                                                                                                                                </tr>
                                                                                                                                                                                                                <% }
                                                                                                                                                                                                                    %>

                                                                                                                                                                                                                    <% if
                                                                                                                                                                                                                        (listPesawat
                                                                                                                                                                                                                        !=null
                                                                                                                                                                                                                        &&
                                                                                                                                                                                                                        !listPesawat.isEmpty())
                                                                                                                                                                                                                        {
                                                                                                                                                                                                                        for
                                                                                                                                                                                                                        (Pesawat
                                                                                                                                                                                                                        p
                                                                                                                                                                                                                        :
                                                                                                                                                                                                                        listPesawat)
                                                                                                                                                                                                                        {
                                                                                                                                                                                                                        %>
                                                                                                                                                                                                                        <tr>
                                                                                                                                                                                                                            <td>
                                                                                                                                                                                                                                <%= (p.getKodePesawat()
                                                                                                                                                                                                                                    !=null)
                                                                                                                                                                                                                                    ?
                                                                                                                                                                                                                                    p.getKodePesawat()
                                                                                                                                                                                                                                    :
                                                                                                                                                                                                                                    p.getID_Pesawat()
                                                                                                                                                                                                                                    %>
                                                                                                                                                                                                                            </td>
                                                                                                                                                                                                                            <td>
                                                                                                                                                                                                                                <%= p.getJenisPesawat()
                                                                                                                                                                                                                                    %>
                                                                                                                                                                                                                            </td>
                                                                                                                                                                                                                            <td>
                                                                                                                                                                                                                                <%= p.getNamaOperator()
                                                                                                                                                                                                                                    %>
                                                                                                                                                                                                                            </td>
                                                                                                                                                                                                                            <td>
                                                                                                                                                                                                                                <%= p.getTipe_mesin()
                                                                                                                                                                                                                                    %>
                                                                                                                                                                                                                            </td>
                                                                                                                                                                                                                            <td>
                                                                                                                                                                                                                                <%= p.getPabrikan()
                                                                                                                                                                                                                                    %>
                                                                                                                                                                                                                            </td>
                                                                                                                                                                                                                            <td>
                                                                                                                                                                                                                                <%= p.getTahun_produksi()
                                                                                                                                                                                                                                    %>
                                                                                                                                                                                                                            </td>
                                                                                                                                                                                                                            <td>
                                                                                                                                                                                                                                <%= p.getNegara_asal()
                                                                                                                                                                                                                                    %>
                                                                                                                                                                                                                            </td>
                                                                                                                                                                                                                        </tr>
                                                                                                                                                                                                                        <% } }
                                                                                                                                                                                                                            %>
                                                                                                                                        </tbody>
                                                                                                                                    </table>
                                                                                                                </div>


                                                                                                            </div>
                                                                                    </div>
                                                                                    <% } %>
                                        </div>
                                    </div>

                                    </div>
                                    </div> <!-- End Content Left -->

                                    <div class="sidebar-right">

                                        <% if (activePage.equals("home")) { %>
                                            <!-- Statistics moved to main content area -->
                                            <% } %>

                                                <!-- Sidebar category menu removed - now using horizontal tabs above content -->
                                                <% if (activePage.equals("kategori")) { %>

                                                    <!-- Unit selector moved to above table -->
                                    </div>
                                    <% } %>
                                        </div>


                                        </div> <!-- End Sidebar Right -->
                                        <script>
                                            function searchTable() {
                                                var input, filter, table, tr, td, i, txtValue;
                                                input = document.getElementById("searchInput");
                                                filter = input.value.toUpperCase();
                                                table = document.querySelector(".data-table");
                                                tr = table.getElementsByTagName("tr");
                                                for (i = 0; i < tr.length; i++) {
                                                    // Search in all columns
                                                    var found = false;
                                                    td = tr[i].getElementsByTagName("td");
                                                    for (var j = 0; j < td.length; j++) {
                                                        if (td[j]) {
                                                            txtValue = td[j].textContent || td[j].innerText;
                                                            if (txtValue.toUpperCase().indexOf(filter) > -1) {
                                                                found = true;
                                                                break;
                                                            }
                                                        }
                                                    }
                                                    if (i > 0) { // Skip header row
                                                        if (found) {
                                                            tr[i].style.display = "";
                                                        } else {
                                                            tr[i].style.display = "none";
                                                        }
                                                    }
                                                }
                                            }

                                            function sortTable(n) {
                                                var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
                                                table = document.querySelector(".data-table");
                                                switching = true;
                                                dir = "asc";
                                                while (switching) {
                                                    switching = false;
                                                    rows = table.rows;
                                                    for (i = 1; i < (rows.length - 1); i++) {
                                                        shouldSwitch = false;
                                                        x = rows[i].getElementsByTagName("TD")[n];
                                                        y = rows[i + 1].getElementsByTagName("TD")[n];
                                                        // Check if rows are visible (don't sort hidden rows if filtered?? Actually better to sort all)
                                                        // Basic string comparison
                                                        if (dir == "asc") {
                                                            if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                                                                shouldSwitch = true;
                                                                break;
                                                            }
                                                        } else if (dir == "desc") {
                                                            if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                                                                shouldSwitch = true;
                                                                break;
                                                            }
                                                        }
                                                    }
                                                    if (shouldSwitch) {
                                                        rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                                                        switching = true;
                                                        switchcount++;
                                                    } else {
                                                        if (switchcount == 0 && dir == "asc") {
                                                            dir = "desc";
                                                            switching = true;
                                                        }
                                                    }
                                                }
                                            }
                                        </script>
                                        </div> <!-- End Main Content -->
                                </body>

                                </html>