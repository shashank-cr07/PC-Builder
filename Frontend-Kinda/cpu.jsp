<html>
<head><title>CPU List</title></head>
<body>
<h2>Available CPUs</h2>

<button onclick="loadParts()">Load Parts</button>
<div id="output"></div>

<script>
    function getRequest(url, callback) {
        const xhr = new XMLHttpRequest();
        xhr.open("GET", url, true);

        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                callback(xhr.responseText);
            }
        };

        xhr.send();
    }

    function loadParts() {
        getRequest("/cpu", function (response) {
            document.getElementById("output").innerText = response;
        });
    }
</script>

<p> </p>
</body>
</html>
