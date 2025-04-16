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

        .IhdHeading {
            font-size: 3.5rem;
            font-family: "Inter", sans-serif; /* Fallback since Moonscape isn't imported */
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

        #mainIhdContent {
            display: flex;
            justify-content: center;
            padding: 30px 60px;
        }

        #searchBarIhdContainer {
            display: flex;
            align-items: center;
            gap: 12px;
            margin: 30px 60px 10px;
            flex-wrap: wrap;
        }

        #ihdNameInput {
            padding: 10px;
            font-size: 14px;
            border-radius: 8px;
            border: 1px solid #444;
            background-color: #1a1a1a;
            color: #fff;
            width: 160px;
        }

        #searchBarIhdContainer button,
        #paginationIhdContainer button {
            padding: 10px 18px;
            font-size: 14px;
            background-color: #333;
            border: none;
            border-radius: 8px;
            color: #fff;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        #searchBarIhdContainer button:hover,
        #paginationIhdContainer button:hover {
            background-color: #555;
        }

        #allIhdOutput {
            min-width: 600px;
            margin-top: 20px;
            overflow-x: auto;
        }

        #allIhd {
            border-collapse: collapse;
            width: 100%;
            background-color: #141414;
            color: #fff;
            font-size: 14px;
            border-radius: 8px;
            overflow: hidden;
        }

        #allIhd th,
        #allIhd td {
            border: 1px solid #2c2c2c;
            padding: 14px 18px;
            text-align: center;
        }

        #allIhd th {
            background-color: #1e1e1e;
            font-weight: 600;
        }

        #allIhd tbody tr {
            cursor: pointer;
            transition: background-color 0.2s;
        }

        #allIhd tbody tr:nth-child(odd) {
            background-color: #1a1a1a;
        }

        #allIhd tbody tr:hover {
            background-color: #292929;
        }

        #allIhd tbody tr.selected {
            background-color: #2a4a2a;
        }

        #paginationIhdContainer {
            margin: 30px 60px;
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        /* Modal Styles */
        #ihdDetails {
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

        #ihdDetails h3 {
            margin-top: 0;
            color: #fff;
            border-bottom: 1px solid #444;
            padding-bottom: 10px;
        }

        #ihdDetails p {
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

        #selectedIhdDisplay {
            margin: 20px 60px;
            padding: 20px;
            background-color: #1f1f1f;
            border-radius: 12px;
            display: none;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }

        #selectedIhdDisplay h3 {
            margin-top: 0;
            color: #4CAF50;
            border-bottom: 1px solid #333;
            padding-bottom: 10px;
        }

        #selectedIhdDisplay p {
            margin: 8px 0;
        }

        #removeSelectedIhd {
            background-color: #f44336;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            margin-top: 15px;
            transition: background-color 0.3s;
        }

        #removeSelectedIhd:hover {
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

            #mainIhdContent {
                padding: 20px;
            }

            #searchBarIhdContainer,
            #paginationIhdContainer {
                margin: 20px;
                justify-content: center;
            }

            #allIhdOutput {
                min-width: unset;
                width: 100%;
            }

            #ihdDetails {
                width: 90%;
                padding: 20px;
            }

            .IhdHeading {
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
            <h2 class="IhdHeading">Internal Hard Drive Information</h2>
        </div>
    </div>

    <!-- Selected IHD Display -->
    <div id="selectedIhdDisplay">
        <h3>Your Selected Internal Hard Drive</h3>
        <p><strong>Name:</strong> <span id="selectedIhdName"></span></p>
        <p><strong>Price:</strong> <span id="selectedIhdPrice"></span></p>
        <p><strong>Capacity:</strong> <span id="selectedIhdCapacity"></span></p>
        <button id="removeSelectedIhd">Remove Selection</button>
    </div>

    <!-- Input and Buttons -->
    <div id="searchBarIhdContainer">
        <input type="text" id="ihdNameInput" placeholder="Search Internal Hard Drive" />
        <button onclick="searchIhd()">Search</button>
        <button onclick="clearSearch()">Clear search</button>
    </div>

    <!-- Table -->
    <div id="mainIhdContent">
        <!-- IHD Table -->
        <div id="allIhdOutput">
            <table id="allIhd">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Price</th>
                        <th>Interface</th>
                        <th>Capacity</th>
                        <th>Price Per GB</th>
                        <th>Cache</th>
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
    <div id="paginationIhdContainer">
        <button onclick="previousPage()">Previous</button>
        <button onclick="nextPage()">Next</button>
    </div>

    <!-- IHD Details Modal -->
    <div id="overlay"></div>
    <div id="ihdDetails">
        <button id="closeDetails">×</button>
        <h3 id="detailsName"></h3>
        <p><strong>ID:</strong> <span id="detailsId"></span></p>
        <p><strong>Price:</strong> <span id="detailsPrice"></span></p>
        <p><strong>Interface:</strong> <span id="detailsInterface"></span></p>
        <p><strong>Capacity:</strong> <span id="detailsCapacity"></span></p>
        <p><strong>Price Per GB:</strong> <span id="detailsPricePerGb"></span></p>
        <p><strong>Cache:</strong> <span id="detailsCache"></span></p>
        <p><strong>Form Factor:</strong> <span id="detailsFormFactor"></span></p>
        <button id="addToBuildBtn">Add to Build</button>
    </div>

    <!-- Notification -->
    <div id="buildNotification"></div>

    <script>
        // Global variables
        let allIhdData = [];
        let currentPage = 0;
        const pageSize = 15;
        let currentSelectedIhd = null;
        let selectedIhd = null;

        // Back to Main Menu functionality
        document.getElementById('backToMainMenu').addEventListener('click', function() {
            window.location.href = '/home-pc';
        });

        // Load saved selection from localStorage
        function loadSelectedIhd() {
            const savedIhd = localStorage.getItem('selectedIhd');
            if (savedIhd) {
                try {
                    selectedIhd = JSON.parse(savedIhd);
                    updateSelectedIhdDisplay();
                    // Find the complete IHD data from allIhdData
                    if (selectedIhd && allIhdData.length > 0) {
                        const completeIhd = allIhdData.find(i => i.id === selectedIhd.id);
                        if (completeIhd) {
                            selectedIhd = completeIhd;
                        }
                    }
                } catch (e) {
                    console.error("Error parsing saved IHD:", e);
                    localStorage.removeItem('selectedIhd');
                }
            }
        }

        // Save selection to localStorage
        function saveSelectedIhd() {
            if (selectedIhd) {
                localStorage.setItem('selectedIhd', JSON.stringify({
                    id: selectedIhd.id,
                    name: selectedIhd.name,
                    price: selectedIhd.price,
                    capacity: selectedIhd.capacity
                }));
            } else {
                localStorage.removeItem('selectedIhd');
            }
        }

        // Clear search
        function clearSearch() {
            document.getElementById("ihdNameInput").value = "";
            fetchAllIhds();
        }

        // Fetch all IHDs from the backend
        function fetchAllIhds() {
            console.log("Fetching IHDs from /internal-hard-drive");
            $.ajax({
                url: '/internal-hard-drive',
                method: 'GET',
                success: function(ihdList) {
                    console.log("Received IHD data:", ihdList);
                    if (!Array.isArray(ihdList) || ihdList.length === 0) {
                        console.warn("No IHD data received or data is not an array");
                        alert("No internal hard drives found. The server returned an empty list.");
                        return;
                    }
                    allIhdData = ihdList;
                    currentPage = 0;
                    displayIhdPage(currentPage);
                    // After loading data, check if we have a saved selection
                    loadSelectedIhd();
                    // Highlight the saved selection in the table if it exists
                    if (selectedIhd) {
                        highlightSelectedIhdInTable();
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.error("Failed to fetch IHDs:", textStatus, errorThrown);
                    console.error("Response:", jqXHR.responseText);
                    alert(`Failed to fetch internal hard drives: ${textStatus}. Check the console for details.`);
                }
            });
        }

        // Highlight the selected IHD in the table
        function highlightSelectedIhdInTable() {
            const rows = document.querySelectorAll("#allIhd tbody tr");
            rows.forEach(row => {
                if (selectedIhd && row.cells[0].textContent === selectedIhd.id.toString()) {
                    row.classList.add('selected');
                } else {
                    row.classList.remove('selected');
                }
            });
        }

        // Display a page of data
        function displayIhdPage(page) {
            console.log(`Displaying page ${page} with pageSize ${pageSize}`);
            const tableBody = document.querySelector("#allIhd tbody");
            if (!tableBody) {
                console.error("Table body not found!");
                alert("Error: Table body not found in the DOM.");
                return;
            }
            tableBody.innerHTML = "";
            const startIndex = page * pageSize;
            const endIndex = startIndex + pageSize;
            const pageData = allIhdData.slice(startIndex, endIndex);
            console.log("Page data:", pageData);
            if (pageData.length === 0 && allIhdData.length > 0) {
                console.warn("No data for this page, but data exists");
                tableBody.innerHTML = "<tr><td colspan='8'>No internal hard drives on this page</td></tr>";
                return;
            } else if (pageData.length === 0) {
                tableBody.innerHTML = "<tr><td colspan='8'>No internal hard drives available</td></tr>";
                return;
            }
            pageData.forEach(ihd => {
                addIhdRow(ihd);
            });
            // Re-highlight selected IHD after rendering
            if (selectedIhd) {
                highlightSelectedIhdInTable();
            }
        }

        // Append a single row to the table
        function addIhdRow(entry) {
            console.log("Adding row for IHD:", entry);
            const tableBody = document.querySelector("#allIhd tbody");
            const row = document.createElement("tr");

            // Highlight if this is the selected IHD
            if (selectedIhd && selectedIhd.id === entry.id) {
                row.classList.add('selected');
            }

            // Validate entry data
            if (!entry || typeof entry !== 'object') {
                console.error("Invalid IHD entry:", entry);
                return;
            }

            row.innerHTML = "<td>" + entry.id + "</td>" +
                "<td>" + entry.name + "</td>" +
                "<td>" + (entry.price ? "$" + entry.price : "Out of stock") + "</td>" +
                "<td>" + entry.interfaceType + "</td>" +
                "<td>" + entry.capacity + "</td>" +
                "<td>" + (entry.pricePerGb ? "$" + entry.pricePerGb : "N/A") + "</td>" +
                "<td>" + entry.cache + "</td>" +
                "<td>" + entry.formFactor + "</td>";

            row.addEventListener('click', function() {
                handleRowClick(entry);
            });

            tableBody.appendChild(row);
        }

        // Handle row click with confirmation logic
        function handleRowClick(ihd) {
            currentSelectedIhd = ihd;

            if (selectedIhd && selectedIhd.id === ihd.id) {
                // Clicked on already selected IHD - ask to deselect
                if (confirm("Do you want to remove this internal hard drive from your build?")) {
                    removeSelectedIhd();
                }
            } else if (selectedIhd) {
                // Already have a selected IHD - ask to replace
                if (confirm(`You already have ${selectedIhd.name} selected. Replace it with ${ihd.name}?`)) {
                    setSelectedIhd(ihd);
                }
            } else {
                // No IHD selected - just select this one
                setSelectedIhd(ihd);
            }

            // Show details in modal
            showIhdDetails(ihd);
        }

        // Set the selected IHD
        function setSelectedIhd(ihd) {
            // Remove previous selection highlight
            if (selectedIhd) {
                const rows = document.querySelectorAll("#allIhd tbody tr");
                rows.forEach(row => {
                    if (row.cells[0].textContent === selectedIhd.id.toString()) {
                        row.classList.remove('selected');
                    }
                });
            }

            selectedIhd = ihd;

            // Add new selection highlight
            highlightSelectedIhdInTable();

            // Update the selected IHD display
            updateSelectedIhdDisplay();

            // Save to localStorage
            saveSelectedIhd();

            // Show notification
            showNotification(`${ihd.name} added to your build!`);
        }

        // Remove the selected IHD
        function removeSelectedIhd() {
            if (!selectedIhd) return;

            const ihdName = selectedIhd.name;

            // Remove selection highlight
            const rows = document.querySelectorAll("#allIhd tbody tr");
            rows.forEach(row => {
                if (row.cells[0].textContent === selectedIhd.id.toString()) {
                    row.classList.remove('selected');
                }
            });

            selectedIhd = null;

            // Hide the selected IHD display
            document.getElementById('selectedIhdDisplay').style.display = 'none';

            // Clear from localStorage
            saveSelectedIhd();

            // Show notification
            showNotification(`${ihdName} removed from your build!`);
        }

        // Update the selected IHD display panel
        function updateSelectedIhdDisplay() {
            if (selectedIhd) {
                document.getElementById('selectedIhdName').textContent = selectedIhd.name || 'Unknown';
                document.getElementById('selectedIhdPrice').textContent = selectedIhd.price != null ? "$" + selectedIhd.price : "Out of stock";
                document.getElementById('selectedIhdCapacity').textContent = selectedIhd.capacity || 'N/A';
                document.getElementById('selectedIhdDisplay').style.display = 'block';
            } else {
                document.getElementById('selectedIhdDisplay').style.display = 'none';
            }
        }

        // Show IHD details in modal
        function showIhdDetails(ihd) {
            currentSelectedIhd = ihd;
            document.getElementById('detailsId').textContent = ihd.id || 'N/A';
            document.getElementById('detailsName').textContent = ihd.name || 'Unknown';
            document.getElementById('detailsPrice').textContent = ihd.price != null ? "$" + ihd.price : "Out of stock";
            document.getElementById('detailsInterface').textContent = ihd.interfaceType || 'N/A';
            document.getElementById('detailsCapacity').textContent = ihd.capacity || 'N/A';
            document.getElementById('detailsPricePerGb').textContent = ihd.pricePerGb != null ? "$" + ihd.pricePerGb : 'N/A';
            document.getElementById('detailsCache').textContent = ihd.cache || 'N/A';
            document.getElementById('detailsFormFactor').textContent = ihd.formFactor || 'N/A';

            // Update Add to Build button text and color
            const addButton = document.getElementById('addToBuildBtn');
            if (selectedIhd && selectedIhd.id === ihd.id) {
                addButton.textContent = 'Remove from Build';
                addButton.classList.add('remove');
            } else {
                addButton.textContent = 'Add to Build';
                addButton.classList.remove('remove');
            }

            document.getElementById('overlay').style.display = 'block';
            document.getElementById('ihdDetails').style.display = 'block';
        }

        // Add to Build button functionality
        document.getElementById('addToBuildBtn').addEventListener('click', function() {
            if (!currentSelectedIhd) return;

            if (selectedIhd && selectedIhd.id === currentSelectedIhd.id) {
                // Clicked remove
                removeSelectedIhd();
            } else if (selectedIhd) {
                // Confirm replacement
                if (confirm(`Replace ${selectedIhd.name} with ${currentSelectedIhd.name}?`)) {
                    setSelectedIhd(currentSelectedIhd);
                }
            } else {
                // Just add
                setSelectedIhd(currentSelectedIhd);
            }

            closeModal();
        });

        // Remove Selected IHD button functionality
        document.getElementById('removeSelectedIhd').addEventListener('click', function() {
            if (selectedIhd) {
                if (confirm(`Remove ${selectedIhd.name} from your build?`)) {
                    removeSelectedIhd();
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
            document.getElementById('ihdDetails').style.display = 'none';
        }

        // Pagination functions
        function nextPage() {
            if ((currentPage + 1) * pageSize < allIhdData.length) {
                currentPage++;
                displayIhdPage(currentPage);
            } else {
                alert("No more data.");
            }
        }

        function previousPage() {
            if (currentPage > 0) {
                currentPage--;
                displayIhdPage(currentPage);
            } else {
                alert("You are on the first page.");
            }
        }

        // Search IHD
        function searchIhd() {
            const query = document.getElementById("ihdNameInput").value.trim().toLowerCase();
            console.log("Searching IHDs with query:", query);

            $.ajax({
                url: '/internal-hard-drive/name-search?name=' + encodeURIComponent(query),
                method: 'GET',
                success: function(data) {
                    console.log("Search results:", data);
                    if (!Array.isArray(data) || data.length === 0) {
                        console.warn("No search results found");
                        alert("No internal hard drives found for search query.");
                    }
                    allIhdData = data;
                    currentPage = 0;
                    displayIhdPage(currentPage);
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.error("Search failed:", textStatus, errorThrown);
                    console.error("Response:", jqXHR.responseText);
                    alert(`Search failed: ${textStatus}. Check the console for details.`);
                }
            });
        }

        // Load all IHDs on page load
        $(document).ready(function() {
            console.log("Page loaded, fetching IHDs");
            fetchAllIhds();
        });
    </script>
</body>
</html>