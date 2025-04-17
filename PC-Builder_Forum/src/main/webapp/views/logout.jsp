<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <title>Logging Out...</title>
    <script>
        // Clear localStorage and redirect
        localStorage.clear(); // ✅ Clears localStorage
        window.location.href = "/"; // Redirect to homepage
    </script>
</head>
<body>
    <p>Logging out...</p>
</body>
</html>
