<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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

        .CpuCoolerHeading {
            font-size: 3.5rem;
            font-family: 'Inter', sans-serif; /* Fallback since Moonscape isn't imported */
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
            justify-content: center;
            padding: 30px 60px;
        }

        #allCpuCoolerOutput {
            min-width: 600px;
            margin-top: 20px;
            overflow-x: auto;
        }

        #allCpuCooler {
            border-collapse: collapse;
            width: 100%;
            background-color: #141414;
            color: #fff;
            font-size: 14px;
            border-radius: 8px;
            overflow: hidden;
        }

        #allCpuCooler th,
        #allCpuCooler td {
            border: 1px solid #2c2c2c;
            padding: 14px 18px;
            text-align: center;
        }

        #allCpuCooler th {
            background-color: #1e1e1e;
            font-weight: 600;
        }

        #allCpuCooler tbody tr {
            cursor: pointer;
            transition: background-color 0.2s;
        }

        #allCpuCooler tbody tr:nth-child(odd) {
            background-color: #1a1a1a;
        }

        #allCpuCooler tbody tr:hover {
            background-color: #292929;
        }

        #allCpuCooler tbody tr.selected {
            background-color: #2a4a2a;
        }

        #searchBarContainer {
            display: flex;
            align-items: center;
            gap: 12px;
            margin: 30px 60px 10px;
            flex-wrap: wrap;
        }

        #cpuCoolerNameInput {
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

        /* Modal Styles */
        #cpuCoolerDetails {
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

        #cpuCoolerDetails h3 {
            margin-top: 0;
            color: #fff;
            border-bottom: 1px solid #444;
            padding-bottom: 10px;
        }

        #cpuCoolerDetails p {
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

        #selectedCpuCoolerDisplay {
            margin: 20px 60px;
            padding: 20px;
            background-color: #1f1f1f;
            border-radius: 12px;
            display: none;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }

        #selectedCpuCoolerDisplay h3 {
            margin-top: 0;
            color: #4CAF50;
            border-bottom: 1px solid #333;
            padding-bottom: 10px;
        }

        #selectedCpuCoolerDisplay p {
            margin: 8px 0;
        }

        #removeSelectedCpuCooler {
            background-color: #f44336;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            margin-top: 15px;
            transition: background-color 0.3s;
        }

        #removeSelectedCpuCooler:hover {
            background-color: #d32f2f;
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
                padding: 20px;
            }

            #searchBarContainer,
            #paginationContainer {
                margin: 20px;
                justify-content: center;
            }

            #allCpuCoolerOutput {
                min-width: unset;
                width: 100%;
            }

            #cpuCoolerDetails {
                width: 90%;
                padding: 20px;
            }

            .CpuCoolerHeading {
                font-size: 2.5rem;
            }
        }
        .user-dropdown {
            position: fixed; /* already fixed — good */
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
            position: fixed; /* ← changed from absolute to fixed */
            right: 10px; /* match user-dropdown's right */
            top: 60px;   /* still appears just below the dropdown */
            background-color: #1a1a1a;
            border-radius: 8px;
            box-shadow: 0 8px 20px rgba(255, 255, 255, 0.08);
            min-width: 180px;
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
    </style>
</head>
<body>
    <!-- Back to Main Menu Button -->
    <button id="backToMainMenu">Back to Main Menu</button>

    <!-- Heading -->
    <div class="heading-container">
        <div class="geometric-border">
            <h2 class="CpuCoolerHeading">CPU Cooler Information</h2>
        </div>
    </div>

    <!-- Selected CPU Cooler Display -->
    <div id="selectedCpuCoolerDisplay">
        <h3>Your Selected CPU Cooler</h3>
        <p><strong>Name:</strong> <span id="selectedCpuCoolerName"></span></p>
        <p><strong>Price:</strong> <span id="selectedCpuCoolerPrice"></span></p>
        <p><strong>Size:</strong> <span id="selectedCpuCoolerSize"></span></p>
        <button id="removeSelectedCpuCooler">Remove Selection</button>
    </div>

    <!-- Input and Buttons -->
    <div id="searchBarContainer">
        <input type="text" id="cpuCoolerNameInput" placeholder="Search CPU Coolers" />
        <button onclick="searchCpuCooler()">Search</button>
        <button onclick="clearSearch()">Clear search</button>
    </div>

    <!-- Table -->
    <div id="mainContent">
        <!-- CPU Cooler Table -->
        <div id="allCpuCoolerOutput">
            <table id="allCpuCooler">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Price</th>
                        <th>RPM</th>
                        <th>Noise Level</th>
                        <th>Size</th>
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

    <!-- CPU Cooler Details Modal -->
    <div id="overlay"></div>
    <div id="cpuCoolerDetails">
        <button id="closeDetails">x</button>
        <h3 id="detailsName"></h3>
        <p><strong>ID:</strong> <span id="detailsId"></span></p>
        <p><strong>Price:</strong> <span id="detailsPrice"></span></p>
        <p><strong>RPM:</strong> <span id="detailsRpm"></span></p>
        <p><strong>Noise Level:</strong> <span id="detailsNoiseLevel"></span></p>
        <p><strong>Size:</strong> <span id="detailsSize"></span></p>
        <p><strong>Color:</strong> <span id="detailsColor"></span></p>
        <button id="addToBuildBtn">Add to Build</button>
    </div>

    <!-- Notification -->
    <div id="buildNotification"></div>

    <script>
        // Global variables
        let allCpuCoolerData = [];
        let currentPage = 0;
        const pageSize = 15;
        let currentSelectedCpuCooler = null;
        let selectedCpuCooler = null;

        let currentPcId = localStorage.getItem('pcId');
async function updatePartOnServer(partType, partId) {
        try {
            const url = currentPcId
                ? `/api/score/add-part?pcId=`+currentPcId
                : `/api/score/add-part`;
            console.log(url);
            const response = await fetch(url, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    partType: partType,
                    partId: partId
                })
            });
            
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            
            const result = await response.json();
            
            if (result.success && result.pcId) {
                console.log(result.pcId);
                currentPcId = result.pcId;
                localStorage.setItem('pcId', currentPcId);
            }
            
            return result;
        } catch (error) {
            console.error('Error updating part:', error);
            showNotification('Failed to sync with server');
            return { success: false, message: 'Network error' };
        }
    }



        // Back to Main Menu functionality
        document.getElementById('backToMainMenu').addEventListener('click', function() {
            window.location.href = '/home-pc';
        });

        // Load saved selection from localStorage
        function loadSelectedCpuCooler() {
            const savedCooler = localStorage.getItem('selectedCpuCooler');
            if (savedCooler) {
                try {
                    selectedCpuCooler = JSON.parse(savedCooler);
                    updateSelectedCpuCoolerDisplay();
                    if (selectedCpuCooler && allCpuCoolerData.length > 0) {
                        const completeCooler = allCpuCoolerData.find(c => c.id === selectedCpuCooler.id);
                        if (completeCooler) {
                            selectedCpuCooler = completeCooler;
                        }
                    }
                } catch (e) {
                    console.error("Error parsing saved CPU cooler:", e);
                    localStorage.removeItem('selectedCpuCooler');
                }
            }
        }

        // Save selection to localStorage
        async function saveSelectedCpuCooler() {
            if (selectedCpuCooler) {
                localStorage.setItem('selectedCpuCooler', JSON.stringify({
                    id: selectedCpuCooler.id,
                    name: selectedCpuCooler.name,
                    price: selectedCpuCooler.price,
                    size: selectedCpuCooler.size
                }));
                await updatePartOnServer('cpu_cooler', selectedCpuCooler.id);
            } else {
                localStorage.removeItem('selectedCpuCooler');
            }
        }

        // Clear search
        function clearSearch() {
            document.getElementById("cpuCoolerNameInput").value = "";
            fetchAllCpuCoolers();
        }

        // Fetch all CPU Coolers from the backend
        function fetchAllCpuCoolers() {
            console.log("Fetching CPU coolers from /cpu-cooler");
            $.ajax({
                url: '/cpu-cooler',
                method: 'GET',
                success: function(coolerList) {
                    console.log("Received CPU cooler data:", coolerList);
                    if (!Array.isArray(coolerList) || coolerList.length === 0) {
                        console.warn("No CPU cooler data received or data is not an array");
                        alert("No CPU coolers found. The server returned an empty list.");
                        return;
                    }
                    allCpuCoolerData = coolerList;
                    currentPage = 0;
                    displayCpuCoolerPage(currentPage);
                    // After loading data, check if we have a saved selection
                    loadSelectedCpuCooler();
                    // Highlight the saved selection in the table if it exists
                    if (selectedCpuCooler) {
                        highlightSelectedCpuCoolerInTable();
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.error("Failed to fetch CPU coolers:", textStatus, errorThrown);
                    console.error("Response:", jqXHR.responseText);
                    alert(`Failed to fetch CPU coolers: ${textStatus}. Check the console for details.`);
                }
            });
        }

        // Highlight the selected CPU cooler in the table
        function highlightSelectedCpuCoolerInTable() {
            const rows = document.querySelectorAll("#allCpuCooler tbody tr");
            rows.forEach(row => {
                if (selectedCpuCooler && row.cells[0].textContent === selectedCpuCooler.id.toString()) {
                    row.classList.add('selected');
                } else {
                    row.classList.remove('selected');
                }
            });
        }

        // Display a page of data
        function displayCpuCoolerPage(page) {
            console.log(`Displaying page ${page} with pageSize ${pageSize}`);
            const tableBody = document.querySelector("#allCpuCooler tbody");
            if (!tableBody) {
                console.error("Table body not found!");
                alert("Error: Table body not found in the DOM.");
                return;
            }
            tableBody.innerHTML = "";
            const startIndex = page * pageSize;
            const endIndex = startIndex + pageSize;
            const pageData = allCpuCoolerData.slice(startIndex, endIndex);
            console.log("Page data:", pageData);
            if (pageData.length === 0 && allCpuCoolerData.length > 0) {
                console.warn("No data for this page, but data exists");
                tableBody.innerHTML = "<tr><td colspan='7'>No CPU coolers on this page</td></tr>";
                return;
            } else if (pageData.length === 0) {
                tableBody.innerHTML = "<tr><td colspan='7'>No CPU coolers available</td></tr>";
                return;
            }
            pageData.forEach(cooler => {
                addCpuCoolerRow(cooler);
            });
            // Re-highlight selected CPU cooler after rendering
            if (selectedCpuCooler) {
                highlightSelectedCpuCoolerInTable();
            }
        }

        // Append a single row to the table
        function addCpuCoolerRow(entry) {
            console.log("Adding row for CPU cooler:", entry);
            const tableBody = document.querySelector("#allCpuCooler tbody");
            const row = document.createElement("tr");

            // Highlight if this is the selected cooler
            if (selectedCpuCooler && selectedCpuCooler.id === entry.id) {
                row.classList.add('selected');
            }

            // Validate entry data
            if (!entry || typeof entry !== 'object') {
                console.error("Invalid CPU cooler entry:", entry);
                return;
            }

            row.innerHTML = "<td>" + (entry.id || 'N/A') + "</td>" +
                            "<td>" + (entry.name || 'Unknown') + "</td>" +
                            "<td>" + (entry.price != null ? "$" + entry.price : "Out of stock") + "</td>" +
                            "<td>" + (entry.rpm || 'N/A') + "</td>" +
                            "<td>" + (entry.noiseLevel || 'N/A') + "</td>" +
                            "<td>" + (entry.size || 'N/A') + "</td>" +
                            "<td>" + (entry.color || 'N/A') + "</td>";

            row.addEventListener('click', function() {
                handleRowClick(entry);
            });

            tableBody.appendChild(row);
        }

        // Handle row click with confirmation logic
        function handleRowClick(cooler) {
            currentSelectedCpuCooler = cooler;

            if (selectedCpuCooler && selectedCpuCooler.id === cooler.id) {
                // Clicked on already selected cooler - ask to deselect
                if (confirm("Do you want to remove this CPU cooler from your build?")) {
                    removeSelectedCpuCooler();
                }
            } else if (selectedCpuCooler) {
                // Already have a selected cooler - ask to replace
                if (confirm(`You already have ${selectedCpuCooler.name} selected. Replace it with ${cooler.name}?`)) {
                    setSelectedCpuCooler(cooler);
                }
            } else {
                // No cooler selected - just select this one
                setSelectedCpuCooler(cooler);
            }

            // Show details in modal
            showCpuCoolerDetails(cooler);
        }

        // Set the selected CPU cooler
        function setSelectedCpuCooler(cooler) {
            // Remove previous selection highlight
            if (selectedCpuCooler) {
                const rows = document.querySelectorAll("#allCpuCooler tbody tr");
                rows.forEach(row => {
                    if (row.cells[0].textContent === selectedCpuCooler.id.toString()) {
                        row.classList.remove('selected');
                    }
                });
            }

            selectedCpuCooler = cooler;

            // Add new selection highlight
            highlightSelectedCpuCoolerInTable();

            // Update the selected cooler display
            updateSelectedCpuCoolerDisplay();

            // Save to localStorage
            saveSelectedCpuCooler();

            // Show notification
            showNotification(`${cooler.name} added to your build!`);
        }

        // Remove the selected CPU cooler
        async function removeSelectedCpuCooler() {
            if (!selectedCpuCooler) return;

            const coolerName = selectedCpuCooler.name;

            // Remove selection highlight
            const rows = document.querySelectorAll("#allCpuCooler tbody tr");
            rows.forEach(row => {
                if (row.cells[0].textContent === selectedCpuCooler.id.toString()) {
                    row.classList.remove('selected');
                }
            });

            selectedCpuCooler = null;

            // Hide the selected cooler display
            document.getElementById('selectedCpuCoolerDisplay').style.display = 'none';

            // Clear from localStorage
            saveSelectedCpuCooler();
            
            await updatePartOnServer('cpu_cooler', null);

            // Show notification
            showNotification(`${coolerName} removed from your build!`);
        }

        // Update the selected cooler display panel
        function updateSelectedCpuCoolerDisplay() {
            if (selectedCpuCooler) {
                document.getElementById('selectedCpuCoolerName').textContent = selectedCpuCooler.name || 'Unknown';
                document.getElementById('selectedCpuCoolerPrice').textContent = selectedCpuCooler.price != null ? "$" + selectedCpuCooler.price : "Out of stock";
                document.getElementById('selectedCpuCoolerSize').textContent = selectedCpuCooler.size || 'N/A';
                document.getElementById('selectedCpuCoolerDisplay').style.display = 'block';
            } else {
                document.getElementById('selectedCpuCoolerDisplay').style.display = 'none';
            }
        }

        // Show cooler details in modal
        function showCpuCoolerDetails(cooler) {
            currentSelectedCpuCooler = cooler;
            document.getElementById('detailsId').textContent = cooler.id || 'N/A';
            document.getElementById('detailsName').textContent = cooler.name || 'Unknown';
            document.getElementById('detailsPrice').textContent = cooler.price != null ? "$" + cooler.price : "Out of stock";
            document.getElementById('detailsRpm').textContent = cooler.rpm || 'N/A';
            document.getElementById('detailsNoiseLevel').textContent = cooler.noiseLevel || 'N/A';
            document.getElementById('detailsSize').textContent = cooler.size || 'N/A';
            document.getElementById('detailsColor').textContent = cooler.color || 'N/A';

            // Update Add to Build button text and color
            const addButton = document.getElementById('addToBuildBtn');
            if (selectedCpuCooler && selectedCpuCooler.id === cooler.id) {
                addButton.textContent = 'Remove from Build';
                addButton.classList.add('remove');
            } else {
                addButton.textContent = 'Add to Build';
                addButton.classList.remove('remove');
            }

            document.getElementById('overlay').style.display = 'block';
            document.getElementById('cpuCoolerDetails').style.display = 'block';
        }

        // Add to Build button functionality
        document.getElementById('addToBuildBtn').addEventListener('click', function() {
            if (!currentSelectedCpuCooler) return;

            if (selectedCpuCooler && selectedCpuCooler.id === currentSelectedCpuCooler.id) {
                // Clicked remove
                removeSelectedCpuCooler();
            } else if (selectedCpuCooler) {
                // Confirm replacement
                if (confirm(`Replace ${selectedCpuCooler.name} with ${currentSelectedCpuCooler.name}?`)) {
                    setSelectedCpuCooler(currentSelectedCpuCooler);
                }
            } else {
                // Just add
                setSelectedCpuCooler(currentSelectedCpuCooler);
            }

            closeModal();
        });

        // Remove Selected Cooler button functionality
        document.getElementById('removeSelectedCpuCooler').addEventListener('click', function() {
            if (selectedCpuCooler) {
                if (confirm(`Remove ${selectedCpuCooler.name} from your build?`)) {
                    removeSelectedCpuCooler();
                }
            }
        });

        // Show notification
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
            document.getElementById('cpuCoolerDetails').style.display = 'none';
        }

        // Pagination functions
        function nextPage() {
            if ((currentPage + 1) * pageSize < allCpuCoolerData.length) {
                currentPage++;
                displayCpuCoolerPage(currentPage);
            } else {
                alert("No more data.");
            }
        }

        function previousPage() {
            if (currentPage > 0) {
                currentPage--;
                displayCpuCoolerPage(currentPage);
            } else {
                alert("You are on the first page.");
            }
        }

        // Search CPU Cooler
        function searchCpuCooler() {
            const query = document.getElementById("cpuCoolerNameInput").value.trim().toLowerCase();
            console.log("Searching CPU coolers with query:", query);

            $.ajax({
                url: '/cpu-cooler/name-search?name=' + encodeURIComponent(query),
                method: 'GET',
                success: function(data) {
                    console.log("Search results:", data);
                    if (!Array.isArray(data) || data.length === 0) {
                        console.warn("No search results found");
                        alert("No CPU coolers found for search query.");
                    }
                    allCpuCoolerData = data;
                    currentPage = 0;
                    displayCpuCoolerPage(currentPage);
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.error("Search failed:", textStatus, errorThrown);
                    console.error("Response:", jqXHR.responseText);
                    alert(`Search failed: ${textStatus}. Check the console for details.`);
                }
            });
        }

        // Load all coolers on page load
        $(document).ready(function() {
            console.log("Page loaded, fetching CPU coolers");
            fetchAllCpuCoolers();
        });
    </script>
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