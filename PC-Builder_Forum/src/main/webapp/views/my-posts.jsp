<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>My Posts</title>
    <link rel="stylesheet" type="text/css" href="/my-posts.css">
</head>
<body>

    <!-- Header -->
    <div class="header-container">
        <div class="create-forum">
            <a href="/home"><button>Back</button></a>
        </div>
        <div class="user-menu">
            <img src="/images/user-icon.jpg" alt="User" class="user-icon" onclick="toggleDropdown()">
            <span style="margin-left: 0.5rem;" onclick = "toggleDropdown()">${username}</span>
            <div class="dropdown-menu" id="dropdown">
                <ul>
                    <li><a href="/my-forums">My Forums</a></li>
                    <li><a href="/my-posts">My Posts</a></li>
                    <li><a href="/home-pc">Build PC</a></li>
                    <li><a href="/builds">View Builds</a></li>
                    <li><a href="/logout">Logout</a></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Content -->
    <div class="content">
        <h2>My Posts</h2>

        <!-- Loop through the post data -->
        <ul>
            <c:forEach var="postData" items="${postsData}">
                <li>
                    <div style="margin-bottom: 25px; text-align: left;">
                        <p><strong>Forum:</strong> ${postData.forum.name}</p>
                        <p><strong>Post:</strong> ${postData.content}</p>
                        <div style="margin-left: 20px; margin-top: 10px;">
                            <p><strong>Comments:</strong></p>
                            <ul>
                                <c:choose>
                                    <c:when test="${not empty commentsMap[postData.id]}">
                                        <c:forEach var="commentData" items="${commentsMap[postData.id]}">
                                            <li>
                                                ${commentData.comment.content}
                                                <small style="color: #aaa;"> - ${commentData.username}</small>
                                            </li>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <li style="color: #aaa;">No comments yet.</li>
                                    </c:otherwise>
                                </c:choose>
                            </ul>
                        </div>
                    </div>
                </li>
            </c:forEach>
        </ul>
    </div>

    <script>
        // Function to toggle the dropdown menu
        function toggleDropdown() {
            const dropdown = document.getElementById("dropdown");
            dropdown.classList.toggle("show");
        }

        // Close dropdown if clicked outside
        window.onclick = function(event) {
            if (!event.target.matches('.user-icon')) {
                const dropdowns = document.getElementsByClassName("dropdown-menu");
                for (let i = 0; i < dropdowns.length; i++) {
                    const openDropdown = dropdowns[i];
                    if (openDropdown.classList.contains('show')) {
                        openDropdown.classList.remove('show');
                    }
                }
            }
        }
    </script>

</body>
</html>
