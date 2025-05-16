<%-- 
    Document   : index
    Created on : 16 May 2025, 13.40.01
    Author     : user
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Cinema - Sistem Pemesanan Tiket Bioskop</title>
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
            position: relative;
            overflow-x: hidden;
        }
        
        /* Animated background shapes */
        body::before,
        body::after {
            content: '';
            position: fixed;
            border-radius: 50%;
            filter: blur(100px);
            opacity: 0.7;
            animation: float 15s infinite;
        }
        
        body::before {
            width: 400px;
            height: 400px;
            background: #FF6B6B;
            top: -200px;
            right: -200px;
        }
        
        body::after {
            width: 600px;
            height: 600px;
            background: #4ECDC4;
            bottom: -300px;
            left: -300px;
            animation-delay: -7s;
        }
        
        @keyframes float {
            0%, 100% { transform: translate(0, 0) rotate(0deg); }
            25% { transform: translate(-50px, 50px) rotate(90deg); }
            50% { transform: translate(50px, -50px) rotate(180deg); }
            75% { transform: translate(-50px, -50px) rotate(270deg); }
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            position: relative;
            z-index: 1;
        }
        
        .header {
            text-align: center;
            margin-bottom: 50px;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        h1 {
            color: white;
            font-size: 3rem;
            font-weight: 700;
            margin-bottom: 10px;
            text-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        
        .subtitle {
            color: rgba(255, 255, 255, 0.9);
            font-size: 1.2rem;
            font-weight: 300;
        }
        
        .movie-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 30px;
            margin-top: 30px;
        }
        
        .movie-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            overflow: hidden;
            transition: all 0.3s ease;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            position: relative;
        }
        
        .movie-card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.2);
        }
        
        .movie-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            filter: brightness(0.9);
        }
        
        .movie-content {
            padding: 20px;
        }
        
        .movie-title {
            color: white;
            font-size: 1.3rem;
            font-weight: 600;
            margin-bottom: 15px;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        
        .movie-info {
            display: flex;
            align-items: center;
            color: rgba(255, 255, 255, 0.8);
            margin: 8px 0;
            font-size: 0.9rem;
        }
        
        .movie-info::before {
            content: '•';
            margin-right: 8px;
            color: #FFE66D;
            font-size: 1.2rem;
        }
        
        .price-tag {
            background: linear-gradient(135deg, #FFE66D, #FF6B6B);
            color: #333;
            padding: 8px 16px;
            border-radius: 50px;
            font-weight: 600;
            display: inline-block;
            margin: 15px 0;
            box-shadow: 0 4px 15px rgba(255, 107, 107, 0.3);
        }
        
        .btn-select {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 50px;
            cursor: pointer;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
            width: 100%;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }
        
        .btn-select:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
        }
        
        .genre-badge {
            position: absolute;
            top: 55px;
            right: 15px;
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(10px);
            padding: 5px 15px;
            border-radius: 50px;
            color: white;
            font-size: 0.8rem;
            font-weight: 500;
            border: 1px solid rgba(255, 255, 255, 0.3);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>My Cinema by VWZN</h1>
            <p class="subtitle">Pengalaman Menonton Film Terbaik Anda</p>
        </div>
        
        <%
            String[][] movies = {
                {"Bidaah", "Sci-Fi", "192", "50000", "3",},
                {"Maze Runner 1", "Action", "150", "45000", "4"},
                {"The Zombies", "Action", "166", "55000", "3"},
                {"My Love", "Romance", "176", "48000", "2"},
            };
            
            String[] showtimes = {"10:00", "13:00", "16:00", "19:00", "22:00"};
        %>
        
        <div class="movie-grid">
            <% for(int i = 0; i < movies.length; i++) { %>
                <div class="movie-card">
                    <span class="genre-badge"><%= movies[i][1] %></span>
                    <div class="movie-content">
                        <h3 class="movie-title"><%= movies[i][0] %></h3>
                        <div class="movie-info">Durasi: <%= movies[i][2] %> menit</div>
                        <div class="movie-info">Tersedia <%= movies[i][4] %> jam tayang</div>
                        <div class="price-tag">Rp <%= String.format("%,d", Integer.parseInt(movies[i][3])) %></div>
                        <form method="post" action="formPesan.jsp">
                            <input type="hidden" name="movieIndex" value="<%= i %>">
                            <button type="submit" class="btn-select">Pesan Tiket</button>
                        </form>
                    </div>
                </div>
            <% } %>
        </div>
    </div>
</body>
</html>
