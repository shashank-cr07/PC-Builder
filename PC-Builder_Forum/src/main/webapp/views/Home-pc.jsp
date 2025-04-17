<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
            padding: 2rem;
            padding-top: 8rem; /* Prevent content from hiding behind header */
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

        .cards-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 2rem;
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
            z-index: 1002;
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
            z-index: 1001;
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

        /* Checkout Button Styles */
        .checkout-button {
            display: block;
            margin: 1.5rem auto;
            padding: 0.5rem 1rem;
            background: linear-gradient(90deg, #00ffe7, #ff00c8);
            color: #fff;
            font-size: 0.9rem;
            font-family: 'Orbitron', sans-serif;
            text-transform: uppercase;
            border: none;
            border-radius: 0.5rem;
            cursor: pointer;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
            transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
            text-decoration: none;
            text-align: center;
            width: 120px;
        }

        .checkout-button:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.4);
        }
    </style>
</head>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const items = [
            { key: "selectedCpu", elementId: "cpu-title", fallback: "CPU" },
            { key: "selectedGpu", elementId: "gpu-title", fallback: "Video Card" },
            { key: "selectedMb", elementId: "motherboard-title", fallback: "Motherboard" },
            { key: "selectedPsu", elementId: "psu-title", fallback: "Power Supply" },
            { key: "selectedCpuCooler", elementId: "cooler-title", fallback: "CPU Cooler" },
            { key: "selectedCase", elementId: "case-title", fallback: "CPU Case" },
            { key: "selectedFan", elementId: "fan-title", fallback: "Case Fan" },
            { key: "selectedMemory", elementId: "memory-title", fallback: "Memory" },
            { key: "selectedOs", elementId: "os-title", fallback: "Operating System" },
            { key: "selectedTp", elementId: "tp-title", fallback: "Thermal Paste" },
            { key: "selectedIhd", elementId: "ihd-title", fallback: "Internal Hard Drive" },
            { key: "selectedEhd", elementId: "ehd-title", fallback: "External Hard Drive" },
            { key: "selectedFanCtrl", elementId: "fanctrl-title", fallback: "Fan Controller" }
        ];

        items.forEach(({ key, elementId, fallback }) => {
            const data = localStorage.getItem(key);
            const element = document.getElementById(elementId);
            if (data && element) {
                try {
                    const parsed = JSON.parse(data);
                    if (parsed && parsed.name) {
                        element.textContent = parsed.name;
                    } else {
                        element.textContent = fallback;
                    }
                } catch (e) {
                    console.error(`Error parsing ${key}`, e);
                    element.textContent = fallback;
                }
            }
        });
    });
</script>

<body>
    <header>
        <h1 class="page-title">Build Your Own PC</h1>
    </header>

    <!-- Cards Container -->
    <div class="cards-container">
        <a href="/cpupage" class="card">
            <img src="views/images/cpu.webp" alt="CPU">
            <h2 id="cpu-title">CPU</h2>
        </a>

        <a href="/video-cardpage" class="card">
            <img src="views/images/gpu.JPG" alt="GPU">
            <h2 id="gpu-title">Video Card</h2>
        </a>

        <a href="/motherboardpage" class="card">
            <img src="views/images/motherboard.webp" alt="Motherboard">
            <h2 id="motherboard-title">Motherboard</h2>
        </a>

        <a href="/power-supplypage" class="card">
            <img src="views/images/power-supply.webp" alt="Power Supply">
            <h2 id="psu-title">Power Supply</h2>
        </a>

        <a href="/cpu-coolerpage" class="card">
            <img src="views/images/cooler.jpg" alt="CPU Cooler">
            <h2 id="cooler-title">CPU Cooler</h2>
        </a>

        <a href="/case-tablepage" class="card">
            <img src="views/images/cpu-case.jpg" alt="CPU-Case">
            <h2 id="case-title">CPU Case</h2>
        </a>

        <a href="/case-fanpage" class="card">
            <img src="views/images/cpu-fan.webp" alt="CPU-Fan">
            <h2 id="fan-title">Case Fan</h2>
        </a>

        <a href="/memorypage" class="card">
            <img src="views/images/memory.jpeg" alt="Memory">
            <h2 id="memory-title">Memory</h2>
        </a>

        <a href="/ospage" class="card">
            <img src="views/images/os.jpeg" alt="OS">
            <h2 id="os-title">Operating System</h2>
        </a>

        <a href="/thermal-pastepage" class="card">
            <img src="views/images/thermel paste.jpeg" alt="Thermal Paste">
            <h2 id="tp-title">Thermal Paste</h2>
        </a>

        <a href="/internal-hard-drivepage" class="card">
            <img src="views/images/ihd.jpeg" alt="Internal Hard Drive">
            <h2 id="ihd-title">Internal Hard Drive</h2>
        </a>

        <a href="/external-hard-drivepage" class="card">
            <img src="views/images/ehd.jpeg" alt="External Hard Drive">
            <h2 id="ehd-title">External Hard Drive</h2>
        </a>

        <a href="/fan-controllerpage" class="card">
            <img src="views/images/fan-controller.jpeg" alt="Fan Controller">
            <h2 id="fanctrl-title">Fan Controller</h2>
        </a>
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
                    Signup to save build
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <br>
    <div class="dropdown-content" id="dropdownMenu">
        <ul>
            <li><a href="/home">Go to Forums Page</a></li>
            <li><a href="/builds">View Builds</a></li>
            <li><a href="/home-pc" onclick="confirmLogout(event)">Logout</a></li>
        </ul>
    </div>

    <!-- Checkout Button -->
    <a href="/checkout" class="checkout-button">Checkout</a>
    <a href="/budget-planner" class="checkout-button">Reccomed PC</a>

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
        if (confirm('Are you sure you want to logout? Session will be lost if not saved')) {
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