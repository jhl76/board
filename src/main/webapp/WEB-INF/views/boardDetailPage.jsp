<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>home.jsp</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
    #boardDetail {
        max-width: 800px; /* 너비 제한 */
        margin: auto; /* 중앙 정렬 */
    }
    .content-box {
        background: #f9f9f9; /* 연한 배경 */
        padding: 15px;
        border-radius: 5px;
        border: 1px solid #ddd;
        min-height: 100px;
        white-space: pre-line; /* 줄바꿈 유지 */
    }
    h4 {
        font-size: 1.4rem;
    }
    .small {
        font-size: 0.875rem;
    }
    #fileNm:hover {
    cursor: pointer; /* 손가락 모양 커서 */
}
</style>
</head>
<body>

<div class="container">
	<div class="text-center">
		<h2>게시글 상세정보</h2>
		<p class="text-success">*${user.userId }*님 반갑습니다.</p>
		
		<nav aria-label="breadcrumb">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="home.do">공지 게시판</a></li>
				<li class="breadcrumb-item active" aria-current="page">게시글 상세정보</li>
			</ol>
		</nav>
		
		<div class="text-end">
			<button id="logoutBtn" class="btn-light">logout</button>
		</div>
		
	</div>
	
   	<c:choose>
		<c:when test="${user.authrtCd == '1'}">
	        <div class="text-end"><p class="text-primary">ROLE : 사용자</p></div>
		</c:when>
		<c:when test="${user.authrtCd == '2'}">
	        <div class="text-end"><p class="text-primary">ROLE : 관리자</p></div>
		</c:when>
   	</c:choose>
   	
    
	<div id="boardDetail" class="container mt-5">
	    <h3 class="fw-bold border-bottom pb-3" title="${boardVo.bbsTtl}">
	    	<c:choose>
	    		<c:when test="${boardVo.bbsTtl.length() > 50}">
	    			${boardVo.bbsTtl.substring(0,50)}…
	    		</c:when>
	    		<c:otherwise>
	    			${boardVo.bbsTtl}
	    		</c:otherwise>
	    	</c:choose>
	    </h3>
	    <div class="text-muted fs-5 mb-4">
	        <span class="fw-semibold">아이디:</span> ${boardVo.userId} · 
	        <span class="fw-semibold">작성:</span> ${boardVo.wrtDt} · 
	        <span class="fw-semibold">IP:</span> ${boardVo.cntnIpAddr} · 
	        <span class="fw-semibold">조회수:</span> ${boardVo.bbsInqCnt}
	    </div>
	    <div class="p-4 bg-light border rounded fs-5" style="word-break: break-word;" title='${boardVo.bbsCn}'>
	    	${boardVo.bbsCn}
			<c:if test="${boardVo.fileNm.endsWith('.jpg') || boardVo.fileNm.endsWith('.png') || boardVo.fileNm.endsWith('.gif')}">
	    		<br><br>
		    	<div class="p-4 bg-white border rounded text-center" >
					    <img src="showImage.do?fileNm=${boardVo.fileNm}" style="width:300px; height:auto;"/>
		    	</div> 
			</c:if>
	    </div>
	    <div class="text-muted fs-6 mt-4">
	    	<c:if test="${not empty boardVo.updtDt }">
		        <h4 class="fw-semibold">수정: ${boardVo.updtDt} </h4> 
	    	</c:if>
	    </div>
	    <c:if test="${not empty boardVo.fileNm}">
	        <div class="text-muted fs-5 mb-4">
	            <span class="fw-semibold">첨부파일:</span>
				<a href="fileDownload.do?fileNm=${boardVo.fileNm}" class="text-decoration-none">
				    <i class="bi bi-download"></i> ${boardVo.orgnlFileNm}
				</a>
	        </div>
    	</c:if>
	</div>
	
	<div class="text-center">
    	<c:choose>
			<c:when test="${user.authrtCd == '2'}">
		        <button id="deleteBtn" class="btn btn-danger">삭제</button>
		        <button id="updateBtn" class="btn btn-primary">수정</button>
			</c:when>
    	</c:choose>
    </div>
    
    <div id="commentsSection" class="container mt-5">
	    <h4 class="fw-bold border-bottom pb-3">댓글</h4>
	    
	    <c:choose>
	    	<c:when test="${empty commentList }">
	    		<div class="text-center"><span class="text-danger">*작성된 댓글이 아직 없습니다＊</span></div>
	    	</c:when>
	    </c:choose>
	    
	    <c:choose>
	    	<c:when test="${user.authrtCd == '1' }">
			    <form action="insertComment.do" method="post">
			    	<input type="hidden" name="userId" value="${user.userId}"> 
			    	<input type="hidden" name="bbsSn" value="${boardVo.bbsSn}"> 
				    <div class="mb-3">
				   		<div class="form-text text-end" id="cnLength">0 / 4000</div>
				        <textarea id="cmntCn" name="cmntCn" class="form-control" rows="3" placeholder="댓글을 입력하세요." maxlength="4000"></textarea>
				    </div>
				    <div class="text-end">
				        <button type="submit" class="btn btn-success">댓글 등록</button>
				    </div>
			    </form>
	    	</c:when>
	    </c:choose>
	
		<div id="commentList" class="mt-4">
		    <c:forEach var="comment" items="${commentList}">
		    	<div class="border rounded p-3 mb-2 bg-light"  style="margin-left: ${comment.upCmntNo != null ? '40px' : '0px'};">
		            <div class="d-flex justify-content-between">
		                <strong class="me-2">${comment.userId}</strong>
					    <div>
					        <small class="text-muted me-3">
					            <i class="bi bi-calendar-date"></i> 작성일자: ${comment.wrtDt}		
					        </small>
					        <small class="text-muted">
					            <i class="bi bi-pencil" id="updtDt-${comment.cmntNo}"></i> 수정일자: <span id="updtDtText-${comment.cmntNo}">${comment.updtDt}</span>
					        </small>
					    </div>
		            </div>
		            
		            <%pageContext.setAttribute("replaceChar", "\n"); %>
		            <p class="mt-2 mb-1" id="showCmntCn-${comment.cmntNo}" >
						${fn:replace(comment.cmntCn, replaceChar, "<br/>")}
					</p>
		            
		            <textarea class="form-control" 
		                style="display: none;"
		                id="inputCmntCn-${comment.cmntNo}">${comment.cmntCn}</textarea>
		             
		            <textarea  class="form-control"
		            	style="display: none;"
		            	id="inputUpCmntCn-${comment.cmntNo }">${comment.cmntCn}</textarea>
		            
		            <c:choose>
		                <c:when test="${user.authrtCd == '1' && user.userId == comment.userId}">
	                        <button type="button" id="cmntUpdateBtn-${comment.cmntNo }" 	class="cmntUpdateBtn btn-success"
	                        data-cmntno="${comment.cmntNo}">변경</button>
	                        <button type="button" id="cmntDeleteBtn-${comment.cmntNo  }"  class="cmntDeleteBtn btn-danger"
	                        data-cmntno="${comment.cmntNo}">삭제</button>
	                        <button type="button" id="saveCmntBtn-${comment.cmntNo}" 	    class="saveCmntBtn btn-primary" 
	                        data-cmntno="${comment.cmntNo}" style="display: none;">저장</button>
							<button type="button" id="cancelCmntBtn-${comment.cmntNo}"    class="cancelCmntBtn btn-secondary" 
							data-cmntno="${comment.cmntNo}" style="display: none;">취소</button>
		                </c:when>
		                <c:when test="${user.authrtCd == '2'}">
		                	<c:if test="${comment.upCmntNo == null }">
			                    <button type="button" id="insertUpCmntBtn-${comment.cmntNo  }" 	class="insertUpCmntBtn btn-success"
			                    data-cmntno="${comment.cmntNo}">대댓글 달기</button>
		                	</c:if>
		                	<c:if test="${comment.upCmntNo != null }">
			                	<button type="button" id="upCmntUpdateBtn-${comment.cmntNo }" 	class="upCmntUpdateBtn btn-success"
		                        data-cmntno="${comment.cmntNo}">변경</button>
		                	</c:if>
		                	<button type="button" id="insertUpCmntBtn2-${comment.cmntNo  }"  	class="insertUpCmntBtn2 btn-primary"
		                    data-cmntno="${comment.cmntNo}" style="display: none;">등록</button>
		                    <button type="button" id="cmntDeleteBtn-${comment.cmntNo  }"  	class="cmntDeleteBtn btn-danger"
		                    data-cmntno="${comment.cmntNo}">삭제</button>
		                    <button type="button" id="saveUpCmntBtn-${comment.cmntNo}" 	    	class="saveUpCmntBtn btn-primary" 
	                        data-cmntno="${comment.cmntNo}" style="display: none;">저장</button>
							<button type="button" id="cancelUpCmntBtn-${comment.cmntNo}"    	class="cancelUpCmntBtn btn-secondary" 
							data-cmntno="${comment.cmntNo}" style="display: none;">취소</button>
							<button type="button" id="cancelUpCmntBtn2-${comment.cmntNo}"    	class="cancelUpCmntBtn2 btn-secondary" 
							data-cmntno="${comment.cmntNo}" style="display: none;">취소</button>
		                </c:when>
		            </c:choose>
		        </div>
		    </c:forEach>
		</div>

	</div>
</div>

<script>
    $(document).ready(function()
    {
        $("#logoutBtn").click(function()
        {
        	window.location.href = "logout.do"; 
		});
        
        $("#deleteBtn").click(function()
        {
        	result = confirm("정말로 삭제하시겠습니까?");
        	if (result)
        	{
	            window.location.href = "deleteBoard.do?bbsSn="+${boardVo.bbsSn}; 
			}
        });
        
        $("#updateBtn").click(function()
        {
            window.location.href = "adminBoardUpdatePage.do?bbsSn="+${boardVo.bbsSn}; 
        });
        
        $(".cmntDeleteBtn").click(function() 
        {
        	var cmntNo = $(this).data('cmntno');
			var result = confirm("정말로 삭제하시겠습니까?");
			if (result) {
				window.location.href = "deleteComment.do?cmntNo="+cmntNo+"&bbsSn="+${boardVo.bbsSn};
			}
		});
        
        $(".cmntUpdateBtn").click(function()
        {
        	var cmntNo = $(this).data('cmntno');
        	
        	$("#showCmntCn-" + cmntNo).hide();
        	$("#inputCmntCn-" + cmntNo).show().focus();
        	
        	$("#cmntUpdateBtn-" + cmntNo).hide();
        	$("#cmntDeleteBtn-" + cmntNo).hide();
        	
        	$("#saveCmntBtn-" + cmntNo).show();
        	$("#cancelCmntBtn-" + cmntNo).show();
			
		});
        
        $(".saveCmntBtn").click(function() 
        {
        	var cmntNo = $(this).data('cmntno');
        	var cmntCn = $("#inputCmntCn-" + cmntNo).val();
        	
        	$.ajax({
        		type : "POST",
        		url : "<c:url value='updateUserComment.do'/>", 
        	    dataType: "json",
        	    data: {  
                    cmntNo: cmntNo.toString(),
                    cmntCn: cmntCn
                },
        		success : function(response) {
        			console.log("response:", response);
                    console.log("response.resultMap.status:", response.resultMap.status);
					if (response.resultMap.status == "success") {
						
        			// 입력값을 기존 내용으로 업데이트
                    $("#inputCmntCn-" + cmntNo).val(response.resultMap.cmntCn);
        			$("#showCmntCn-" + cmntNo).html(response.resultMap.cmntCn.replaceAll("\n", "<br/>"));
        			$("#updtDtText-" + cmntNo).text(response.resultMap.updtDt);
                    
                    // 입력 필드 숨기고 기존 내용 보이기
                    $("#inputCmntCn-" + cmntNo).hide();
                    $("#showCmntCn-" + cmntNo).show();

                    // 버튼 원래대로 복구 (변경 버튼 보이기)
                    $("#cmntUpdateBtn-" + cmntNo).show();
                    $("#cmntDeleteBtn-" + cmntNo).show();
                    $("#saveCmntBtn-" + cmntNo).hide();
                    $("#cancelCmntBtn-" + cmntNo).hide();
					}
					else {
						alert("댓글 수정에 실패했습니다.");
					}
				},
				error : function() {
				    alert("서버 오류 발생");
				}
        	});
		});
        
        $(".cancelCmntBtn").click(function() 
        {
        	var cmntNo = $(this).data('cmntno');
        	
        	$("#showCmntCn-" + cmntNo).show();
        	$("#inputCmntCn-" + cmntNo).hide();
        	
        	$("#cmntUpdateBtn-" + cmntNo).show();
        	$("#cmntDeleteBtn-" + cmntNo).show();
        	
        	$("#saveCmntBtn-" + cmntNo).hide();
        	$("#cancelCmntBtn-" + cmntNo).hide();
			
		});
        
        $(".insertUpCmntBtn").click(function()
        {
        	var cmntNo = $(this).data('cmntno');
          	$("#inputUpCmntCn-" + cmntNo).show().val(null);
          	
          	$("#insertUpCmntBtn-" + cmntNo).hide();
          	$("#cmntDeleteBtn-" + cmntNo).hide();
          	
          	$("#insertUpCmntBtn2-" + cmntNo).show();
          	$("#cancelUpCmntBtn-" + cmntNo).show();
          	
        });
        
        $(".insertUpCmntBtn2").click(function()
        {
        	var cmntNo = $(this).data('cmntno');
          	var cmntCn = $("#inputUpCmntCn-" + cmntNo).val();
          	var bbsSn = ${boardVo.bbsSn};
          	var userId = "${user.userId }";
          	
          	var params = new URLSearchParams();
            params.append("cmntNo", cmntNo);
            params.append("cmntCn", cmntCn);
            params.append("bbsSn", bbsSn);
            params.append("userId", userId);

            var url = "insertUpCmnt.do?" + params.toString();
            window.location.href = url;
		});
        
        $(".cancelUpCmntBtn").click(function() 
        {
        	var cmntNo = $(this).data('cmntno');
        	
        	$("#showCmntCn-" + cmntNo).show();
        	$("#insertUpCmntBtn-" + cmntNo).show();
        	$("#cmntDeleteBtn-" + cmntNo).show();
        	
        	$("#insertUpCmntBtn2-" + cmntNo).hide();
        	$("#saveUpCmntBtn-" + cmntNo).hide();
        	$("#cancelUpCmntBtn-" + cmntNo).hide();
        	$("#inputUpCmntCn-" + cmntNo).hide();
			
		});
        
        $(".cancelUpCmntBtn2").click(function() 
         {
         	var cmntNo = $(this).data('cmntno');
         	
         	$("#showCmntCn-" + cmntNo).show();
         	$("#upCmntUpdateBtn-" + cmntNo).show();
         	$("#cmntDeleteBtn-" + cmntNo).show();
         	
         	$("#insertUpCmntBtn2-" + cmntNo).hide();
         	$("#saveUpCmntBtn-" + cmntNo).hide();
         	$("#cancelUpCmntBtn2-" + cmntNo).hide();
         	$("#inputUpCmntCn-" + cmntNo).hide();
 			
 		});
        
        $(".upCmntUpdateBtn").click(function()
        {
        	var cmntNo = $(this).data('cmntno');
        	
        	$("#showCmntCn-" + cmntNo).hide();
        	$("#inputUpCmntCn-" + cmntNo).show().focus();
        	
        	$("#upCmntUpdateBtn-" + cmntNo).hide();
        	$("#cmntDeleteBtn-" + cmntNo).hide();
        	
        	$("#saveUpCmntBtn-" + cmntNo).show();
        	$("#cancelUpCmntBtn2-" + cmntNo).show();
			
		});
        
        $(".saveUpCmntBtn").click(function() 
        {
        	var cmntNo = $(this).data('cmntno');
        	var cmntCn = $("#inputUpCmntCn-" + cmntNo).val();
        	
        	$.ajax({
        		type : "POST",
        		url : "<c:url value='updateAdminComment.do'/>", 
        	    dataType: "json",
        	    data: {  
                    cmntNo: cmntNo.toString(),
                    cmntCn: cmntCn
                },
        		success : function(response) {
        			console.log("response:", response);
                    console.log("response.resultMap.status:", response.resultMap.status);
					if (response.resultMap.status == "success") {
						
        			// 입력값을 기존 내용으로 업데이트
                    $("#inputUpCmntCn-" + cmntNo).val(response.resultMap.cmntCn);
                    $("#showCmntCn-" + cmntNo).html(response.resultMap.cmntCn.replaceAll("\n", "<br/>"));
        			$("#updtDtText-" + cmntNo).text(response.resultMap.updtDt);
                    
                    // 입력 필드 숨기고 기존 내용 보이기
                    $("#inputUpCmntCn-" + cmntNo).hide();
                    $("#showCmntCn-" + cmntNo).show();

                    // 버튼 원래대로 복구 (변경 버튼 보이기)
                    $("#upCmntUpdateBtn-" + cmntNo).show();
                    $("#cmntDeleteBtn-" + cmntNo).show();
                    $("#saveUpCmntBtn-" + cmntNo).hide();
                    $("#cancelUpCmntBtn-" + cmntNo).hide();
                    $("#cancelUpCmntBtn2-" + cmntNo).hide();
					}
					else {
						alert("댓글 수정에 실패했습니다.");
					}
				},
				error : function() {
				    alert("서버 오류 발생");
				}
        	});
		});
        
        $("#fileDelete").click(function deletefile() {
       		$('#fileName').val(null);
       	});
        
        $("#cmntCn").on("input", function() {
			$("#cnLength").text($("#cmntCn").val().length + " / 4000");
		})
    });
</script>

</body>
</html>