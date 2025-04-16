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

        .MemoryHeading {
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

        #searchBarContainer {
            display: flex;
            align-items: center;
            gap: 12px;
            margin: 30px 60px 10px;
            flex-wrap: wrap;
        }

        #memoryNameInput {
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

        #allMemoryOutput {
            flex: 2;
            min-width: 600px;
            margin-top: 20px;
            overflow-x: auto;
        }

        #allMemory {
            border-collapse: collapse;
            width: 100%;
            background-color: #141414;
            color: #fff;
            font-size: 14px;
            border-radius: 8px;
            overflow: hidden;
        }

        #allMemory th,
        #allMemory td {
            border: 1px solid #2c2c2c;
            padding: 14px 18px;
            text-align: center;
        }

        #allMemory th {
            background-color: #1e1e1e;
            font-weight: 600;
        }

        #allMemory tbody tr {
            cursor: pointer;
            transition: background-color 0.2s;
        }

        #allMemory tbody tr:nth-child(odd) {
            background-color: #1a1a1a;
        }

        #allMemory tbody tr:hover {
            background-color: #292929;
        }

        #allMemory tbody tr.selected {
            background-color: #2a4a2a;
        }

        #paginationContainer {
            margin: 30px 60px;
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        /* Modal Styles */
        #memoryDetails {
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

        #memoryDetails h3 {
            margin-top: 0;
            color: #fff;
            border-bottom: 1px solid #444;
            padding-bottom: 10px;
        }

        #memoryDetails p {
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

        #selectedMemoryDisplay {
            margin: 20px 60px;
            padding: 20px;
            background-color: #1f1f1f;
            border-radius: 12px;
            display: none;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }

        #selectedMemoryDisplay h3 {
            margin-top: 0;
            color: #4CAF50;
            border-bottom: 1px solid #333;
            padding-bottom: 10px;
        }

        #selectedMemoryDisplay p {
            margin: 8px 0;
        }

        #removeSelectedMemory {
            background-color: #f44336;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            margin-top: 15px;
            transition: background-color 0.3s;
        }

        #removeSelectedMemory:hover {
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

            #allMemoryOutput {
                min-width: unset;
                width: 100%;
            }

            #memoryDetails {
                width: 90%;
                padding: 20px;
            }

            .MemoryHeading {
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
            <h2 class="MemoryHeading">Memory Information</h2>
        </div>
    </div>

    <!-- Selected Memory Display -->
    <div id="selectedMemoryDisplay">
        <h3>Your Selected Memory</h3>
        <p><strong>Name:</strong> <span id="selectedMemoryName"></span></p>
        <p><strong>Price:</strong> <span id="selectedMemoryPrice"></span></p>
        <p><strong>Speed:</strong> <span id="selectedMemorySpeed"></span></p>
        <p><strong>Modules:</strong> <span id="selectedMemoryModules"></span></p>
        <button id="removeSelectedMemory">Remove Selection</button>
    </div>

    <!-- Input and Buttons -->
    <div id="searchBarContainer">
        <input type="text" id="memoryNameInput" placeholder="Search Memory" />
        <button onclick="searchMemory()">Search</button>
        <button onclick="clearSearch()">Clear search</button>
    </div>

    <!-- Output & Table Side-by-side -->
    <div id="mainContent">
        <!-- Memory Table -->
        <div id="allMemoryOutput">
            <table id="allMemory">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Price</th>
                        <th>Speed</th>
                        <th>Modules</th>
                        <th>Price Per GB</th>
                        <th>Color</th>
                        <th>First Word Latency</th>
                        <th>CAS Latency</th>
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

    <!-- Memory Details Modal -->
    <div id="overlay"></div>
    <div id="memoryDetails">
        <button id="closeDetails">x</button>
        <h3 id="detailsName"></h3>
        <p><strong>ID:</strong> <span id="detailsId"></span></p>
        <p><strong>Price:</strong> <span id="detailsPrice"></span></p>
        <p><strong>Speed:</strong> <span id="detailsSpeed"></span></p>
        <p><strong>Modules:</strong> <span id="detailsModules"></span></p>
        <p><strong>Price Per GB:</strong> <span id="detailsPricePerGb"></span></p>
        <p><strong>Color:</strong> <span id="detailsColor"></span></p>
        <p><strong>First Word Latency:</strong> <span id="detailsFirstWordLatency"></span></p>
        <p><strong>CAS Latency:</strong> <span id="detailsCasLatency"></span></p>
        <button id="addToBuildBtn">Add to Build</button>
    </div>

    <!-- Notification -->
    <div id="buildNotification"></div>

    <script>
        // Global variables
        let allMemoryData = [];
        let currentPage = 0;
        const pageSize = 15;
        let currentSelectedMemory = null;
        let selectedMemory = null;

        // Back to Main Menu functionality
        document.getElementById('backToMainMenu').addEventListener('click', function() {
            window.location.href = '/';
        });

        // Load saved selection from localStorage
        function loadSelectedMemory() {
            const savedMemory = localStorage.getItem('selectedMemory');
            if (savedMemory) {
                try {
                    selectedMemory = JSON.parse(savedMemory);
                    updateSelectedMemoryDisplay();
                    // Find the complete memory data from allMemoryData
                    if (selectedMemory && allMemoryData.length > 0) {
                        const completeMemory = allMemoryData.find(m => m.id === selectedMemory.id);
                        if (completeMemory) {
                            selectedMemory = completeMemory;
                        }
                    }
                } catch (e) {
                    console.error("Error parsing saved memory:", e);
                    localStorage.removeItem('selectedMemory');
                }
            }
        }

        // Save selection to localStorage
        function saveSelectedMemory() {
            if (selectedMemory) {
                localStorage.setItem('selectedMemory', JSON.stringify({
                    id: selectedMemory.id,
                    name: selectedMemory.name,
                    price: selectedMemory.price,
                    speed: selectedMemory.speed,
                    modules: selectedMemory.modules
                }));
            } else {
                localStorage.removeItem('selectedMemory');
            }
        }

        function clearSearch() {
            document.getElementById("memoryNameInput").value = "";
            fetchAllMemories();
        }

        // Fetch all Memory from the backend
        function fetchAllMemories() {
            $.ajax({
                url: '/memory',
                method: 'GET',
                success: function(memoryList) {
                    allMemoryData = memoryList;
                    currentPage = 0;
                    displayMemoryPage(currentPage);
                    // After loading data, check if we have a saved selection
                    loadSelectedMemory();
                    // Highlight the saved selection in the table if it exists
                    if (selectedMemory) {
                        highlightSelectedMemoryInTable();
                    }
                },
                error: function() {
                    alert('Failed to fetch memory items.');
                }
            });
        }

        // Highlight the selected memory in the table
        function highlightSelectedMemoryInTable() {
            const rows = document.querySelectorAll("#allMemory tbody tr");
            rows.forEach(row => {
                if (selectedMemory && row.cells[0].textContent === selectedMemory.id.toString()) {
                    row.classList.add('selected');
                } else {
                    row.classList.remove('selected');
                }
            });
        }

        // Display a page of data
        function displayMemoryPage(page) {
            const tableBody = document.querySelector("#allMemory tbody");
            tableBody.innerHTML = "";
            const startIndex = page * pageSize;
            const endIndex = startIndex + pageSize;
            const pageData = allMemoryData.slice(startIndex, endIndex);
            pageData.forEach(memory => {
                addMemoryRow(memory);
            });
            
            // Re-highlight selected memory after rendering
            if (selectedMemory) {
                highlightSelectedMemoryInTable();
            }
        }

        // Append a single row to the table
        function addMemoryRow(memory) {
            const tableBody = document.querySelector("#allMemory tbody");
            const row = document.createElement("tr");
            
            // Highlight if this is the selected memory
            if (selectedMemory && selectedMemory.id === memory.id) {
                row.classList.add('selected');
            }
            
            row.innerHTML = "<td>" + memory.id + "</td>" +
                "<td>" + memory.name + "</td>" +
                "<td>" + (memory.price ? "$" + memory.price : "Out of stock") + "</td>" +
                "<td>" + memory.speed + "</td>" +
                "<td>" + memory.modules + "</td>" +
                "<td>" + "$" + memory.pricePerGb + "</td>" +
                "<td>" + memory.color + "</td>" +
                "<td>" + memory.firstWordLatency + "</td>" +
                "<td>" + memory.casLatency + "</td>";
            
            row.addEventListener('click', function() {
                handleRowClick(memory);
            });
            
            tableBody.appendChild(row);
        }

        // Handle row click with confirmation logic
        function handleRowClick(memory) {
            currentSelectedMemory = memory;
            
            if (selectedMemory && selectedMemory.id === memory.id) {
                // Clicked on already selected memory - ask to deselect
                if (confirm("Do you want to remove this memory from your build?")) {
                    removeSelectedMemory();
                }
            } else if (selectedMemory) {
                // Already have a selected memory - ask to replace
                if (confirm("You already have ${selectedMemory.name} selected. Replace it with ${memory.name}?")) {
                    setSelectedMemory(memory);
                }
            } else {
                // No memory selected - just select this one
                setSelectedMemory(memory);
            }
            
            // Show details in modal
            showMemoryDetails(memory);
        }

        // Set the selected memory
        function setSelectedMemory(memory) {
            // Remove previous selection highlight
            if (selectedMemory) {
                const rows = document.querySelectorAll("#allMemory tbody tr");
                rows.forEach(row => {
                    if (row.cells[0].textContent === selectedMemory.id.toString()) {
                        row.classList.remove('selected');
                    }
                });
            }
            
            selectedMemory = memory;
            
            // Add new selection highlight
            highlightSelectedMemoryInTable();
            
            // Update the selected memory display
            updateSelectedMemoryDisplay();
            
            // Save to localStorage
            saveSelectedMemory();
            
            // Show notification
            showNotification("${memory.name} added to your build!");
        }

        // Remove the selected memory
        function removeSelectedMemory() {
            if (!selectedMemory) return;
            
            const memoryName = selectedMemory.name;
            
            // Remove selection highlight
            const rows = document.querySelectorAll("#allMemory tbody tr");
            rows.forEach(row => {
                if (row.cells[0].textContent === selectedMemory.id.toString()) {
                    row.classList.remove('selected');
                }
            });
            
            selectedMemory = null;
            
            // Hide the selected memory display
            document.getElementById('selectedMemoryDisplay').style.display = 'none';
            
            // Clear from localStorage
            saveSelectedMemory();
            
            // Show notification
            showNotification("${memoryName} removed from your build!");
        }

        // Update the selected memory display panel
        function updateSelectedMemoryDisplay() {
            if (selectedMemory) {
                document.getElementById('selectedMemoryName').textContent = selectedMemory.name;
                document.getElementById('selectedMemoryPrice').textContent = selectedMemory.price ? "$" + selectedMemory.price : "Out Of stock";
                document.getElementById('selectedMemorySpeed').textContent = selectedMemory.speed;
                document.getElementById('selectedMemoryModules').textContent = selectedMemory.modules;
                document.getElementById('selectedMemoryDisplay').style.display = 'block';
            } else {
                document.getElementById('selectedMemoryDisplay').style.display = 'none';
            }
        }

        // Show memory details in modal
        function showMemoryDetails(memory) {
            currentSelectedMemory = memory;
            document.getElementById('detailsId').textContent = memory.id;
            document.getElementById('detailsName').textContent = memory.name;
            document.getElementById('detailsPrice').textContent = memory.price ? "$" + memory.price : "Out Of stock";
            document.getElementById('detailsSpeed').textContent = memory.speed;
            document.getElementById('detailsModules').textContent = memory.modules;
            document.getElementById('detailsPricePerGb').textContent = memory.pricePerGb ? "$" + memory.pricePerGb : "N/A";
            document.getElementById('detailsColor').textContent = memory.color;
            document.getElementById('detailsFirstWordLatency').textContent = memory.firstWordLatency;
            document.getElementById('detailsCasLatency').textContent = memory.casLatency;
            
            // Update Add to Build button text and color
            const addButton = document.getElementById('addToBuildBtn');
            if (selectedMemory && selectedMemory.id === memory.id) {
                addButton.textContent = 'Remove from Build';
                addButton.classList.add('remove');
            } else {
                addButton.textContent = 'Add to Build';
                addButton.classList.remove('remove');
            }
            
            document.getElementById('overlay').style.display = 'block';
            document.getElementById('memoryDetails').style.display = 'block';
        }

        // Add to Build button functionality
        document.getElementById('addToBuildBtn').addEventListener('click', function() {
            if (!currentSelectedMemory) return;
            
            if (selectedMemory && selectedMemory.id === currentSelectedMemory.id) {
                // Clicked remove
                removeSelectedMemory();
            } else if (selectedMemory) {
                // Confirm replacement
                if (confirm("Replace ${selectedMemory.name} with ${currentSelectedMemory.name}?")) {
                    setSelectedMemory(currentSelectedMemory);
                }
            } else {
                // Just add
                setSelectedMemory(currentSelectedMemory);
            }
            
            closeModal();
        });

        // Remove Selected Memory button functionality
        document.getElementById('removeSelectedMemory').addEventListener('click', function() {
            if (selectedMemory) {
                if (confirm("Remove ${selectedMemory.name} from your build?")) {
                    removeSelectedMemory();
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
            document.getElementById('memoryDetails').style.display = 'none';
        }

        // Pagination functions
        function nextPage() {
            if ((currentPage + 1) * pageSize < allMemoryData.length) {
                currentPage++;
                displayMemoryPage(currentPage);
            } else {
                alert("No more data.");
            }
        }

        function previousPage() {
            if (currentPage > 0) {
                currentPage--;
                displayMemoryPage(currentPage);
            } else {
                alert("You are on the first page.");
            }
        }

        function searchMemory() {
            const query = document.getElementById("memoryNameInput").value.trim().toLowerCase();

            $.ajax({
                url: '/memory/name-search?name=' + query,
                method: 'GET',
                success: function(data) {
                    allMemoryData = data;
                    currentPage = 0;
                    displayMemoryPage(currentPage);
                },
                error: function() {
                    console.log("Error occurred while fetching search results.");
                }
            });
        }

        // Load all memory on page load
        $(document).ready(function() {
            fetchAllMemories();
        });
    </script>
</body>
</html>