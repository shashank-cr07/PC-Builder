<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Choose an Option</title>
    <style>
        /* Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        html, body {
            height: 100%;
            width: 100%;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f7f7f7;
        }

        .container {
            display: flex;
            height: 100vh;
            width: 100%;
        }

        /* Left Side */
        .left {
            flex: 1;
            background-color: #ffffff;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 20px;
            text-align: center;
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
        }

        .left img {
            max-width: 80%;
            max-height: 300px;
            height: auto;
            margin-bottom: 30px;
            border-radius: 10px;
        }

        .left button {
            background-color: #e53935;
            color: white;
            font-size: 18px;
            padding: 15px 35px;
            border: none;
            border-radius: 50px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
            font-weight: bold;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .left button:hover {
            background-color: #c62828;
            transform: translateY(-4px);
        }

        .left button:active {
            transform: translateY(2px);
        }

        /* Right Side */
        .right {
            flex: 1;
            background-color: #000;
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 20px;
            text-align: center;
            box-shadow: -2px 0 10px rgba(0, 0, 0, 0.1);
        }

        .right h2 {
            color: #e53935;
            font-size: 36px;
            margin-bottom: 40px;
            font-weight: bold;
        }

        .right img {
            max-width: 70%;
            height: 300px;
            margin-bottom: 30px;
            border-radius: 10px;
        }

        .right button {
            background-color: #e53935;
            color: white;
            font-size: 18px;
            padding: 15px 35px;
            border: none;
            border-radius: 50px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
            font-weight: bold;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .right button:hover {
            background-color: #c62828;
            transform: translateY(-4px);
        }

        .right button:active {
            transform: translateY(2px);
        }
        
        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                flex-direction: column;
            }

            .left, .right {
                width: 100%;
                height: auto;
                padding: 20px;
            }

            .left img, .right img {
                max-width: 90%;
            }
        }
        .user-dropdown {
            position: fixed;
            top: 10px;
            right: 10px;
            display: flex;
            align-items: center;
            background-color: #444;
            padding: 6px 10px;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.3);
            cursor: pointer;
            color: white;
            font-size: 0.95rem;
            z-index: 10;
        }

        .user-dropdown img.user-icon {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            margin-right: 8px;
            border: 2px solid white;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            right: 0;
            top: 60px; /* Adjusted top */
            background-color: #1a1a1a;
            border-radius: 8px;
            box-shadow: 0 8px 20px rgba(255, 255, 255, 0.08);
            min-width: 180px; /* Consistent width */
            z-index: 1000;
        }

        .dropdown-content ul {
            list-style: none;
            margin: 0;
            padding: 15px;
        }

        .dropdown-content ul li {
            padding: 12px;
            cursor: pointer;
            border-bottom: 1px solid #333;
            transition: background-color 0.2s ease, color 0.2s ease;
        }

        .dropdown-content ul li:last-child {
            border-bottom: none;
        }

        .dropdown-content ul li a {
            color: #eee;
            text-decoration: none;
            display: block;
        }

        .dropdown-content ul li:hover,
        .dropdown-content ul li a:hover {
            color: #fc3434;
        }

        .dropdown-content.show {
            display: block;
        }

    </style>
</head>
<body>

<div class="container">
    <!-- Left Side -->
    <div class="left">
        <img src="images/pc-image.jpeg" alt="PC Image">
        <button onclick="window.location.href='/home-pc'">Build Your PC</button>
    </div>

        <!-- Right Side -->
    <div class="right">
        <img src="images/reddit_logo.jpeg" alt="Reddit Logo">

        <c:choose>
            <c:when test="${not empty loggedInUser}">
                <button onclick = "window.location.href='/home'">View forums ${loggedInUser.username}</button>
            </c:when>
            <c:otherwise>
                <button onclick="window.location.href='/login'">Join The Forums</button>
            </c:otherwise>
        </c:choose>
    </div>


<!-- User Dropdown -->
<div class="user-dropdown" onclick="handleUserClick()">
    <img src="/images/user-icon.jpg" alt="User Icon" class="user-icon">
    <div>
        <c:choose>
            <c:when test="${not empty loggedInUser}">
                ${loggedInUser.username}
            </c:when>
            <c:otherwise>
                Sign In
            </c:otherwise>
        </c:choose>
    </div>
</div>
<br>
<div class="dropdown-content" id="dropdownMenu">
    <ul>
        <li><a href="/home">Go to Forums Page</a></li>
        <li><a href="/home-pc">Build PC</a></li>
        <li><a href="/builds">View Builds</a></li>
        <li><a href="/home-pc" onclick="confirmLogout(event)">Logout</a></li>
    </ul>
</div>

<script>
    function handleUserClick() {
        const isLoggedIn = '<c:out value="${not empty loggedInUser}"/>' === 'true';
        if (isLoggedIn) {
            document.getElementById('dropdownMenu').classList.toggle('show');
        } else {
            window.location.href = '/login';
        }
    }

    function confirmLogout(event) {
        event.preventDefault();
        if (confirm('Are you sure you want to logout?')) {
            window.location.href = '/logout';
        }
    }

    // Hide dropdown when clicking outside
    window.addEventListener('click', function(e) {
        const dropdown = document.getElementById('dropdownMenu');
        const userBox = document.querySelector('.user-dropdown');
        if (!userBox.contains(e.target)) {
            dropdown.classList.remove('show');
        }
    });
</script>
</body>
</html>
