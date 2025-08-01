<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
        <h2>게시글 등록</h2>
    </div>
    
    <form action="insertBoard.do" method="POST" enctype="multipart/form-data">
        <div class="mb-3">
            <label for="bbsTtl" class="form-label">제목<span class="text-danger">*</span></label>
            <div class="form-text text-end" id="ttlLength">0 / 256</div>
            <input type="text" class="form-control" id="bbsTtl" name="bbsTtl" maxlength="256" required>
        </div>
        
        <div class="mb-3">
            <label for="bbsCn" class="form-label">내용<span class="text-danger">*</span></label>
            <div class="form-text text-end" id="cnLength">0 / 4000</div>
            <textarea class="form-control" id="bbsCn" name="bbsCn" rows="5" maxlength="4000" required></textarea>
        </div>

        <div class="mb-3">
            <label for="rmrkCn" class="form-label">비고</label>
            <input type="text" class="form-control" id="rmrkCn" name="rmrkCn" disabled="disabled">
        </div>
        
        <div class="mb-3">
            <label for="uploadFile" class="form-label">첨부파일</label>
            <input type="file" class="form-control" id="uploadFile" name="uploadFile">
        </div>
        
        <div class="mb-3 d-flex justify-content-start">
		    <button type="button" class="btn btn-success" id="homeBtn">이전</button>
		</div>

        <div class="mb-3 text-end">
            <button type="submit" class="btn btn-primary">등록</button>
            <button type="reset" class="btn btn-danger" id="resetBtn">취소</button>
        </div>
    </form>

</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        $("#homeBtn").click(function() {
            window.location.href = "home.do";
        });
        
        $("#bbsTtl").on("input", function() {
            $("#ttlLength").text(this.value.length + ' / 256');
        });

        $("#bbsCn").on("input", function() {
            $("#cnLength").text(this.value.length + ' / 4000');
        });
        
        $("#resetBtn").on("click", function() {
        	$("#ttlLength").text( '0 / 256');
        	$("#cnLength").text( '0 / 256');
		})

    });
</script>
	
</body>
</html>
