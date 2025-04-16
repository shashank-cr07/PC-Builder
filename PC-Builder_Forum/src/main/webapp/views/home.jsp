<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home - Forums</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
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
            padding: 40px;
            display: flex;
            flex-direction: column;
            align-items: center;
            min-height: 100vh;
        }
        header {
            width: 100%;
            max-width: 1200px;
            margin-bottom: 30px;
        }
        .header-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 30px;
            background-color: #1a1a1a;
            border-radius: 10px;
            box-shadow: 0 6px 20px rgba(255, 255, 255, 0.05);
        }
        .create-forum button {
            padding: 14px 28px;
            background-color: #e53935;
            color: #fff;
            border: none;
            border-radius: 6px;
            font-size: 18px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }
        .create-forum button:hover {
            background-color: #c62828;
            transform: scale(1.05);
        }
        .search-bar {
            display: flex;
            align-items: center;
        }
        .search-bar input[type="text"] {
            padding: 12px 15px;
            border: 1px solid #333;
            border-radius: 6px;
            background-color: #222;
            color: #fff;
            font-size: 16px;
            margin: 0 15px;
            width: 250px;
            transition: border-color 0.3s ease;
        }
        .search-bar input[type="text"]:focus {
            outline: none;
            border-color: #e53935;
        }
        .search-bar button[type="submit"] {
            padding: 12px 20px;
            background-color: #333;
            color: #fff;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .search-bar button[type="submit"]:hover {
            background-color: #555;
        }
        .user-menu {
            position: relative;
            display: flex;
            align-items: center;
        }
        .user-icon {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            cursor: pointer;
            transition: transform 0.3s ease;
            border: 2px solid #fff;
        }
        .user-icon:hover {
            transform: scale(1.1);
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
            margin-top: 40px;
            padding: 30px;
            background-color: #1a1a1a;
            border-radius: 10px;
            box-shadow: 0 6px 20px rgba(255, 255, 255, 0.05);
            text-align: center;
        }
        .home-message {
            color: #ddd;
            margin-bottom: 25px;
            font-size: 1.1em;
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
                margin-bottom: 20px;
            }
            .header-container {
                flex-direction: column;
                align-items: stretch;
                padding: 15px;
            }
            .create-forum {
                width: 100%;
                margin-bottom: 10px;
                margin-right: 0;
            }
            .create-forum button {
                width: 100%;
            }
            .search-bar {
                width: 100%;
                margin: 10px 0;
            }
            .search-bar input[type="text"] {
                width: calc(100% - 80px);
                margin: 0 10px 0 0;
            }
            .user-menu {
                align-self: flex-end;
            }
            .content {
                margin-top: 20px;
                padding: 20px;
            }
            .content ul li a {
                font-size: 18px;
            }
        }
    </style>
</head>
<body>
<header>
    <div class="header-container">
        <div class="create-forum">
            <button onclick="window.location.href='/create-forum'">Create a Forum</button>
        </div>

        <div class="search-bar">
            <input type="text" placeholder="Search forums...">
            <button type="submit">Search</button>
        </div>

        <div class="user-menu" id="userMenu">
            <img src="/images/user-icon.jpg" alt="User" class="user-icon" onclick="toggleMenu()">
            <div class="dropdown-menu" id="dropdownMenu">
                <ul>
                    <li><a href="/my-forums">My Forums</a></li>
                    <li><a href="/my-posts">My Posts</a></li>
                    <li><a href="/logout">Logout</a></li>
                </ul>
            </div>
        </div>
    </div>
</header>

<div class="content">
    <div class="home-message">
        <h1>Forums</h1>
    </div>
    <ul>
        <c:forEach var="forum" items="${forums}">
            <li>
                <a href="/forum/${forum.id}">${forum.name}</a>
            </li>
        </c:forEach>
    </ul>
</div>

<script>
    function toggleMenu() {
        document.getElementById('dropdownMenu').classList.toggle('show');
    }

    window.addEventListener('click', function (e) {
        if (!document.getElementById('userMenu').contains(e.target)) {
            document.getElementById('dropdownMenu').classList.remove('show');
        }
    });

    const searchInput = document.querySelector('.search-bar input[type="text"]');
    const forumList = document.querySelector('.content ul');
    const forumItems = forumList.querySelectorAll('li');

    document.querySelector('.search-bar button[type="submit"]').addEventListener('click', performSearch);
    searchInput.addEventListener('keypress', function (e) {
        if (e.key === 'Enter') {
            performSearch();
        }
    });

    function performSearch() {
        const searchTerm = searchInput.value.toLowerCase();
        forumItems.forEach(item => {
            const forumName = item.querySelector('a').textContent.toLowerCase();
            if (forumName.includes(searchTerm)) {
                item.style.display = '';
            } else {
                item.style.display = 'none';
            }
        });
    }
</script>
</body>
</html>
