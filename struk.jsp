    <%-- 
        Document   : struk
        Created on : 16 May 2025, 13.43.43
        Author     : user
    --%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="javax.servlet.http.HttpSession" %>
    <%@ page import="java.text.NumberFormat" %>
    <%@ page import="java.util.Locale" %>
    <!DOCTYPE html>
    <html>
    <head>
        <title>Struk Pemesanan - My Cinema</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Poppins', sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                position: relative;
                overflow-y: auto;
                background-attachment: fixed;
            }

            /* Animated circles */
            .circle {
                position: fixed;
                border-radius: 50%;
                filter: blur(60px);
                opacity: 0.6;
                animation: float 20s infinite ease-in-out;
            }

            .circle:nth-child(1) {
                width: 300px;
                height: 300px;
                background: #FF6B6B;
                top: -150px;
                left: -150px;
            }

            .circle:nth-child(2) {
                width: 200px;
                height: 200px;
                background: #4ECDC4;
                bottom: -100px;
                right: -100px;
                animation-delay: -5s;
            }

            .circle:nth-child(3) {
                width: 250px;
                height: 250px;
                background: #FFE66D;
                top: 50%;
                right: -125px;
                animation-delay: -10s;
            }

            @keyframes float {
                0%, 100% { transform: translate(0, 0); }
                33% { transform: translate(30px, -30px); }
                66% { transform: translate(-20px, 20px); }
            }

            .container {
                width: 90%;
                max-width: 600px;
                position: relative;
                z-index: 1;
                margin: 20px 0;
            }

            .receipt-card {
                background: rgba(255, 255, 255, 0.1);
                backdrop-filter: blur(20px);
                border-radius: 25px;
                padding: 40px;
                box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
                border: 1px solid rgba(255, 255, 255, 0.2);
            }

            h1 {
                color: white;
                text-align: center;
                margin-bottom: 30px;
                font-size: 2rem;
                text-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            .success-message {
                background: rgba(76, 175, 80, 0.15);
                backdrop-filter: blur(10px);
                border: 1px solid rgba(76, 175, 80, 0.3);
                color: #E8F5E9;
                padding: 15px;
                border-radius: 15px;
                text-align: center;
                margin-bottom: 20px;
                font-weight: 500;
                text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            .receipt {
                background: rgba(255, 255, 255, 0.05);
                backdrop-filter: blur(10px);
                border: 2px dashed rgba(255, 255, 255, 0.3);
                padding: 30px;
                border-radius: 15px;
            }

            .receipt-header {
                text-align: center;
                margin-bottom: 30px;
                color: white;
            }

            .receipt-header h2 {
                font-size: 1.8rem;
                margin-bottom: 10px;
                text-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            .receipt-header p {
                color: rgba(255, 255, 255, 0.9);
                font-size: 1.1rem;
            }

            .receipt-body {
                margin: 20px 0;
            }

            .receipt-row {
                display: flex;
                justify-content: space-between;
                margin: 15px 0;
                padding: 10px 0;
                border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            }

            .receipt-label {
                font-weight: 600;
                color: rgba(255, 255, 255, 0.8);
                text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            .receipt-value {
                color: white;
                text-align: right;
            }

            .total-row {
                margin-top: 25px;
                padding-top: 20px;
                border-top: 2px solid rgba(255, 255, 255, 0.3);
                font-size: 1.3rem;
                font-weight: bold;
            }

            .total-row .receipt-label,
            .total-row .receipt-value {
                color: #FFE66D;
                text-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
            }

            .btn-container {
                text-align: center;
                margin-top: 40px;
            }

            .btn-new {
                background: linear-gradient(135deg, #667eea, #764ba2);
                color: white;
                border: none;
                padding: 14px 40px;
                border-radius: 50px;
                cursor: pointer;
                text-decoration: none;
                display: inline-block;
                font-weight: 600;
                font-size: 1rem;
                transition: all 0.3s ease;
                box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
            }

            .btn-new:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
            }

            .ticket-info {
                background: rgba(255, 255, 255, 0.05);
                backdrop-filter: blur(5px);
                padding: 15px;
                border-radius: 10px;
                margin-top: 15px;
                color: rgba(255, 255, 255, 0.9);
                font-size: 0.9rem;
                text-align: center;
            }
        </style>
    </head>
    <body>
        <div class="circle"></div>
        <div class="circle"></div>
        <div class="circle"></div>

        <div class="container">
            <div class="receipt-card">
                <%
                    // Get data from form
                    String customerName = request.getParameter("customerName");
                    int ticketCount = Integer.parseInt(request.getParameter("ticketCount"));
                    String movieTitle = request.getParameter("movieTitle");
                    String showtime = request.getParameter("showtime");

                    // Get movie data from session
                    String[] selectedMovie = (String[]) session.getAttribute("selectedMovie");
                    int pricePerTicket = Integer.parseInt(selectedMovie[3]);
                    int totalPrice = pricePerTicket * ticketCount;

                    // Format currency
                    NumberFormat formatter = NumberFormat.getCurrencyInstance(new Locale("id", "ID"));
                    String formattedPrice = formatter.format(pricePerTicket);
                    String formattedTotal = formatter.format(totalPrice);
                %>

                <h1>Struk Pemesanan</h1>

                <div class="success-message">
                    ✅ Pemesanan Berhasil!
                </div>

                <div class="receipt">
                    <div class="receipt-header">
                        <h2>My Cinema</h2>
                        <p>Terima Kasih Atas Pemesanan Anda</p>
                    </div>

                    <div class="receipt-body">
                        <div class="receipt-row">
                            <span class="receipt-label">Nama Pemesan:</span>
                            <span class="receipt-value"><%= customerName %></span>
                        </div>

                        <div class="receipt-row">
                            <span class="receipt-label">Film:</span>
                            <span class="receipt-value"><%= movieTitle %></span>
                        </div>

                        <div class="receipt-row">
                            <span class="receipt-label">Jam Tayang:</span>
                            <span class="receipt-value"><%= showtime %></span>
                        </div>

                        <div class="receipt-row">
                            <span class="receipt-label">Jumlah Tiket:</span>
                            <span class="receipt-value"><%= ticketCount %> tiket</span>
                        </div>

                        <div class="receipt-row">
                            <span class="receipt-label">Harga per Tiket:</span>
                            <span class="receipt-value"><%= formattedPrice %></span>
                        </div>

                        <div class="receipt-row total-row">
                            <span class="receipt-label">Total Pembayaran:</span>
                            <span class="receipt-value"><%= formattedTotal %></span>
                        </div>
                    </div>

                    <div class="ticket-info">
                        <p>Silakan tunjukkan struk ini di loket untuk mendapatkan tiket fisik Anda</p>
                        <p style="margin-top: 10px;">Kode Booking: <%= String.format("CG%05d", (int)(Math.random() * 99999)) %></p>
                    </div>
                </div>

                <div class="btn-container">
                    <a href="index.jsp" class="btn-new">Pesan Tiket Lainnya</a>
                </div>
            </div>
        </div>
    </body>
    </html>
