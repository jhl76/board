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

<style type="text/css">
.trRow:hover {
    background-color: #c8e0fd !important; 
    cursor: pointer; /* 손가락 모양 커서 */
}
a:hover{
	text-decoration: underline !important;
	}
#title:hover{
	font-style: oblique;
	color: maroon;
}
.card {
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    will-change: transform;
}

.card:hover {
    transform: translateY(-20px); /* 위로 5px 떠오름 */
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
}
.slider-container {
	overflow: hidden;
	width: 100%;
	background-color: #f8f9fa;
	padding: 10px 0;
	border-radius: 12px;
}

.slider-track {
	display: flex;
	width: calc(200px * 12); /* 이미지 개수에 따라 조정 */
	animation: scroll 35s linear infinite;
}

.slide-img {
	width: 200px;
	height: auto;
	margin: 0 20px;
	flex-shrink: 0;
	border-radius: 10px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
}

@keyframes scroll {
	0% { transform: translateX(0); }
	100% { transform: translateX(-50%); }
}
.btn-map{
  width:48px; height:48px;
  border:none; background:#fff;
  display:inline-flex; align-items:center; justify-content:center;
  transition:transform .15s ease, box-shadow .15s ease;
}
.btn-map img{
  width:22px; height:22px; 
  opacity:.9; transition:opacity .15s ease;
}
.btn-map:hover{
  transform:translateY(-1px);
  box-shadow:0 .35rem .8rem rgba(0,0,0,.12);
}
.btn-map:hover img{ opacity:1; }
.btn-map:focus{ outline:none; box-shadow:0 0 0 .2rem rgba(13,110,253,.25); }
</style>

</head>

<body>

<div class="container">
	<div class="text-center">
	
	<div class="container-fluid bg-white rounded shadow-sm p-4 mb-4 text-center">
	  <br>
	  <!-- 타이틀 -->
	  <h2 class="fw-bold text-primary mb-2">📘 BOARD</h2>
	
	  <!-- 사용자 환영 메시지 -->
	  <div class="mb-1">
	    <span class="text-success fw-semibold">${user.userId}</span>님 반갑습니다.
	  </div>
	
	  <!-- 역할 표시 -->
	  <div class="mb-3 small">
	    <c:choose>
	      <c:when test="${user.authrtCd == '1'}">
	        (ROLE: <span class="text-success fw-bold">사용자</span>)
	      </c:when>
	      <c:when test="${user.authrtCd == '2'}">
	        (ROLE: <span class="text-success fw-bold">관리자</span>)
	      </c:when>
	    </c:choose>
	  </div>
	
	  <!-- 경로 표시 -->
	  <nav aria-label="breadcrumb" class="d-flex justify-content-left">
	    <ol class="breadcrumb bg-transparent m-0">
	      <li class="breadcrumb-item active" aria-current="page">
	        <a href="home.do" class="text-decoration-none text-primary">공지 게시판 / </a>
	      </li>
	    </ol>
	  </nav>
	
	</div>
		
	<div class="text-end">
		<span class="text-danger">GIS Reflect 실습 하러가기 →</span>
		<button id="gisBtn" type="button" class="btn-map rounded-circle shadow-sm"
		        aria-label="지도 열기" title="지도 열기">
		  <img src="images/free-icon-map-locator-4904251.png" alt="" />
		</button>
		<span class="text-danger">GIS OpenLayer 실습 하러가기 →</span>
		<button id="gisOlBtn" type="button" class="btn-map rounded-circle shadow-sm"
		        aria-label="지도 열기" title="지도 열기">
		  <img src="images/google-maps.png" alt="" />
		</button>
		<button id="logoutBtn" type="button" class="btn-map rounded-circle shadow-sm"
		title="로그아웃"><img src="images/shutdown.png"></button>
	</div>
		
	</div>
   	
	<nav class="navbar bg-body-tertiary">
		<div class="container-fluid my-4 p-4 bg-light rounded shadow-sm">
		  <div class="mb-3">
		    <span class="text-success fw-bold" style="font-size: 1.75rem;">📋 게시판 검색</span>
		  </div>
		
		  <form class="row row-cols-lg-auto g-3 align-items-center" method="GET" action="home.do">
		    <div class="col-12">
		      <select class="form-select" id="searchBy" name="searchBy" aria-label="검색 항목 선택">
		        <option value="">🔍 검색항목 선택</option>
		        <option value="bbsTtl">제목</option>
		        <option value="userId">사용자ID</option>
		      </select>
		    </div>
		
		    <div class="col-12">
		      <input type="search" class="form-control" id="searchCn" name="searchCn"
		             placeholder="검색 내용을 입력하세요" aria-label="검색 내용"
		             value="${searchCn}">
		    </div>
		
		    <div class="col-12">
		      <button class="btn btn-outline-success d-flex align-items-center px-3 py-2" type="submit">
		        <img src="images/search1.png" alt="검색" width="20" height="20" class="me-2">
		        검색
		      </button>
		    </div>
		  </form>
		</div>
		
		<c:if test="${searchBy == null or searchCn == null }">
			<div>
				<span class="text-dark">전체 게시물 수 : ${boardCount }</span>
			</div>
		</c:if>
		<c:if test="${searchBy != null and searchCn != null }">
			<div>
				<span class="text-dark">전체 게시물 수 : ${searchBoardCount }</span>
			</div>
		</c:if>
		<div class="text-end mt-3">
			<select class="form-select me-2" id="pageLimit" name="pageLimit">
				<option value="10" ${pageLimit == 10 ? 'selected' : ''}>10개씩 보기</option>
				<option value="30" ${pageLimit == 30 ? 'selected' : ''}>30개씩 보기</option>
				<option value="50" ${pageLimit == 50 ? 'selected' : ''}>50개씩 보기</option>
			</select>
		</div>
	</nav>
	<div class="mt-3 d-flex justify-content-end">
	  <select class="form-select w-auto" id="filter" name="filter">
	    <option value="fast" ${filter == 'fast' ? 'selected' : '' }>최신순</option>
	    <option value="last"  ${filter == 'last' ? 'selected' : '' }>오래된순</option>
	    <option value="popular"  ${filter == 'popular' ? 'selected' : '' }>인기순</option>
	  </select>
	</div>
    
    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4 mt-3">
	    <c:forEach var="dto" items="${boardList}">
	        <div class="col">
	            <div class="card h-100 trRow" data-bbssn="${dto.bbsSn}" style="cursor: pointer;">
	                <div class="card-body">
	                    <h5 class="card-title" title="${dto.bbsTtl}">
	                        <c:choose>
	                            <c:when test="${fn:length(dto.bbsTtl) > 30}">
	                                <span style="color: #4487fd; font-size: 18pt;">${fn:substring(dto.bbsTtl, 0, 30)}&hellip;</span>
	                            </c:when>
	                            <c:otherwise>
	                                <span style="color: #4487fd; font-size: 18pt;">${dto.bbsTtl}</span>
	                            </c:otherwise>
	                        </c:choose>
	                        <c:if test="${dto.cmntCount > 0}">
	                            <span class="badge bg-danger">${dto.cmntCount}</span>
	                        </c:if>
	                        <c:if test="${not empty dto.fileNm}">
	                            <img src="images/photo.png" class="float-end" style="width: 25px;" />
	                        </c:if>
	                    </h5>
	                    <p class="card-text mb-1">
	                        <strong>ID:</strong> <span style="color: #0d3153">${dto.userId}</span>
	                    </p>
	                    <p class="card-text mb-1">
	                        <strong>작성일시:</strong> <span style="color: #0d3153">${dto.wrtDt}</span>
	                    </p>
	                    <p class="card-text mb-0">
	                        <strong>조회수:</strong> <span style="color: #0d3153">${dto.bbsInqCnt}</span>
	                    </p>
	                </div>
	            </div>
	        </div>
	    </c:forEach>
	</div>
    
    
    <c:choose>
            	<c:when test="${empty boardList }">
            		<div class="text-center"><span class="text-danger">※ 해당 검색 결과가 존재하지 않습니다.</span></div>
            	</c:when>
    </c:choose>
    
    <div class="text-end">
    	<c:choose>
			<c:when test="${user.authrtCd == '2'}">
		        <button id="registerBtn" class="btn btn-primary">등록</button>
			</c:when>
    	</c:choose>
    </div>
    
	<nav aria-label="Page navigation">
		<ul class="pagination justify-content-center">
		<c:choose>
			<c:when test="${paging.page <= 1 }">
				<li class="page-item disabled">
					<a class="page-link"  aria-label="Previous">
					    <span aria-hidden="true">&laquo;</span>
					</a>
				</li>
			</c:when>
			<c:otherwise>
				<li class="page-item">
					<a class="page-link" 
					href="home.do?page=${paging.page - 1 }
					&searchBy=${searchBy}&searchCn=${searchCn}
					&pageLimit=${pageLimit}&filter=${filter}" aria-label="Previous">
					    <span aria-hidden="true">&laquo;</span>
					</a>
				</li>
			</c:otherwise>
		</c:choose>
		
		<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="i" step="1">
			<c:choose>
				<c:when test="${paging.page == i }">
					<li class="page-item disabled">
						<span class="page-link">${i }</span>
					</li>
				</c:when>
				<c:otherwise>
					<li class="page-item">
						<a class="page-link" 
						href="home.do?page=${i }
						&searchBy=${searchBy}&searchCn=${searchCn}
						&pageLimit=${pageLimit}&filter=${filter}"><span>${i }</span></a>
					</li>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<c:choose>
			<c:when test="${paging.page >= paging.maxPage }">
				<li class="page-item disabled">
					<a class="page-link" aria-label="Next">
					    <span aria-hidden="true">&raquo;</span>
					</a>
				</li>
			</c:when>
			<c:otherwise>
				<li class="page-item">
					<a class="page-link"
					 href="home.do?page=${paging.page + 1 }
					 &searchBy=${searchBy}&searchCn=${searchCn}
					 &pageLimit=${pageLimit}&filter=${filter}" aria-label="Next">
					    <span aria-hidden="true">&raquo;</span>
					</a>
				</li>
			</c:otherwise>
		</c:choose>
		
		</ul>
	</nav>
	
	<br><br><br><br><br><br><br><br><br>
	<div class="form-control">
		<span>tech stack</span>
		
		<div class="slider-container">
			<div class="slider-track">
				<img src="images/html.png" class="slide-img">
				<img src="images/css-3.png" class="slide-img">
				<img src="images/js.png" class="slide-img">
				<img src="images/java.png" class="slide-img">
				<img src="images/spring.png" class="slide-img">
				<img src="images/postgre.png" class="slide-img">
				
				<!-- 반복 이미지로 이어붙이기 (무한 루프 효과) -->
				<img src="images/html.png" class="slide-img">
				<img src="images/css-3.png" class="slide-img">
				<img src="images/js.png" class="slide-img">
				<img src="images/java.png" class="slide-img">
				<img src="images/spring.png" class="slide-img">
				<img src="images/postgre.png" class="slide-img">
			</div>
		</div>
	</div>

	
</div>

<script type="text/javascript">
    $(document).ready(function()
    {
        $("#registerBtn").click(function()
        {
            window.location.href = "adminBoardInsertPage.do"; 
        });
        
        $("#logoutBtn").click(function()
        {
        	window.location.href = "logout.do"; 
		});
        
        $("#gisBtn").click(function()
        {
        	window.location.href = "gisHome.do"; 
		});
        
        $("#gisOlBtn").click(function()
        {
        	window.location.href = "gisOlHome.do"; 
		});
        
        $(".trRow").click(function() 
        {
        	var bbsSn = $(this).data("bbssn"); 
        	window.location.href = "boardDetailPage.do?bbsSn=" +bbsSn; 
		});
        
        $("#pageLimit").on("change", function() {
        	var pageLimit = $(this).val();
            var searchBy = $("#searchBy").val();
            var searchCn = $("#searchCn").val();
			var filter = $("#filter").val();
			
            // URL에 필요한 파라미터 조합
           var url = "home.do?pageLimit=" + pageLimit 
          					+ "&searchBy=" + searchBy
          					+ "&searchCn=" + searchCn
          					+ "&filter="+filter;

            window.location.href = url;
        });
        
        $("#filter").on("change", function() {
			var filter = $(this).val();
			var searchBy = $("#searchBy").val();
            var searchCn = $("#searchCn").val(); 
			var url = "home.do?filter="+filter+"&searchBy="+searchBy+"&searchCn="+searchCn;
			window.location.href = url;
		});
    });
</script>

</body>
</html>