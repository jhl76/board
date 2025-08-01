<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginPage.do</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>

<div class="container mt-4">

    <div class="text-center mb-4">
        <h2>게시판 로그인</h2>
        <c:if test="${param.error != null}">
        	<h3 class="text-danger">★★★사용자 정보가 일치하지 않습니다.★★★</h3>
    	</c:if>
    </div>
    
    
    <form action="login.do" method="POST">
    
   		<!--  	
   		<div class="mb-3">
            <label class="form-label">ROLE</label>
            <div class="d-flex gap-3">
                <div class="form-check">
                    <input class="form-check-input" type="radio" id="roleUser" name="authrt_cd" value="1">
                    <label class="form-check-label" for="roleUser">USER</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" id="roleAdmin" name="authrt_cd" value="2" checked>
                    <label class="form-check-label" for="roleAdmin">ADMIN</label>
                </div>
            </div>
        </div> 
        -->
    
        <div class="mb-3">
            <label for="user_id" class="form-label">ID</label>
            <input type="text" class="form-control" id="user_id" name="user_id" required>
        </div>
        
        <div class="mb-3">
            <label for="user_pw" class="form-label">PW</label>
            <input type="text" class="form-control" id="user_pw" name="user_pw" required>
        </div>
        
        
        <div class="mb-3">
            <button type="submit" class="btn btn-primary">로그인</button>
        </div>
    </form>

</div>


<script src="https://code.jquery.com/jquery-3.6.0.min.js">

</script>
</body>
</html>