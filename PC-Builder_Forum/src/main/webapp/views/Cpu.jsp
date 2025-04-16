<!DOCTYPE html>
<html>
<head>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .Cpu {
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
        #cpuOutput {
            max-width: 300px;
            padding: 24px;
            border-radius: 12px;
            background-color: #ffffff;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #090101;
        }
        #cpuOutput p {
            font-size: 16px;
            margin: 12px 0;
            line-height: 1.6;
        }
        #cpuOutput strong {
            color: #222;
            font-weight: 600;
        }
        #cpuOutput span {
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
        #allCpuOutput {
            align-self: flex-start;
            margin: 40px 0 0 40px;
            max-width: 100%;
            overflow-x: auto;
        }
        #allCPU {
            border-collapse: collapse;
            width: 800px; /* Increased table width */
            background-color: #1c1c1c;
            color: white;
            font-size: 14px;
        }
        #allCPU th,
        #allCPU td {
            border: 1px solid #444;
            padding: 12px 16px; /* Larger padding for better spacing */
            text-align: center;
        }
        #allCPU th {
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

<h2 class="Cpu">CPU Information</h2>

<!-- Input and Buttons -->
<div id="searchBarContainer">
    <input type="number" id="cpuIdInput" placeholder="Enter CPU ID" />
    <button onclick="fetchCPUById()">Get CPU by ID</button>
</div>

<!-- CPU Output & Table Side-by-side -->
<div id="mainContent">
    <!-- CPU Output Area -->
    <div id="cpuOutput">
        <p><strong>ID:</strong> <span id="cpuId"></span></p>
        <p><strong>Name:</strong> <span id="cpuName"></span></p>
        <p><strong>Price:</strong> $<span id="cpuPrice"></span></p>
        <p><strong>Core Count:</strong> <span id="cpuCoreCount"></span></p>
        <p><strong>Core Clock:</strong> <span id="cpuCoreClock"></span> GHz</p>
        <p><strong>Boost Clock:</strong> <span id="cpuBoostClock"></span> GHz</p>
        <p><strong>TDP:</strong> <span id="cpuTdp"></span> W</p>
        <p><strong>Graphics:</strong> <span id="cpuGraphics"></span></p>
        <p><strong>SMT Enabled:</strong> <span id="cpuSmt"></span></p>
    </div>

    <!-- CPU Table -->
    <div id="allCpuOutput">
        <table id="allCPU">
            <thead>
                <tr class="All_cpu_heading">
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

<script>
    // Global variables for client-side pagination
    let allCpuData = [];
    let currentPage = 0;
    const pageSize = 15;

    // Fetch all CPUs from the backend and store them in allCpuData
    function fetchAllCPU() {
        $.ajax({
            url: '/cpu',
            method: 'GET',
            success: function(cpuList) {
                allCpuData = cpuList;  // Store the entire dataset
                currentPage = 0;       // Start at page 0
                displayPage(currentPage);
            },
            error: function() {
                alert('Failed to fetch CPUs.');
            }
        });
    }

    // Display a page of data
    function displayPage(page) {
        const tableBody = document.querySelector("#allCPU tbody");
        tableBody.innerHTML = "";  // Clear existing rows
        const startIndex = page * pageSize;
        const endIndex = startIndex + pageSize;
        const pageData = allCpuData.slice(startIndex, endIndex);
        pageData.forEach(cpu => {
            addRow(cpu);
        });
    }

    // Append a single row to the table
    function addRow(entry) {
        const tableBody = document.querySelector("#allCPU tbody");
        const row = document.createElement("tr");
        row.innerHTML = "<td>" + entry.id + "</td><td>" + entry.name + "</td><td>$" + entry.price +
            "</td><td>" + entry.coreCount + "</td><td>" + entry.coreClock + " GHz</td><td>" +
            entry.boostClock + " GHz</td><td>" + entry.tdp + " W</td><td>" + entry.graphics + "</td>";
        tableBody.appendChild(row);
    }

    // Go to the next page if available
    function nextPage() {
        if ((currentPage + 1) * pageSize < allCpuData.length) {
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

    function fetchCPUById() {
        const cpuId = $('#cpuIdInput').val();
        if (!cpuId) {
            alert('Please enter a valid CPU ID.');
            return;
        }
        $.ajax({
            url: '/cpu/' + cpuId,
            method: 'GET',
            success: function(cpu) {
                console.log("Fetched CPU:", cpu);
                $('#cpuId').text(cpu.id);
                $('#cpuName').text(cpu.name);
                $('#cpuPrice').text(cpu.price);
                $('#cpuCoreCount').text(cpu.coreCount);
                $('#cpuCoreClock').text(cpu.coreClock);
                $('#cpuBoostClock').text(cpu.boostClock);
                $('#cpuTdp').text(cpu.tdp);
                $('#cpuGraphics').text(cpu.graphics);
                $('#cpuSmt').text(cpu.smt ? 'Yes' : 'No');
            },
            error: function() {
                alert('Failed to fetch CPU data.');
            }
        });
    }

    // Load all CPUs on page load
    $(document).ready(function() {
        fetchAllCPU();
    });
</script>

</body>
</html>