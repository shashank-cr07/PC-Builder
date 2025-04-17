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

        #fanOutput {
            flex: 1;
            min-width: 280px;
            max-width: 350px;
            padding: 24px;
            border-radius: 16px;
            background-color: #1f1f1f;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
            color: #e2e2e2;
        }

        #fanOutput p {
            font-size: 15px;
            margin: 12px 0;
            line-height: 1.6;
        }

        #fanOutput strong {
            color: #ffffff;
            font-weight: 600;
        }

        #fanOutput span {
            color: #aaa;
        }

        #searchBarContainer {
            display: flex;
            align-items: center;
            gap: 12px;
            margin: 30px 60px 10px;
            flex-wrap: wrap;
        }

        #fanNameInput {
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

        #allFanOutput {
            flex: 2;
            min-width: 600px;
            margin-top: 20px;
            overflow-x: auto;
        }

        #allFan {
            border-collapse: collapse;
            width: 100%;
            background-color: #141414;
            color: #fff;
            font-size: 14px;
            border-radius: 8px;
            overflow: hidden;
        }

        #allFan th,
        #allFan td {
            border: 1px solid #2c2c2c;
            padding: 14px 18px;
            text-align: center;
        }

        #allFan th {
            background-color: #1e1e1e;
            font-weight: 600;
        }

        #allFan tbody tr {
            cursor: pointer;
            transition: background-color 0.2s;
        }

        #allFan tbody tr:nth-child(odd) {
            background-color: #1a1a1a;
        }

        #allFan tbody tr:hover {
            background-color: #292929;
        }

        #allFan tbody tr.selected {
            background-color: #2a4a2a;
        }

        #paginationContainer {
            margin: 30px 60px;
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        /* Modal Styles */
        #fanDetails {
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

        #fanDetails h3 {
            margin-top: 0;
            color: #fff;
            border-bottom: 1px solid #444;
            padding-bottom: 10px;
        }

        #fanDetails p {
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

        #selectedFanDisplay {
            margin: 20px 60px;
            padding: 20px;
            background-color: #1f1f1f;
            border-radius: 12px;
            display: none;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }

        #selectedFanDisplay h3 {
            margin-top: 0;
            color: #4CAF50;
            border-bottom: 1px solid #333;
            padding-bottom: 10px;
        }

        #selectedFanDisplay p {
            margin: 8px 0;
        }

        #removeSelectedFan {
            background-color: #f44336;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            margin-top: 15px;
            transition: background-color 0.3s;
        }

        #removeSelectedFan:hover {
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

            #allFanOutput {
                min-width: unset;
                width: 100%;
            }

            #fanDetails {
                width: 90%;
                padding: 20px;
            }

            .FanHeading {
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

    <div class="heading-container">
        <div class="geometric-border">
            <h2 class="FanHeading">Case Fan</h2>
        </div>
    </div>

    <!-- Selected Fan Display -->
    <div id="selectedFanDisplay">
        <h3>Your Selected Case Fan</h3>
        <p><strong>Name:</strong> <span id="selectedFanName"></span></p>
        <p><strong>Price:</strong> $<span id="selectedFanPrice"></span></p>
        <p><strong>Size:</strong> <span id="selectedFanSize"></span></p>
        <p><strong>RPM:</strong> <span id="selectedFanRpm"></span></p>
        <button id="removeSelectedFan">Remove Selection</button>
    </div>

    <!-- Input and Buttons -->
    <div id="searchBarContainer">
        <input type="text" id="fanNameInput" placeholder="Search Case Fans" />
        <button onclick="searchCaseFan()">Search</button>
        <button onclick="clearSearch()">Clear search</button>
    </div>
    
    <!-- Output & Table Side-by-side -->
    <div id="mainContent">
        <!-- Case Fan Table -->
        <div id="allFanOutput">
            <table id="allFan">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Price</th>
                        <th>Size</th>
                        <th>RPM</th>
                        <th>Airflow</th>
                        <th>Noise Level</th>
                        <th>Color</th>
                        <th>PWM</th>
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

    <!-- Fan Details Modal -->
    <div id="overlay"></div>
    <div id="fanDetails">
        <button id="closeDetails">&times;</button>
        <h3 id="detailsName"></h3>
        <p><strong>ID:</strong> <span id="detailsId"></span></p>
        <p><strong>Price:</strong> $<span id="detailsPrice"></span></p>
        <p><strong>Size:</strong> <span id="detailsSize"></span></p>
        <p><strong>RPM:</strong> <span id="detailsRpm"></span></p>
        <p><strong>Airflow:</strong> <span id="detailsAirflow"></span></p>
        <p><strong>Noise Level:</strong> <span id="detailsNoiseLevel"></span></p>
        <p><strong>Color:</strong> <span id="detailsColor"></span></p>
        <p><strong>PWM:</strong> <span id="detailsPwm"></span></p>
        <button id="addToBuildBtn">Add to Build</button>
    </div>

    <!-- Notification -->
    <div id="buildNotification"></div>
    
    <script>
        // Global variables
        let allFanData = [];
        let currentPage = 0;
        const pageSize = 15;
        let currentSelectedFan = null;
        let selectedFan = null;

        // Load saved selection from localStorage
        function loadSelectedFan() {
            const savedFan = localStorage.getItem('selectedFan');
            if (savedFan) {
                try {
                    selectedFan = JSON.parse(savedFan);
                    updateSelectedFanDisplay();
                    // Find the complete fan data from allFanData
                    if (selectedFan && allFanData.length > 0) {
                        const completeFan = allFanData.find(f => f.id === selectedFan.id);
                        if (completeFan) {
                            selectedFan = completeFan;
                        }
                    }
                } catch (e) {
                    console.error("Error parsing saved fan:", e);
                    localStorage.removeItem('selectedFan');
                }
            }
        }

        // Save selection to localStorage
        function saveSelectedFan() {
            if (selectedFan) {
                localStorage.setItem('selectedFan', JSON.stringify({
                    id: selectedFan.id,
                    name: selectedFan.name,
                    price: selectedFan.price,
                    size: selectedFan.size,
                    rpm: selectedFan.rpm
                    // Include other minimal necessary properties
                }));
            } else {
                localStorage.removeItem('selectedFan');
            }
        }

        function clearSearch() {
            document.getElementById("fanNameInput").value = "";
            fetchAllFans();
        }

        // Fetch all Fans from the backend
        function fetchAllFans() {
            $.ajax({
                url: '/case-fan',
                method: 'GET',
                success: function(fanList) {
                    allFanData = fanList;
                    currentPage = 0;
                    displayFanPage(currentPage);
                    // After loading data, check if we have a saved selection
                    loadSelectedFan();
                    // Highlight the saved selection in the table if it exists
                    if (selectedFan) {
                        highlightSelectedFanInTable();
                    }
                },
                error: function() {
                    alert('Failed to fetch case fans.');
                }
            });
        }

        // Highlight the selected fan in the table
        function highlightSelectedFanInTable() {
            const rows = document.querySelectorAll("#allFan tbody tr");
            rows.forEach(row => {
                if (selectedFan && row.cells[0].textContent === selectedFan.id.toString()) {
                    row.classList.add('selected');
                } else {
                    row.classList.remove('selected');
                }
            });
        }

        // Display a page of data
        function displayFanPage(page) {
            const tableBody = document.querySelector("#allFan tbody");
            tableBody.innerHTML = "";
            const startIndex = page * pageSize;
            const endIndex = startIndex + pageSize;
            const pageData = allFanData.slice(startIndex, endIndex);
            pageData.forEach(f => {
                addFanRow(f);
            });
            
            // Re-highlight selected fan after rendering
            if (selectedFan) {
                highlightSelectedFanInTable();
            }
        }

        // Append a single row to the table
        function addFanRow(entry) {
            const tableBody = document.querySelector("#allFan tbody");
            const row = document.createElement("tr");
            
            // Highlight if this is the selected fan
            if (selectedFan && selectedFan.id === entry.id) {
                row.classList.add('selected');
            }
            
            row.innerHTML = "<td>" + entry.id + "</td>" +
                            "<td>" + entry.name + "</td>" +
                            "<td>" + (entry.price ? "$" + entry.price : "Out Of Stock") + "</td>" +
                            "<td>" + entry.size + "</td>" +
                            "<td>" + entry.rpm + "</td>" +
                            "<td>" + entry.airflow + "</td>" +
                            "<td>" + entry.noiseLevel + "</td>" +
                            "<td>" + entry.color + "</td>" +
                            "<td>" + entry.pwm + "</td>";
            
            row.addEventListener('click', function() {
                handleRowClick(entry);
            });
            
            tableBody.appendChild(row);
        }

        // Handle row click with confirmation logic
        function handleRowClick(f) {
            currentSelectedFan = f;
            
            if (selectedFan && selectedFan.id === f.id) {
                // Clicked on already selected fan - ask to deselect
                if (confirm("Do you want to remove this case fan from your build?")) {
                    removeSelectedFan();
                }
            } else if (selectedFan) {
                // Already have a selected fan - ask to replace
                if (confirm(`You already have ${selectedFan.name} selected. Replace it with ${f.name}?`)) {
                    setSelectedFan(f);
                }
            } else {
                // No fan selected - just select this one
                setSelectedFan(f);
            }
            
            // Show details in modal
            showFanDetails(f);
        }

        // Set the selected fan
        function setSelectedFan(f) {
            // Remove previous selection highlight
            if (selectedFan) {
                const rows = document.querySelectorAll("#allFan tbody tr");
                rows.forEach(row => {
                    if (row.cells[0].textContent === selectedFan.id.toString()) {
                        row.classList.remove('selected');
                    }
                });
            }
            
            selectedFan = f;
            
            // Add new selection highlight
            highlightSelectedFanInTable();
            
            // Update the selected fan display
            updateSelectedFanDisplay();
            
            // Save to localStorage
            saveSelectedFan();
            
            // Show notification
            showNotification(`${f.name} added to your build!`);
        }

        // Remove the selected fan
        function removeSelectedFan() {
            if (!selectedFan) return;
            
            const fanName = selectedFan.name;
            
            // Remove selection highlight
            const rows = document.querySelectorAll("#allFan tbody tr");
            rows.forEach(row => {
                if (row.cells[0].textContent === selectedFan.id.toString()) {
                    row.classList.remove('selected');
                }
            });
            
            selectedFan = null;
            
            // Hide the selected fan display
            document.getElementById('selectedFanDisplay').style.display = 'none';
            
            // Clear from localStorage
            saveSelectedFan();
            
            // Show notification
            showNotification(`${fanName} removed from your build!`);
        }

        // Update the selected fan display panel
        function updateSelectedFanDisplay() {
            if (selectedFan) {
                document.getElementById('selectedFanName').textContent = selectedFan.name;
                document.getElementById('selectedFanPrice').textContent = selectedFan.price ? "$" + selectedFan.price : "Out Of Stock";
                document.getElementById('selectedFanSize').textContent = selectedFan.size;
                document.getElementById('selectedFanRpm').textContent = selectedFan.rpm;
                document.getElementById('selectedFanDisplay').style.display = 'block';
            } else {
                document.getElementById('selectedFanDisplay').style.display = 'none';
            }
        }

        // Show fan details in modal
        function showFanDetails(f) {
            currentSelectedFan = f;
            document.getElementById('detailsId').textContent = f.id;
            document.getElementById('detailsName').textContent = f.name;
            document.getElementById('detailsPrice').textContent = f.price ? "$" + f.price : "Out Of Stock";
            document.getElementById('detailsSize').textContent = f.size;
            document.getElementById('detailsRpm').textContent = f.rpm;
            document.getElementById('detailsAirflow').textContent = f.airflow;
            document.getElementById('detailsNoiseLevel').textContent = f.noiseLevel;
            document.getElementById('detailsColor').textContent = f.color;
            document.getElementById('detailsPwm').textContent = f.pwm;
            
            // Update Add to Build button text and color
            const addButton = document.getElementById('addToBuildBtn');
            if (selectedFan && selectedFan.id === f.id) {
                addButton.textContent = 'Remove from Build';
                addButton.classList.add('remove');
            } else {
                addButton.textContent = 'Add to Build';
                addButton.classList.remove('remove');
            }
            
            document.getElementById('overlay').style.display = 'block';
            document.getElementById('fanDetails').style.display = 'block';
        }

        // Add to Build button functionality
        document.getElementById('addToBuildBtn').addEventListener('click', function() {
            if (!currentSelectedFan) return;
            
            if (selectedFan && selectedFan.id === currentSelectedFan.id) {
                // Clicked remove
                removeSelectedFan();
            } else if (selectedFan) {
                // Confirm replacement
                if (confirm(`Replace ${selectedFan.name} with ${currentSelectedFan.name}?`)) {
                    setSelectedFan(currentSelectedFan);
                }
            } else {
                // Just add
                setSelectedFan(currentSelectedFan);
            }
            
            closeModal();
        });

        // Remove Selected Fan button functionality
        document.getElementById('removeSelectedFan').addEventListener('click', function() {
            if (selectedFan) {
                if (confirm(`Remove ${selectedFan.name} from your build?`)) {
                    removeSelectedFan();
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
            document.getElementById('fanDetails').style.display = 'none';
        }

        // Pagination functions
        function nextPage() {
            if ((currentPage + 1) * pageSize < allFanData.length) {
                currentPage++;
                displayFanPage(currentPage);
            } else {
                alert("No more data.");
            }
        }

        function previousPage() {
            if (currentPage > 0) {
                currentPage--;
                displayFanPage(currentPage);
            } else {
                alert("You are on the first page.");
            }
        }

        function searchCaseFan() {
            const query = document.getElementById("fanNameInput").value.trim().toLowerCase();

            $.ajax({
                url: '/case-fan/name-search?name=' + query,
                method: 'GET',
                success: function(data) {
                    allFanData = data;
                    currentPage = 0;
                    displayFanPage(currentPage);
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

        // Load all fans on page load
        $(document).ready(function() {
            fetchAllFans();
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