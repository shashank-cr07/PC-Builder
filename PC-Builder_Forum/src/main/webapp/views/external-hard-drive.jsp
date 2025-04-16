<!DOCTYPE html>
<html>
<head>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap');

        .heading-container {
            display: flex;
            justify-content: center;
            margin-top: 40px;
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

        .FanHeading {
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

        #ehdOutput {
            flex: 1;
            min-width: 280px;
            max-width: 350px;
            padding: 24px;
            border-radius: 16px;
            background-color: #1f1f1f;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
            color: #e2e2e2;
        }

        #ehdOutput p {
            font-size: 15px;
            margin: 12px 0;
            line-height: 1.6;
        }

        #ehdOutput strong {
            color: #ffffff;
            font-weight: 600;
        }

        #ehdOutput span {
            color: #aaa;
        }

        #searchBarContainer {
            display: flex;
            align-items: center;
            gap: 12px;
            margin: 30px 60px 10px;
            flex-wrap: wrap;
        }

        #ehdNameInput {
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

        #allEhdOutput {
            flex: 2;
            min-width: 600px;
            margin-top: 20px;
            overflow-x: auto;
        }

        #allEhd {
            border-collapse: collapse;
            width: 100%;
            background-color: #141414;
            color: #fff;
            font-size: 14px;
            border-radius: 8px;
            overflow: hidden;
        }

        #allEhd th,
        #allEhd td {
            border: 1px solid #2c2c2c;
            padding: 14px 18px;
            text-align: center;
        }

        #allEhd th {
            background-color: #1e1e1e;
            font-weight: 600;
        }

        #allEhd tbody tr {
            cursor: pointer;
            transition: background-color 0.2s;
        }

        #allEhd tbody tr:nth-child(odd) {
            background-color: #1a1a1a;
        }

        #allEhd tbody tr:hover {
            background-color: #292929;
        }

        #allEhd tbody tr.selected {
            background-color: #2a4a2a;
        }

        #paginationContainer {
            margin: 30px 60px;
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        /* Modal Styles */
        #ehdDetails {
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

        #ehdDetails h3 {
            margin-top: 0;
            color: #fff;
            border-bottom: 1px solid #444;
            padding-bottom: 10px;
        }

        #ehdDetails p {
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

        #selectedEhdDisplay {
            margin: 20px 60px;
            padding: 20px;
            background-color: #1f1f1f;
            border-radius: 12px;
            display: none;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }

        #selectedEhdDisplay h3 {
            margin-top: 0;
            color: #4CAF50;
            border-bottom: 1px solid #333;
            padding-bottom: 10px;
        }

        #selectedEhdDisplay p {
            margin: 8px 0;
        }

        #removeSelectedEhd {
            background-color: #f44336;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            margin-top: 15px;
            transition: background-color 0.3s;
        }

        #removeSelectedEhd:hover {
            background-color: #d32f2f;
        }

        @media (max-width: 768px) {
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

            #allEhdOutput {
                min-width: unset;
                width: 100%;
            }

            #ehdDetails {
                width: 90%;
                padding: 20px;
            }

            .FanHeading {
                font-size: 2.5rem;
            }
        }
        
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

        /* Adjust heading container to account for the back button */
        .heading-container {
            margin-top: 80px; /* Increased to make space for the back button */
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
        }
    </style>
</head>
<body>

    <!-- Back to Main Menu Button -->
    <button id="backToMainMenu"> Back to Main Menu</button>

    <div class="heading-container">
        <div class="geometric-border">
            <h2 class="FanHeading">External Hard Drive</h2>
        </div>
    </div>

    <!-- Selected EHD Display -->
    <div id="selectedEhdDisplay">
        <h3>Your Selected External Hard Drive</h3>
        <p><strong>Name:</strong> <span id="selectedEhdName"></span></p>
        <p><strong>Price:</strong> $<span id="selectedEhdPrice"></span></p>
        <p><strong>Capacity:</strong> <span id="selectedEhdCapacity"></span></p>
        <button id="removeSelectedEhd">Remove Selection</button>
    </div>
    
    <!-- Input and Buttons -->
    <div id="searchBarContainer">
        <input type="text" id="ehdNameInput" placeholder="Search External Hard Drive" />
        <button onclick="searchEHD()">Search</button>
        <button onclick="clearSearch()">Clear search</button>
    </div>
    
    <!-- Output & Table Side-by-side -->
    <div id="mainContent">
        <!-- EHD Table -->
        <div id="allEhdOutput">
            <table id="allEhd">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Price</th>
                        <th>Interface</th>
                        <th>Capacity</th>
                        <th>Price Per GB</th>
                        <th>Colour</th>
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

    <!-- EHD Details Modal -->
    <div id="overlay"></div>
    <div id="ehdDetails">
        <button id="closeDetails">&times;</button>
        <h3 id="detailsName"></h3>
        <p><strong>ID:</strong> <span id="detailsId"></span></p>
        <p><strong>Price:</strong> $<span id="detailsPrice"></span></p>
        <p><strong>Interface:</strong> <span id="detailsInterface"></span></p>
        <p><strong>Capacity:</strong> <span id="detailsCapacity"></span></p>
        <p><strong>Price Per GB:</strong> $<span id="detailsPricePerGb"></span></p>
        <p><strong>Color:</strong> <span id="detailsColor"></span></p>
        <button id="addToBuildBtn">Add to Build</button>
    </div>

    <!-- Notification -->
    <div id="buildNotification"></div>
    
    <script>
        // Global variables
        let allEhdData = [];
        let currentPage = 0;
        const pageSize = 15;
        let currentSelectedEhd = null;
        let selectedEhd = null;

        // Load saved selection from localStorage
        function loadSelectedEhd() {
            const savedEhd = localStorage.getItem('selectedEhd');
            if (savedEhd) {
                try {
                    selectedEhd = JSON.parse(savedEhd);
                    updateSelectedEhdDisplay();
                    // Find the complete EHD data from allEhdData
                    if (selectedEhd && allEhdData.length > 0) {
                        const completeEhd = allEhdData.find(e => e.id === selectedEhd.id);
                        if (completeEhd) {
                            selectedEhd = completeEhd;
                        }
                    }
                } catch (e) {
                    console.error("Error parsing saved EHD:", e);
                    localStorage.removeItem('selectedEhd');
                }
            }
        }

        // Save selection to localStorage
        function saveSelectedEhd() {
            if (selectedEhd) {
                localStorage.setItem('selectedEhd', JSON.stringify({
                    id: selectedEhd.id,
                    name: selectedEhd.name,
                    price: selectedEhd.price,
                    capacity: selectedEhd.capacity
                    // Include other minimal necessary properties
                }));
            } else {
                localStorage.removeItem('selectedEhd');
            }
        }

        function clearSearch() {
            document.getElementById("ehdNameInput").value = "";
            fetchAllEhds();
        }

        // Fetch all EHDs from the backend
        function fetchAllEhds() {
            $.ajax({
                url: '/external-hard-drive',
                method: 'GET',
                success: function(ehdList) {
                    allEhdData = ehdList;
                    currentPage = 0;
                    displayEhdPage(currentPage);
                    // After loading data, check if we have a saved selection
                    loadSelectedEhd();
                    // Highlight the saved selection in the table if it exists
                    if (selectedEhd) {
                        highlightSelectedEhdInTable();
                    }
                },
                error: function() {
                    alert('Failed to fetch external hard drives.');
                }
            });
        }

        // Highlight the selected EHD in the table
        function highlightSelectedEhdInTable() {
            const rows = document.querySelectorAll("#allEhd tbody tr");
            rows.forEach(row => {
                if (selectedEhd && row.cells[0].textContent === selectedEhd.id.toString()) {
                    row.classList.add('selected');
                } else {
                    row.classList.remove('selected');
                }
            });
        }

        // Display a page of data
        function displayEhdPage(page) {
            const tableBody = document.querySelector("#allEhd tbody");
            tableBody.innerHTML = "";
            const startIndex = page * pageSize;
            const endIndex = startIndex + pageSize;
            const pageData = allEhdData.slice(startIndex, endIndex);
            pageData.forEach(e => {
                addEhdRow(e);
            });
            
            // Re-highlight selected EHD after rendering
            if (selectedEhd) {
                highlightSelectedEhdInTable();
            }
        }

        // Append a single row to the table
        function addEhdRow(entry) {
            const tableBody = document.querySelector("#allEhd tbody");
            const row = document.createElement("tr");
            
            // Highlight if this is the selected EHD
            if (selectedEhd && selectedEhd.id === entry.id) {
                row.classList.add('selected');
            }
            
            row.innerHTML = "<td>" + entry.id + "</td>" +
                            "<td>" + entry.name + "</td>" +
                            "<td>" + (entry.price ? "$" + entry.price : "Out Of stock") + "</td>" +
                            "<td>" + entry.interfaceType + "</td>" +
                            "<td>" + entry.capacity + "</td>" +
                            "<td>" + entry.pricePerGb + "</td>" +
                            "<td>" + entry.color + "</td>";
            
            row.addEventListener('click', function() {
                handleRowClick(entry);
            });
            
            tableBody.appendChild(row);
        }

        // Handle row click with confirmation logic
        function handleRowClick(e) {
            currentSelectedEhd = e;
            
            if (selectedEhd && selectedEhd.id === e.id) {
                // Clicked on already selected EHD - ask to deselect
                if (confirm("Do you want to remove this external hard drive from your build?")) {
                    removeSelectedEhd();
                }
            } else if (selectedEhd) {
                // Already have a selected EHD - ask to replace
                if (confirm(`You already have ${selectedEhd.name} selected. Replace it with ${e.name}?`)) {
                    setSelectedEhd(e);
                }
            } else {
                // No EHD selected - just select this one
                setSelectedEhd(e);
            }
            
            // Show details in modal
            showEhdDetails(e);
        }

        // Set the selected EHD
        function setSelectedEhd(e) {
            // Remove previous selection highlight
            if (selectedEhd) {
                const rows = document.querySelectorAll("#allEhd tbody tr");
                rows.forEach(row => {
                    if (row.cells[0].textContent === selectedEhd.id.toString()) {
                        row.classList.remove('selected');
                    }
                });
            }
            
            selectedEhd = e;
            
            // Add new selection highlight
            highlightSelectedEhdInTable();
            
            // Update the selected EHD display
            updateSelectedEhdDisplay();
            
            // Save to localStorage
            saveSelectedEhd();
            
            // Show notification
            showNotification(`${e.name} added to your build!`);
        }

        // Remove the selected EHD
        function removeSelectedEhd() {
            if (!selectedEhd) return;
            
            const ehdName = selectedEhd.name;
            
            // Remove selection highlight
            const rows = document.querySelectorAll("#allEhd tbody tr");
            rows.forEach(row => {
                if (row.cells[0].textContent === selectedEhd.id.toString()) {
                    row.classList.remove('selected');
                }
            });
            
            selectedEhd = null;
            
            // Hide the selected EHD display
            document.getElementById('selectedEhdDisplay').style.display = 'none';
            
            // Clear from localStorage
            saveSelectedEhd();
            
            // Show notification
            showNotification(`${ehdName} removed from your build!`);
        }

        // Update the selected EHD display panel
        function updateSelectedEhdDisplay() {
            if (selectedEhd) {
                document.getElementById('selectedEhdName').textContent = selectedEhd.name;
                document.getElementById('selectedEhdPrice').textContent = selectedEhd.price ? "$" + selectedEhd.price : "Out Of stock";
                document.getElementById('selectedEhdCapacity').textContent = selectedEhd.capacity;
                document.getElementById('selectedEhdDisplay').style.display = 'block';
            } else {
                document.getElementById('selectedEhdDisplay').style.display = 'none';
            }
        }

        // Show EHD details in modal
        function showEhdDetails(e) {
            currentSelectedEhd = e;
            document.getElementById('detailsId').textContent = e.id;
            document.getElementById('detailsName').textContent = e.name;
            document.getElementById('detailsPrice').textContent = e.price ? "$" + e.price : "Out Of stock";
            document.getElementById('detailsInterface').textContent = e.interfaceType;
            document.getElementById('detailsCapacity').textContent = e.capacity;
            document.getElementById('detailsPricePerGb').textContent = e.pricePerGb;
            document.getElementById('detailsColor').textContent = e.color;
            
            // Update Add to Build button text and color
            const addButton = document.getElementById('addToBuildBtn');
            if (selectedEhd && selectedEhd.id === e.id) {
                addButton.textContent = 'Remove from Build';
                addButton.classList.add('remove');
            } else {
                addButton.textContent = 'Add to Build';
                addButton.classList.remove('remove');
            }
            
            document.getElementById('overlay').style.display = 'block';
            document.getElementById('ehdDetails').style.display = 'block';
        }

        // Add to Build button functionality
        document.getElementById('addToBuildBtn').addEventListener('click', function() {
            if (!currentSelectedEhd) return;
            
            if (selectedEhd && selectedEhd.id === currentSelectedEhd.id) {
                // Clicked remove
                removeSelectedEhd();
            } else if (selectedEhd) {
                // Confirm replacement
                if (confirm(`Replace ${selectedEhd.name} with ${currentSelectedEhd.name}?`)) {
                    setSelectedEhd(currentSelectedEhd);
                }
            } else {
                // Just add
                setSelectedEhd(currentSelectedEhd);
            }
            
            closeModal();
        });

        // Remove Selected EHD button functionality
        document.getElementById('removeSelectedEhd').addEventListener('click', function() {
            if (selectedEhd) {
                if (confirm(`Remove ${selectedEhd.name} from your build?`)) {
                    removeSelectedEhd();
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
            document.getElementById('ehdDetails').style.display = 'none';
        }

        // Pagination functions
        function nextPage() {
            if ((currentPage + 1) * pageSize < allEhdData.length) {
                currentPage++;
                displayEhdPage(currentPage);
            } else {
                alert("No more data.");
            }
        }

        function previousPage() {
            if (currentPage > 0) {
                currentPage--;
                displayEhdPage(currentPage);
            } else {
                alert("You are on the first page.");
            }
        }

        function searchEHD() {
            const query = document.getElementById("ehdNameInput").value.trim().toLowerCase();

            $.ajax({
                url: '/external-hard-drive/name-search?name=' + query,
                method: 'GET',
                success: function(data) {
                    allEhdData = data;
                    currentPage = 0;
                    displayEhdPage(currentPage);
                },
                error: function() {
                    console.log("Error occurred while fetching search results.");
                }
            });
        }

        // Back to Main Menu functionality
        document.getElementById('backToMainMenu').addEventListener('click', function() {
            window.location.href = '/home-pc';
        });

        // Load all EHDs on page load
        $(document).ready(function() {
            fetchAllEhds();
        });
    </script>
</body>
</html>