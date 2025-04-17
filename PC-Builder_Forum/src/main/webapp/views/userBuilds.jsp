<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Your PC Builds</title>
    <style>
        body {
            font-family: sans-serif;
            margin: 0;
            background-color: #000; /* Black background */
            color: #fff; /* White text */
        }
        .header h2 {
    position: absolute;
    left: 50%;
    transform: translateX(-50%);
    margin: 0;
    font-size: 24px;
    color: #f00;
}

        .header {
            background-color: #111;
            color: #fff;
            padding: 1rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid #f00;
            position: relative;
        }

        h2 {
            color: #f00;
            text-align: center;
            margin-top: 2rem;
        }

        .builds-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding-top: 2rem;
            padding-bottom: 2rem;
        }

        .build-card {
            border: 1px solid #333;
            padding: 16px;
            margin: 12px;
            border-radius: 10px;
            background-color: #111;
            width: 90%;
            max-width: 600px;
        }

        .build-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 8px;
            color: #fff;
        }

        .build-card p {
            margin-bottom: 0.5rem;
            color: #ddd;
        }

        .build-card strong {
            color: #f00;
        }

        .user-info {
            position: absolute;
            top: 1rem;
            right: 1rem;
            display: flex;
            align-items: center;
        }

        .user-info img {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            cursor: pointer;
            object-fit: cover;
        }

        .user-info span {
            margin-left: 0.5rem;
            cursor: pointer;
            color: #fff;
        }

        .user-dropdown {
            position: absolute;
            top: calc(100% + 0.5rem);
            right: 0;
            background-color: #222;
            border: 1px solid #f00;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
            z-index: 10;
            display: none;
            min-width: 120px;
        }

        .user-dropdown.show {
            display: block;
        }

        .user-dropdown ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .user-dropdown ul li a {
            display: block;
            padding: 0.75rem 1rem;
            text-decoration: none;
            color: #fff;
            transition: background-color 0.3s ease;
        }

        .user-dropdown ul li a:hover {
            background-color: #f00;
            color: #000;
        }
    </style>
</head>
<body>

    <div class="header">
        <div>
            <a href="/"
               style="color: #fff; text-decoration: none; padding: 0.5rem 1rem; border: 1px solid #f00; border-radius: 5px; transition: background-color 0.3s ease;"
               onmouseover="this.style.backgroundColor='#f00'; this.style.color='#000';"
               onmouseout="this.style.backgroundColor='transparent'; this.style.color='#fff';">Back</a>
        </div>
    
        <h2>Your PC Builds</h2>
    
        <div class="user-info" id="user-info">
            <img src="/images/user-icon.jpg" alt="User Icon" onclick="toggleMenu()">
            <span onclick="toggleMenu()">${username}</span>
            <div class="user-dropdown" id="user-dropdown">
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
    

    <div class="builds-container">
        <c:forEach var="pc" items="${pcBuilds}">
            <div class="build-card">
                <div class="build-title">Build : ${pc.name}</div>
    
                <c:if test="${pc.cpu != null}">
                    <p><strong>CPU:</strong> ${pc.cpu.name}</p>
                </c:if>
    
                <c:if test="${pc.videoCard != null}">
                    <p><strong>GPU:</strong> ${pc.videoCard.name}</p>
                </c:if>
    
                <c:if test="${pc.memory != null}">
                    <p><strong>RAM:</strong> ${pc.memory.name}</p>
                </c:if>
    
                <c:if test="${pc.motherboard != null}">
                    <p><strong>Motherboard:</strong> ${pc.motherboard.name}</p>
                </c:if>
    
                <c:if test="${pc.internalHardDrive != null}">
                    <p><strong>Storage:</strong> ${pc.internalHardDrive.capacity} GB</p>
                </c:if>
    
                <c:if test="${pc.externalHardDrive != null}">
                    <p><strong>External Storage:</strong> ${pc.externalHardDrive.capacity} GB</p>
                </c:if>
    
                <c:if test="${pc.powerSupply != null}">
                    <p><strong>Power Supply:</strong> ${pc.powerSupply.name}</p>
                </c:if>
    
                <c:if test="${pc.caseTable != null}">
                    <p><strong>Case:</strong> ${pc.caseTable.name}</p>
                </c:if>
    
                <c:if test="${pc.cpuCooler != null}">
                    <p><strong>CPU Cooler:</strong> ${pc.cpuCooler.name}</p>
                </c:if>
    
                <c:if test="${pc.fanController != null}">
                    <p><strong>Fan Controller:</strong> ${pc.fanController.name}</p>
                </c:if>
    
                <c:if test="${pc.caseFan != null}">
                    <p><strong>Case Fan:</strong> ${pc.caseFan.name}</p>
                </c:if>
    
                <c:if test="${pc.thermalPaste != null}">
                    <p><strong>Thermal Paste:</strong> ${pc.thermalPaste.name}</p>
                </c:if>
    
                <c:if test="${pc.os != null}">
                    <p><strong>Operating System:</strong> ${pc.os.name}</p>
                </c:if>
            </div>
        </c:forEach>
    </div>
    

<script>
    function toggleMenu() {
        document.getElementById('user-dropdown').classList.toggle('show');
    }

    window.addEventListener('click', function (e) {
        if (!document.getElementById('user-info').contains(e.target)) {
            document.getElementById('user-dropdown').classList.remove('show');
        }
    });
</script>

</body>
</html>