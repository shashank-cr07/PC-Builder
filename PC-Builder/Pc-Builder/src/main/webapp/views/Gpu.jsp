<!DOCTYPE html>
<html>
<head>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .Gpu {
            font-family: 'LibreBaskerville';
            src: url('LibreBaskerville-Regular.ttf') format('truetype');
            font-size: 5.0rem;
        }
        body {
            margin: 0;
            font-family: 'Helvetica Neue', sans-serif;
            background-color: #090101;
            color: #d1caca;
        }
        #mainContent {
            display: flex;
            flex-direction: row;
            justify-content: space-between;
            align-items: flex-start;
            padding: 20px 40px;
            gap: 40px;
        }
        #gpuOutput {
            max-width: 300px;
            padding: 24px;
            border-radius: 12px;
            background-color: #ffffff;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #090101;
        }
        #gpuOutput p {
            font-size: 16px;
            margin: 12px 0;
            line-height: 1.6;
        }
        #gpuOutput strong {
            color: #222;
            font-weight: 600;
        }
        #gpuOutput span {
            color: #555;
        }
        #searchBarContainer {
            display: flex;
            align-items: center;
            gap: 10px;
            margin: 40px 0 20px 40px;
        }
        #cpuIdInput {
            padding: 6px 10px;
            font-size: 14px;
            width: 120px;
        }
        #searchBarContainer button {
            padding: 6px 12px;
            font-size: 14px;
            cursor: pointer;
        }
        #allgpuOutput {
            align-self: flex-start;
            margin: 40px 0 0 40px;
            max-width: 100%;
            overflow-x: auto;
        }
        #allGPU {
            border-collapse: collapse;
            width: 800px; /* Increased table width */
            background-color: #1c1c1c;
            color: white;
            font-size: 14px;
        }
        #allGPU th,
        #allGPU td {
            border: 1px solid #444;
            padding: 12px 16px; /* Larger padding for better spacing */
            text-align: center;
        }
        #allGPU th {
            background-color: #2a2a2a;
            font-weight: bold;
        }
        #paginationContainer {
            margin: 20px 40px 0 40px;
            display: flex;
            gap: 10px;
        }
        #paginationContainer button {
            padding: 6px 12px;
            font-size: 14px;
            cursor: pointer;
        }
        @media (max-width: 768px) {
            #mainContent {
                flex-direction: column;
                padding: 20px;
            }
            #searchBarContainer {
                margin: 20px 0;
            }
        }
    </style>
</head>
<body>

<h2 class="Gpu">Video Card Information</h2>

<!-- Input and Buttons -->
<div id="searchBarContainer">
    <input type="number" id="gpuIdInput" placeholder="Enter GPU ID" />
    <button onclick="fetchGPUById()">Get GPU by ID</button>
</div>

<!-- CPU Output & Table Side-by-side -->
<div id="mainContent">
    <!-- CPU Output Area -->
    <div id="gpuOutput">
        <p><strong>ID:</strong> <span id="gpuId"></span></p>
        <p><strong>Name:</strong> <span id="gpuName"></span></p>
        <p><strong>Price:</strong> $<span id="gpuPrice"></span></p>
        <p><strong>Chipset:</strong> <span id="gpuChipset"></span> W</p>
        <p><strong>Core Clock:</strong> <span id="gpuCoreClock"></span> GHz</p>
        <p><strong>Boost Clock:</strong> <span id="gpuBoostClock"></span> GHz</p>
        <p><strong>Memory:</strong> <span id="gpuMemory"></span> Gb</p>
        <p><strong>Color:</strong> <span id="gpuColor"></span></p>
        <p><strong>Length:</strong> <span id="gpuLength"></span> mm</p>
    </div>

    <!-- GPU Table -->
    <div id="allgpuOutput">
        <table id="allGPU">
            <thead>
                <tr class="All_gpu_heading">
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

<script>
    // Global variables for client-side pagination
    let allGPUData = [];
    let currentPage = 0;
    const pageSize = 15;

    // Fetch all CPUs from the backend and store them in allGPUData
    function fetchallGPU() {
        $.ajax({
            url: '/video-card',
            method: 'GET',
            success: function(gpuList) { 
                allGPUData = gpuList;  // Store the entire dataset
                currentPage = 0;       // Start at page 0
                displayPage(currentPage);
            },
            error: function() {
                alert('Failed to fetch GPUs.');
            }
        });
    }

    // Display a page of data
    function displayPage(page) {
        const tableBody = document.querySelector("#allGPU tbody");
        tableBody.innerHTML = "";  // Clear existing rows
        const startIndex = page * pageSize;
        const endIndex = startIndex + pageSize;
        const pageData = allGPUData.slice(startIndex, endIndex);
        pageData.forEach(gpu => {
            addRow(gpu);
        });
    }

    // Append a single row to the table
    function addRow(entry) {
        const tableBody = document.querySelector("#allGPU tbody");
        const row = document.createElement("tr");
        row.innerHTML = "<td>" + entry.id + "</td><td>" + entry.name + "</td><td>$" + entry.price +
            "</td><td>" + entry.chipset + "</td><td>" + entry.core_clock + " GHz</td><td>" + entry.boost_clock + " GHz</td><td>" + 
                entry.memory + " Gb</td><td>" + entry.color + "</td><td>" + entry.length + " mm</td>";
        tableBody.appendChild(row);
    }

    // Go to the next page if available
    function nextPage() {
        if ((currentPage + 1) * pageSize < allGPUData.length) {
            currentPage++;
            displayPage(currentPage);
        } else {
            alert("No more data.");
        }
    }

    // Go to the previous page if available
    function previousPage() {
        if (currentPage > 0) {
            currentPage--;
            displayPage(currentPage);
        } else {
            alert("You are on the first page.");
        }
    }

    function fetchGPUById() {
        const gpuId = $('#gpuIdInput').val();
        if (!gpuId) {
            alert('Please enter a valid GPU ID.');
            return;
        }
        $.ajax({
            url: '/video-card/' + gpuId,
            method: 'GET',
            success: function(gpu) {
                console.log("Fetched CPU:", gpu);
                $('#gpuId').text(gpu.id);
                $('#gpuName').text(gpu.name);
                $('#gpuPrice').text(gpu.price);
                $('#gpuChipset').text(gpu.chipset);
                $('#gpuMemory').text(gpu.memory);
                $('#gpuCoreClock').text(gpu.core_clock);
                $('#gpuBoostClock').text(gpu.boost_clock);
                $('#gpuColor').text(gpu.color);
                $('#gpuLength').text(gpu.length);
            },
            error: function() {
                alert('Failed to fetch CPU data.');
            }
        });
    }

    // Load all CPUs on page load
    $(document).ready(function() {
        fetchallGPU();
    });
</script>

</body>
</html>