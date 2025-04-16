<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Forums</title>
    <link rel="stylesheet" href="/homestyle.css">
    <style>
        /* (CSS kept exactly the same — no changes made) */
        /* Reset and Global Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Roboto', sans-serif;
            background-color: #000;
            color: #fff;
            display: flex;
            flex-direction: column;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        header {
            width: 100%;
            max-width: 1200px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 30px;
            background-color: #1a1a1a;
            border-radius: 10px;
            box-shadow: 0 6px 20px rgba(255, 255, 255, 0.05);
            margin-bottom: 30px;
        }

        .back-button {
            padding: 10px 20px;
            background-color: #e53935;
            color: #fff;
            font-size: 16px;
            border: none;
            border-radius: 6px;
            text-decoration: none;
            display: inline-block;
            text-align: center;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .back-button:hover {
            background-color: #c62828;
            transform: scale(1.05);
        }

        .header-center {
            font-size: 24px;
            font-weight: bold;
            color: #fff;
            text-align: center;
            flex-grow: 1;
        }

        .user-menu {
            position: relative;
        }

        .user-icon {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            cursor: pointer;
            border: 2px solid #fff;
        }

        .dropdown-menu {
            position: absolute;
            top: 60px;
            right: 0;
            background-color: #1a1a1a;
            border-radius: 8px;
            width: 180px;
            display: none;
            box-shadow: 0 8px 20px rgba(255, 255, 255, 0.08);
            z-index: 10;
        }

        .dropdown-menu.show {
            display: block;
        }

        .dropdown-menu ul {
            list-style: none;
            padding: 15px;
        }

        .dropdown-menu li {
            padding: 12px;
            border-bottom: 1px solid #333;
        }

        .dropdown-menu li:last-child {
            border-bottom: none;
        }

        .dropdown-menu li a {
            color: #eee;
            text-decoration: none;
            display: block;
            transition: color 0.2s ease;
        }

        .dropdown-menu li a:hover {
            color: #e53935;
        }

        .content {
            width: 100%;
            max-width: 800px;
            padding: 30px;
            background-color: #1a1a1a;
            border-radius: 10px;
            box-shadow: 0 6px 20px rgba(255, 255, 255, 0.05);
            text-align: center;
        }

        .content h2 {
            margin-bottom: 30px;
            color: #ddd;
        }

        .content ul {
            list-style: none;
            text-align: left;
            padding: 0;
        }

        .content ul li {
            margin-bottom: 15px;
            padding: 15px;
            border-bottom: 1px solid #333;
            transition: background-color 0.3s ease;
        }

        .content ul li:last-child {
            border-bottom: none;
        }

        .content ul li a {
            color: #e53935;
            text-decoration: none;
            font-size: 20px;
            display: block;
            transition: color 0.2s ease;
        }

        .content ul li a:hover {
            color: #fff;
            text-decoration: underline;
            background-color: #333;
            border-radius: 6px;
        }

        @media (max-width: 768px) {
            body {
                padding: 20px;
            }

            header {
                flex-direction: column;
                align-items: stretch;
                padding: 15px;
            }

            .back-button {
                margin-bottom: 15px;
            }

            .header-center {
                margin: 10px 0;
            }

            .user-menu {
                align-self: flex-end;
            }

            .content {
                padding: 20px;
            }

            .content ul li a {
                font-size: 18px;
            }
        }
    </style>
</head>
<body>
    <!-- Header Section -->
    <header>
        <a href="/home" class="back-button">Back</a>
        <div class="header-center">Your Forums</div>
        <div class="user-menu" id="userMenu">
            <img src="/images/user-icon.jpg" alt="User" class="user-icon" onclick="toggleMenu()">
            <span style="margin-left: 0.5rem;" onclick = "toggleMenu()">${username}</span>

            <div class="dropdown-menu" id="dropdownMenu">
                <ul>
                    <li><a href="/my-forums">My Forums</a></li>
                    <li><a href="/my-posts">My Posts</a></li>
                    <li><a href="/home-pc">Build PC</a></li>
                    <li><a href="/builds">View Builds</a></li>
                    <li><a href="/logout">Logout</a></li>
                </ul>
            </div>
        </div>
    </header>

    <!-- Content Section -->
    <div class="content">
        <ul>
            <c:forEach var="forum" items="${forums}">
                <li>
                    <a href="/forum/${forum.id}">${forum.name}</a>
                </li>
            </c:forEach>
        </ul>

        <c:if test="${empty forums}">
            <p>You have not created any forums yet.</p>
        </c:if>
    </div>

    <!-- JavaScript to toggle dropdown -->
    <script>
        function toggleMenu() {
            document.getElementById('dropdownMenu').classList.toggle('show');
        }

        window.addEventListener('click', function (e) {
            if (!document.getElementById('userMenu').contains(e.target)) {
                document.getElementById('dropdownMenu').classList.remove('show');
            }
        });
    </script>
</body>
</html>
