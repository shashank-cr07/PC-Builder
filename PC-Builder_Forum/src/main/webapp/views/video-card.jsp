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

        .GpuHeading {
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

        #gpuOutput {
            flex: 1;
            min-width: 280px;
            max-width: 350px;
            padding: 24px;
            border-radius: 16px;
            background-color: #1f1f1f;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
            color: #e2e2e2;
        }

        #gpuOutput p {
            font-size: 15px;
            margin: 12px 0;
            line-height: 1.6;
        }

        #gpuOutput strong {
            color: #ffffff;
            font-weight: 600;
        }

        #gpuOutput span {
            color: #aaa;
        }

        #searchBarContainer {
            display: flex;
            align-items: center;
            gap: 12px;
            margin: 30px 60px 10px;
            flex-wrap: wrap;
        }

        #gpuNameInput {
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

        #allGpuOutput {
            flex: 2;
            min-width: 600px;
            margin-top: 20px;
            overflow-x: auto;
        }

        #allGPU {
            border-collapse: collapse;
            width: 100%;
            background-color: #141414;
            color: #fff;
            font-size: 14px;
            border-radius: 8px;
            overflow: hidden;
        }

        #allGPU th,
        #allGPU td {
            border: 1px solid #2c2c2c;
            padding: 14px 18px;
            text-align: center;
        }

        #allGPU th {
            background-color: #1e1e1e;
            font-weight: 600;
        }

        #allGPU tbody tr {
            cursor: pointer;
            transition: background-color 0.2s;
        }

        #allGPU tbody tr:nth-child(odd) {
            background-color: #1a1a1a;
        }

        #allGPU tbody tr:hover {
            background-color: #292929;
        }

        #allGPU tbody tr.selected {
            background-color: #2a4a2a;
        }

        #paginationContainer {
            margin: 30px 60px;
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        /* Modal Styles */
        #gpuDetails {
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

        #gpuDetails h3 {
            margin-top: 0;
            color: #fff;
            border-bottom: 1px solid #444;
            padding-bottom: 10px;
        }

        #gpuDetails p {
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

        #selectedGpuDisplay {
            margin: 20px 60px;
            padding: 20px;
            background-color: #1f1f1f;
            border-radius: 12px;
            display: none;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }

        #selectedGpuDisplay h3 {
            margin-top: 0;
            color: #4CAF50;
            border-bottom: 1px solid #333;
            padding-bottom: 10px;
        }

        #selectedGpuDisplay p {
            margin: 8px 0;
        }

        #removeSelectedGpu {
            background-color: #f44336;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            margin-top: 15px;
            transition: background-color 0.3s;
        }

        #removeSelectedGpu:hover {
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

            #allGpuOutput {
                min-width: unset;
                width: 100%;
            }

            #gpuDetails {
                width: 90%;
                padding: 20px;
            }

            .GpuHeading {
                font-size: 2.5rem;
            }
        }
    </style>
</head>
<body>

    <!-- Back to Main Menu Button -->
    <button id="backToMainMenu"> Back to Main Menu</button>

    <div class="heading-container">
        <h2 class="GpuHeading">GPU Information</h2>
    </div>

    <!-- Selected GPU Display -->
    <div id="selectedGpuDisplay">
        <h3>Your Selected GPU</h3>
        <p><strong>Name:</strong> <span id="selectedGpuName"></span></p>
        <p><strong>Price:</strong> <span id="selectedGpuPrice"></span></p>
        <p><strong>Chipset:</strong> <span id="selectedGpuChipset"></span></p>
        <p><strong>Memory:</strong> <span id="selectedGpuMemory"></span></p>
        <p><strong>Length:</strong> <span id="selectedGpuLength"></span></p>
        <button id="removeSelectedGpu">Remove Selection</button>
    </div>

    <!-- Input and Buttons -->
    <div id="searchBarContainer">
        <input type="text" id="gpuNameInput" placeholder="Search GPUs" />
        <button onclick="searchGPU()">Search</button>
        <button onclick="clearSearch()">Clear search</button>
    </div>

    <!-- Output & Table Side-by-side -->
    <div id="mainContent">
        <!-- GPU Table -->
        <div id="allGpuOutput">
            <table id="allGPU">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Price</th>
                        <th>Chipset</th>
                        <th>Core Clock</th>
                        <th>Boost Clock</th>
                        <th>Memory</th>
                        <th>Color</th>
                        <th>Length</th>
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

    <!-- GPU Details Modal -->
    <div id="overlay"></div>
    <div id="gpuDetails">
        <button id="closeDetails">&times;</button>
        <h3 id="detailsName"></h3>
        <p><strong>ID:</strong> <span id="detailsId"></span></p>
        <p><strong>Price:</strong> <span id="detailsPrice"></span></p>
        <p><strong>Chipset:</strong> <span id="detailsChipset"></span></p>
        <p><strong>Core Clock:</strong> <span id="detailsCoreClock"></span></p>
        <p><strong>Boost Clock:</strong> <span id="detailsBoostClock"></span></p>
        <p><strong>Memory:</strong> <span id="detailsMemory"></span></p>
        <p><strong>Color:</strong> <span id="detailsColor"></span></p>
        <p><strong>Length:</strong> <span id="detailsLength"></span></p>
        <button id="addToBuildBtn">Add to Build</button>
    </div>

    <!-- Notification -->
    <div id="buildNotification"></div>

    <script>
        // Global variables
        let allGPUData = [];
        let currentPage = 0;
        const pageSize = 15;
        let currentSelectedGpu = null;
        let selectedGpu = null;

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
        function loadSelectedGpu() {
            const savedGpu = localStorage.getItem('selectedGpu');
            if (savedGpu) {
                try {
                    selectedGpu = JSON.parse(savedGpu);
                    updateSelectedGpuDisplay();
                    // Find the complete GPU data from allGPUData
                    if (selectedGpu && allGPUData.length > 0) {
                        const completeGpu = allGPUData.find(g => g.id === selectedGpu.id);
                        if (completeGpu) {
                            selectedGpu = completeGpu;
                        }
                    }
                } catch (e) {
                    console.error("Error parsing saved GPU:", e);
                    localStorage.removeItem('selectedGpu');
                }
            }
        }

        // Save selection to localStorage
        async function saveSelectedGpu() {
            if (selectedGpu) {
                localStorage.setItem('selectedGpu', JSON.stringify({
                    id: selectedGpu.id,
                    name: selectedGpu.name,
                    price: selectedGpu.price,
                    chipset: selectedGpu.chipset,
                    memory: selectedGpu.memory,
                    length: selectedGpu.length,
                    // Include other minimal necessary properties
                }));
                await updatePartOnServer('video_card', selectedGpu.id);

            } else {
                localStorage.removeItem('selectedGpu');
            }
        }

        function clearSearch() {
            document.getElementById("gpuNameInput").value = "";
            fetchAllGPUs();
        }

        // Fetch all GPUs from the backend
        function fetchAllGPUs() {
            $.ajax({
                url: '/video-card',
                method: 'GET',
                success: function(gpuList) {
                    allGPUData = gpuList;
                    currentPage = 0;
                    displayGpuPage(currentPage);
                    // After loading data, check if we have a saved selection
                    loadSelectedGpu();
                    // Highlight the saved selection in the table if it exists
                    if (selectedGpu) {
                        highlightSelectedGpuInTable();
                    }
                },
                error: function() {
                    alert('Failed to fetch GPUs.');
                }
            });
        }

        // Highlight the selected GPU in the table
        function highlightSelectedGpuInTable() {
            const rows = document.querySelectorAll("#allGPU tbody tr");
            rows.forEach(row => {
                if (selectedGpu && row.cells[0].textContent === selectedGpu.id.toString()) {
                    row.classList.add('selected');
                } else {
                    row.classList.remove('selected');
                }
            });
        }

        // Display a page of data
        function displayGpuPage(page) {
            const tableBody = document.querySelector("#allGPU tbody");
            tableBody.innerHTML = "";
            const startIndex = page * pageSize;
            const endIndex = startIndex + pageSize;
            const pageData = allGPUData.slice(startIndex, endIndex);
            pageData.forEach(g => {
                addGpuRow(g);
            });
            
            // Re-highlight selected GPU after rendering
            if (selectedGpu) {
                highlightSelectedGpuInTable();
            }
        }

        // Append a single row to the table
        function addGpuRow(entry) {
            const tableBody = document.querySelector("#allGPU tbody");
            const row = document.createElement("tr");
            
            // Highlight if this is the selected GPU
            if (selectedGpu && selectedGpu.id === entry.id) {
                row.classList.add('selected');
            }
            
            row.innerHTML = "<td>" + entry.id + "</td>" +
                            "<td>" + entry.name + "</td>" +
                            "<td>" + (entry.price ? "$" + entry.price : "Out Of stock") + "</td>" +
                            "<td>" + entry.chipset + "</td>" +
                            "<td>" + entry.core_clock + " GHz</td>" +
                            "<td>" + entry.boost_clock + " GHz</td>" +
                            "<td>" + entry.memory + " GB</td>" +
                            "<td>" + entry.color + "</td>" +
                            "<td>" + entry.length + " mm</td>";
            
            row.addEventListener('click', function() {
                handleRowClick(entry);
            });
            
            tableBody.appendChild(row);
        }

        // Handle row click with confirmation logic
        function handleRowClick(g) {
            currentSelectedGpu = g;
            
            if (selectedGpu && selectedGpu.id === g.id) {
                // Clicked on already selected GPU - ask to deselect
                if (confirm("Do you want to remove this GPU from your build?")) {
                    removeSelectedGpu();
                }
            } else if (selectedGpu) {
                // Already have a selected GPU - ask to replace
                if (confirm(`You already have ${selectedGpu.name} selected. Replace it with ${g.name}?`)) {
                    setSelectedGpu(g);
                }
            } else {
                // No GPU selected - just select this one
                setSelectedGpu(g);
            }
            
            // Show details in modal
            showGpuDetails(g);
        }

        // Set the selected GPU
        function setSelectedGpu(g) {
            // Remove previous selection highlight
            if (selectedGpu) {
                const rows = document.querySelectorAll("#allGPU tbody tr");
                rows.forEach(row => {
                    if (row.cells[0].textContent === selectedGpu.id.toString()) {
                        row.classList.remove('selected');
                    }
                });
            }
            
            selectedGpu = g;
            
            // Add new selection highlight
            highlightSelectedGpuInTable();
            
            // Update the selected GPU display
            updateSelectedGpuDisplay();
            
            // Save to localStorage
            saveSelectedGpu();
            
            // Show notification
            showNotification(`${g.name} added to your build!`);
        }

        // Remove the selected GPU
        async function removeSelectedGpu() {
            if (!selectedGpu) return;
            
            const gpuName = selectedGpu.name;
            
            // Remove selection highlight
            const rows = document.querySelectorAll("#allGPU tbody tr");
            rows.forEach(row => {
                if (row.cells[0].textContent === selectedGpu.id.toString()) {
                    row.classList.remove('selected');
                }
            });
            
            selectedGpu = null;
            
            // Hide the selected GPU display
            document.getElementById('selectedGpuDisplay').style.display = 'none';
            
            // Clear from localStorage
            saveSelectedGpu();
            await updatePartOnServer('video_card', null);

            // Show notification
            showNotification(`${gpuName} removed from your build!`);
        }

        // Update the selected GPU display panel
        function updateSelectedGpuDisplay() {
            if (selectedGpu) {
                document.getElementById('selectedGpuName').textContent = selectedGpu.name;
                document.getElementById('selectedGpuPrice').textContent = selectedGpu.price ? "$" + selectedGpu.price : "Out Of stock";
                document.getElementById('selectedGpuChipset').textContent = selectedGpu.chipset;
                document.getElementById('selectedGpuMemory').textContent = selectedGpu.memory + " GB";
                document.getElementById('selectedGpuLength').textContent = selectedGpu.length + " mm";
                document.getElementById('selectedGpuDisplay').style.display = 'block';
            } else {
                document.getElementById('selectedGpuDisplay').style.display = 'none';
            }
        }

        // Show GPU details in modal
        function showGpuDetails(g) {
            currentSelectedGpu = g;
            document.getElementById('detailsId').textContent = g.id;
            document.getElementById('detailsName').textContent = g.name;
            document.getElementById('detailsPrice').textContent = g.price ? "$" + g.price : "Out Of stock";
            document.getElementById('detailsChipset').textContent = g.chipset;
            document.getElementById('detailsCoreClock').textContent = g.core_clock + " GHz";
            document.getElementById('detailsBoostClock').textContent = g.boost_clock + " GHz";
            document.getElementById('detailsMemory').textContent = g.memory + " GB";
            document.getElementById('detailsColor').textContent = g.color;
            document.getElementById('detailsLength').textContent = g.length + " mm";
            
            // Update Add to Build button text and color
            const addButton = document.getElementById('addToBuildBtn');
            if (selectedGpu && selectedGpu.id === g.id) {
                addButton.textContent = 'Remove from Build';
                addButton.classList.add('remove');
            } else {
                addButton.textContent = 'Add to Build';
                addButton.classList.remove('remove');
            }
            
            document.getElementById('overlay').style.display = 'block';
            document.getElementById('gpuDetails').style.display = 'block';
        }

        // Add to Build button functionality
        document.getElementById('addToBuildBtn').addEventListener('click', function() {
            if (!currentSelectedGpu) return;
            
            if (selectedGpu && selectedGpu.id === currentSelectedGpu.id) {
                // Clicked remove
                removeSelectedGpu();
            } else if (selectedGpu) {
                // Confirm replacement
                if (confirm(`Replace ${selectedGpu.name} with ${currentSelectedGpu.name}?`)) {
                    setSelectedGpu(currentSelectedGpu);
                }
            } else {
                // Just add
                setSelectedGpu(currentSelectedGpu);
            }
            
            closeModal();
        });

        // Remove Selected GPU button functionality
        document.getElementById('removeSelectedGpu').addEventListener('click', function() {
            if (selectedGpu) {
                if (confirm(`Remove ${selectedGpu.name} from your build?`)) {
                    removeSelectedGpu();
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
            document.getElementById('gpuDetails').style.display = 'none';
        }

        // Pagination functions
        function nextPage() {
            if ((currentPage + 1) * pageSize < allGPUData.length) {
                currentPage++;
                displayGpuPage(currentPage);
            } else {
                alert("No more data.");
            }
        }

        function previousPage() {
            if (currentPage > 0) {
                currentPage--;
                displayGpuPage(currentPage);
            } else {
                alert("You are on the first page.");
            }
        }

        function searchGPU() {
            const query = document.getElementById("gpuNameInput").value.trim().toLowerCase();

            $.ajax({
                url: '/video-card/name-search?name=' + query,
                method: 'GET',
                success: function(data) {
                    allGPUData = data;
                    currentPage = 0;
                    displayGpuPage(currentPage);
                },
                error: function() {
                    console.log("Error occurred while fetching search results.");
                }
            });
        }

        // Load all GPUs on page load
        $(document).ready(function() {
            fetchAllGPUs();
        });
    </script>
</body>
</html>