<%-- 
    Document   : formPesan
    Created on : 16 May 2025, 13.43.07
    Author     : user
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Form Pemesanan - My Cinema</title>
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
                overflow: hidden;
            }

            /* Animated circles */
            .circle {
                position: absolute;
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
                0%, 100% {
                    transform: translate(0, 0);
                }
                33% {
                    transform: translate(30px, -30px);
                }
                66% {
                    transform: translate(-20px, 20px);
                }
            }

            .container {
                width: 90%;
                max-width: 500px;
                position: relative;
                z-index: 1;
            }

            .form-card {
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

            .movie-info {
                background: rgba(255, 255, 255, 0.1);
                backdrop-filter: blur(10px);
                padding: 20px;
                border-radius: 15px;
                margin-bottom: 30px;
                border: 1px solid rgba(255, 255, 255, 0.2);
            }

            .movie-info h3 {
                color: white;
                margin-bottom: 10px;
                font-size: 1.3rem;
            }

            .movie-info p {
                color: rgba(255, 255, 255, 0.9);
                margin: 5px 0;
            }

            .price-highlight {
                color: #FFE66D;
                font-weight: 600;
                font-size: 1.1rem;
            }

            .form-group {
                margin-bottom: 25px;
            }

            label {
                display: block;
                color: white;
                margin-bottom: 8px;
                font-weight: 500;
                text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            input[type="text"],
            input[type="number"],
            select {
                width: 100%;
                padding: 12px 20px;
                background: rgba(255, 255, 255, 0.1);
                border: 1px solid rgba(255, 255, 255, 0.3);
                border-radius: 12px;
                color: white;
                font-size: 16px;
                transition: all 0.3s ease;
                backdrop-filter: blur(5px);
            }

            input[type="text"]:focus,
            input[type="number"]:focus,
            select:focus {
                outline: none;
                background: rgba(255, 255, 255, 0.15);
                border-color: rgba(255, 255, 255, 0.5);
                box-shadow: 0 0 20px rgba(102, 126, 234, 0.3);
            }

            input::placeholder {
                color: rgba(255, 255, 255, 0.6);
            }

            select option {
                background: #764ba2;
                color: white;
            }

            input[readonly] {
                background: rgba(255, 255, 255, 0.05);
                cursor: not-allowed;
            }

            .btn-group {
                display: flex;
                gap: 15px;
                margin-top: 30px;
            }

            .btn {
                flex: 1;
                padding: 14px 24px;
                border: none;
                border-radius: 50px;
                cursor: pointer;
                font-weight: 600;
                font-size: 1rem;
                transition: all 0.3s ease;
                text-decoration: none;
                text-align: center;
                display: inline-block;
            }

            .btn-submit {
                background: linear-gradient(135deg, #667eea, #764ba2);
                color: white;
                box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
            }

            .btn-submit:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
            }

            .btn-back {
                background: rgba(255, 255, 255, 0.1);
                color: white;
                border: 1px solid rgba(255, 255, 255, 0.3);
                backdrop-filter: blur(10px);
            }

            .btn-back:hover {
                background: rgba(255, 255, 255, 0.2);
            }
        </style>
    </head>
    <body>
        <div class="circle"></div>
        <div class="circle"></div>
        <div class="circle"></div>

        <div class="container">
            <div class="form-card">
                <%
                    // Get movie data
                    String[][] movies = {
                        {"Bidaah", "Sci-Fi", "192", "50000", "3",},
                        {"Maze Runner 1", "Action", "150", "45000", "4"},
                        {"The Zombies", "Action", "166", "55000", "3"},
                        {"My Love", "Romance", "176", "48000", "2"},
                    };

                    String[] showtimes = {"10:00", "13:00", "16:00", "19:00", "22:00"};

                    int movieIndex = Integer.parseInt(request.getParameter("movieIndex"));
                    String[] selectedMovie = movies[movieIndex];

                    // Store movie data in session
                    session.setAttribute("selectedMovie", selectedMovie);
                    session.setAttribute("movieIndex", movieIndex);
                %>

                <h1>Form Pemesanan Tiket</h1>

                <div class="movie-info">
                    <h3><%= selectedMovie[0]%></h3>
                    <p>Genre: <%= selectedMovie[1]%> | Durasi: <%= selectedMovie[2]%> menit</p>
                    <p class="price-highlight">Harga Tiket: Rp <%= String.format("%,d", Integer.parseInt(selectedMovie[3]))%></p>
                </div>

                <form method="post" action="struk.jsp">
                    <div class="form-group">
                        <label for="customerName">Nama Pemesan</label>
                        <input type="text" id="customerName" name="customerName" placeholder="Masukkan nama lengkap" required>
                    </div>

                    <div class="form-group">
                        <label for="ticketCount">Jumlah Tiket</label>
                        <input type="number" id="ticketCount" name="ticketCount" min="1" max="10" value="1" required>
                    </div>

                    <div class="form-group">
                        <label for="movieTitle">Film yang Dipilih</label>
                        <input type="text" id="movieTitle" name="movieTitle" value="<%= selectedMovie[0]%>" readonly>
                    </div>

                    <div class="form-group">
                        <label for="showtime">Jam Tayang</label>
                        <select id="showtime" name="showtime" required>
                            <option value="">-- Pilih Jam Tayang --</option>
                            <% for (String time : showtimes) {%>
                            <option value="<%= time%>"><%= time%></option>
                            <% }%>
                        </select>
                    </div>

                    <div class="btn-group">
                        <a href="index.jsp" class="btn btn-back">Kembali</a>
                        <button type="submit" class="btn btn-submit">Pesan Tiket</button>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
