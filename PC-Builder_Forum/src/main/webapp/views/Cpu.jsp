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

        .CpuHeading {
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

        #cpuOutput {
            flex: 1;
            min-width: 280px;
            max-width: 350px;
            padding: 24px;
            border-radius: 16px;
            background-color: #1f1f1f;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
            color: #e2e2e2;
        }

        #cpuOutput p {
            font-size: 15px;
            margin: 12px 0;
            line-height: 1.6;
        }

        #cpuOutput strong {
            color: #ffffff;
            font-weight: 600;
        }

        #cpuOutput span {
            color: #aaa;
        }

        #searchBarContainer {
            display: flex;
            align-items: center;
            gap: 12px;
            margin: 30px 60px 10px;
            flex-wrap: wrap;
        }

        #cpuNameInput {
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

        #allCpuOutput {
            flex: 2;
            min-width: 600px;
            margin-top: 20px;
            overflow-x: auto;
        }

        #allCPU {
            border-collapse: collapse;
            width: 100%;
            background-color: #141414;
            color: #fff;
            font-size: 14px;
            border-radius: 8px;
            overflow: hidden;
        }

        #allCPU th,
        #allCPU td {
            border: 1px solid #2c2c2c;
            padding: 14px 18px;
            text-align: center;
        }

        #allCPU th {
            background-color: #1e1e1e;
            font-weight: 600;
        }

        #allCPU tbody tr {
            cursor: pointer;
            transition: background-color 0.2s;
        }

        #allCPU tbody tr:nth-child(odd) {
            background-color: #1a1a1a;
        }

        #allCPU tbody tr:hover {
            background-color: #292929;
        }

        #allCPU tbody tr.selected {
            background-color: #2a4a2a;
        }

        #paginationContainer {
            margin: 30px 60px;
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        /* Modal Styles */
        #cpuDetails {
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

        #cpuDetails h3 {
            margin-top: 0;
            color: #fff;
            border-bottom: 1px solid #444;
            padding-bottom: 10px;
        }

        #cpuDetails p {
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

        #selectedCpuDisplay {
            margin: 20px 60px;
            padding: 20px;
            background-color: #1f1f1f;
            border-radius: 12px;
            display: none;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }

        #selectedCpuDisplay h3 {
            margin-top: 0;
            color: #4CAF50;
            border-bottom: 1px solid #333;
            padding-bottom: 10px;
        }

        #selectedCpuDisplay p {
            margin: 8px 0;
        }

        #removeSelectedCpu {
            background-color: #f44336;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            margin-top: 15px;
            transition: background-color 0.3s;
        }

        #removeSelectedCpu:hover {
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

            #allCpuOutput {
                min-width: unset;
                width: 100%;
            }

            #cpuDetails {
                width: 90%;
                padding: 20px;
            }

            .CpuHeading {
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
    <button id="backToMainMenu"> Back to Main Menu</button>

    <div class="heading-container">
        <h2 class="CpuHeading">CPU Information</h2>
    </div>

    <!-- Selected CPU Display -->
    <div id="selectedCpuDisplay">
        <h3>Your Selected CPU</h3>
        <p><strong>Name:</strong> <span id="selectedCpuName"></span></p>
        <p><strong>Price:</strong> $<span id="selectedCpuPrice"></span></p>
        <p><strong>Core Count:</strong> <span id="selectedCpuCoreCount"></span></p>
        <p><strong>Core Clock:</strong> <span id="selectedCpuCoreClock"></span> GHz</p>
        <button id="removeSelectedCpu">Remove Selection</button>
    </div>

    <!-- Input and Buttons -->
    <div id="searchBarContainer">
        <input type="text" id="cpuNameInput" placeholder="Search CPUs" />
        <button onclick="searchCPU()">Search</button>
        <button onclick="clearSearch()">Clear search</button>
    </div>

    <!-- Output & Table Side-by-side -->
    <div id="mainContent">
        <!-- CPU Table -->
        <div id="allCpuOutput">
            <table id="allCPU">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Price</th>
                        <th>Core Count</th>
                        <th>Core Clock</th>
                        <th>Boost Clock</th>
                        <th>TDP</th>
                        <th>Graphics</th>
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

    <!-- CPU Details Modal -->
    <div id="overlay"></div>
    <div id="cpuDetails">
        <button id="closeDetails">&times;</button>
        <h3 id="detailsName"></h3>
        <p><strong>ID:</strong> <span id="detailsId"></span></p>
        <p><strong>Price:</strong> $<span id="detailsPrice"></span></p>
        <p><strong>Core Count:</strong> <span id="detailsCoreCount"></span></p>
        <p><strong>Core Clock:</strong> <span id="detailsCoreClock"></span> GHz</p>
        <p><strong>Boost Clock:</strong> <span id="detailsBoostClock"></span> GHz</p>
        <p><strong>TDP:</strong> <span id="detailsTdp"></span> W</p>
        <p><strong>Graphics:</strong> <span id="detailsGraphics"></span></p>
        <button id="addToBuildBtn">Add to Build</button>
    </div>

    <!-- Notification -->
    <div id="buildNotification"></div>

    <script>
        // Global variables
        let allCpuData = [];
        let currentPage = 0;
        const pageSize = 15;
        let currentSelectedCpu = null;
        let selectedCpu = null;

        // Back to Main Menu functionality
        document.getElementById('backToMainMenu').addEventListener('click', function() {
            window.location.href = '/home-pc';
        });

        // Load saved selection from localStorage
        function loadSelectedCpu() {
            const savedCpu = localStorage.getItem('selectedCpu');
            if (savedCpu) {
                try {
                    selectedCpu = JSON.parse(savedCpu);
                    updateSelectedCpuDisplay();
                    // Find the complete CPU data from allCpuData
                    if (selectedCpu && allCpuData.length > 0) {
                        const completeCpu = allCpuData.find(c => c.id === selectedCpu.id);
                        if (completeCpu) {
                            selectedCpu = completeCpu;
                        }
                    }
                } catch (e) {
                    console.error("Error parsing saved CPU:", e);
                    localStorage.removeItem('selectedCpu');
                }
            }
        }

        // Save selection to localStorage
        function saveSelectedCpu() {
            if (selectedCpu) {
                localStorage.setItem('selectedCpu', JSON.stringify({
                    id: selectedCpu.id,
                    name: selectedCpu.name,
                    price: selectedCpu.price,
                    coreCount: selectedCpu.coreCount,
                    coreClock: selectedCpu.coreClock,
                    // Include other minimal necessary properties
                }));
            } else {
                localStorage.removeItem('selectedCpu');
            }
        }

        function clearSearch() {
            document.getElementById("cpuNameInput").value = "";
            fetchAllCPU();
        }

        // Fetch all CPUs from the backend
        function fetchAllCPU() {
            $.ajax({
                url: '/cpu',
                method: 'GET',
                success: function(cpuList) {
                    allCpuData = cpuList;
                    currentPage = 0;
                    displayCpuPage(currentPage);
                    // After loading data, check if we have a saved selection
                    loadSelectedCpu();
                    // Highlight the saved selection in the table if it exists
                    if (selectedCpu) {
                        highlightSelectedCpuInTable();
                    }
                },
                error: function() {
                    alert('Failed to fetch CPUs.');
                }
            });
        }

        // Highlight the selected CPU in the table
        function highlightSelectedCpuInTable() {
            const rows = document.querySelectorAll("#allCPU tbody tr");
            rows.forEach(row => {
                if (selectedCpu && row.cells[0].textContent === selectedCpu.id.toString()) {
                    row.classList.add('selected');
                } else {
                    row.classList.remove('selected');
                }
            });
        }

        // Display a page of data
        function displayCpuPage(page) {
            const tableBody = document.querySelector("#allCPU tbody");
            tableBody.innerHTML = "";
            const startIndex = page * pageSize;
            const endIndex = startIndex + pageSize;
            const pageData = allCpuData.slice(startIndex, endIndex);
            pageData.forEach(c => {
                addCpuRow(c);
            });
            
            // Re-highlight selected CPU after rendering
            if (selectedCpu) {
                highlightSelectedCpuInTable();
            }
        }

        // Append a single row to the table
        function addCpuRow(entry) {
            const tableBody = document.querySelector("#allCPU tbody");
            const row = document.createElement("tr");
            
            // Highlight if this is the selected CPU
            if (selectedCpu && selectedCpu.id === entry.id) {
                row.classList.add('selected');
            }
            
            row.innerHTML = "<td>" + entry.id + "</td>" +
                            "<td>" + entry.name + "</td>" +
                            "<td>" + (entry.price ? "$" + entry.price : "Out Of stock") + "</td>" +
                            "<td>" + entry.coreCount + "</td>" +
                            "<td>" + entry.coreClock + " GHz</td>" +
                            "<td>" + entry.boostClock + " GHz</td>" +
                            "<td>" + entry.tdp + " W</td>" +
                            "<td>" + entry.graphics + "</td>";
            
            row.addEventListener('click', function() {
                handleRowClick(entry);
            });
            
            tableBody.appendChild(row);
        }

        // Handle row click with confirmation logic
        function handleRowClick(c) {
            currentSelectedCpu = c;
            
            if (selectedCpu && selectedCpu.id === c.id) {
                // Clicked on already selected CPU - ask to deselect
                if (confirm("Do you want to remove this CPU from your build?")) {
                    removeSelectedCpu();
                }
            } else if (selectedCpu) {
                // Already have a selected CPU - ask to replace
                if (confirm(`You already have ${selectedCpu.name} selected. Replace it with ${c.name}?`)) {
                    setSelectedCpu(c);
                }
            } else {
                // No CPU selected - just select this one
                setSelectedCpu(c);
            }
            
            // Show details in modal
            showCpuDetails(c);
        }

        // Set the selected CPU
        function setSelectedCpu(c) {
            // Remove previous selection highlight
            if (selectedCpu) {
                const rows = document.querySelectorAll("#allCPU tbody tr");
                rows.forEach(row => {
                    if (row.cells[0].textContent === selectedCpu.id.toString()) {
                        row.classList.remove('selected');
                    }
                });
            }
            
            selectedCpu = c;
            
            // Add new selection highlight
            highlightSelectedCpuInTable();
            
            // Update the selected CPU display
            updateSelectedCpuDisplay();
            
            // Save to localStorage
            saveSelectedCpu();
            
            // Show notification
            showNotification(`${c.name} added to your build!`);
        }

        // Remove the selected CPU
        function removeSelectedCpu() {
            if (!selectedCpu) return;
            
            const cpuName = selectedCpu.name;
            
            // Remove selection highlight
            const rows = document.querySelectorAll("#allCPU tbody tr");
            rows.forEach(row => {
                if (row.cells[0].textContent === selectedCpu.id.toString()) {
                    row.classList.remove('selected');
                }
            });
            
            selectedCpu = null;
            
            // Hide the selected CPU display
            document.getElementById('selectedCpuDisplay').style.display = 'none';
            
            // Clear from localStorage
            saveSelectedCpu();
            
            // Show notification
            showNotification(`${cpuName} removed from your build!`);
        }

        // Update the selected CPU display panel
        function updateSelectedCpuDisplay() {
            if (selectedCpu) {
                document.getElementById('selectedCpuName').textContent = selectedCpu.name;
                document.getElementById('selectedCpuPrice').textContent = selectedCpu.price ? "$" + selectedCpu.price : "Out Of stock";
                document.getElementById('selectedCpuCoreCount').textContent = selectedCpu.coreCount;
                document.getElementById('selectedCpuCoreClock').textContent = selectedCpu.coreClock;
                document.getElementById('selectedCpuDisplay').style.display = 'block';
            } else {
                document.getElementById('selectedCpuDisplay').style.display = 'none';
            }
        }

        // Show CPU details in modal
        function showCpuDetails(c) {
            currentSelectedCpu = c;
            document.getElementById('detailsId').textContent = c.id;
            document.getElementById('detailsName').textContent = c.name;
            document.getElementById('detailsPrice').textContent = c.price ? "$" + c.price : "Out Of stock";
            document.getElementById('detailsCoreCount').textContent = c.coreCount;
            document.getElementById('detailsCoreClock').textContent = c.coreClock;
            document.getElementById('detailsBoostClock').textContent = c.boostClock;
            document.getElementById('detailsTdp').textContent = c.tdp;
            document.getElementById('detailsGraphics').textContent = c.graphics;
            
            // Update Add to Build button text and color
            const addButton = document.getElementById('addToBuildBtn');
            if (selectedCpu && selectedCpu.id === c.id) {
                addButton.textContent = 'Remove from Build';
                addButton.classList.add('remove');
            } else {
                addButton.textContent = 'Add to Build';
                addButton.classList.remove('remove');
            }
            
            document.getElementById('overlay').style.display = 'block';
            document.getElementById('cpuDetails').style.display = 'block';
        }

        // Add to Build button functionality
        document.getElementById('addToBuildBtn').addEventListener('click', function() {
            if (!currentSelectedCpu) return;
            
            if (selectedCpu && selectedCpu.id === currentSelectedCpu.id) {
                // Clicked remove
                removeSelectedCpu();
            } else if (selectedCpu) {
                // Confirm replacement
                if (confirm(`Replace ${selectedCpu.name} with ${currentSelectedCpu.name}?`)) {
                    setSelectedCpu(currentSelectedCpu);
                }
            } else {
                // Just add
                setSelectedCpu(currentSelectedCpu);
            }
            
            closeModal();
        });

        // Remove Selected CPU button functionality
        document.getElementById('removeSelectedCpu').addEventListener('click', function() {
            if (selectedCpu) {
                if (confirm(`Remove ${selectedCpu.name} from your build?`)) {
                    removeSelectedCpu();
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
            document.getElementById('cpuDetails').style.display = 'none';
        }

        // Pagination functions
        function nextPage() {
            if ((currentPage + 1) * pageSize < allCpuData.length) {
                currentPage++;
                displayCpuPage(currentPage);
            } else {
                alert("No more data.");
            }
        }

        function previousPage() {
            if (currentPage > 0) {
                currentPage--;
                displayCpuPage(currentPage);
            } else {
                alert("You are on the first page.");
            }
        }

        function searchCPU() {
            const query = document.getElementById("cpuNameInput").value.trim().toLowerCase();

            $.ajax({
                url: '/cpu/name-search?name=' + query,
                method: 'GET',
                success: function(data) {
                    allCpuData = data;
                    currentPage = 0;
                    displayCpuPage(currentPage);
                },
                error: function() {
                    console.log("Error occurred while fetching search results.");
                }
            });
        }

        // Load all CPUs on page load
        $(document).ready(function() {
            fetchAllCPU();
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