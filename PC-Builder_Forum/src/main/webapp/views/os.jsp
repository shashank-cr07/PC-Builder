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

        .OsHeading {
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

        #searchBarContainer {
            display: flex;
            align-items: center;
            gap: 12px;
            margin: 30px 60px 10px;
            flex-wrap: wrap;
        }

        #osNameInput {
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

        #allOsOutput {
            min-width: 600px;
            margin-top: 20px;
            overflow-x: auto;
        }

        #allOs {
            border-collapse: collapse;
            width: 100%;
            background-color: #141414;
            color: #fff;
            font-size: 14px;
            border-radius: 8px;
            overflow: hidden;
        }

        #allOs th,
        #allOs td {
            border: 1px solid #2c2c2c;
            padding: 14px 18px;
            text-align: center;
        }

        #allOs th {
            background-color: #1e1e1e;
            font-weight: 600;
        }

        #allOs tbody tr {
            cursor: pointer;
            transition: background-color 0.2s;
        }

        #allOs tbody tr:nth-child(odd) {
            background-color: #1a1a1a;
        }

        #allOs tbody tr:hover {
            background-color: #292929;
        }

        #allOs tbody tr.selected {
            background-color: #2a4a2a;
        }

        #paginationContainer {
            margin: 30px 60px;
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        /* Modal Styles */
        #osDetails {
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

        #osDetails h3 {
            margin-top: 0;
            color: #fff;
            border-bottom: 1px solid #444;
            padding-bottom: 10px;
        }

        #osDetails p {
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

        #selectedOsDisplay {
            margin: 20px 60px;
            padding: 20px;
            background-color: #1f1f1f;
            border-radius: 12px;
            display: none;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }

        #selectedOsDisplay h3 {
            margin-top: 0;
            color: #4CAF50;
            border-bottom: 1px solid #333;
            padding-bottom: 10px;
        }

        #selectedOsDisplay p {
            margin: 8px 0;
        }

        #removeSelectedOs {
            background-color: #f44336;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            margin-top: 15px;
            transition: background-color 0.3s;
        }

        #removeSelectedOs:hover {
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
                padding: 20px;
            }

            #searchBarContainer,
            #paginationContainer {
                margin: 20px;
                justify-content: center;
            }

            #allOsOutput {
                min-width: unset;
                width: 100%;
            }

            #osDetails {
                width: 90%;
                padding: 20px;
            }

            .OsHeading {
                font-size: 2.5rem;
            }
        }
    </style>
</head>
<body>
    <!-- Back to Main Menu Button -->
    <button id="backToMainMenu">Back to Main Menu</button>

    <!-- Heading -->
    <div class="heading-container">
        <div class="geometric-border">
            <h2 class="OsHeading">Operating System Information</h2>
        </div>
    </div>

    <!-- Selected OS Display -->
    <div id="selectedOsDisplay">
        <h3>Your Selected Operating System</h3>
        <p><strong>Name:</strong> <span id="selectedOsName"></span></p>
        <p><strong>Price:</strong> <span id="selectedOsPrice"></span></p>
        <p><strong>Mode:</strong> <span id="selectedOsMode"></span></p>
        <button id="removeSelectedOs">Remove Selection</button>
    </div>

    <!-- Input and Buttons -->
    <div id="searchBarContainer">
        <input type="text" id="osNameInput" placeholder="Search Operating System" />
        <button onclick="searchOs()">Search</button>
        <button onclick="clearSearch()">Clear search</button>
    </div>

    <!-- Table -->
    <div id="mainContent">
        <!-- OS Table -->
        <div id="allOsOutput">
            <table id="allOs">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Price</th>
                        <th>Mode</th>
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

    <!-- OS Details Modal -->
    <div id="overlay"></div>
    <div id="osDetails">
        <button id="closeDetails">x</button>
        <h3 id="detailsName"></h3>
        <p><strong>ID:</strong> <span id="detailsId"></span></p>
        <p><strong>Price:</strong> <span id="detailsPrice"></span></p>
        <p><strong>Mode:</strong> <span id="detailsMode"></span></p>
        <p><strong>Max Memory:</strong> <span id="detailsMaxMemory"></span></p>
        <button id="addToBuildBtn">Add to Build</button>
    </div>

    <!-- Notification -->
    <div id="buildNotification"></div>

    <script>
        // Global variables
        let allOsData = [];
        let currentPage = 0;
        const pageSize = 15;
        let currentSelectedOs = null;
        let selectedOs = null;

        // Back to Main Menu functionality
        document.getElementById('backToMainMenu').addEventListener('click', function() {
            window.location.href = '/';
        });

        // Load saved selection from localStorage
        function loadSelectedOs() {
            const savedOs = localStorage.getItem('selectedOs');
            if (savedOs) {
                try {
                    selectedOs = JSON.parse(savedOs);
                    updateSelectedOsDisplay();
                    // Find the complete OS data from allOsData
                    if (selectedOs && allOsData.length > 0) {
                        const completeOs = allOsData.find(o => o.id === selectedOs.id);
                        if (completeOs) {
                            selectedOs = completeOs;
                        }
                    }
                } catch (e) {
                    console.error("Error parsing saved OS:", e);
                    localStorage.removeItem('selectedOs');
                }
            }
        }

        // Save selection to localStorage
        function saveSelectedOs() {
            if (selectedOs) {
                localStorage.setItem('selectedOs', JSON.stringify({
                    id: selectedOs.id,
                    name: selectedOs.name,
                    price: selectedOs.price,
                    mode: selectedOs.mode
                }));
            } else {
                localStorage.removeItem('selectedOs');
            }
        }

        // Clear search
        function clearSearch() {
            document.getElementById("osNameInput").value = "";
            fetchAllOs();
        }

        // Fetch all OSs from the backend
        function fetchAllOs() {
            console.log("Fetching OSs from /os");
            $.ajax({
                url: '/os',
                method: 'GET',
                success: function(osList) {
                    console.log("Received OS data:", osList);
                    if (!Array.isArray(osList) || osList.length === 0) {
                        console.warn("No OS data received or data is not an array");
                        alert("No operating systems found. The server returned an empty list.");
                        return;
                    }
                    allOsData = osList;
                    currentPage = 0;
                    displayOsPage(currentPage);
                    // After loading data, check if we have a saved selection
                    loadSelectedOs();
                    // Highlight the saved selection in the table if it exists
                    if (selectedOs) {
                        highlightSelectedOsInTable();
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.error("Failed to fetch OSs:", textStatus, errorThrown);
                    console.error("Response:", jqXHR.responseText);
                    alert(`Failed to fetch operating systems: ${textStatus}. Check the console for details.`);
                }
            });
        }

        // Highlight the selected OS in the table
        function highlightSelectedOsInTable() {
            const rows = document.querySelectorAll("#allOs tbody tr");
            rows.forEach(row => {
                if (selectedOs && row.cells[0].textContent === selectedOs.id.toString()) {
                    row.classList.add('selected');
                } else {
                    row.classList.remove('selected');
                }
            });
        }

        // Display a page of data
        function displayOsPage(page) {
            console.log(`Displaying page ${page} with pageSize ${pageSize}`);
            const tableBody = document.querySelector("#allOs tbody");
            if (!tableBody) {
                console.error("Table body not found!");
                alert("Error: Table body not found in the DOM.");
                return;
            }
            tableBody.innerHTML = "";
            const startIndex = page * pageSize;
            const endIndex = startIndex + pageSize;
            const pageData = allOsData.slice(startIndex, endIndex);
            console.log("Page data:", pageData);
            if (pageData.length === 0 && allOsData.length > 0) {
                console.warn("No data for this page, but data exists");
                tableBody.innerHTML = "<tr><td colspan='5'>No operating systems on this page</td></tr>";
                return;
            } else if (pageData.length === 0) {
                tableBody.innerHTML = "<tr><td colspan='5'>No operating systems available</td></tr>";
                return;
            }
            pageData.forEach(os => {
                addOsRow(os);
            });
            // Re-highlight selected OS after rendering
            if (selectedOs) {
                highlightSelectedOsInTable();
            }
        }

        // Append a single row to the table
        function addOsRow(entry) {
            console.log("Adding row for OS:", entry);
            const tableBody = document.querySelector("#allOs tbody");
            const row = document.createElement("tr");

            // Highlight if this is the selected OS
            if (selectedOs && selectedOs.id === entry.id) {
                row.classList.add('selected');
            }

            // Validate entry data
            if (!entry || typeof entry !== 'object') {
                console.error("Invalid OS entry:", entry);
                return;
            }

            row.innerHTML = "<td>" + (entry.id || 'N/A') + "</td>" +
                            "<td>" + (entry.name || 'Unknown') + "</td>" +
                            "<td>" + (entry.price != null ? "$" + entry.price : "Out of stock") + "</td>" +
                            "<td>" + (entry.mode || 'N/A') + "</td>" +
                            "<td>" + (entry.maxMemory || 'N/A') + "</td>";

            row.addEventListener('click', function() {
                handleRowClick(entry);
            });

            tableBody.appendChild(row);
        }

        // Handle row click with confirmation logic
        function handleRowClick(os) {
            currentSelectedOs = os;

            if (selectedOs && selectedOs.id === os.id) {
                // Clicked on already selected OS - ask to deselect
                if (confirm("Do you want to remove this operating system from your build?")) {
                    removeSelectedOs();
                }
            } else if (selectedOs) {
                // Already have a selected OS - ask to replace
                if (confirm(`You already have ${selectedOs.name} selected. Replace it with ${os.name}?`)) {
                    setSelectedOs(os);
                }
            } else {
                // No OS selected - just select this one
                setSelectedOs(os);
            }

            // Show details in modal
            showOsDetails(os);
        }

        // Set the selected OS
        function setSelectedOs(os) {
            // Remove previous selection highlight
            if (selectedOs) {
                const rows = document.querySelectorAll("#allOs tbody tr");
                rows.forEach(row => {
                    if (row.cells[0].textContent === selectedOs.id.toString()) {
                        row.classList.remove('selected');
                    }
                });
            }

            selectedOs = os;

            // Add new selection highlight
            highlightSelectedOsInTable();

            // Update the selected OS display
            updateSelectedOsDisplay();

            // Save to localStorage
            saveSelectedOs();

            // Show notification
            showNotification(`${os.name} added to your build!`);
        }

        // Remove the selected OS
        function removeSelectedOs() {
            if (!selectedOs) return;

            const osName = selectedOs.name;

            // Remove selection highlight
            const rows = document.querySelectorAll("#allOs tbody tr");
            rows.forEach(row => {
                if (row.cells[0].textContent === selectedOs.id.toString()) {
                    row.classList.remove('selected');
                }
            });

            selectedOs = null;

            // Hide the selected OS display
            document.getElementById('selectedOsDisplay').style.display = 'none';

            // Clear from localStorage
            saveSelectedOs();

            // Show notification
            showNotification(`${osName} removed from your build!`);
        }

        // Update the selected OS display panel
        function updateSelectedOsDisplay() {
            if (selectedOs) {
                document.getElementById('selectedOsName').textContent = selectedOs.name || 'Unknown';
                document.getElementById('selectedOsPrice').textContent = selectedOs.price != null ? "$" + selectedOs.price : "Out of stock";
                document.getElementById('selectedOsMode').textContent = selectedOs.mode || 'N/A';
                document.getElementById('selectedOsDisplay').style.display = 'block';
            } else {
                document.getElementById('selectedOsDisplay').style.display = 'none';
            }
        }

        // Show OS details in modal
        function showOsDetails(os) {
            currentSelectedOs = os;
            document.getElementById('detailsId').textContent = os.id || 'N/A';
            document.getElementById('detailsName').textContent = os.name || 'Unknown';
            document.getElementById('detailsPrice').textContent = os.price != null ? "$" + os.price : "Out of stock";
            document.getElementById('detailsMode').textContent = os.mode || 'N/A';
            document.getElementById('detailsMaxMemory').textContent = os.maxMemory || 'N/A';

            // Update Add to Build button text and color
            const addButton = document.getElementById('addToBuildBtn');
            if (selectedOs && selectedOs.id === os.id) {
                addButton.textContent = 'Remove from Build';
                addButton.classList.add('remove');
            } else {
                addButton.textContent = 'Add to Build';
                addButton.classList.remove('remove');
            }

            document.getElementById('overlay').style.display = 'block';
            document.getElementById('osDetails').style.display = 'block';
        }

        // Add to Build button functionality
        document.getElementById('addToBuildBtn').addEventListener('click', function() {
            if (!currentSelectedOs) return;

            if (selectedOs && selectedOs.id === currentSelectedOs.id) {
                // Clicked remove
                removeSelectedOs();
            } else if (selectedOs) {
                // Confirm replacement
                if (confirm(`Replace ${selectedOs.name} with ${currentSelectedOs.name}?`)) {
                    setSelectedOs(currentSelectedOs);
                }
            } else {
                // Just add
                setSelectedOs(currentSelectedOs);
            }

            closeModal();
        });

        // Remove Selected OS button functionality
        document.getElementById('removeSelectedOs').addEventListener('click', function() {
            if (selectedOs) {
                if (confirm(`Remove ${selectedOs.name} from your build?`)) {
                    removeSelectedOs();
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
            document.getElementById('osDetails').style.display = 'none';
        }

        // Pagination functions
        function nextPage() {
            if ((currentPage + 1) * pageSize < allOsData.length) {
                currentPage++;
                displayOsPage(currentPage);
            } else {
                alert("No more data.");
            }
        }

        function previousPage() {
            if (currentPage > 0) {
                currentPage--;
                displayOsPage(currentPage);
            } else {
                alert("You are on the first page.");
            }
        }

        // Search OS
        function searchOs() {
            const query = document.getElementById("osNameInput").value.trim().toLowerCase();
            console.log("Searching OSs with query:", query);

            $.ajax({
                url: '/os/name-search?name=' + encodeURIComponent(query),
                method: 'GET',
                success: function(data) {
                    console.log("Search results:", data);
                    if (!Array.isArray(data) || data.length === 0) {
                        console.warn("No search results found");
                        alert("No operating systems found for search query.");
                    }
                    allOsData = data;
                    currentPage = 0;
                    displayOsPage(currentPage);
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.error("Search failed:", textStatus, errorThrown);
                    console.error("Response:", jqXHR.responseText);
                    alert(`Search failed: ${textStatus}. Check the console for details.`);
                }
            });
        }

        // Load all OSs on page load
        $(document).ready(function() {
            console.log("Page loaded, fetching OSs");
            fetchAllOs();
        });
    </script>
</body>
</html>