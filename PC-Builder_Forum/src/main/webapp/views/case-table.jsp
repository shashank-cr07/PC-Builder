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

        .CaseHeading {
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

        #caseOutput {
            flex: 1;
            min-width: 280px;
            max-width: 350px;
            padding: 24px;
            border-radius: 16px;
            background-color: #1f1f1f;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
            color: #e2e2e2;
        }

        #caseOutput p {
            font-size: 15px;
            margin: 12px 0;
            line-height: 1.6;
        }

        #caseOutput strong {
            color: #ffffff;
            font-weight: 600;
        }

        #caseOutput span {
            color: #aaa;
        }

        #searchBarContainer {
            display: flex;
            align-items: center;
            gap: 12px;
            margin: 30px 60px 10px;
            flex-wrap: wrap;
        }

        #caseIdInput {
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

        #allCaseOutput {
            flex: 2;
            min-width: 600px;
            margin-top: 20px;
            overflow-x: auto;
        }

        #allCase {
            border-collapse: collapse;
            width: 100%;
            background-color: #141414;
            color: #fff;
            font-size: 14px;
            border-radius: 8px;
            overflow: hidden;
        }

        #allCase th,
        #allCase td {
            border: 1px solid #2c2c2c;
            padding: 14px 18px;
            text-align: center;
        }

        #allCase th {
            background-color: #1e1e1e;
            font-weight: 600;
        }

        #allCase tbody tr {
            cursor: pointer;
            transition: background-color 0.2s;
        }

        #allCase tbody tr:nth-child(odd) {
            background-color: #1a1a1a;
        }

        #allCase tbody tr:hover {
            background-color: #292929;
        }

        #allCase tbody tr.selected {
            background-color: #2a4a2a;
        }

        #paginationContainer {
            margin: 30px 60px;
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        /* Modal Styles */
        #caseDetails {
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

        #caseDetails h3 {
            margin-top: 0;
            color: #fff;
            border-bottom: 1px solid #444;
            padding-bottom: 10px;
        }

        #caseDetails p {
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

        #selectedCaseDisplay {
            margin: 20px 60px;
            padding: 20px;
            background-color: #1f1f1f;
            border-radius: 12px;
            display: none;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }

        #selectedCaseDisplay h3 {
            margin-top: 0;
            color: #4CAF50;
            border-bottom: 1px solid #333;
            padding-bottom: 10px;
        }

        #selectedCaseDisplay p {
            margin: 8px 0;
        }

        #removeSelectedCase {
            background-color: #f44336;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            margin-top: 15px;
            transition: background-color 0.3s;
        }

        #removeSelectedCase:hover {
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

            #allCaseOutput {
                min-width: unset;
                width: 100%;
            }

            #caseDetails {
                width: 90%;
                padding: 20px;
            }

            .CaseHeading {
                font-size: 2.5rem;
            }
        }
    </style>
</head>
<body>

    <!-- Back to Main Menu Button -->
    <button id="backToMainMenu">Back to Main Menu</button>

    <div class="heading-container">
        <h2 class="CaseHeading">Case Information</h2>
    </div>

    <!-- Selected Case Display -->
    <div id="selectedCaseDisplay">
        <h3>Your Selected Case</h3>
        <p><strong>Name:</strong> <span id="selectedCaseName"></span></p>
        <p><strong>Price:</strong> <span id="selectedCasePrice"></span></p>
        <p><strong>PSU Included:</strong> <span id="selectedCasePsu"></span></p>
        <button id="removeSelectedCase">Remove Selection</button>
    </div>

    <!-- Input and Buttons -->
    <div id="searchBarContainer">
        <input type="text" id="caseNameInput" placeholder="Search Cases" />
        <button onclick="searchCase()">Search</button>
        <button onclick="clearSearch()">Clear search</button>
    </div>

    <!-- Output & Table Side-by-side -->
    <div id="mainContent">
        <!-- Case Table -->
        <div id="allCaseOutput">
            <table id="allCase">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Price</th>
                        <th>PSU</th>
                        <th>Side Panel</th>
                        <th>External Volume</th>
                        <th>Internal 35 Bays</th>
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

    <!-- Case Details Modal -->
    <div id="overlay"></div>
    <div id="caseDetails">
        <button id="closeDetails">&times;</button>
        <h3 id="detailsName"></h3>
        <p><strong>ID:</strong> <span id="detailsId"></span></p>
        <p><strong>Price:</strong> <span id="detailsPrice"></span></p>
        <p><strong>PSU Included:</strong> <span id="detailsPsu"></span></p>
        <p><strong>Side Panel:</strong> <span id="detailsSidePanel"></span></p>
        <p><strong>External Volume:</strong> <span id="detailsExternalVolume"></span></p>
        <p><strong>Internal 3.5" Bays:</strong> <span id="detailsInternal35Bays"></span></p>
        <p><strong>Color:</strong> <span id="detailsColor"></span></p>
        <button id="addToBuildBtn">Add to Build</button>
    </div>

    <!-- Notification -->
    <div id="buildNotification"></div>

    <script>
        // Global variables
        let allCaseData = [];
        let currentPage = 0;
        const pageSize = 15;
        let currentSelectedCase = null;
        let selectedCase = null;

        // Back to Main Menu functionality
        document.getElementById('backToMainMenu').addEventListener('click', function() {
            window.location.href = '/home-pc';
        });

        // Load saved selection from localStorage
        function loadSelectedCase() {
            const savedCase = localStorage.getItem('selectedCase');
            if (savedCase) {
                try {
                    selectedCase = JSON.parse(savedCase);
                    updateSelectedCaseDisplay();
                    // Find the complete case data from allCaseData
                    if (selectedCase && allCaseData.length > 0) {
                        const completeCase = allCaseData.find(c => c.id === selectedCase.id);
                        if (completeCase) {
                            selectedCase = completeCase;
                        }
                    }
                } catch (e) {
                    console.error("Error parsing saved case:", e);
                    localStorage.removeItem('selectedCase');
                }
            }
        }

        // Save selection to localStorage
        function saveSelectedCase() {
            if (selectedCase) {
                localStorage.setItem('selectedCase', JSON.stringify({
                    id: selectedCase.id,
                    name: selectedCase.name,
                    price: selectedCase.price,
                    psu: selectedCase.psu,
                    // Include other minimal necessary properties
                }));
            } else {
                localStorage.removeItem('selectedCase');
            }
        }

        function clearSearch() {
            document.getElementById("caseNameInput").value = "";
            fetchAllCases();
        }

        // Fetch all Cases from the backend
        function fetchAllCases() {
            $.ajax({
                url: '/case-table',
                method: 'GET',
                success: function(caseList) {
                    allCaseData = caseList;
                    currentPage = 0;
                    displayCasePage(currentPage);
                    // After loading data, check if we have a saved selection
                    loadSelectedCase();
                    // Highlight the saved selection in the table if it exists
                    if (selectedCase) {
                        highlightSelectedCaseInTable();
                    }
                },
                error: function() {
                    alert('Failed to fetch cases.');
                }
            });
        }

        // Highlight the selected case in the table
        function highlightSelectedCaseInTable() {
            const rows = document.querySelectorAll("#allCase tbody tr");
            rows.forEach(row => {
                if (selectedCase && row.cells[0].textContent === selectedCase.id.toString()) {
                    row.classList.add('selected');
                } else {
                    row.classList.remove('selected');
                }
            });
        }

        // Display a page of data
        function displayCasePage(page) {
            const tableBody = document.querySelector("#allCase tbody");
            tableBody.innerHTML = "";
            const startIndex = page * pageSize;
            const endIndex = startIndex + pageSize;
            const pageData = allCaseData.slice(startIndex, endIndex);
            pageData.forEach(c => {
                addCaseRow(c);
            });
            
            // Re-highlight selected case after rendering
            if (selectedCase) {
                highlightSelectedCaseInTable();
            }
        }

        // Append a single row to the table
        function addCaseRow(entry) {
            const tableBody = document.querySelector("#allCase tbody");
            const row = document.createElement("tr");
            
            // Highlight if this is the selected case
            if (selectedCase && selectedCase.id === entry.id) {
                row.classList.add('selected');
            }
            
            row.innerHTML = "<td>" + entry.id + "</td>" +
                            "<td>" + entry.name + "</td>" +
                            "<td>" + (entry.price ? "$" + entry.price : "Out Of stock") + "</td>" +
                            "<td>" + (entry.psu ? "Yes" : "No") + "</td>" +
                            "<td>" + entry.sidePanel + "</td>" +
                            "<td>" + entry.externalVolume + "</td>" +
                            "<td>" + entry.internal35Bays + "</td>" +
                            "<td>" + entry.color + "</td>";
            
            row.addEventListener('click', function() {
                handleRowClick(entry);
            });
            
            tableBody.appendChild(row);
        }

        // Handle row click with confirmation logic
        function handleRowClick(c) {
            currentSelectedCase = c;
            
            if (selectedCase && selectedCase.id === c.id) {
                // Clicked on already selected case - ask to deselect
                if (confirm("Do you want to remove this case from your build?")) {
                    removeSelectedCase();
                }
            } else if (selectedCase) {
                // Already have a selected case - ask to replace
                if (confirm(`You already have ${selectedCase.name} selected. Replace it with ${c.name}?`)) {
                    setSelectedCase(c);
                }
            } else {
                // No case selected - just select this one
                setSelectedCase(c);
            }
            
            // Show details in modal
            showCaseDetails(c);
        }

        // Set the selected case
        function setSelectedCase(c) {
            // Remove previous selection highlight
            if (selectedCase) {
                const rows = document.querySelectorAll("#allCase tbody tr");
                rows.forEach(row => {
                    if (row.cells[0].textContent === selectedCase.id.toString()) {
                        row.classList.remove('selected');
                    }
                });
            }
            
            selectedCase = c;
            
            // Add new selection highlight
            highlightSelectedCaseInTable();
            
            // Update the selected case display
            updateSelectedCaseDisplay();
            
            // Save to localStorage
            saveSelectedCase();
            
            // Show notification
            showNotification(`${c.name} added to your build!`);
        }

        // Remove the selected case
        function removeSelectedCase() {
            if (!selectedCase) return;
            
            const caseName = selectedCase.name;
            
            // Remove selection highlight
            const rows = document.querySelectorAll("#allCase tbody tr");
            rows.forEach(row => {
                if (row.cells[0].textContent === selectedCase.id.toString()) {
                    row.classList.remove('selected');
                }
            });
            
            selectedCase = null;
            
            // Hide the selected case display
            document.getElementById('selectedCaseDisplay').style.display = 'none';
            
            // Clear from localStorage
            saveSelectedCase();
            
            // Show notification
            showNotification(`${caseName} removed from your build!`);
        }

        // Update the selected case display panel
        function updateSelectedCaseDisplay() {
            if (selectedCase) {
                document.getElementById('selectedCaseName').textContent = selectedCase.name;
                document.getElementById('selectedCasePrice').textContent = selectedCase.price ? "$" + selectedCase.price : "Out Of stock";
                document.getElementById('selectedCasePsu').textContent = selectedCase.psu ? "Yes" : "No";
                document.getElementById('selectedCaseDisplay').style.display = 'block';
            } else {
                document.getElementById('selectedCaseDisplay').style.display = 'none';
            }
        }

        // Show case details in modal
        function showCaseDetails(c) {
            currentSelectedCase = c;
            document.getElementById('detailsId').textContent = c.id;
            document.getElementById('detailsName').textContent = c.name;
            document.getElementById('detailsPrice').textContent = c.price ? "$" + c.price : "Out Of stock";
            document.getElementById('detailsPsu').textContent = c.psu ? "Yes" : "No";
            document.getElementById('detailsSidePanel').textContent = c.sidePanel;
            document.getElementById('detailsExternalVolume').textContent = c.externalVolume;
            document.getElementById('detailsInternal35Bays').textContent = c.internal35Bays;
            document.getElementById('detailsColor').textContent = c.color;
            
            // Update Add to Build button text and color
            const addButton = document.getElementById('addToBuildBtn');
            if (selectedCase && selectedCase.id === c.id) {
                addButton.textContent = 'Remove from Build';
                addButton.classList.add('remove');
            } else {
                addButton.textContent = 'Add to Build';
                addButton.classList.remove('remove');
            }
            
            document.getElementById('overlay').style.display = 'block';
            document.getElementById('caseDetails').style.display = 'block';
        }

        // Add to Build button functionality
        document.getElementById('addToBuildBtn').addEventListener('click', function() {
            if (!currentSelectedCase) return;
            
            if (selectedCase && selectedCase.id === currentSelectedCase.id) {
                // Clicked remove
                removeSelectedCase();
            } else if (selectedCase) {
                // Confirm replacement
                if (confirm(`Replace ${selectedCase.name} with ${currentSelectedCase.name}?`)) {
                    setSelectedCase(currentSelectedCase);
                }
            } else {
                // Just add
                setSelectedCase(currentSelectedCase);
            }
            
            closeModal();
        });

        // Remove Selected Case button functionality
        document.getElementById('removeSelectedCase').addEventListener('click', function() {
            if (selectedCase) {
                if (confirm(`Remove ${selectedCase.name} from your build?`)) {
                    removeSelectedCase();
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
            document.getElementById('caseDetails').style.display = 'none';
        }

        // Pagination functions
        function nextPage() {
            if ((currentPage + 1) * pageSize < allCaseData.length) {
                currentPage++;
                displayCasePage(currentPage);
            } else {
                alert("No more data.");
            }
        }

        function previousPage() {
            if (currentPage > 0) {
                currentPage--;
                displayCasePage(currentPage);
            } else {
                alert("You are on the first page.");
            }
        }

        function searchCase() {
            const query = document.getElementById("caseNameInput").value.trim().toLowerCase();

            $.ajax({
                url: '/case-table/name-search?name=' + query,
                method: 'GET',
                success: function(data) {
                    allCaseData = data;
                    currentPage = 0;
                    displayCasePage(currentPage);
                },
                error: function() {
                    console.log("Error occurred while fetching search results.");
                }
            });
        }

        // Load all cases on page load
        $(document).ready(function() {
            fetchAllCases();
        });
    </script>
</body>
</html>