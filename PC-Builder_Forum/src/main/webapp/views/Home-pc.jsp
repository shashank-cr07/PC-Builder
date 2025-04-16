<!DOCTYPE html>
<html>
<head>
    <title> Build Your Ultimate PC | Custom PC Builder</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Orbitron:wght@600&display=swap');

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

        header {
            width: 100%;
            background: #121212;
            padding: 1.5rem 0;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.5);
            position: fixed;
            top: 0;
            left: 0;
            z-index: 1000;
        }

        .page-title {
            text-align: center;
            font-size: 2.8rem;
            font-family: 'Orbitron', sans-serif;
            background: linear-gradient(90deg, #00ffe7, #ff00c8);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 0 0 10px #ff00c855;
            margin: 0;
        }

        body {
            padding-top: 8rem; /* Prevent content from hiding behind header */
        }

        .card {
            background-color: rgb(167, 167, 189);
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
            font-family: "Moonscape";
            src: url("Moonscape Demo.otf") format('truetype');
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
    <header>
        <h1 class="page-title">Build Your Own PC</h1>
    </header>

    <!-- Cards Below -->

    <a href="/cpupage" class="card">
        <img src="views/images/cpu.webp" alt="CPU">
        <h2>CPU</h2>
    </a>

    <a href="/video-cardpage" class="card">
        <img src="views/images/gpu.JPG" alt="GPU">
        <h2>Video Card</h2>
    </a>

    <a href="/motherboardpage" class="card">
        <img src="views/images/motherboard.webp" alt="Motherboard">
        <h2>Motherboard</h2>
    </a>

    <a href="/power-supplypage" class="card">
        <img src="views/images/power-supply.webp" alt="Power Supply">
        <h2>Power Supply</h2>
    </a>

    <a href="/cpu-coolerpage" class="card">
        <img src="views/images/cooler.jpg" alt="CPU Cooler">
        <h2>CPU Cooler</h2>
    </a>

    <a href="/case-tablepage" class="card">
        <img src="views/images/cpu-case.jpg" alt="CPU-Case">
        <h2>CPU Case</h2>
    </a>

    <a href="/case-fanpage" class="card">
        <img src="views/images/cpu-fan.webp" alt="CPU-Fan">
        <h2>Case Fan</h2>
    </a>

    <a href="/memorypage" class="card">
        <img src="views/images/memory.jpeg" alt="Memory">
        <h2>Memory</h2>
    </a>

    <a href="/ospage" class="card">
        <img src="views/images/os.jpeg" alt="OS">
        <h2>Operating System</h2>
    </a>

    <a href="/thermal-pastepage" class="card">
        <img src="views/images/thermel paste.jpeg" alt="Thermal Paste">
        <h2>Thermal Paste</h2>
    </a>

    <a href="/internal-hard-drivepage" class="card">
        <img src="views/images/ihd.jpeg" alt="Internal Hard Drive">
        <h2>Internal Hard Drive</h2>
    </a>

    <a href="/external-hard-drivepage" class="card">
        <img src="views/images/ehd.jpeg" alt="External Hard Drive">
        <h2>External Hard Drive</h2>
    </a>

    <a href="/fan-controllerpage" class="card">
        <img src="views/images/fan-controller.jpeg" alt="Fan Controller">
        <h2>Fan Controller</h2>
    </a>
</body>
</html>
