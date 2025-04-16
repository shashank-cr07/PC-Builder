<!DOCTYPE html>
<html>
<head>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap');
        
        /* Back to Main Menu Button */
        #backToMainMenu {
            position: fixed;
            top: 20px;
            left: 20px;
            padding: 10px 20px;
            background-color: #444;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-family: 'Inter', sans-serif;
            font-size: 14px;
            z-index: 100;
            transition: background-color 0.3s ease;
        }

        #backToMainMenu:hover {
            background-color: #555;
        }

        .heading-container {
            display: flex;
            justify-content: center;
            margin-top: 80px;
            position: relative;
        }

        .geometric-border {
            padding: 20px 40px;
            border: 4px solid #888;
            border-radius: 16px;
            background: linear-gradient(135deg, rgba(255,255,255,0.05), rgba(255,255,255,0.02));
            box-shadow: 0 0 20px rgba(255, 255, 255, 0.05), 0 0 60px rgba(255, 255, 255, 0.02);
            position: relative;
            z-index: 1;
        }

        .FanCtrlHeading {
            font-size: 3.5rem;
            font-family: "Moonscape";
            background: linear-gradient(to right, #a09d9d, #424444);
            -webkit-text-fill-color: black;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        body {
            margin: 0;
            font-family: 'Inter', sans-serif;
            background: linear-gradient(to bottom, #090101 0%, #1e1e1e 100%);
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            color: #f0f0f0;
        }

        #mainContent {
            display: flex;
            flex-direction: row;
            justify-content: space-around;
            align-items: flex-start;
            padding: 30px 60px;
            gap: 60px;
            flex-wrap: wrap;
        }

        #fanCtrlOutput {
            flex: 1;
            min-width: 280px;
            max-width: 350px;
            padding: 24px;
            border-radius: 16px;
            background-color: #1f1f1f;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
            color: #e2e2e2;
        }

        #fanCtrlOutput p {
            font-size: 15px;
            margin: 12px 0;
            line-height: 1.6;
        }

        #fanCtrlOutput strong {
            color: #ffffff;
            font-weight: 600;
        }

        #fanCtrlOutput span {
            color: #aaa;
        }

        #searchBarContainer {
            display: flex;
            align-items: center;
            gap: 12px;
            margin: 30px 60px 10px;
            flex-wrap: wrap;
        }

        #fanCtrlNameInput {
            padding: 10px;
            font-size: 14px;
            border-radius: 8px;
            border: 1px solid #444;
            background-color: #1a1a1a;
            color: #fff;
            width: 160px;
        }

        #searchBarContainer button,
        #paginationContainer button {
            padding: 10px 18px;
            font-size: 14px;
            background-color: #333;
            border: none;
            border-radius: 8px;
            color: #fff;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        #searchBarContainer button:hover,
        #paginationContainer button:hover {
            background-color: #555;
        }

        #allFanCtrlOutput {
            flex: 2;
            min-width: 600px;
            margin-top: 20px;
            overflow-x: auto;
        }

        #allFanCtrl {
            border-collapse: collapse;
            width: 100%;
            background-color: #141414;
            color: #fff;
            font-size: 14px;
            border-radius: 8px;
            overflow: hidden;
        }

        #allFanCtrl th,
        #allFanCtrl td {
            border: 1px solid #2c2c2c;
            padding: 14px 18px;
            text-align: center;
        }

        #allFanCtrl th {
            background-color: #1e1e1e;
            font-weight: 600;
        }

        #allFanCtrl tbody tr {
            cursor: pointer;
            transition: background-color 0.2s;
        }

        #allFanCtrl tbody tr:nth-child(odd) {
            background-color: #1a1a1a;
        }

        #allFanCtrl tbody tr:hover {
            background-color: #292929;
        }

        #allFanCtrl tbody tr.selected {
            background-color: #2a4a2a;
        }

        #paginationContainer {
            margin: 30px 60px;
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        /* Modal Styles */
        #fanCtrlDetails {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #2a2a2a;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.6);
            z-index: 1000;
            max-width: 500px;
            width: 80%;
            display: none;
        }

        #fanCtrlDetails h3 {
            margin-top: 0;
            color: #fff;
            border-bottom: 1px solid #444;
            padding-bottom: 10px;
        }

        #fanCtrlDetails p {
            margin: 10px 0;
            color: #d1caca;
        }

        #closeDetails {
            position: absolute;
            top: 10px;
            right: 10px;
            background: none;
            border: none;
            color: #d1caca;
            font-size: 20px;
            cursor: pointer;
        }

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

        #addToBuildBtn {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 12px 24px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 20px 0 0 0;
            cursor: pointer;
            border-radius: 8px;
            transition: all 0.3s ease;
            width: 100%;
        }

        #addToBuildBtn:hover {
            background-color: #45a049;
            transform: translateY(-2px);
        }

        #addToBuildBtn.remove {
            background-color: #f44336;
        }

        #addToBuildBtn.remove:hover {
            background-color: #d32f2f;
        }

        #buildNotification {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background-color: #4CAF50;
            color: white;
            padding: 15px;
            border-radius: 8px;
            z-index: 1000;
            display: none;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
        }

        #selectedFanCtrlDisplay {
            margin: 20px 60px;
            padding: 20px;
            background-color: #1f1f1f;
            border-radius: 12px;
            display: none;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }

        #selectedFanCtrlDisplay h3 {
            margin-top: 0;
            color: #4CAF50;
            border-bottom: 1px solid #333;
            padding-bottom: 10px;
        }

        #selectedFanCtrlDisplay p {
            margin: 8px 0;
        }

        #removeSelectedFanCtrl {
            background-color: #f44336;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            margin-top: 15px;
            transition: background-color 0.3s;
        }

        #removeSelectedFanCtrl:hover {
            background-color: #d32f2f;
        }

        @media (max-width: 768px) {
            #backToMainMenu {
                top: 10px;
                left: 10px;
                padding: 8px 16px;
            }
            
            .heading-container {
                margin-top: 60px;
            }

            #mainContent {
                flex-direction: column;
                padding: 20px;
                gap: 30px;
            }

            #searchBarContainer,
            #paginationContainer {
                margin: 20px;
                justify-content: center;
            }

            #allFanCtrlOutput {
                min-width: unset;
                width: 100%;
            }

            #fanCtrlDetails {
                width: 90%;
                padding: 20px;
            }

            .FanCtrlHeading {
                font-size: 2.5rem;
            }
        }
    </style>
</head>
<body>

    <!-- Back to Main Menu Button -->
    <button id="backToMainMenu">Back to Main Menu</button>

    <div class="heading-container">
        <div class="geometric-border">
            <h2 class="FanCtrlHeading">Fan Controller</h2>
        </div>
    </div>

    <!-- Selected Fan Controller Display -->
    <div id="selectedFanCtrlDisplay">
        <h3>Your Selected Fan Controller</h3>
        <p><strong>Name:</strong> <span id="selectedFanCtrlName"></span></p>
        <p><strong>Price:</strong> $<span id="selectedFanCtrlPrice"></span></p>
        <p><strong>Channels:</strong> <span id="selectedFanCtrlChannels"></span></p>
        <p><strong>Channel Wattage:</strong> <span id="selectedFanCtrlChannelWattage"></span></p>
        <p><strong>PWM:</strong> <span id="selectedFanCtrlPwm"></span></p>
        <button id="removeSelectedFanCtrl">Remove Selection</button>
    </div>

    <!-- Input and Buttons -->
    <div id="searchBarContainer">
        <input type="text" id="fanCtrlNameInput" placeholder="Search Fan Controllers" />
        <button onclick="searchFanCtrl()">Search</button>
        <button onclick="clearSearch()">Clear search</button>
    </div>

    <!-- Output & Table Side-by-side -->
    <div id="mainContent">
        <!-- Fan Controller Table -->
        <div id="allFanCtrlOutput">
            <table id="allFanCtrl">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Price</th>
                        <th>Channels</th>
                        <th>Channel Wattage</th>
                        <th>PWM</th>
                        <th>Color</th>
                        <th>Form Factor</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Data will be appended here -->
                </tbody>    
            </table>
        </div>
    </div>

    <!-- Pagination Buttons -->
    <div id="paginationContainer">
        <button onclick="previousPage()">Previous</button>
        <button onclick="nextPage()">Next</button>
    </div>

    <!-- Fan Controller Details Modal -->
    <div id="overlay"></div>
    <div id="fanCtrlDetails">
        <button id="closeDetails">&times;</button>
        <h3 id="detailsName"></h3>
        <p><strong>ID:</strong> <span id="detailsId"></span></p>
        <p><strong>Price:</strong> $<span id="detailsPrice"></span></p>
        <p><strong>Channels:</strong> <span id="detailsChannels"></span></p>
        <p><strong>Channel Wattage:</strong> <span id="detailsChannelWattage"></span></p>
        <p><strong>PWM:</strong> <span id="detailsPwm"></span></p>
        <p><strong>Color:</strong> <span id="detailsColor"></span></p>
        <p><strong>Form Factor:</strong> <span id="detailsFormFactor"></span></p>
        <button id="addToBuildBtn">Add to Build</button>
    </div>

    <!-- Notification -->
    <div id="buildNotification"></div>

    <script>
        // Global variables
        let allFanCtrlData = [];
        let currentPage = 0;
        const pageSize = 15;
        let currentSelectedFanCtrl = null;
        let selectedFanCtrl = null;

        // Back to Main Menu functionality
        document.getElementById('backToMainMenu').addEventListener('click', function() {
            window.location.href = '/home-pc';
        });

        // Load saved selection from localStorage
        function loadSelectedFanCtrl() {
            const savedFanCtrl = localStorage.getItem('selectedFanCtrl');
            if (savedFanCtrl) {
                try {
                    selectedFanCtrl = JSON.parse(savedFanCtrl);
                    updateSelectedFanCtrlDisplay();
                    // Find the complete fan controller data from allFanCtrlData
                    if (selectedFanCtrl && allFanCtrlData.length > 0) {
                        const completeFanCtrl = allFanCtrlData.find(f => f.id === selectedFanCtrl.id);
                        if (completeFanCtrl) {
                            selectedFanCtrl = completeFanCtrl;
                        }
                    }
                } catch (e) {
                    console.error("Error parsing saved fan controller:", e);
                    localStorage.removeItem('selectedFanCtrl');
                }
            }
        }

        // Save selection to localStorage
        function saveSelectedFanCtrl() {
            if (selectedFanCtrl) {
                localStorage.setItem('selectedFanCtrl', JSON.stringify({
                    id: selectedFanCtrl.id,
                    name: selectedFanCtrl.name,
                    price: selectedFanCtrl.price,
                    channels: selectedFanCtrl.channels,
                    channelWattage: selectedFanCtrl.channelWattage,
                    pwm: selectedFanCtrl.pwm,
                    // Include other minimal necessary properties
                }));
            } else {
                localStorage.removeItem('selectedFanCtrl');
            }
        }

        function clearSearch() {
            document.getElementById("fanCtrlNameInput").value = "";
            fetchAllFanCtrls();
        }

        // Fetch all Fan Controllers from the backend
        function fetchAllFanCtrls() {
            $.ajax({
                url: '/fan-controller',
                method: 'GET',
                success: function(fanCtrlList) {
                    allFanCtrlData = fanCtrlList;
                    currentPage = 0;
                    displayFanCtrlPage(currentPage);
                    // After loading data, check if we have a saved selection
                    loadSelectedFanCtrl();
                    // Highlight the saved selection in the table if it exists
                    if (selectedFanCtrl) {
                        highlightSelectedFanCtrlInTable();
                    }
                },
                error: function() {
                    alert('Failed to fetch fan controllers.');
                }
            });
        }

        // Highlight the selected fan controller in the table
        function highlightSelectedFanCtrlInTable() {
            const rows = document.querySelectorAll("#allFanCtrl tbody tr");
            rows.forEach(row => {
                if (selectedFanCtrl && row.cells[0].textContent === selectedFanCtrl.id.toString()) {
                    row.classList.add('selected');
                } else {
                    row.classList.remove('selected');
                }
            });
        }

        // Display a page of data
        function displayFanCtrlPage(page) {
            const tableBody = document.querySelector("#allFanCtrl tbody");
            tableBody.innerHTML = "";
            const startIndex = page * pageSize;
            const endIndex = startIndex + pageSize;
            const pageData = allFanCtrlData.slice(startIndex, endIndex);
            pageData.forEach(f => {
                addFanCtrlRow(f);
            });
            
            // Re-highlight selected fan controller after rendering
            if (selectedFanCtrl) {
                highlightSelectedFanCtrlInTable();
            }
        }

        // Append a single row to the table
        function addFanCtrlRow(entry) {
            const tableBody = document.querySelector("#allFanCtrl tbody");
            const row = document.createElement("tr");
            
            // Highlight if this is the selected fan controller
            if (selectedFanCtrl && selectedFanCtrl.id === entry.id) {
                row.classList.add('selected');
            }
            
            row.innerHTML = "<td>" + entry.id + "</td>" +
                            "<td>" + entry.name + "</td>" +
                            "<td>" + (entry.price ? "$" + entry.price : "Out Of stock") + "</td>" +
                            "<td>" + entry.channels + "</td>" +
                            "<td>" + (entry.channelWattage ? entry.channelWattage + "W" : "N/A") + "</td>" +
                            "<td>" + entry.pwm + "</td>" +
                            "<td>" + (entry.color || "N/A") + "</td>" +
                            "<td>" + entry.formFactor + "</td>";
            
            row.addEventListener('click', function() {
                handleRowClick(entry);
            });
            
            tableBody.appendChild(row);
        }

        // Handle row click with confirmation logic
        function handleRowClick(f) {
            currentSelectedFanCtrl = f;
            
            if (selectedFanCtrl && selectedFanCtrl.id === f.id) {
                // Clicked on already selected fan controller - ask to deselect
                if (confirm("Do you want to remove this fan controller from your build?")) {
                    removeSelectedFanCtrl();
                }
            } else if (selectedFanCtrl) {
                // Already have a selected fan controller - ask to replace
                if (confirm(`You already have ${selectedFanCtrl.name} selected. Replace it with ${f.name}?`)) {
                    setSelectedFanCtrl(f);
                }
            } else {
                // No fan controller selected - just select this one
                setSelectedFanCtrl(f);
            }
            
            // Show details in modal
            showFanCtrlDetails(f);
        }

        // Set the selected fan controller
        function setSelectedFanCtrl(f) {
            // Remove previous selection highlight
            if (selectedFanCtrl) {
                const rows = document.querySelectorAll("#allFanCtrl tbody tr");
                rows.forEach(row => {
                    if (row.cells[0].textContent === selectedFanCtrl.id.toString()) {
                        row.classList.remove('selected');
                    }
                });
            }
            
            selectedFanCtrl = f;
            
            // Add new selection highlight
            highlightSelectedFanCtrlInTable();
            
            // Update the selected fan controller display
            updateSelectedFanCtrlDisplay();
            
            // Save to localStorage
            saveSelectedFanCtrl();
            
            // Show notification
            showNotification(`${f.name} added to your build!`);
        }

        // Remove the selected fan controller
        function removeSelectedFanCtrl() {
            if (!selectedFanCtrl) return;
            
            const fanCtrlName = selectedFanCtrl.name;
            
            // Remove selection highlight
            const rows = document.querySelectorAll("#allFanCtrl tbody tr");
            rows.forEach(row => {
                if (row.cells[0].textContent === selectedFanCtrl.id.toString()) {
                    row.classList.remove('selected');
                }
            });
            
            selectedFanCtrl = null;
            
            // Hide the selected fan controller display
            document.getElementById('selectedFanCtrlDisplay').style.display = 'none';
            
            // Clear from localStorage
            saveSelectedFanCtrl();
            
            // Show notification
            showNotification(`${fanCtrlName} removed from your build!`);
        }

        // Update the selected fan controller display panel
        function updateSelectedFanCtrlDisplay() {
            if (selectedFanCtrl) {
                document.getElementById('selectedFanCtrlName').textContent = selectedFanCtrl.name;
                document.getElementById('selectedFanCtrlPrice').textContent = selectedFanCtrl.price ? "$" + selectedFanCtrl.price : "Out Of stock";
                document.getElementById('selectedFanCtrlChannels').textContent = selectedFanCtrl.channels;
                document.getElementById('selectedFanCtrlChannelWattage').textContent = selectedFanCtrl.channelWattage ? selectedFanCtrl.channelWattage + "W" : "N/A";
                document.getElementById('selectedFanCtrlPwm').textContent = selectedFanCtrl.pwm;
                document.getElementById('selectedFanCtrlDisplay').style.display = 'block';
            } else {
                document.getElementById('selectedFanCtrlDisplay').style.display = 'none';
            }
        }

        // Show fan controller details in modal
        function showFanCtrlDetails(f) {
            currentSelectedFanCtrl = f;
            document.getElementById('detailsId').textContent = f.id;
            document.getElementById('detailsName').textContent = f.name;
            document.getElementById('detailsPrice').textContent = f.price ? "$" + f.price : "Out Of stock";
            document.getElementById('detailsChannels').textContent = f.channels;
            document.getElementById('detailsChannelWattage').textContent = f.channelWattage ? f.channelWattage + "W" : "N/A";
            document.getElementById('detailsPwm').textContent = f.pwm;
            document.getElementById('detailsColor').textContent = f.color || "N/A";
            document.getElementById('detailsFormFactor').textContent = f.formFactor;
            
            // Update Add to Build button text and color
            const addButton = document.getElementById('addToBuildBtn');
            if (selectedFanCtrl && selectedFanCtrl.id === f.id) {
                addButton.textContent = 'Remove from Build';
                addButton.classList.add('remove');
            } else {
                addButton.textContent = 'Add to Build';
                addButton.classList.remove('remove');
            }
            
            document.getElementById('overlay').style.display = 'block';
            document.getElementById('fanCtrlDetails').style.display = 'block';
        }

        // Add to Build button functionality
        document.getElementById('addToBuildBtn').addEventListener('click', function() {
            if (!currentSelectedFanCtrl) return;
            
            if (selectedFanCtrl && selectedFanCtrl.id === currentSelectedFanCtrl.id) {
                // Clicked remove
                removeSelectedFanCtrl();
            } else if (selectedFanCtrl) {
                // Confirm replacement
                if (confirm(`Replace ${selectedFanCtrl.name} with ${currentSelectedFanCtrl.name}?`)) {
                    setSelectedFanCtrl(currentSelectedFanCtrl);
                }
            } else {
                // Just add
                setSelectedFanCtrl(currentSelectedFanCtrl);
            }
            
            closeModal();
        });

        // Remove Selected Fan Controller button functionality
        document.getElementById('removeSelectedFanCtrl').addEventListener('click', function() {
            if (selectedFanCtrl) {
                if (confirm(`Remove ${selectedFanCtrl.name} from your build?`)) {
                    removeSelectedFanCtrl();
                }
            }
        });

        function showNotification(message) {
            const notification = document.getElementById('buildNotification');
            notification.textContent = message;
            notification.style.display = 'block';
            
            // Hide after 3 seconds
            setTimeout(function() {
                notification.style.display = 'none';
            }, 3000);
        }

        // Close modal
        document.getElementById('closeDetails').addEventListener('click', function() {
            closeModal();
        });
        
        // Close modal when clicking on overlay
        document.getElementById('overlay').addEventListener('click', function() {
            closeModal();
        });

        function closeModal() {
            document.getElementById('overlay').style.display = 'none';
            document.getElementById('fanCtrlDetails').style.display = 'none';
        }

        // Pagination functions
        function nextPage() {
            if ((currentPage + 1) * pageSize < allFanCtrlData.length) {
                currentPage++;
                displayFanCtrlPage(currentPage);
            } else {
                alert("No more data.");
            }
        }

        function previousPage() {
            if (currentPage > 0) {
                currentPage--;
                displayFanCtrlPage(currentPage);
            } else {
                alert("You are on the first page.");
            }
        }

        function searchFanCtrl() {
            const query = document.getElementById("fanCtrlNameInput").value.trim().toLowerCase();

            $.ajax({
                url: '/fan-controller/name-search?name=' + query,
                method: 'GET',
                success: function(data) {
                    allFanCtrlData = data;
                    currentPage = 0;
                    displayFanCtrlPage(currentPage);
                },
                error: function() {
                    console.log("Error occurred while fetching search results.");
                }
            });
        }

        // Load all fan controllers on page load
        $(document).ready(function() {
            fetchAllFanCtrls();
        });
    </script>
</body>
</html>