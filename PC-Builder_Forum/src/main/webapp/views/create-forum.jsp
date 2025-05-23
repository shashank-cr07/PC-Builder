<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create a Forum</title>
    <link rel="stylesheet" href="create-forum.css"> <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        /* General Styles */
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #000; /* Black background */
            color: #fff;
            margin: 0;
            padding: 40px; /* Consistent padding */
            display: flex;
            flex-direction: column;
            align-items: center;
            min-height: 100vh;
        }

        /* Header Styles */
        header {
            width: 100%;
            max-width: 1200px; /* Consistent max-width */
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
            background-color: #e53935; /* Red accent */
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

        /* User Menu Styles */
        .user-menu {
            position: relative;
            display: flex;
            align-items: center;
        }

        .user-icon {
            width: 45px; /* Consistent icon size */
            height: 45px;
            border-radius: 50%;
            cursor: pointer;
            transition: transform 0.3s ease;
            border: 2px solid #fff; /* White border for consistency */
        }

        .user-icon:hover {
            transform: scale(1.1);
        }

        .dropdown-menu {
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

        .dropdown-menu ul {
            list-style: none;
            margin: 0;
            padding: 15px;
        }

        .dropdown-menu ul li {
            padding: 12px;
            cursor: pointer;
            border-bottom: 1px solid #333;
            transition: background-color 0.2s ease, color 0.2s ease;
        }

        .dropdown-menu ul li:last-child {
            border-bottom: none;
        }

        .dropdown-menu ul li a {
            color: #eee;
            text-decoration: none;
            display: block;
        }

        .dropdown-menu ul li:hover,
        .dropdown-menu ul li a:hover {
            background-color: #e53935;
            color: #fff;
        }

        .show {
            display: block;
        }

        /* Content Section */
        .content {
            width: 100%;
            max-width: 600px;
            margin-top: 40px; /* Consistent margin-top */
            padding: 30px;
            background-color: #1a1a1a;
            border-radius: 10px;
            box-shadow: 0 6px 20px rgba(255, 255, 255, 0.05);
        }

        h1 {
            color: #e53935;
            font-size: 2.5em;
            margin-bottom: 25px;
            text-align: center;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 8px;
            color: #ddd;
        }

        .form-group input[type="text"] {
            width: 100%;
            padding: 12px 15px;
            border-radius: 6px;
            border: 1px solid #333;
            background-color: #222;
            color: #fff;
            font-size: 1em;
            box-sizing: border-box;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .form-group input[type="text"]:focus {
            outline: none;
            border-color: #e53935;
            box-shadow: 0 0 8px rgba(229, 57, 53, 0.5);
        }

        button[type="submit"] {
            padding: 14px 30px;
            background-color: #e53935;
            color: #fff;
            border: none;
            border-radius: 6px;
            font-size: 1.1em;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        button[type="submit"]:hover {
            background-color: #c62828;
            transform: scale(1.05);
        }

        /* Responsive Design */
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
            }

            .user-menu {
                align-self: flex-end;
                margin-top: 10px;
            }

            .content {
                margin-top: 30px;
                padding: 20px;
            }

            h1 {
                font-size: 2em;
            }

            button[type="submit"] {
                font-size: 1em;
            }
        }
    </style>
</head>
<body>
    <header>
        <div class="header-container">
            <div class="create-forum">
                <button onclick="window.location.href='/home'">Back to Home</button>
            </div>

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
        </div>
    </header>

    <div class="content">
        <h1>Create a New Forum</h1>
        <form action="/create-forum" method="post">
            <div class="form-group">
                <label for="forumName">Forum Name:</label>
                <input type="text" id="forumName" name="name" required placeholder="Enter forum name">
            </div>
            <button type="submit">Create Forum</button>
        </form>
    </div>

    <script>
        function toggleMenu() {
            document.getElementById('dropdownMenu').classList.toggle('show');
        }

        // Close dropdown if clicked outside
        window.addEventListener('click', function (e) {
            if (!document.getElementById('userMenu').contains(e.target)) {
                document.getElementById('dropdownMenu').classList.remove('show');
            }
        });
    </script>
</body>
</html>