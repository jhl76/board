<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 등록</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>

<div class="container mt-4">

    <div class="text-center mb-4">
        <h2>게시글 수정</h2>
    </div>
    
    <nav aria-label="breadcrumb">
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="home.do">공지 게시판</a></li>
			<li class="breadcrumb-item"><a href="boardDetailPage.do?bbsSn=${boardVo.bbsSn }">게시글 상세정보</a></li>
			<li class="breadcrumb-item active" aria-current="page">게시글 수정</li>
		</ol>
	</nav>
    
    <form action="updateBoard.do" method="POST" enctype="multipart/form-data">
    	<input type="hidden" id="bbsSn" name="bbsSn" value="${boardVo.bbsSn }">
        <div class="mb-3">
            <label for="bbsTtl" class="form-label">제목</label>
            <div class="form-text text-end" id="ttlLength">0 / 256</div>
            <input type="text" class="form-control" id="bbsTtl" name="bbsTtl"  value="${boardVo.bbsTtl }" required maxlength="256">
        </div>
        
        <div class="mb-3">
            <label for="bbsCn" class="form-label">내용</label>
            <div class="form-text text-end" id="cnLength">0 / 4000</div>
            <textarea class="form-control" id="bbsCn" name="bbsCn" rows="5"  required maxlength="4000">${boardVo.bbsCn }</textarea>
        </div>

        <div class="mb-3">
            <label for="rmrkCn" class="form-label">비고</label>
            <input type="text" class="form-control" id="rmrkCn" name="rmrkCn" value="${boardVo.rmrkCn }">
        </div>
        
	    <div class="mb-3">
	        <label class="form-label">첨부파일<c:if test="${boardVo.fileNm == null }"><span class="text-warning">  *현재 저장된 파일 정보는 존재하지 않습니다.*</span></c:if></label>
	        <input type="file" class="form-control" id="uploadFile" name="uploadFile">
	    </div>
		
		<div class="mb-3 d-flex justify-content-start">
		    <button type="button" class="btn btn-success" id="homeBtn">이전</button>
		</div>
        <div class="mb-3 text-end">
            <button type="submit" class="btn btn-primary">수정</button>
        </div>
    </form>
    
    <c:if test="${boardVo.fileNm != null}">
	    <form action="deleteFile.do" method="POST" id="deleteFileForm">
	        <input type="hidden" name="bbsSn" value="${boardVo.bbsSn}">
	        <button type="button" class="btn btn-danger" id="deleteFileBtn">파일 삭제</button>
	    </form>
	</c:if>

</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        $("#homeBtn").click(function() {
            window.location.href = "boardDetailPage.do?bbsSn=" + ${boardVo.bbsSn};
        });
        $("#deleteFileBtn").click(function() {
			if (confirm("정말로 삭제하시겠습니까?")) {
				$("#deleteFileForm").submit();
			}
		});
        
        var bbsTtlLen = $("#bbsTtl").val().length;
        $("#ttlLength").text(bbsTtlLen + " / 256");
        var bbsCnLen = $("#bbsCn").val().length;
        $("#cnLength").text(bbsCnLen + " / 4000");
        
        $("#bbsTtl").on("input", function() {
			$("#ttlLength").text($(this).val().length + " / 256");
		})
        
		$("#bbsCn").on("input", function() {
			$("#cnLength").text($(this).val().length + " / 4000");
		})
        
        
    });
</script>
</body>
</html>
