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

        .Motherboard {
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

        #mbOutput {
            flex: 1;
            min-width: 280px;
            max-width: 350px;
            padding: 24px;
            border-radius: 16px;
            background-color: #1f1f1f;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
            color: #e2e2e2;
        }

        #mbOutput p {
            font-size: 15px;
            margin: 12px 0;
            line-height: 1.6;
        }

        #mbOutput strong {
            color: #ffffff;
            font-weight: 600;
        }

        #mbOutput span {
            color: #aaa;
        }

        #searchBarContainer {
            display: flex;
            align-items: center;
            gap: 12px;
            margin: 30px 60px 10px;
            flex-wrap: wrap;
        }

        #mbNameInput {
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

        #allMbOutput {
            flex: 2;
            min-width: 600px;
            margin-top: 20px;
            overflow-x: auto;
        }

        #allMB {
            border-collapse: collapse;
            width: 100%;
            background-color: #141414;
            color: #fff;
            font-size: 14px;
            border-radius: 8px;
            overflow: hidden;
        }

        #allMB th,
        #allMB td {
            border: 1px solid #2c2c2c;
            padding: 14px 18px;
            text-align: center;
        }

        #allMB th {
            background-color: #1e1e1e;
            font-weight: 600;
        }

        #allMB tbody tr {
            cursor: pointer;
            transition: background-color 0.2s;
        }

        #allMB tbody tr:nth-child(odd) {
            background-color: #1a1a1a;
        }

        #allMB tbody tr:hover {
            background-color: #292929;
        }

        #allMB tbody tr.selected {
            background-color: #2a4a2a;
        }

        #paginationContainer {
            margin: 30px 60px;
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        /* Modal Styles */
        #mbDetails {
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

        #mbDetails h3 {
            margin-top: 0;
            color: #fff;
            border-bottom: 1px solid #444;
            padding-bottom: 10px;
        }

        #mbDetails p {
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

        #selectedMbDisplay {
            margin: 20px 60px;
            padding: 20px;
            background-color: #1f1f1f;
            border-radius: 12px;
            display: none;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }

        #selectedMbDisplay h3 {
            margin-top: 0;
            color: #4CAF50;
            border-bottom: 1px solid #333;
            padding-bottom: 10px;
        }

        #selectedMbDisplay p {
            margin: 8px 0;
        }

        #removeSelectedMb {
            background-color: #f44336;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            margin-top: 15px;
            transition: background-color 0.3s;
        }

        #removeSelectedMb:hover {
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

            #allMbOutput {
                min-width: unset;
                width: 100%;
            }

            #mbDetails {
                width: 90%;
                padding: 20px;
            }

            .Motherboard {
                font-size: 2.5rem;
            }
        }
    </style>
</head>
<body>

    <!-- Back to Main Menu Button -->
    <button id="backToMainMenu"> Back to Main Menu</button>

    <div class="heading-container">
        <div class="geometric-border">
            <h2 class="Motherboard">Motherboard Information</h2>
        </div>
    </div>

    <!-- Selected Motherboard Display -->
    <div id="selectedMbDisplay">
        <h3>Your Selected Motherboard</h3>
        <p><strong>Name:</strong> <span id="selectedMbName"></span></p>
        <p><strong>Price:</strong> <span id="selectedMbPrice"></span></p>
        <p><strong>Socket:</strong> <span id="selectedMbSocket"></span></p>
        <button id="removeSelectedMb">Remove Selection</button>
    </div>

    <!-- Input and Buttons -->
    <div id="searchBarContainer">
        <input type="text" id="mbNameInput" placeholder="Search Motherboards" />
        <button onclick="searchMotherboard()">Search</button>
        <button onclick="clearSearch()">Clear search</button>
    </div>

    <!-- Output & Table Side-by-side -->
    <div id="mainContent">
        <!-- Motherboard Table -->
        <div id="allMbOutput">
            <table id="allMB">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Price</th>
                        <th>Socket</th>
                        <th>Chipset</th>
                        <th>Form Factor</th>
                        <th>Memory Slots</th>
                        <th>Max Memory</th>
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

    <!-- Motherboard Details Modal -->
    <div id="overlay"></div>
    <div id="mbDetails">
        <button id="closeDetails">x</button>
        <h3 id="detailsName"></h3>
        <p><strong>ID:</strong> <span id="detailsId"></span></p>
        <p><strong>Price:</strong> <span id="detailsPrice"></span></p>
        <p><strong>Socket:</strong> <span id="detailsSocket"></span></p>
        <p><strong>Chipset:</strong> <span id="detailsChipset"></span></p>
        <p><strong>Form Factor:</strong> <span id="detailsFormFactor"></span></p>
        <p><strong>Memory Slots:</strong> <span id="detailsMemorySlots"></span></p>
        <p><strong>Max Memory:</strong> <span id="detailsMaxMemory"></span></p>
        <button id="addToBuildBtn">Add to Build</button>
    </div>

    <!-- Notification -->
    <div id="buildNotification"></div>

    <script>
        // Global variables
        let allMbData = [];
        let currentPage = 0;
        const pageSize = 15;
        let currentSelectedMb = null;
        let selectedMb = null;

        // Back to Main Menu functionality
        document.getElementById('backToMainMenu').addEventListener('click', function() {
            window.location.href = '/home-pc';
        });

        // Load saved selection from localStorage
        function loadSelectedMb() {
            const savedMb = localStorage.getItem('selectedMb');
            if (savedMb) {
                try {
                    selectedMb = JSON.parse(savedMb);
                    updateSelectedMbDisplay();
                    // Find the complete motherboard data from allMbData
                    if (selectedMb && allMbData.length > 0) {
                        const completeMb = allMbData.find(mb => mb.id === selectedMb.id);
                        if (completeMb) {
                            selectedMb = completeMb;
                        }
                    }
                } catch (e) {
                    console.error("Error parsing saved motherboard:", e);
                    localStorage.removeItem('selectedMb');
                }
            }
        }

        // Save selection to localStorage
        function saveSelectedMb() {
            if (selectedMb) {
                localStorage.setItem('selectedMb', JSON.stringify({
                    id: selectedMb.id,
                    name: selectedMb.name,
                    price: selectedMb.price,
                    socket: selectedMb.socket
                }));
            } else {
                localStorage.removeItem('selectedMb');
            }
        }

        function clearSearch() {
            document.getElementById("mbNameInput").value = "";
            fetchAllMotherboards();
        }

        // Fetch all Motherboards from the backend
        function fetchAllMotherboards() {
            $.ajax({
                url: '/motherboard',
                method: 'GET',
                success: function(mbList) {
                    allMbData = mbList;
                    currentPage = 0;
                    displayMbPage(currentPage);
                    // After loading data, check if we have a saved selection
                    loadSelectedMb();
                    // Highlight the saved selection in the table if it exists
                    if (selectedMb) {
                        highlightSelectedMbInTable();
                    }
                },
                error: function() {
                    alert('Failed to fetch motherboards.');
                }
            });
        }

        // Highlight the selected motherboard in the table
        function highlightSelectedMbInTable() {
            const rows = document.querySelectorAll("#allMB tbody tr");
            rows.forEach(row => {
                if (selectedMb && row.cells[0].textContent === selectedMb.id.toString()) {
                    row.classList.add('selected');
                } else {
                    row.classList.remove('selected');
                }
            });
        }

        // Display a page of data
        function displayMbPage(page) {
            const tableBody = document.querySelector("#allMB tbody");
            tableBody.innerHTML = "";
            const startIndex = page * pageSize;
            const endIndex = startIndex + pageSize;
            const pageData = allMbData.slice(startIndex, endIndex);
            pageData.forEach(mb => {
                addMbRow(mb);
            });
            
            // Re-highlight selected motherboard after rendering
            if (selectedMb) {
                highlightSelectedMbInTable();
            }
        }

        // Append a single row to the table
        function addMbRow(mb) {
            const tableBody = document.querySelector("#allMB tbody");
            const row = document.createElement("tr");
            
            // Highlight if this is the selected motherboard
            if (selectedMb && selectedMb.id === mb.id) {
                row.classList.add('selected');
            }
            
            row.innerHTML = "<td>" + mb.id + "</td>" +
                "<td>" + mb.name + "</td>" +
                "<td>" + (mb.price ? "$" + mb.price : "Out of stock") + "</td>" +
                "<td>" + mb.socket + "</td>" +
                "<td>" + mb.chipset + "</td>" +
                "<td>" + mb.formFactor + "</td>" +
                "<td>" + mb.memorySlots + "</td>" +
                "<td>" + mb.maxMemory + "GB" + "</td>";
            
            row.addEventListener('click', function() {
                handleRowClick(mb);
            });
            
            tableBody.appendChild(row);
        }

        // Handle row click with confirmation logic
        function handleRowClick(mb) {
            currentSelectedMb = mb;
            
            if (selectedMb && selectedMb.id === mb.id) {
                // Clicked on already selected motherboard - ask to deselect
                if (confirm("Do you want to remove this motherboard from your build?")) {
                    removeSelectedMb();
                }
            } else if (selectedMb) {
                // Already have a selected motherboard - ask to replace
                if (confirm("You already have ${selectedMb.name} selected. Replace it with ${mb.name}?")) {
                    setSelectedMb(mb);
                }
            } else {
                // No motherboard selected - just select this one
                setSelectedMb(mb);
            }
            
            // Show details in modal
            showMbDetails(mb);
        }

        // Set the selected motherboard
        function setSelectedMb(mb) {
            // Remove previous selection highlight
            if (selectedMb) {
                const rows = document.querySelectorAll("#allMB tbody tr");
                rows.forEach(row => {
                    if (row.cells[0].textContent === selectedMb.id.toString()) {
                        row.classList.remove('selected');
                    }
                });
            }
            
            selectedMb = mb;
            
            // Add new selection highlight
            highlightSelectedMbInTable();
            
            // Update the selected motherboard display
            updateSelectedMbDisplay();
            
            // Save to localStorage
            saveSelectedMb();
            
            // Show notification
            showNotification("${mb.name} added to your build!");
        }

        // Remove the selected motherboard
        function removeSelectedMb() {
            if (!selectedMb) return;
            
            const mbName = selectedMb.name;
            
            // Remove selection highlight
            const rows = document.querySelectorAll("#allMB tbody tr");
            rows.forEach(row => {
                if (row.cells[0].textContent === selectedMb.id.toString()) {
                    row.classList.remove('selected');
                }
            });
            
            selectedMb = null;
            
            // Hide the selected motherboard display
            document.getElementById('selectedMbDisplay').style.display = 'none';
            
            // Clear from localStorage
            saveSelectedMb();
            
            // Show notification
            showNotification("${mbName} removed from your build!");
        }

        // Update the selected motherboard display panel
        function updateSelectedMbDisplay() {
            if (selectedMb) {
                document.getElementById('selectedMbName').textContent = selectedMb.name;
                document.getElementById('selectedMbPrice').textContent = selectedMb.price ? "$" + selectedMb.price : "Out Of stock";
                document.getElementById('selectedMbSocket').textContent = selectedMb.socket;
                document.getElementById('selectedMbDisplay').style.display = 'block';
            } else {
                document.getElementById('selectedMbDisplay').style.display = 'none';
            }
        }

        // Show motherboard details in modal
        function showMbDetails(mb) {
            currentSelectedMb = mb;
            document.getElementById('detailsId').textContent = mb.id;
            document.getElementById('detailsName').textContent = mb.name;
            document.getElementById('detailsPrice').textContent = mb.price ? "$" + mb.price : "Out Of stock";
            document.getElementById('detailsSocket').textContent = mb.socket;
            document.getElementById('detailsChipset').textContent = mb.chipset;
            document.getElementById('detailsFormFactor').textContent = mb.formFactor;
            document.getElementById('detailsMemorySlots').textContent = mb.memorySlots;
            document.getElementById('detailsMaxMemory').textContent = mb.maxMemory + "GB";
            
            // Update Add to Build button text and color
            const addButton = document.getElementById('addToBuildBtn');
            if (selectedMb && selectedMb.id === mb.id) {
                addButton.textContent = 'Remove from Build';
                addButton.classList.add('remove');
            } else {
                addButton.textContent = 'Add to Build';
                addButton.classList.remove('remove');
            }
            
            document.getElementById('overlay').style.display = 'block';
            document.getElementById('mbDetails').style.display = 'block';
        }

        // Add to Build button functionality
        document.getElementById('addToBuildBtn').addEventListener('click', function() {
            if (!currentSelectedMb) return;
            
            if (selectedMb && selectedMb.id === currentSelectedMb.id) {
                // Clicked remove
                removeSelectedMb();
            } else if (selectedMb) {
                // Confirm replacement
                if (confirm("Replace ${selectedMb.name} with ${currentSelectedMb.name}?")) {
                    setSelectedMb(currentSelectedMb);
                }
            } else {
                // Just add
                setSelectedMb(currentSelectedMb);
            }
            
            closeModal();
        });

        // Remove Selected Motherboard button functionality
        document.getElementById('removeSelectedMb').addEventListener('click', function() {
            if (selectedMb) {
                if (confirm("Remove ${selectedMb.name} from your build?")) {
                    removeSelectedMb();
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
            document.getElementById('mbDetails').style.display = 'none';
        }

        // Pagination functions
        function nextPage() {
            if ((currentPage + 1) * pageSize < allMbData.length) {
                currentPage++;
                displayMbPage(currentPage);
            } else {
                alert("No more data.");
            }
        }

        function previousPage() {
            if (currentPage > 0) {
                currentPage--;
                displayMbPage(currentPage);
            } else {
                alert("You are on the first page.");
            }
        }

        function searchMotherboard() {
            const query = document.getElementById("mbNameInput").value.trim().toLowerCase();

            $.ajax({
                url: '/motherboard/name-search?name=' + query,
                method: 'GET',
                success: function(data) {
                    allMbData = data;
                    currentPage = 0;
                    displayMbPage(currentPage);
                },
                error: function() {
                    console.log("Error occurred while fetching search results.");
                }
            });
        }

        // Load all motherboards on page load
        $(document).ready(function() {
            fetchAllMotherboards();
        });
    </script>
</body>
</html>