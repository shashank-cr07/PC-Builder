<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>PC Budget Planner</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #121212;
            color: #ffffff;
            padding: 30px;
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
        }

        .slider-container {
            text-align: center;
            margin-bottom: 40px;
        }

        .slider-value {
            font-size: 20px;
            margin-top: 10px;
        }

        .preset-options {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }

        .preset-options button {
            padding: 12px 24px;
            font-size: 16px;
            background-color: #333;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
        }

        .preset-options button:hover {
            background-color: #555;
        }

        #customBudgetSection {
            display: none;
            margin-top: 30px;
        }

        .custom-budget-table {
            margin: 0 auto;
            max-width: 600px;
            border-collapse: collapse;
            width: 100%;
        }

        .custom-budget-table th, .custom-budget-table td {
            padding: 12px;
            border: 1px solid #444;
            text-align: center;
        }

        .custom-budget-table input {
            width: 80px;
            padding: 6px;
            background-color: #1e1e1e;
            border: 1px solid #666;
            color: #fff;
            border-radius: 4px;
        }

        .custom-button {
            padding: 12px 24px;
            font-size: 16px;
            background-color: #333;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            margin-top: 20px;
        }

        .custom-button:hover {
            background-color: #555;
        }

        .table-button-container {
            text-align: center;
        }
        
        .total-budget {
            text-align: center;
            font-size: 18px;
            margin-bottom: 20px;
        }
        
        .budget-warning {
            color: #ff5555;
            text-align: center;
            margin-top: 10px;
        }

        /* Popup Card Styles */
        .popup-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }

        .popup-card {
            background: #1e1e1e;
            border-radius: 12px;
            padding: 20px;
            max-width: 500px;
            width: 90%;
            max-height: 80vh;
            overflow-y: auto;
            position: relative;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
        }

        .popup-card h3 {
            margin: 0 0 20px;
            text-align: center;
            font-size: 24px;
            color: #4CAF50;
        }

        .popup-card .close-button {
            position: absolute;
            top: 10px;
            right: 10px;
            background: #555;
            color: white;
            border: none;
            border-radius: 50%;
            width: 30px;
            height: 30px;
            cursor: pointer;
            font-size: 16px;
            line-height: 30px;
            text-align: center;
        }

        .popup-card .close-button:hover {
            background: #777;
        }

        .popup-card .part-item {
            margin-bottom: 10px;
            padding: 10px;
            background: #2a2a2a;
            border-radius: 8px;
            font-size: 16px;
        }

        .popup-card .part-item strong {
            color: #4CAF50;
            margin-right: 5px;
        }

        .popup-card .part-item span {
            color: #ffffff;
        }

    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script>
        let totalBudget = 1000; // Default budget
        
        function updateSliderValue(val) {
            totalBudget = val;
            document.getElementById('budgetValue').textContent = "$" + val;
            updateTotalCustomBudget();
        }

        function showCustomBudget() {
            document.getElementById("customBudgetSection").style.display = "block";
            updateTotalCustomBudget();
        }

        function hideCustomBudget() {
            document.getElementById("customBudgetSection").style.display = "none";
        }
        
        function updateTotalCustomBudget() {
            let inputs = document.querySelectorAll('#customBudgetSection input[type="number"]');
            let sum = 0;
            
            inputs.forEach(input => {
                const value = parseFloat(input.value) || 0;
                sum += value;
            });
            
            document.getElementById('totalCustomBudget').textContent = `
                Total Allocated: $ + sum.toFixed(2)` + ` of $ ` +totalBudget;
                
            const warningElement = document.getElementById('budgetWarning');
            if (sum > totalBudget) {
                warningElement.textContent = "Warning: Your allocations exceed the total budget!";
                warningElement.style.display = "block";
            } else {
                warningElement.style.display = "none";
            }
        }
        
        function calculateFractions() {
            let inputs = document.querySelectorAll('#customBudgetSection input[type="number"]');
            let sum = 0;
            const fractions = {};
            
            inputs.forEach(input => {
                const value = parseFloat(input.value) || 0;
                sum += value;
            });
            
            if (sum === 0) return {};
            
            inputs.forEach(input => {
                const value = parseFloat(input.value) || 0;
                const fraction = value / sum;
                fractions[input.name.replace('Budget', '')] = fraction.toFixed(4);
            });
            
            return fractions;
        }

        function showPopup(response) {
            const popup = document.getElementById('responsePopup');
            const responseContainer = document.getElementById('responseContent');
            responseContainer.innerHTML = ''; // Clear previous content

            // Format the response data - only show part names
            for (const [key, value] of Object.entries(response)) {
                if (value && typeof value === 'object' && value.name) {
                    const item = document.createElement('div');
                    item.className = 'response-item';
                    item.innerHTML = `<strong> ` + key + ` :</strong> ` + value.name;
                    responseContainer.appendChild(item);
                }
            }

            popup.style.display = 'flex';
        }

        function closePopup() {
            document.getElementById('responsePopup').style.display = 'none';
        }

        function getValues(){
            const fractions = calculateFractions();
            
            let inputs = document.querySelectorAll('#customBudgetSection input[type="number"]');
            let sum = 0;
            
            inputs.forEach(input => {
                const value = parseFloat(input.value) || 0;
                sum += value;
            });

            const totalAllocated = Object.values(fractions).reduce((sum, val) => sum + parseFloat(val), 0);
            console.log(JSON.stringify({
                    "budget": sum.toFixed(2),
                    "user": 1, 
                    "cpu": fractions.cpu,
                    "motherboard": fractions.motherboard,
                    "memory": fractions.memory,
                    "videoCard": fractions.gpu,
                    "powerSupply": fractions.psu,
                    "caseTable": fractions.case,
                    "cpuCooler": fractions.CpuCooler,
                    "internalHardDrive": fractions.ihd,
                    "externalHardDrive": fractions.ehd,
                    "fanController": fractions.fanController,
                    "caseFan": fractions.caseFan,
                    "thermalPaste": fractions.thermalPaste,
                    "os": fractions.os
                })
            );
            if (totalAllocated === 0) {
                alert("Please allocate some budget to components first.");
                return;
            }
            
            console.log("Budget Fractions:", fractions);
            console.log("Total Budget:", totalBudget);
            let data = JSON.stringify({
                    "budget": totalBudget,
                    "user": 1, 
                    "cpu": fractions.cpu,
                    "motherboard": fractions.motherboard,
                    "memory": fractions.memory,
                    "videoCard": fractions.gpu,
                    "powerSupply": fractions.psu,
                    "caseTable": fractions.case,
                    "cpuCooler": fractions.CpuCooler,
                    "internalHardDrive": fractions.ihd,
                    "externalHardDrive": fractions.ehd,
                    "fanController": fractions.fanController,
                    "caseFan": fractions.caseFan,
                    "thermalPaste": fractions.thermalPaste,
                    "os": fractions.os
            });
            
            $.ajax({
                url: "http://localhost:8080/api/score/reccomend",
                method: "POST",
                contentType: "application/json",
                data: data,
                success: function(response) {
                    console.log("Success:", response);
                    console.log(data);
                    showPopup(response);
                },
                error: function(xhr, status, error) {
                    console.error("Error:", error);
                    console.log(data);
                    alert("Failed to fetch recommendations. Please try again.");
                }
            });
        }

        function presetSelected(type) {
            hideCustomBudget();
            alert("You selected a preset for: " + type);
            
        }
        
        document.addEventListener('DOMContentLoaded', function() {
            const inputs = document.querySelectorAll('#customBudgetSection input[type="number"]');
            inputs.forEach(input => {
                input.addEventListener('input', updateTotalCustomBudget);
            });
        });
    </script>
</head>
<body>

    <h2>PC Budget Planner</h2>

    <div class="slider-container">
        <label for="budgetSlider">Select Total Budget:</label><br>
        <input type="range" id="budgetSlider" min="300" max="10000" value="1000" step="50" oninput="updateSliderValue(this.value)">
        <div class="slider-value" id="budgetValue">$1000</div>
    </div>

    <div class="preset-options">
        <button onclick="presetSelected('Work')">Work</button>
        <button onclick="presetSelected('Gaming')">Gaming</button>
        <button onclick="presetSelected('Photo Editing')">Photo Editing</button>
        <button onclick="presetSelected('Streaming')">Streaming</button>
        <button onclick="showCustomBudget()">Custom</button>    
    </div>

    <div id="customBudgetSection">
        <h3 style="text-align:center;">Distribute Budget Across Parts</h3>
        <div class="total-budget" id="totalCustomBudget">Total Allocated: $0 of $1000</div>
        <div class="budget-warning" id="budgetWarning" style="display: none;"></div>
        
        <table class="custom-budget-table">
            <tr>
                <th>Component</th>
                <th>Budget ($)</th>
            </tr>
            <tr><td>CPU</td><td><input type="number" step="0.01" name="cpuBudget" min="0" value="0"></td></tr>
            <tr><td>Video Card</td><td><input type="number" step="0.01" name="gpuBudget" min="0" value="0"></td></tr>
            <tr><td>Memory</td><td><input type="number" step="0.01" name="memoryBudget" min="0" value="0"></td></tr>
            <tr><td>CPU Cooler</td><td><input type="number" step="0.01" name="CpuCoolerBudget" min="0" value="0"></td></tr>
            <tr><td>Motherboard</td><td><input type="number" step="0.01" name="motherboardBudget" min="0" value="0"></td></tr>
            <tr><td>Case</td><td><input type="number" step="0.01" name="caseBudget" min="0" value="0"></td></tr>
            <tr><td>Power Supply</td><td><input type="number" step="0.01" name="psuBudget" min="0" value="0"></td></tr>
            <tr><td>Case Fan</td><td><input type="number" step="0.01" name="caseFanBudget" min="0" value="0"></td></tr>
            <tr><td>External Hard Drive</td><td><input type="number" step="0.01" name="ehdBudget" min="0" value="0"></td></tr>
            <tr><td>Internal Hard Drive</td><td><input type="number" step="0.01" name="ihdBudget" min="0" value="0"></td></tr>
            <tr><td>Operating System</td><td><input type="number" step="0.01" name="osBudget" min="0" value="0"></td></tr>
            <tr><td>Thermal Paste</td><td><input type="number" step="0.01" name="thermalPasteBudget" min="0" value="0"></td></tr>
            <tr><td>Fan Controller</td><td><input type="number" step="0.01" name="fanControllerBudget" min="0" value="0"></td></tr>
        </table>

        <div class="table-button-container">
            <button class="custom-button" onclick="getValues()">View Custom Parameters</button>
        </div>
    </div>

    <!-- Popup Card -->
    <div class="popup-overlay" id="responsePopup">
        <div class="popup-card">
            <button class="close-button" onclick="closePopup()">×</button>
            <h3>Recommended Build Parts</h3>
            <div id="responseContent"></div>
        </div>
    </div>

</body>
</html>