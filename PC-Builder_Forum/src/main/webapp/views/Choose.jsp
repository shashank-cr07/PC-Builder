<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        <button onclick="window.location.href='/login'">Join The Forums</button>
    </div>
</div>

</body>
</html>
