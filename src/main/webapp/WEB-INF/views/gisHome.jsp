<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QGIS</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
<script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
</head>
<style>
	#map {
    position: relative;      /* ⬅️ 지도 내부에 절대배치 요소를 고정하기 위해 추가 */
    width: 100%;
    height: 700px;
  }
  .legend-toggle {
    position: absolute;
    right: 10px;
    bottom: 10px;
    z-index: 1001;           /* Leaflet 기본 컨트롤보다 살짝 높게 */
  }
  .legend-box {
    position: absolute;
    right: 10px;
    bottom: 60px;            /* 버튼 위로 살짝 띄움 */
    background: rgba(255,255,255,0.9);
    padding: 8px;
    border-radius: 6px;
    box-shadow: 0 2px 6px rgba(0,0,0,.15);
    display: none;
    z-index: 1001;
  }
  .legend-box img {
    max-width: 240px;
    display: block;
  }
</style>
<body>

	<div class="container">
	<br> <br> <h3>QGIS - GeoServer EPSG:5186 (Reflect)</h3>
	<div id="targetDiv"></div><br>
	    
	<div class="row g-3 align-items-stretch mb-3">
	  <div class="col-6 col-md-3">
	    <div class="card h-100 shadow-sm">
	      <div class="card-body d-flex align-items-center">
	        <img src="images/1.png" alt="총 인구" class="me-3 rounded-circle border" style="width: 50px; height: 50px; object-fit: cover;" />
	        <div>
	          <div class="small text-muted fw-bold"><span class="text-danger">${sido.statsYm }</span> 기준 인천시 총인구수</div>
	          <div class="h4 fw-bold mb-0" id="sumTotal"><fmt:formatNumber value="${sido.totNmprC}" pattern="#,###" /></div>
	        </div>
	      </div>
	    </div>
	  </div>
	
	  <div class="col-6 col-md-3">
	    <div class="card h-100 shadow-sm">
	      <div class="card-body d-flex align-items-center">
	        <img src="images/2.png" alt="전월인구" class="me-3 rounded-circle border" style="width: 50px; height: 50px; object-fit: cover;" />
	        <div>
	          <div class="small text-muted fw-bold">전월인구수</div>
	          <div class="h4 fw-bold mb-0" id="lsmtNmpr"><fmt:formatNumber value="${sido.lsmtNmpr}" pattern="#,###" /></div>
	        </div>
	      </div>
	    </div>
	  </div>
	
	  <div class="col-6 col-md-3">
	    <div class="card h-100 shadow-sm">
	      <div class="card-body d-flex align-items-center">
	        <img src="images/3.png" alt="전월대비" class="me-3 rounded-circle border" style="width: 50px; height: 50px; object-fit: cover;" />
	        <div>
	          <div class="small text-muted fw-bold">전월대비</div>
	          <div class="h4 fw-bold mb-0" id="totNmprL"><fmt:formatNumber value="${sido.totNmprL}" pattern="#,###" /></div>
	        </div>
	      </div>
	    </div>
	  </div>
	
	  <div class="col-6 col-md-3">
	    <div class="card h-100 shadow-sm">
	      <div class="card-body d-flex align-items-center">
	        <img src="images/4.png" alt="남녀비율" class="me-3 rounded-circle border" style="width: 50px; height: 50px; object-fit: cover;" />
	        <div>
	          <div class="small text-muted fw-bold">남녀비율</div>
	          <div class="h4 fw-bold mb-0" id="maleFeml"><fmt:formatNumber value="${sido.maleFeml}" pattern="#,###" /></div>
	        </div>
	      </div>
	    </div>
	  </div>
	
	  <div class="col-6 col-md-3">
	    <div class="card h-100 shadow-sm">
	      <div class="card-body d-flex align-items-center">
	        <img src="images/5.png" alt="남성인구" class="me-3 rounded-circle border" style="width: 50px; height: 50px; object-fit: cover;" />
	        <div>
	          <div class="small text-muted fw-bold">남성인구수</div>
	          <div class="h4 fw-bold mb-0" id="maleNmprCnt"><fmt:formatNumber value="${sido.maleNmpr}" pattern="#,###" /></div>
	        </div>
	      </div>
	    </div>
	  </div>
	
	  <div class="col-6 col-md-3">
	    <div class="card h-100 shadow-sm">
	      <div class="card-body d-flex align-items-center">
	        <img src="images/6.png" alt="여성인구" class="me-3 rounded-circle border" style="width: 50px; height: 50px; object-fit: cover;" />
	        <div>
	          <div class="small text-muted fw-bold">여성인구수</div>
	          <div class="h4 fw-bold mb-0" id="femlNmprCnt"><fmt:formatNumber value="${sido.femlNmpr}" pattern="#,###" /></div>
	        </div>
	      </div>
	    </div>
	  </div>
	
	  <div class="col-6 col-md-3">
	    <div class="card h-100 shadow-sm">
	      <div class="card-body d-flex align-items-center">
	        <img src="images/7.png" alt="세대 수" class="me-3 rounded-circle border" style="width: 50px; height: 50px; object-fit: cover;" />
	        <div>
	          <div class="small text-muted fw-bold">세대 수</div>
	          <div class="h4 fw-bold mb-0" id="hhCnt"><fmt:formatNumber value="${sido.hhCnt}" pattern="#,###" /></div>
	        </div>
	      </div>
	    </div>
	  </div>
	
	  <div class="col-6 col-md-3">
	    <div class="card h-100 shadow-sm">
	      <div class="card-body d-flex align-items-center">
	        <img src="images/8.png" alt="세대당 인구" class="me-3 rounded-circle border" style="width: 50px; height: 50px; object-fit: cover;" />
	        <div>
	          <div class="small text-muted fw-bold">세대당 인구</div>
	          <div class="h4 fw-bold mb-0" id="hhNmpr">${sido.hhNmpr}</div>
	        </div>
	      </div>
	    </div>
	  </div>
	</div>

	<br>
	<div class="mb-2 d-flex align-items-center gap-2">
		<label for="layerSelect" class="form-label mb-0">레이어 선택</label>
		<select id="layerSelect" class="form-select form-select-sm w-auto">
		  <option value="umd" selected>읍면동 인구 (UMD)</option>
		  <option value="sgg">시군구 인구 (SGG)</option>
		</select>
	</div>
     
    <div id="map">
	    <div class="legend-toggle">
	      <button id="toggleLegend" class="btn btn-primary btn-sm">범례 보기</button>
	    </div>
	
	    <div id="legendBox" class="legend-box">
	      <strong id="legendTitle">인천 군/구별 총 인구 수</strong>
	      <img id="legendImg" alt="Legend">
	    </div>
    </div>
    
   	<br>
    <div class="mb-3 d-flex justify-content-start">
	    <button type="button" class="btn btn-success" id="homeBtn">뒤로 가기</button>
	</div>
	
	<!-- 모달 영역 -->
	<div class="modal fade" id="infoModal" tabindex="-1" aria-labelledby="infoModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-scrollable modal-lg">
	    <div class="modal-content shadow-lg border-0 rounded-4">
	      <div class="modal-header bg-primary text-white rounded-top-4">
	        <h5 class="modal-title fw-bold" id="infoModalLabel">📍 선택한 위치 정보</h5>
	        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="닫기"></button>
	      </div>
	      <div class="modal-body bg-light">
	        <table class="table table-bordered table-hover align-middle bg-white shadow-sm rounded">
	          <tbody id="infoTableBody" class="table-group-divider">
	            <!-- JS로 동적 삽입 -->
	          </tbody>
	        </table>
	      </div>
	      <div class="modal-footer bg-light rounded-bottom-4">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	</div>
		
	</div>
	
	<script>
	// 지도 생성
	const map = L.map('map').setView([37.5665, 126.9780], 11);
	
	// 배경지도
	L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
	  maxZoom: 19, attribution: '© OpenStreetMap'
	}).addTo(map);
	
	// 공통 WMS 베이스 & 레이어 정의
	const WMS_BASE = 'http://10.10.232.22:8083/geoserver';
	const LAYERS = {
	  sgg: {
	    title: '인천 군/구별 총 인구 수',
	    workspace: 'INCHEON_SGG_POPP_STAT',
	    layerName: 'INCHEON_SGG_POPP_STAT:INCHEON_SGG_POPP_STAT',
	    styleName: 'INCHEON_SGG_POPP_STAT'
	  },
	  umd: {
	    title: '인천 읍/면/동별 총 인구 수',
	    workspace: 'INCHEON_UMD_POPP_STAT',
	    layerName: 'INCHEON_UMD_POPP_STAT:INCHEON_UMD_POPP_STAT',
	    styleName: 'INCHEON_UMD_POPP_STAT'
	  }
	};
	
	let wmsLayer = null;
	
	// 레이어 로더 함수
	function loadLayer(key) {
	  const cfg = LAYERS[key];
	  const wmsUrl = WMS_BASE + '/' + cfg.workspace + '/wms';
	  $("#targetDiv").html("<strong>" + wmsUrl + "</strong>");
	
	  if (wmsLayer) map.removeLayer(wmsLayer);
	
	  wmsLayer = L.tileLayer.wms(wmsUrl, {
	    layers: cfg.layerName,
	    styles: cfg.styleName,
	    format: 'image/png',
	    transparent: true,
	    version: '1.1.1',
	    tiled: true,
	    uppercase: true
	  }).addTo(map);
	  
	  // ▼ 현재 레이어 갱신
	  currentLayerKey = key;
	
	  // 범례 갱신
	  document.getElementById('legendTitle').textContent = cfg.title;
	  const legendUrl =
	    wmsUrl + '?service=WMS&request=GetLegendGraphic&format=image/png'
	    + '&layer=' + encodeURIComponent(cfg.layerName)
	    + '&style=' + encodeURIComponent(cfg.styleName)
	    + '&legend_options=' + encodeURIComponent('fontName: Open Sans;fontSize:12;forceLabels:on;dpi:150')
	    + '&_=' + Date.now();  
	  document.getElementById('legendImg').src = legendUrl;
	}  
	
	// 초기 로드: umd
	loadLayer('umd');
	
	// 셀렉트 변경 시 레이어 교체
	$('#layerSelect').on('change', function () {
	  loadLayer($(this).val());
	});
	
	// 범례 토글
	$('#toggleLegend').on('click', function () {
	  $('#legendBox').toggle();
	  $(this).text($('#legendBox').is(':visible') ? '범례 닫기' : '범례 보기');
	});
	
	// 뒤로가기
	$("#homeBtn").click(function() {
	  window.location.href = "home.do";
	});
	
	map.on('click', function (e) {
		const lat = e.latlng.lat;
		const lng = e.latlng.lng;
		
		if (currentLayerKey !== 'umd') return;
	
		$.ajax({
		  url: "getEmdInfoByPoint.do",
		  type: "POST",
		  data: { lat: lat, lng: lng },
		  success: function (data) {
		    const umd = data.resultMap.umd;
		
		    if (data.resultMap.status === "success" && umd) {
		      var html = "";
		      html += "<tr><th>시도명</th><td>" + (umd.sidoNm || "-") + "역시" + "</td></tr>";
		      html += "<tr><th>시군구명</th><td>" + (umd.sggNm || "-") + "</td></tr>";
		      html += "<tr><th>읍면동명</th><td>" + (umd.emdKorNm || "-") + "</td></tr>";
		      html += "<tr><th>총 인구수</th><td>" + (umd.totNmprC || "-") + "</td></tr>";
		      html += "<tr><th>남성 인구수</th><td>" + (umd.maleNmpr || "-") + "</td></tr>";
		      html += "<tr><th>여성 인구수</th><td>" + (umd.femlNmpr || "-") + "</td></tr>";
		      html += "<tr><th>가구 수</th><td>" + (umd.hhCnt || "-") + "</td></tr>";
		      html += "<tr><th>기준 연월</th><td>" + (umd.statsYm || "-") + "</td></tr>";
		
		      $("#infoTableBody").html(html); 
		      $("#infoModal").modal("show");
		    }
		  },
		  error: function () {
		    alert("정보를 불러오지 못했습니다.");
		  }
		});
	});
	
	</script>
	
</body>
</html>