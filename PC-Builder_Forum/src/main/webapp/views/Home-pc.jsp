<!DOCTYPE html>
<html>
<head>
    <title>PC Parts</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: #1d1d1d;
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            padding: 2rem;
            gap: 2rem;
        }

        .card {
            background-color: white;
            border-radius: 1rem;
            width: 250px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            text-align: center;
            overflow: hidden;
            transition: transform 0.2s ease-in-out;
            text-decoration: none;
            color: inherit;
        }

        .card:hover {
            transform: scale(1.05);
        }

        .card img {
            width: 100%;
            height: 180px;
            object-fit: cover;
        }

        .card h2 {
            margin: 1rem 0;
            font-size: 1.5rem;
            font-family: Moonscape;
            src: url('Moonscape Demo.otf') format('truetype');
            font-weight: bold;
            text-transform: uppercase;
        }

        .card p {
            padding: 0 1rem 1rem;
            color: #555;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <h1>Build your own PC</h1>

    <a href="/cpu-page" class="card">
        <img src="cpu.webp" alt="CPU">
        <h2>CPU</h2>
        <p>The brain of the computer that handles all instructions.</p>
    </a>

    <a href="/gpu-page" class="card">
        <img src="gpu.jpg" alt="GPU">
        <h2>GPU</h2>
        <p>Handles graphics processing and video rendering tasks.</p>
    </a>

    <a href="ram.jsp" class="card">
        <img src="ram.webp" alt="RAM">
        <h2>RAM</h2>
        <p>Temporary memory that helps your computer multitask efficiently.</p>
    </a>

    <a href="/motherboard-page" class="card">
        <img src="motherboard.webp" alt="Motherboard">
        <h2>MOTHERBOARD</h2>
        <p>The central hub connecting all components of your PC.</p>
    </a>

</body>
</html>