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
        } button{

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


    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script>
        function getValues(){
            let cpuBudget = document.getElementsByName("cpuBudget")[0].value.trim();
            let gpuBudget = document.getElementsByName("gpuBudget")[0].value.trim();
            let memoryBudget = document.getElementsByName("memoryBudget")[0].value.trim();
            let CpuCoolerBudget = document.getElementsByName("CpuCoolerBudget")[0].value.trim();
            let motherboardBudget = document.getElementsByName("motherboardBudget")[0].value.trim();
            let caseBudget = document.getElementsByName("caseBudget")[0].value.trim();
            let psuBudget = document.getElementsByName("psuBudget")[0].value.trim();
            let caseFanBudget = document.getElementsByName("caseFanBudget")[0].value.trim();
            let EhdBudget = document.getElementsByName("ehdBudget")[0].value.trim();
            let ihdBudget = document.getElementsByName("ihdBudget")[0].value.trim();
            let osBudget = document.getElementsByName("osBudget")[0].value.trim();
            let thermalPasteBudget = document.getElementsByName("thermalPasteBudget")[0].value.trim();
            let fanControllerBudget = document.getElementsByName("fanControllerBudget")[0].value.trim();
            console.log(cpuBudget,gpuBudget,osBudget);

            $.ajax({
                url: "/api/score/reccomend",
                body: JSON.stringify({
                    "budget": 10000,
                    "cpu": cpuBudget,
                    "motherboard": motherboardBudget,
                    "memory": memoryBudget,
                    "videoCard": gpuBudget,
                    "powerSupply": psuBudget,
                    "caseTable": caseBudget,
                    "cpuCooler": CpuCoolerBudget,
                    "internalHardDrive": ihdBudget,
                    "externalHardDrive": EhdBudget,
                    "fanController": fanControllerBudget,
                    "caseFan": caseFanBudget,
                    "thermalPaste": thermalPasteBudget,
                    "operatingSystem": osBudget
                }),
            });
        }

        function updateSliderValue(val) {
            document.getElementById('budgetValue').innerText = "$" + val;
        }

        function showCustomBudget() {
            document.getElementById("customBudgetSection").style.display = "block";
        }

        function hideCustomBudget() {
            document.getElementById("customBudgetSection").style.display = "none";
        }
        function presetSelected(type) {
            hideCustomBudget();
            alert("You selected a preset for: " + type);
            // Here, you can redirect or call backend to generate a build based on selected type and budget
        }
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
        <table class="custom-budget-table">
            <tr>
                <th>Component</th>
                <th>Budget ($)</th>
            </tr>
            <tr><td>CPU</td><td><input type="number" step = "0.01" name="cpuBudget" min="0"></td></tr>
            <tr><td>Video Card</td><td><input type="number" step = "0.01" name="gpuBudget" min="0"></td></tr>
            <tr><td>Memory</td><td><input type="number" step = "0.01" name="memoryBudget" min="0"></td></tr>
            <tr><td>CPU Cooler</td><td><input type="number" step = "0.01" name="CpuCoolerBudget" min="0"></td></tr>
            <tr><td>Motherboard</td><td><input type="number" step = "0.01" name="motherboardBudget" min="0"></td></tr>
            <tr><td>Case</td><td><input type="number" step = "0.01" name="caseBudget" min="0"></td></tr>
            <tr><td>Power Supply</td><td><input type="number" step = "0.01" name="psuBudget" min="0"></td></tr>
            <tr><td>Case Fan</td><td><input type="number" step = "0.01" name="caseFanBudget" min="0"></td></tr>
            <tr><td>External Hard Drive</td><td><input type="number" step = "0.01" name="ehdBudget" min="0"></td></tr>
            <tr><td>Internal Hard Drive</td><td><input type="number" step = "0.01" name="ihdBudget" min="0"></td></tr>
            <tr><td>Operating System</td><td><input type="number" step = "0.01" name="osBudget" min="0"></td></tr>
            <tr><td>Thermal Paste</td><td><input type="number" step = "0.01" name="thermalPasteBudget" min="0"></td></tr>
            <tr><td>Fan Controller</td><td><input type="number" step = "0.01" name="fanControllerBudget" min="0"></td></tr>
        </table>

        <div class="table-button-container">
            <button class="custom-button" onclick="getValues()">View Custom Parameters</button>
        </div>

    </div>

</body>
</html>
