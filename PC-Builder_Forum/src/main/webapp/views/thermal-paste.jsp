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

        .TpHeading {
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

        #tpOutput {
            flex: 1;
            min-width: 280px;
            max-width: 350px;
            padding: 24px;
            border-radius: 16px;
            background-color: #1f1f1f;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
            color: #e2e2e2;
        }

        #tpOutput p {
            font-size: 15px;
            margin: 12px 0;
            line-height: 1.6;
        }

        #tpOutput strong {
            color: #ffffff;
            font-weight: 600;
        }

        #tpOutput span {
            color: #aaa;
        }

        #searchBarContainer {
            display: flex;
            align-items: center;
            gap: 12px;
            margin: 30px 60px 10px;
            flex-wrap: wrap;
        }

        #tpNameInput {
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

        #allTpOutput {
            flex: 2;
            min-width: 600px;
            margin-top: 20px;
            overflow-x: auto;
        }

        #allTp {
            border-collapse: collapse;
            width: 100%;
            background-color: #141414;
            color: #fff;
            font-size: 14px;
            border-radius: 8px;
            overflow: hidden;
        }

        #allTp th,
        #allTp td {
            border: 1px solid #2c2c2c;
            padding: 14px 18px;
            text-align: center;
        }

        #allTp th {
            background-color: #1e1e1e;
            font-weight: 600;
        }

        #allTp tbody tr {
            cursor: pointer;
            transition: background-color 0.2s;
        }

        #allTp tbody tr:nth-child(odd) {
            background-color: #1a1a1a;
        }

        #allTp tbody tr:hover {
            background-color: #292929;
        }

        #allTp tbody tr.selected {
            background-color: #2a4a2a;
        }

        #paginationContainer {
            margin: 30px 60px;
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        /* Modal Styles */
        #tpDetails {
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

        #tpDetails h3 {
            margin-top: 0;
            color: #fff;
            border-bottom: 1px solid #444;
            padding-bottom: 10px;
        }

        #tpDetails p {
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

        #selectedTpDisplay {
            margin: 20px 60px;
            padding: 20px;
            background-color: #1f1f1f;
            border-radius: 12px;
            display: none;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }

        #selectedTpDisplay h3 {
            margin-top: 0;
            color: #4CAF50;
            border-bottom: 1px solid #333;
            padding-bottom: 10px;
        }

        #selectedTpDisplay p {
            margin: 8px 0;
        }

        #removeSelectedTp {
            background-color: #f44336;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            margin-top: 15px;
            transition: background-color 0.3s;
        }

        #removeSelectedTp:hover {
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

            #allTpOutput {
                min-width: unset;
                width: 100%;
            }

            #tpDetails {
                width: 90%;
                padding: 20px;
            }

            .TpHeading {
                font-size: 2.5rem;
            }
        }
    </style>
</head>
<body>

    <!-- Back to Main Menu Button -->
    <button id="backToMainMenu"> Back to Main Menu</button>

    <div class="heading-container">
        <h2 class="TpHeading">Thermal Paste Information</h2>
    </div>

    <!-- Selected Thermal Paste Display -->
    <div id="selectedTpDisplay">
        <h3>Your Selected Thermal Paste</h3>
        <p><strong>Name:</strong> <span id="selectedTpName"></span></p>
        <p><strong>Price:</strong> <span id="selectedTpPrice"></span></p>
        <p><strong>Amount:</strong> <span id="selectedTpAmount"></span></p>
        <button id="removeSelectedTp">Remove Selection</button>
    </div>

    <!-- Input and Buttons -->
    <div id="searchBarContainer">
        <input type="text" id="tpNameInput" placeholder="Search Thermal Paste" />
        <button onclick="searchTP()">Search</button>
        <button onclick="clearSearch()">Clear search</button>
    </div>

    <!-- Output & Table Side-by-side -->
    <div id="mainContent">
        <!-- Thermal Paste Table -->
        <div id="allTpOutput">
            <table id="allTp">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Price</th>
                        <th>Amount</th>
                        <th>Thermal Conductivity</th>
                        <th>Viscosity</th>
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

    <!-- Thermal Paste Details Modal -->
    <div id="overlay"></div>
    <div id="tpDetails">
        <button id="closeDetails">x</button>
        <h3 id="detailsName"></h3>
        <p><strong>ID:</strong> <span id="detailsId"></span></p>
        <p><strong>Price:</strong> <span id="detailsPrice"></span></p>
        <p><strong>Amount:</strong> <span id="detailsAmount"></span></p>
        <p><strong>Thermal Conductivity:</strong> <span id="detailsThermalConductivity"></span></p>
        <p><strong>Viscosity:</strong> <span id="detailsViscosity"></span></p>
        <button id="addToBuildBtn">Add to Build</button>
    </div>

    <!-- Notification -->
    <div id="buildNotification"></div>

    <script>
        // Global variables
        let allTpData = [];
        let currentPage = 0;
        const pageSize = 15;
        let currentSelectedTp = null;
        let selectedTp = null;

        // Back to Main Menu functionality
        document.getElementById('backToMainMenu').addEventListener('click', function() {
            window.location.href = '/home-pc';
        });

        // Load saved selection from localStorage
        function loadSelectedTp() {
            const savedTp = localStorage.getItem('selectedTp');
            if (savedTp) {
                try {
                    selectedTp = JSON.parse(savedTp);
                    updateSelectedTpDisplay();
                    // Find the complete thermal paste data from allTpData
                    if (selectedTp && allTpData.length > 0) {
                        const completeTp = allTpData.find(tp => tp.id === selectedTp.id);
                        if (completeTp) {
                            selectedTp = completeTp;
                        }
                    }
                } catch (e) {
                    console.error("Error parsing saved thermal paste:", e);
                    localStorage.removeItem('selectedTp');
                }
            }
        }

        // Save selection to localStorage
        function saveSelectedTp() {
            if (selectedTp) {
                localStorage.setItem('selectedTp', JSON.stringify({
                    id: selectedTp.id,
                    name: selectedTp.name,
                    price: selectedTp.price,
                    amount: selectedTp.amount
                }));
            } else {
                localStorage.removeItem('selectedTp');
            }
        }

        function clearSearch() {
            document.getElementById("tpNameInput").value = "";
            fetchAllTp();
        }

        // Fetch all Thermal Pastes from the backend
        function fetchAllTp() {
            $.ajax({
                url: '/thermal-paste',
                method: 'GET',
                success: function(tpList) {
                    allTpData = tpList;
                    currentPage = 0;
                    displayTpPage(currentPage);
                    // After loading data, check if we have a saved selection
                    loadSelectedTp();
                    // Highlight the saved selection in the table if it exists
                    if (selectedTp) {
                        highlightSelectedTpInTable();
                    }
                },
                error: function() {
                    alert('Failed to fetch thermal paste data.');
                }
            });
        }

        // Highlight the selected thermal paste in the table
        function highlightSelectedTpInTable() {
            const rows = document.querySelectorAll("#allTp tbody tr");
            rows.forEach(row => {
                if (selectedTp && row.cells[0].textContent === selectedTp.id.toString()) {
                    row.classList.add('selected');
                } else {
                    row.classList.remove('selected');
                }
            });
        }

        // Display a page of data
        function displayTpPage(page) {
            const tableBody = document.querySelector("#allTp tbody");
            tableBody.innerHTML = "";
            const startIndex = page * pageSize;
            const endIndex = startIndex + pageSize;
            const pageData = allTpData.slice(startIndex, endIndex);
            pageData.forEach(tp => {
                addTpRow(tp);
            });
            
            // Re-highlight selected thermal paste after rendering
            if (selectedTp) {
                highlightSelectedTpInTable();
            }
        }

        // Append a single row to the table
        function addTpRow(tp) {
            const tableBody = document.querySelector("#allTp tbody");
            const row = document.createElement("tr");
            
            // Highlight if this is the selected thermal paste
            if (selectedTp && selectedTp.id === tp.id) {
                row.classList.add('selected');
            }
            
            row.innerHTML = "<td>" + (tp.id || "N/A") + "</td>" +
                "<td>" + (tp.name || "Unknown") + "</td>" +
                "<td>" + (tp.price != null ? "$" + tp.price : "Out Of stock") + "</td>" +
                "<td>" + (tp.amount ? tp.amount + "g" : "N/A") + "</td>" +
                "<td>" + (tp.thermalConductivity ? tp.thermalConductivity + " W/mK" : "N/A") + "</td>" +
                "<td>" + (tp.viscosity || "N/A") + "</td>";

            row.addEventListener('click', function() {
                handleRowClick(tp);
            });
            
            tableBody.appendChild(row);
        }

        // Handle row click with confirmation logic
        function handleRowClick(tp) {
            currentSelectedTp = tp;
            
            if (selectedTp && selectedTp.id === tp.id) {
                // Clicked on already selected thermal paste - ask to deselect
                if (confirm("Do you want to remove this thermal paste from your build?")) {
                    removeSelectedTp();
                }
            } else if (selectedTp) {
                // Already have a selected thermal paste - ask to replace
                if ("confirm(You already have ${selectedTp.name} selected. Replace it with ${tp.name}?") {
                    setSelectedTp(tp);
                }
            } else {
                // No thermal paste selected - just select this one
                setSelectedTp(tp);
            }
            
            // Show details in modal
            showTpDetails(tp);
        }

        // Set the selected thermal paste
        function setSelectedTp(tp) {
            // Remove previous selection highlight
            if (selectedTp) {
                const rows = document.querySelectorAll("#allTp tbody tr");
                rows.forEach(row => {
                    if (row.cells[0].textContent === selectedTp.id.toString()) {
                        row.classList.remove('selected');
                    }
                });
            }
            
            selectedTp = tp;
            
            // Add new selection highlight
            highlightSelectedTpInTable();
            
            // Update the selected thermal paste display
            updateSelectedTpDisplay();
            
            // Save to localStorage
            saveSelectedTp();
            
            // Show notification
            showNotification("${tp.name} added to your build!");
        }

        // Remove the selected thermal paste
        function removeSelectedTp() {
            if (!selectedTp) return;
            
            const tpName = selectedTp.name;
            
            // Remove selection highlight
            const rows = document.querySelectorAll("#allTp tbody tr");
            rows.forEach(row => {
                if (row.cells[0].textContent === selectedTp.id.toString()) {
                    row.classList.remove('selected');
                }
            });
            
            selectedTp = null;
            
            // Hide the selected thermal paste display
            document.getElementById('selectedTpDisplay').style.display = 'none';
            
            // Clear from localStorage
            saveSelectedTp();
            
            // Show notification
            showNotification("${tpName} removed from your build!");
        }

        // Update the selected thermal paste display panel
        function updateSelectedTpDisplay() {
            if (selectedTp) {
                document.getElementById('selectedTpName').textContent = selectedTp.name;
                document.getElementById('selectedTpPrice').textContent = selectedTp.price ? "$" + selectedTp.price : "Out Of stock";
                document.getElementById('selectedTpAmount').textContent = selectedTp.amount + "g";
                document.getElementById('selectedTpDisplay').style.display = 'block';
            } else {
                document.getElementById('selectedTpDisplay').style.display = 'none';
            }
        }

        // Show thermal paste details in modal
        function showTpDetails(tp) {
            currentSelectedTp = tp;
            document.getElementById('detailsId').textContent = tp.id;
            document.getElementById('detailsName').textContent = tp.name;
            document.getElementById('detailsPrice').textContent = tp.price ? "$" + tp.price : "Out Of stock";
            document.getElementById('detailsAmount').textContent = tp.amount + "g";
            document.getElementById('detailsThermalConductivity').textContent = tp.thermalConductivity + " W/mK";
            document.getElementById('detailsViscosity').textContent = tp.viscosity;
            
            // Update Add to Build button text and color
            const addButton = document.getElementById('addToBuildBtn');
            if (selectedTp && selectedTp.id === tp.id) {
                addButton.textContent = 'Remove from Build';
                addButton.classList.add('remove');
            } else {
                addButton.textContent = 'Add to Build';
                addButton.classList.remove('remove');
            }
            
            document.getElementById('overlay').style.display = 'block';
            document.getElementById('tpDetails').style.display = 'block';
        }

        // Add to Build button functionality
        document.getElementById('addToBuildBtn').addEventListener('click', function() {
            if (!currentSelectedTp) return;
            
            if (selectedTp && selectedTp.id === currentSelectedTp.id) {
                // Clicked remove
                removeSelectedTp();
            } else if (selectedTp) {
                // Confirm replacement
                if (confirm("Replace ${selectedTp.name} with ${currentSelectedTp.name}?")) {
                    setSelectedTp(currentSelectedTp);
                }
            } else {
                // Just add
                setSelectedTp(currentSelectedTp);
            }
            
            closeModal();
        });

        // Remove Selected Thermal Paste button functionality
        document.getElementById('removeSelectedTp').addEventListener('click', function() {
            if (selectedTp) {
                if (confirm("Remove ${selectedTp.name} from your build?")) {
                    removeSelectedTp();
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
            document.getElementById('tpDetails').style.display = 'none';
        }

        // Pagination functions
        function nextPage() {
            if ((currentPage + 1) * pageSize < allTpData.length) {
                currentPage++;
                displayTpPage(currentPage);
            } else {
                alert("No more data.");
            }
        }

        function previousPage() {
            if (currentPage > 0) {
                currentPage--;
                displayTpPage(currentPage);
            } else {
                alert("You are on the first page.");
            }
        }

        function searchTP() {
            const query = document.getElementById("tpNameInput").value.trim().toLowerCase();

            $.ajax({
                url: '/thermal-paste/name-search?name=' + query,
                method: 'GET',
                success: function(data) {
                    allTpData = data;
                    currentPage = 0;
                    displayTpPage(currentPage);
                },
                error: function() {
                    console.log("Error occurred while fetching search results.");
                }
            });
        }

        // Load all thermal pastes on page load
        $(document).ready(function() {
            fetchAllTp();
        });
    </script>
</body>
</html>