<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>${forum.name} - Forum</title>
    <link rel="stylesheet" href="/forum-detail.css">
</head>

<body>
<script>
    function toggleMenu() {
            document.getElementById('user-dropdown').classList.toggle('show');
        }
        window.addEventListener('click', function (e) {
            if (!document.getElementById('user-info').contains(e.target)) {
                document.getElementById('user-dropdown').classList.remove('show');
            }
        });
</script>
<div class="header">
    <div>
        <a href="/home" class="btn">⬅ Back</a>
    </div>

    <div class="center-title">${forum.name}</div>

    <div class="user-info">
        <img src="/images/user-icon.jpg" alt="User Icon" onclick="toggleMenu()">
        <span style="margin-left: 0.5rem;" onclick="toggleMenu()">${username}</span>
        <div class="user-dropdown">
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

<div class="post-list" style="position: relative;">
    <a href="/create-post?forumId=${forum.id}" class="btn" style="position: absolute; top: 10px; right: 10px;">➕</a>

    <ul>
        <c:choose>
            <c:when test="${empty postsData}">
                <li>No posts yet in this forum.</li>
            </c:when>
            <c:otherwise>
                <c:forEach var="postData" items="${postsData}">
                    <li style="margin-bottom: 2em; list-style: none;">
                        <div>
                            <strong>${postData.post.content}</strong>
                            <span style="color: gray;">(</span>
                            <span style="color: gray;">${postData.username}</span>
                            <span style="color: gray;">)</span>
                        </div>

                        <!-- Comments -->
                        <c:forEach var="commentData" items="${commentsMap[postData.post.id]}">
                            <div style="margin-left: 2em; margin-top: 0.3em;">
                                <span>${commentData.comment.content}</span>
                                <span style="color: gray;">(</span>
                                <span style="color: gray;">${commentData.username}</span>
                                <span style="color: gray;">)</span>
                            </div>
                        </c:forEach>

                        <!-- Comment form -->
                        <form action="/add-comment" method="post" style="margin-left: 2em; margin-top: 0.5em;" class="comment-form">
                            <input type="hidden" name="postId" value="${postData.post.id}"/>
                            <input type="hidden" name="forumId" value="${forum.id}"/>
                            <input type="text" name="content" placeholder="Type your comment here" maxlength="100" required style="width: 300px;"/>
                            <button type="submit">Submit</button>
                        </form>

                        <!-- Line separator -->
                        <hr style="margin-top: 1em; border: 0; border-top: 1px solid #ddd;">
                    </li>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </ul>
</div>

</body>
</html>
