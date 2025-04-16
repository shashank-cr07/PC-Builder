<!DOCTYPE html>
<html>
<head>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
    @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap');
    .heading-container {
    display: flex;
    justify-content: center;
    margin-top: 40px;
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

    .geometric-border::before,
    .geometric-border::after {
        content: '';
        position: absolute;
        border: 2px dashed #777;
        width: 110%;
        height: 130%;
        top: -15%;
        left: -5%;
        border-radius: 18px;
        z-index: -1;
        transform: rotate(3deg);
        opacity: 0.4;
    }
    .geometric-border::after {
        transform: rotate(-3deg);
    }
    .Motherboard {
            font-size: 3.5rem;
            font-family: "Moonscape";
            src: url("Moonscape\ Demo.otf");
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

    #mbOutput {
        flex: 1;
        min-width: 280px;
        max-width: 350px;
        padding: 24px;
        border-radius: 16px;
        background-color: #1f1f1f;
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
        color: #e2e2e2;
    }

    #mbOutput p {
        font-size: 15px;
        margin: 12px 0;
        line-height: 1.6;
    }

    #mbOutput strong {
        color: #ffffff;
        font-weight: 600;
    }

    #mbOutput span {
        color: #aaa;
    }

    #searchBarContainer {
        display: flex;
        align-items: center;
        gap: 12px;
        margin: 30px 60px 10px;
        flex-wrap: wrap;
    }

    #mbIdInput {
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

    #allmbOutput {
        flex: 2;
        min-width: 600px;
        margin-top: 20px;
        overflow-x: auto;
    }

    #allMB {
        border-collapse: collapse;
        width: 100%;
        background-color: #141414;
        color: #fff;
        font-size: 14px;
        border-radius: 8px;
        overflow: hidden;
    }

    #allMB th,
    #allMB td {
        border: 1px solid #2c2c2c;
        padding: 14px 18px;
        text-align: center;
    }

    #allMB th {
        background-color: #1e1e1e;
        font-weight: 600;
    }

    #allMB tbody tr:nth-child(odd) {
        background-color: #1a1a1a;
    }

    #allMB tbody tr:hover {
        background-color: #292929;
    }

    #paginationContainer {
        margin: 30px 60px;
        display: flex;
        gap: 12px;
        flex-wrap: wrap;
    }

    @media (max-width: 768px) {
        #mainContent {
            flex-direction: column;
            padding: 20px;
            gap: 30px;
        }

        #searchBarContainer,
        #paginationContainer {
            justify-content: center;
        }

        #allmbOutput {
            min-width: unset;
            width: 100%;
        }
    }
</style>

</head>
<body>

<h2 class="Motherboard">Motherboard Information</h2>

<!-- Input and Buttons -->
<div id="searchBarContainer">
    <input type="number" id="mbIdInput" placeholder="Enter Motherboard ID" />
    <button onclick="fetchMotherboardById()">Get Motherboard by ID</button>
</div>

<!-- Output & Table Side-by-side -->
<div id="mainContent">
    <!-- Motherboard Output Area -->
    <div id="mbOutput">
        <p><strong>ID:</strong> <span id="mbId"></span></p>
        <p><strong>Name:</strong> <span id="mbName"></span></p>
        <p><strong>Price:</strong> $<span id="mbPrice"></span></p>
        <p><strong>Socket:</strong> <span id="mbSocket"></span></p>
        <p><strong>Form Factor:</strong> <span id="mbFormFactor"></span></p>
        <p><strong>Max Memory:</strong> <span id="mbMaxMemory"></span></p>
        <p><strong>Memory Slots:</strong> <span id="mbMemorySlots"></span></p>
        <p><strong>Color:</strong> <span id="mbColor"></span></p>
    </div>

    <!-- Motherboard Table -->
    <div id="allmbOutput">
        <table id="allMB">
            <thead>
                <tr class="All_mb_heading">
                    <th>ID</th>
                    <th>Name</th>
                    <th>Price</th>
                    <th>Socket</th>
                    <th>Form Factor</th>
                    <th>Max Memory</th>
                    <th>Memory Slots</th>
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

<script>
    let allMBData = [];
    let currentPage = 0;
    const pageSize = 15;

    function fetchAllMotherboards() {
        $.ajax({
            url: '/motherboard',
            method: 'GET',
            success: function(mbList) { 
                allMBData = mbList;
                currentPage = 0;
                displayMBPage(currentPage);
            },
            error: function() {
                alert('Failed to fetch motherboards.');
            }
        });
    }

    function displayMBPage(page) {
        const tableBody = document.querySelector("#allMB tbody");
        tableBody.innerHTML = "";
        const startIndex = page * pageSize;
        const endIndex = startIndex + pageSize;
        const pageData = allMBData.slice(startIndex, endIndex);
        pageData.forEach(mb => {
            addMBRow(mb);
        });
    }

    function addMBRow(entry) {
        const tableBody = document.querySelector("#allMB tbody");
        const row = document.createElement("tr");
        row.innerHTML = "<td>" + entry.id + "</td><td>" + entry.name + "</td><td>$" + entry.price +
            "</td><td>" + entry.socket + "</td><td>" + entry.formFactor + "</td><td>" + entry.maxMemory +
            "</td><td>" + entry.memorySlots + "</td><td>" + entry.color + "</td>";
        tableBody.appendChild(row);
    }

    function nextPage() {
        if ((currentPage + 1) * pageSize < allMBData.length) {
            currentPage++;
            displayMBPage(currentPage);
        } else {
            alert("No more data.");
        }
    }

    function previousPage() {
        if (currentPage > 0) {
            currentPage--;
            displayMBPage(currentPage);
        } else {
            alert("You are on the first page.");
        }
    }

    function fetchMotherboardById() {
        const mbId = $('#mbIdInput').val();
        if (!mbId) {
            alert('Please enter a valid Motherboard ID.');
            return;
        }
        $.ajax({
            url: '/motherboard/' + mbId,
            method: 'GET',
            success: function(mb) {
                console.log(mb)
                $('#mbId').text(mb.id);
                $('#mbName').text(mb.name);
                $('#mbPrice').text(mb.price);
                $('#mbSocket').text(mb.socket);
                $('#mbFormFactor').text(mb.formFactor);
                $('#mbMaxMemory').text(mb.maxMemory);
                $('#mbMemorySlots').text(mb.memorySlots);
                $('#mbColor').text(mb.color);
            },
            error: function() {
                alert('Failed to fetch motherboard data.');
            }
        });
    }

    $(document).ready(function() {
        fetchAllMotherboards();
    });
</script>

</body>
</html>