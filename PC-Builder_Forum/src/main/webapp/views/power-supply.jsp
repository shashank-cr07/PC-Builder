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

        .PsuHeading {
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

        #psuOutput {
            flex: 1;
            min-width: 280px;
            max-width: 350px;
            padding: 24px;
            border-radius: 16px;
            background-color: #1f1f1f;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
            color: #e2e2e2;
        }

        #psuOutput p {
            font-size: 15px;
            margin: 12px 0;
            line-height: 1.6;
        }

        #psuOutput strong {
            color: #ffffff;
            font-weight: 600;
        }

        #psuOutput span {
            color: #aaa;
        }

        #searchBarContainer {
            display: flex;
            align-items: center;
            gap: 12px;
            margin: 30px 60px 10px;
            flex-wrap: wrap;
        }

        #psuNameInput {
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

        #allPsuOutput {
            flex: 2;
            min-width: 600px;
            margin-top: 20px;
            overflow-x: auto;
        }

        #allPsu {
            border-collapse: collapse;
            width: 100%;
            background-color: #141414;
            color: #fff;
            font-size: 14px;
            border-radius: 8px;
            overflow: hidden;
        }

        #allPsu th,
        #allPsu td {
            border: 1px solid #2c2c2c;
            padding: 14px 18px;
            text-align: center;
        }

        #allPsu th {
            background-color: #1e1e1e;
            font-weight: 600;
        }

        #allPsu tbody tr {
            cursor: pointer;
            transition: background-color 0.2s;
        }

        #allPsu tbody tr:nth-child(odd) {
            background-color: #1a1a1a;
        }

        #allPsu tbody tr:hover {
            background-color: #292929;
        }

        #allPsu tbody tr.selected {
            background-color: #2a4a2a;
        }

        #paginationContainer {
            margin: 30px 60px;
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        /* Modal Styles */
        #psuDetails {
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

        #psuDetails h3 {
            margin-top: 0;
            color: #fff;
            border-bottom: 1px solid #444;
            padding-bottom: 10px;
        }

        #psuDetails p {
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

        #selectedPsuDisplay {
            margin: 20px 60px;
            padding: 20px;
            background-color: #1f1f1f;
            border-radius: 12px;
            display: none;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }

        #selectedPsuDisplay h3 {
            margin-top: 0;
            color: #4CAF50;
            border-bottom: 1px solid #333;
            padding-bottom: 10px;
        }

        #selectedPsuDisplay p {
            margin: 8px 0;
        }

        #removeSelectedPsu {
            background-color: #f44336;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            margin-top: 15px;
            transition: background-color 0.3s;
        }

        #removeSelectedPsu:hover {
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

            #allPsuOutput {
                min-width: unset;
                width: 100%;
            }

            #psuDetails {
                width: 90%;
                padding: 20px;
            }

            .PsuHeading {
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
            <h2 class="PsuHeading">Power Supply Information</h2>
        </div>
    </div>

    <!-- Selected PSU Display -->
    <div id="selectedPsuDisplay">
        <h3>Your Selected Power Supply</h3>
        <p><strong>Name:</strong> <span id="selectedPsuName"></span></p>
        <p><strong>Price:</strong> <span id="selectedPsuPrice"></span></p>
        <p><strong>Wattage:</strong> <span id="selectedPsuWattage"></span></p>
        <p><strong>Efficiency:</strong> <span id="selectedPsuEfficiency"></span></p>
        <p><strong>Modular:</strong> <span id="selectedPsuModular"></span></p>
        <button id="removeSelectedPsu">Remove Selection</button>
    </div>

    <!-- Input and Buttons -->
    <div id="searchBarContainer">
        <input type="text" id="psuNameInput" placeholder="Search Power Supplies" />
        <button onclick="searchPSU()">Search</button>
        <button onclick="clearSearch()">Clear search</button>
    </div>

    <!-- Output & Table Side-by-side -->
    <div id="mainContent">
        <!-- PSU Table -->
        <div id="allPsuOutput">
            <table id="allPsu">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Price</th>
                        <th>Type</th>
                        <th>Efficiency</th>
                        <th>Wattage</th>
                        <th>Modular</th>
                        <th>Color</th>
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

    <!-- PSU Details Modal -->
    <div id="overlay"></div>
    <div id="psuDetails">
        <button id="closeDetails">&times;</button>
        <h3 id="detailsName"></h3>
        <p><strong>ID:</strong> <span id="detailsId"></span></p>
        <p><strong>Price:</strong> <span id="detailsPrice"></span></p>
        <p><strong>Type:</strong> <span id="detailsType"></span></p>
        <p><strong>Efficiency:</strong> <span id="detailsEfficiency"></span></p>
        <p><strong>Wattage:</strong> <span id="detailsWattage"></span></p>
        <p><strong>Modular:</strong> <span id="detailsModular"></span></p>
        <p><strong>Color:</strong> <span id="detailsColor"></span></p>
        <button id="addToBuildBtn">Add to Build</button>
    </div>

    <!-- Notification -->
    <div id="buildNotification"></div>

    <script>
        // Global variables
        let allPsuData = [];
        let currentPage = 0;
        const pageSize = 15;
        let currentSelectedPsu = null;
        let selectedPsu = null;

        // Back to Main Menu functionality
        document.getElementById('backToMainMenu').addEventListener('click', function() {
            window.location.href = '/';
        });

        // Load saved selection from localStorage
        function loadSelectedPsu() {
            const savedPsu = localStorage.getItem('selectedPsu');
            if (savedPsu) {
                try {
                    selectedPsu = JSON.parse(savedPsu);
                    updateSelectedPsuDisplay();
                    // Find the complete PSU data from allPsuData
                    if (selectedPsu && allPsuData.length > 0) {
                        const completePsu = allPsuData.find(p => p.id === selectedPsu.id);
                        if (completePsu) {
                            selectedPsu = completePsu;
                        }
                    }
                } catch (e) {
                    console.error("Error parsing saved PSU:", e);
                    localStorage.removeItem('selectedPsu');
                }
            }
        }

        // Save selection to localStorage
        function saveSelectedPsu() {
            if (selectedPsu) {
                localStorage.setItem('selectedPsu', JSON.stringify({
                    id: selectedPsu.id,
                    name: selectedPsu.name,
                    price: selectedPsu.price,
                    wattage: selectedPsu.wattage,
                    efficiency: selectedPsu.efficiency,
                    modular: selectedPsu.modular,
                    // Include other minimal necessary properties
                }));
            } else {
                localStorage.removeItem('selectedPsu');
            }
        }

        function clearSearch() {
            document.getElementById("psuNameInput").value = "";
            fetchAllPsus();
        }

        // Fetch all PSUs from the backend
        function fetchAllPsus() {
            $.ajax({
                url: '/power-supply',
                method: 'GET',
                success: function(psuList) {
                    allPsuData = psuList;
                    currentPage = 0;
                    displayPsuPage(currentPage);
                    // After loading data, check if we have a saved selection
                    loadSelectedPsu();
                    // Highlight the saved selection in the table if it exists
                    if (selectedPsu) {
                        highlightSelectedPsuInTable();
                    }
                },
                error: function() {
                    alert('Failed to fetch power supplies.');
                }
            });
        }

        // Highlight the selected PSU in the table
        function highlightSelectedPsuInTable() {
            const rows = document.querySelectorAll("#allPsu tbody tr");
            rows.forEach(row => {
                if (selectedPsu && row.cells[0].textContent === selectedPsu.id.toString()) {
                    row.classList.add('selected');
                } else {
                    row.classList.remove('selected');
                }
            });
        }

        // Display a page of data
        function displayPsuPage(page) {
            const tableBody = document.querySelector("#allPsu tbody");
            tableBody.innerHTML = "";
            const startIndex = page * pageSize;
            const endIndex = startIndex + pageSize;
            const pageData = allPsuData.slice(startIndex, endIndex);
            pageData.forEach(p => {
                addPsuRow(p);
            });
            
            // Re-highlight selected PSU after rendering
            if (selectedPsu) {
                highlightSelectedPsuInTable();
            }
        }

        // Append a single row to the table
        function addPsuRow(entry) {
            const tableBody = document.querySelector("#allPsu tbody");
            const row = document.createElement("tr");
            
            // Highlight if this is the selected PSU
            if (selectedPsu && selectedPsu.id === entry.id) {
                row.classList.add('selected');
            }
            
            row.innerHTML = "<td>" + entry.id + "</td>" +
                            "<td>" + entry.name + "</td>" +
                            "<td>" + (entry.price ? "$" + entry.price : "Out Of stock") + "</td>" +
                            "<td>" + entry.type + "</td>" +
                            "<td>" + entry.efficiency + "</td>" +
                            "<td>" + entry.wattage + "W</td>" +
                            "<td>" + entry.modular + "</td>" +
                            "<td>" + entry.color + "</td>";
            
            row.addEventListener('click', function() {
                handleRowClick(entry);
            });
            
            tableBody.appendChild(row);
        }

        // Handle row click with confirmation logic
        function handleRowClick(p) {
            currentSelectedPsu = p;
            
            if (selectedPsu && selectedPsu.id === p.id) {
                // Clicked on already selected PSU - ask to deselect
                if (confirm("Do you want to remove this power supply from your build?")) {
                    removeSelectedPsu();
                }
            } else if (selectedPsu) {
                // Already have a selected PSU - ask to replace
                if (confirm(`You already have ${selectedPsu.name} selected. Replace it with ${p.name}?`)) {
                    setSelectedPsu(p);
                }
            } else {
                // No PSU selected - just select this one
                setSelectedPsu(p);
            }
            
            // Show details in modal
            showPsuDetails(p);
        }

        // Set the selected PSU
        function setSelectedPsu(p) {
            // Remove previous selection highlight
            if (selectedPsu) {
                const rows = document.querySelectorAll("#allPsu tbody tr");
                rows.forEach(row => {
                    if (row.cells[0].textContent === selectedPsu.id.toString()) {
                        row.classList.remove('selected');
                    }
                });
            }
            
            selectedPsu = p;
            
            // Add new selection highlight
            highlightSelectedPsuInTable();
            
            // Update the selected PSU display
            updateSelectedPsuDisplay();
            
            // Save to localStorage
            saveSelectedPsu();
            
            // Show notification
            showNotification(`${p.name} added to your build!`);
        }

        // Remove the selected PSU
        function removeSelectedPsu() {
            if (!selectedPsu) return;
            
            const psuName = selectedPsu.name;
            
            // Remove selection highlight
            const rows = document.querySelectorAll("#allPsu tbody tr");
            rows.forEach(row => {
                if (row.cells[0].textContent === selectedPsu.id.toString()) {
                    row.classList.remove('selected');
                }
            });
            
            selectedPsu = null;
            
            // Hide the selected PSU display
            document.getElementById('selectedPsuDisplay').style.display = 'none';
            
            // Clear from localStorage
            saveSelectedPsu();
            
            // Show notification
            showNotification(`${psuName} removed from your build!`);
        }

        // Update the selected PSU display panel
        function updateSelectedPsuDisplay() {
            if (selectedPsu) {
                document.getElementById('selectedPsuName').textContent = selectedPsu.name;
                document.getElementById('selectedPsuPrice').textContent = selectedPsu.price ? "$" + selectedPsu.price : "Out Of stock";
                document.getElementById('selectedPsuWattage').textContent = selectedPsu.wattage + "W";
                document.getElementById('selectedPsuEfficiency').textContent = selectedPsu.efficiency;
                document.getElementById('selectedPsuModular').textContent = selectedPsu.modular;
                document.getElementById('selectedPsuDisplay').style.display = 'block';
            } else {
                document.getElementById('selectedPsuDisplay').style.display = 'none';
            }
        }

        // Show PSU details in modal
        function showPsuDetails(p) {
            currentSelectedPsu = p;
            document.getElementById('detailsId').textContent = p.id;
            document.getElementById('detailsName').textContent = p.name;
            document.getElementById('detailsPrice').textContent = p.price ? "$" + p.price : "Out Of stock";
            document.getElementById('detailsType').textContent = p.type;
            document.getElementById('detailsEfficiency').textContent = p.efficiency;
            document.getElementById('detailsWattage').textContent = p.wattage + "W";
            document.getElementById('detailsModular').textContent = p.modular;
            document.getElementById('detailsColor').textContent = p.color;
            
            // Update Add to Build button text and color
            const addButton = document.getElementById('addToBuildBtn');
            if (selectedPsu && selectedPsu.id === p.id) {
                addButton.textContent = 'Remove from Build';
                addButton.classList.add('remove');
            } else {
                addButton.textContent = 'Add to Build';
                addButton.classList.remove('remove');
            }
            
            document.getElementById('overlay').style.display = 'block';
            document.getElementById('psuDetails').style.display = 'block';
        }

        // Add to Build button functionality
        document.getElementById('addToBuildBtn').addEventListener('click', function() {
            if (!currentSelectedPsu) return;
            
            if (selectedPsu && selectedPsu.id === currentSelectedPsu.id) {
                // Clicked remove
                removeSelectedPsu();
            } else if (selectedPsu) {
                // Confirm replacement
                if (confirm(`Replace ${selectedPsu.name} with ${currentSelectedPsu.name}?`)) {
                    setSelectedPsu(currentSelectedPsu);
                }
            } else {
                // Just add
                setSelectedPsu(currentSelectedPsu);
            }
            
            closeModal();
        });

        // Remove Selected PSU button functionality
        document.getElementById('removeSelectedPsu').addEventListener('click', function() {
            if (selectedPsu) {
                if (confirm(`Remove ${selectedPsu.name} from your build?`)) {
                    removeSelectedPsu();
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
            document.getElementById('psuDetails').style.display = 'none';
        }

        // Pagination functions
        function nextPage() {
            if ((currentPage + 1) * pageSize < allPsuData.length) {
                currentPage++;
                displayPsuPage(currentPage);
            } else {
                alert("No more data.");
            }
        }

        function previousPage() {
            if (currentPage > 0) {
                currentPage--;
                displayPsuPage(currentPage);
            } else {
                alert("You are on the first page.");
            }
        }

        function searchPSU() {
            const query = document.getElementById("psuNameInput").value.trim().toLowerCase();

            $.ajax({
                url: '/power-supply/name-search?name=' + query,
                method: 'GET',
                success: function(data) {
                    allPsuData = data;
                    currentPage = 0;
                    displayPsuPage(currentPage);
                },
                error: function() {
                    console.log("Error occurred while fetching search results.");
                }
            });
        }

        // Load all PSUs on page load
        $(document).ready(function() {
            fetchAllPsus();
        });
    </script>
</body>
</html>