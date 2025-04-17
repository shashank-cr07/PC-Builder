<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>PC Build Checkout | Compatibility & Performance Scores</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Orbitron:wght@600&display=swap');

        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: #1d1d1d;
            color: #ffffff;
            padding: 2rem;
        }

        body.modal-open {
            overflow: hidden;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }

        .header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .page-title {
            font-size: 2.5rem;
            font-family: 'Orbitron', sans-serif;
            background: linear-gradient(90deg, #00ffe7, #ff00c8);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 0 0 10px #ff00c855;
            margin-bottom: 1rem;
        }

        .scores-container {
            display: flex;
            justify-content: space-around;
            margin-bottom: 3rem;
        }

        .score-card {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 1rem;
            padding: 2rem;
            width: 45%;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .score-value {
            font-size: 3rem;
            font-weight: bold;
            margin: 1rem 0;
        }

        .compatibility-score {
            color: #00ffe7;
        }

        .performance-score {
            color: #ff00c8;
        }

        .issues-container {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 1rem;
            padding: 2rem;
            margin-top: 2rem;
        }

        .issues-title {
            font-size: 1.5rem;
            margin-bottom: 1rem;
            color: #ff4444;
        }

        .issue-item {
            margin: 0.5rem 0;
            padding: 0.5rem;
            background: rgba(255, 68, 68, 0.1);
            border-radius: 0.5rem;
        }

        .button-container {
            text-align: center;
            margin-top: 2rem;
            display: flex;
            justify-content: center;
            gap: 1rem;
        }

        .back-button, .confirm-build-button {
            display: inline-block;
            padding: 1rem 2rem;
            background: linear-gradient(90deg, #00ffe7, #ff00c8);
            color: white;
            text-decoration: none;
            border-radius: 0.5rem;
            font-weight: bold;
            transition: transform 0.2s;
            cursor: pointer;
            border: none;
        }

        .back-button:hover, .confirm-build-button:hover {
            transform: scale(1.05);
        }

        /* Modal Styles */
        #overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.7);
            z-index: 999;
            display: none;
        }

        #buildNameModal {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 1rem;
            padding: 2rem;
            z-index: 1000;
            max-width: 400px;
            width: 90%;
            display: none;
            box-shadow: 0 0 20px rgba(255, 0, 200, 0.3);
            border: 1px solid #ff00c8;
        }

        #buildNameModal h3 {
            font-family: 'Orbitron', sans-serif;
            color: #00ffe7;
            margin-top: 0;
            text-align: center;
        }

        #buildNameInput {
            width: 100%;
            padding: 0.75rem;
            margin: 1rem 0;
            border: 1px solid #ff00c8;
            border-radius: 0.5rem;
            background: rgba(255, 255, 255, 0.05);
            color: #ffffff;
            font-size: 1rem;
        }

        #buildNameInput:focus {
            outline: none;
            border-color: #00ffe7;
            box-shadow: 0 0 5px #00ffe7;
        }

        #doneButton {
            display: block;
            width: 100%;
            padding: 0.75rem;
            background: linear-gradient(90deg, #00ffe7, #ff00c8);
            color: white;
            border: none;
            border-radius: 0.5rem;
            font-weight: bold;
            cursor: pointer;
            transition: transform 0.2s;
        }

        #doneButton:hover {
            transform: scale(1.05);
        }

        #closeModal {
            position: absolute;
            top: 10px;
            right: 10px;
            background: none;
            border: none;
            color: #ff00c8;
            font-size: 1.5rem;
            cursor: pointer;
        }

        /* Build Name Card */
        #buildNameCard {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 1rem;
            padding: 2rem;
            margin-top: 3rem;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            display: none;
        }

        #buildNameCard h3 {
            font-family: 'Orbitron', sans-serif;
            color: #ff00c8;
            margin-top: 0;
        }

        #buildNameText {
            font-size: 1.5rem;
            color: #00ffe7;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1 class="page-title">Your PC Build Analysis</h1>
        </div>

        <div class="scores-container">
            <div class="score-card">
                <h2>Compatibility Score</h2>
                <div class="score-value compatibility-score"><span id="compatibilityScore">0</span>%</div>
                <p>Measures how well your components work together</p>
            </div>

            <div class="score-card">
                <h2>Performance Score</h2>
                <div class="score-value performance-score"><span id="performanceScore">0</span>%</div>
                <p>Estimates your system's overall performance potential</p>
            </div>
        </div>

        <c:if test="${not empty compatibilityIssues}">
            <div class="issues-container">
                <h3 class="issues-title">Compatibility Issues</h3>
                <c:forEach items="${compatibilityIssues}" var="issue">
                    <div class="issue-item">${issue}</div>
                </c:forEach>
            </div>
        </c:if>

        <div class="button-container">
            <a href="/home-pc" class="back-button">Back to Builder</a>
            <button class="confirm-build-button" onclick="confirmBuild()">Confirm Build</button>
        </div>

        <!-- Modal for Build Name Input -->
        <div id="overlay"></div>
        <div id="buildNameModal">
            <button id="closeModal">×</button>
            <h3>Name Your Build</h3>
            <input type="text" id="buildNameInput" placeholder="Enter build name" />
            <button id="doneButton" >Done</button>
        </div>

        <!-- Build Name Card -->
        <div id="buildNameCard">
            <h3>Your PC Build</h3>
            <div id="buildNameText"></div>
        </div>
    </div>

    <script>
        // Load saved build name from localStorage on page load
        document.addEventListener('DOMContentLoaded', function() {
            const savedBuildName = localStorage.getItem('buildName');
            if (savedBuildName) {
                showBuildNameCard(savedBuildName);
            }

            // Retrieve all PC build parts from localStorage
            const components = {
                cpu: JSON.parse(localStorage.getItem('selectedCpu') || 'null'),
                motherboard: JSON.parse(localStorage.getItem('selectedMb') || 'null'),
                memory: JSON.parse(localStorage.getItem('selectedMemory') || 'null'),
                videoCard: JSON.parse(localStorage.getItem('selectedGpu') || 'null'),
                powerSupply: JSON.parse(localStorage.getItem('selectedPsu') || 'null'),
                caseTable: JSON.parse(localStorage.getItem('selectedCase') || 'null'),
                cpuCooler: JSON.parse(localStorage.getItem('selectedCpuCooler') || 'null'),
                internalHardDrive: JSON.parse(localStorage.getItem('selectedIhd') || 'null'),
                externalHardDrive: JSON.parse(localStorage.getItem('selectedEhd') || 'null'),
                fanController: JSON.parse(localStorage.getItem('selectedFanCtrl') || 'null'),
                caseFan: JSON.parse(localStorage.getItem('selectedFan') || 'null'),
                thermalPaste: JSON.parse(localStorage.getItem('selectedTp') || 'null'),
                os: JSON.parse(localStorage.getItem('selectedOs') || 'null')
            };

            // Create the request body in the required format
            const requestBody = {
                cpu: components.cpu ? { id: components.cpu.id } : null,
                motherboard: components.motherboard ? { id: components.motherboard.id } : null,
                memory: components.memory ? { id: components.memory.id } : null,
                videoCard: components.videoCard ? { id: components.videoCard.id } : null,
                powerSupply: components.powerSupply ? { id: components.powerSupply.id } : null,
                caseTable: components.caseTable ? { id: components.caseTable.id } : null,
                cpuCooler: components.cpuCooler ? { id: components.cpuCooler.id } : null,
                internalHardDrive: components.internalHardDrive ? { id: components.internalHardDrive.id } : null,
                externalHardDrive: components.externalHardDrive ? { id: components.externalHardDrive.id } : null,
                fanController: components.fanController ? { id: components.fanController.id } : null,
                caseFan: components.caseFan ? { id: components.caseFan.id } : null,
                thermalPaste: components.thermalPaste ? { id: components.thermalPaste.id } : null,
                os: components.os ? { id: components.os.id } : null
            };

            // Send the POST request
            fetch('http://localhost:8080/api/score/total', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(requestBody)
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                console.log('Score results:', data);
                // Update score displays
                const compatibility = data[0] !== undefined ? data[0] : 0;
                const performance = data[1] !== undefined ? data[1] : 0;
                document.getElementById('compatibilityScore').textContent = compatibility;
                document.getElementById('performanceScore').textContent = performance;
            })
            .catch(error => {
                console.error('Error:', error);
                // Display fallback scores
                document.getElementById('compatibilityScore').textContent = 0;
                document.getElementById('performanceScore').textContent = 0;
                alert('Failed to fetch scores. Displaying default values.');
            });
        });

        function confirmBuild() {
            // Clear input and show modal
            document.getElementById('buildNameInput').value = '';
            document.body.classList.add('modal-open');
            document.getElementById('overlay').style.display = 'block';
            document.getElementById('buildNameModal').style.display = 'block';
            document.getElementById('buildNameInput').focus();
        }

        function showBuildNameCard(buildName) {
            document.getElementById('buildNameText').textContent = buildName;
            document.getElementById('buildNameCard').style.display = 'block';
            // Save to localStorage
            localStorage.setItem('buildName', buildName);

        }

        // Done button event listener
        document.getElementById('doneButton').addEventListener('click', function() {
            const buildName = document.getElementById('buildNameInput').value.trim();
            if (buildName) {
                showBuildNameCard(buildName);
                closeModal();
                sendPcName();
            } else {
                alert('Please enter a build name.');
            }
        });
        async function sendPcName() {
        const pcName = localStorage.getItem('buildName');
        const pcId = localStorage.getItem('pcId');
        fetch("http://localhost:8080/api/score/add-name?pcId="+pcId, {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                partType: "name",
                partId: pcName
            })
        })
        .then(response => {
            if (response.ok) {
                alert("PC name added successfully!");
            } else {
                alert("Failed to add PC name.");
            }
        })
        .catch(error => {
            console.error("Error:", error);
            alert("Error sending data.");
        });
    }
        // Close modal event listeners
        document.getElementById('closeModal').addEventListener('click', closeModal);
        document.getElementById('overlay').addEventListener('click', closeModal);

        function closeModal() {
            document.body.classList.remove('modal-open');
            document.getElementById('overlay').style.display = 'none';
            document.getElementById('buildNameModal').style.display = 'none';
        }
    </script>
</body>
</html>