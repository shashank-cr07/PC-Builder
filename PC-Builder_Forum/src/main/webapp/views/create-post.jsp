<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Post</title>
    <link rel="stylesheet" href="/create-post.css">
</head>
<body>

<!-- Header -->
<div class="header-container">
    <h2>Create a New Post in <span>${forum.name}</span></h2>
    <div class="create-forum">
        <a href="/forum/${forum.id}">
            <button>← Back to Forum</button>
        </a>
    </div>
</div>

<!-- Content Area -->
<div class="content">
    <form action="/create-post" method="post" class="post-form">
        <input type="hidden" name="forumId" value="${forum.id}" />

        <textarea name="content" placeholder="What's on your mind?" maxlength="300" required></textarea>

        <button type="submit">Post</button>
    </form>
</div>

</body>
</html>
