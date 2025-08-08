<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QGIS - OpenLayers EPSG:5186</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/ol@7.5.2/ol.css">
<script src="https://cdn.jsdelivr.net/npm/ol@7.5.2/dist/ol.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@0.7.0"></script>
<style>
  #map {
    position: relative;
    width: 100%;
    height: 700px;
  }
  .legend-toggle {
    position: absolute;
    right: 10px;
    bottom: 10px;
    z-index: 1001;
  }
  .legend-box {
    position: absolute;
    right: 10px;
    bottom: 60px;
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
  body {
      padding: 40px;
      font-family: 'Segoe UI', sans-serif;
    }
    .chart-container {
      width: 600px;
      margin: 0 auto;
    }
    .layer-tree {
  width: 100%;
  max-width: 320px;
  background:#fff;
  border:1px solid #e5e7eb;
  border-radius:10px;
  box-shadow:0 1px 3px rgba(0,0,0,.06);
  padding:10px 12px;
}
.layer-tree__title{
  font-weight:800; color:#374151; margin-bottom:8px;
}
.layer-tree details{ margin: 4px 0; }
.layer-tree summary{
  cursor:pointer; list-style:none; padding:6px 8px; border-radius:8px;
  font-weight:700; color:#334155;
}
.layer-tree summary::-webkit-details-marker{ display:none; }
.layer-tree summary:before{
  content:"▸"; display:inline-block; margin-right:6px; transition: transform .2s;
}
.layer-tree details[open] > summary:before{ transform: rotate(90deg); }

.layer-tree ul{ margin:4px 0 6px 10px; padding-left:14px; border-left:1px dashed #d1d5db; }
.layer-tree li{ list-style:none; padding:6px 0 6px 8px; position:relative; }
.layer-tree li::before{
  content:""; position:absolute; left:-14px; top:18px; width:14px; height:1px; background:#d1d5db;
}
.layer-tree label{
  display:flex; align-items:center; gap:8px;
  font-size:.95rem; color:#374151; cursor:pointer;
}
.layer-tree input[type="radio"]{ accent-color:#2563eb; }

.visually-hidden{
  position:absolute !important; width:1px; height:1px; padding:0; margin:-1px;
  overflow:hidden; clip:rect(0,0,0,0); border:0;
}
</style>
</head>
<body>

<div class="container">
  <br><br><h3>QGIS - GeoServer EPSG:5186 (OpenLayers)</h3>
  <div id="targetDiv"></div><br><br>
  
  <div class="form-control">
  <div class="chart-container ">
    <h3 class="text-center">📊 군구별 총 인구 비율</h3><br>
    <canvas id="sggPieChart" width="600" height="600"></canvas>
  </div>
  </div>
  <br><br>
  
  <div class="form-control">
  <h3 class="text-left">📊 인천광역시 인구 통계</h3>
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
	<h3 class="text-left">📊 <span id="sggTitle" class="text-danger"></span> 인구 통계</h3>

	<div class="row g-3 align-items-stretch mb-3" id="sggCards">
	  <div class="col-6 col-md-3">
	    <div class="card h-100 shadow-sm">
	      <div class="card-body d-flex align-items-center">
	        <img src="images/1.png" class="me-3 rounded-circle border" style="width:50px;height:50px;object-fit:cover;" />
	        <div>
	          <div class="small text-muted fw-bold">기준 총인구수</div>
	          <div class="h4 fw-bold mb-0" id="sggSumTotal">-</div>
	        </div>
	      </div>
	    </div>
	  </div>
	
	  <!-- 전월인구 -->
	  <div class="col-6 col-md-3">
	    <div class="card h-100 shadow-sm">
	      <div class="card-body d-flex align-items-center">
	        <img src="images/2.png" class="me-3 rounded-circle border" style="width:50px;height:50px;object-fit:cover;" />
	        <div>
	          <div class="small text-muted fw-bold">전월인구수</div>
	          <div class="h4 fw-bold mb-0" id="sggLsmtNmpr">-</div>
	        </div>
	      </div>
	    </div>
	  </div>
	
	  <!-- 전월대비 -->
	  <div class="col-6 col-md-3">
	    <div class="card h-100 shadow-sm">
	      <div class="card-body d-flex align-items-center">
	        <img src="images/3.png" class="me-3 rounded-circle border" style="width:50px;height:50px;object-fit:cover;" />
	        <div>
	          <div class="small text-muted fw-bold">전월대비</div>
	          <div class="h4 fw-bold mb-0" id="sggTotNmprL">-</div>
	        </div>
	      </div>
	    </div>
	  </div>
	
	  <!-- 남녀비율 -->
	  <div class="col-6 col-md-3">
	    <div class="card h-100 shadow-sm">
	      <div class="card-body d-flex align-items-center">
	        <img src="images/4.png" class="me-3 rounded-circle border" style="width:50px;height:50px;object-fit:cover;" />
	        <div>
	          <div class="small text-muted fw-bold">남녀비율</div>
	          <div class="h4 fw-bold mb-0" id="sggMaleFeml">-</div>
	        </div>
	      </div>
	    </div>
	  </div>
	
	  <!-- 남성/여성/세대/세대당 -->
	  <div class="col-6 col-md-3"><div class="card h-100 shadow-sm"><div class="card-body d-flex align-items-center">
	    <img src="images/5.png" class="me-3 rounded-circle border" style="width:50px;height:50px;object-fit:cover;" />
	    <div><div class="small text-muted fw-bold">남성인구수</div><div class="h4 fw-bold mb-0" id="sggMaleNmprCnt">-</div></div>
	  </div></div></div>
	
	  <div class="col-6 col-md-3"><div class="card h-100 shadow-sm"><div class="card-body d-flex align-items-center">
	    <img src="images/6.png" class="me-3 rounded-circle border" style="width:50px;height:50px;object-fit:cover;" />
	    <div><div class="small text-muted fw-bold">여성인구수</div><div class="h4 fw-bold mb-0" id="sggFemlNmprCnt">-</div></div>
	  </div></div></div>
	
	  <div class="col-6 col-md-3"><div class="card h-100 shadow-sm"><div class="card-body d-flex align-items-center">
	    <img src="images/7.png" class="me-3 rounded-circle border" style="width:50px;height:50px;object-fit:cover;" />
	    <div><div class="small text-muted fw-bold">세대 수</div><div class="h4 fw-bold mb-0" id="sggHhCnt">-</div></div>
	  </div></div></div>
	
	  <div class="col-6 col-md-3"><div class="card h-100 shadow-sm"><div class="card-body d-flex align-items-center">
	    <img src="images/8.png" class="me-3 rounded-circle border" style="width:50px;height:50px;object-fit:cover;" />
	    <div><div class="small text-muted fw-bold">세대당 인구</div><div class="h4 fw-bold mb-0" id="sggHhNmpr">-</div></div>
	  </div></div></div>
	</div>
	
	<div id="sggStatsError" class="text-danger d-none small mt-2"></div>
	  
  </div>

  <br>

    <!-- 트리형 레이어 선택 -->
	<div class="layer-tree mb-2">
	  <div class="layer-tree__title">레이어 선택</div>
	
	<details open>
	  <summary>인구 통계</summary>
	  <ul>
	    <li>
	      <details>
	        <summary>시/군/구 (SGG)</summary>
	        <ul>
	          <li>
	            <label>
	              <input type="radio" name="layerTree" value="sgg" checked> 전체
	            </label>
	          </li>
	          <ul>
	          <c:forEach var="sgg" items="${sggList}">
	            <li>
	              <label>
	                <input type="radio" name="layerTree" value="sgg_${sgg.sggNm}">
	                ${sgg.sggNm}
	              </label>
	            </li>
	          </c:forEach>
	          </ul>
	        </ul>
	      </details>
	    </li>
	    <li>
	      <details id="umdGroup">
	        <summary>읍/면/동 (UMD)</summary>
	        <ul>
	          <li>
	            <label>
	              <input type="radio" name="layerTree" value="umd"> 전체
	            </label>
	          </li>
	          <!-- 읍면동 상세 목록은 필요 시 여기에 추가 -->
	          <span id="umdLoading" class="text-muted small" style="display:none; padding-left:8px;">불러오는 중…</span>
         	  <ul id="umdItems"></ul>
	        </ul>
	      </details>
	    </li>
	  </ul>
	</details>

	
	  <!-- 기존 JS 호환용: 숨겨둔 select (값은 그대로 유지) -->
	  <select id="layerSelect" class="visually-hidden">
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

	const map = new ol.Map({
	    target: 'map',
	    layers: [
	      new ol.layer.Tile({
	        source: new ol.source.OSM()
	      })
	    ],
	    view: new ol.View({
	      center: ol.proj.fromLonLat([126.9780, 37.5665]),
	      zoom: 11
	    })
	  });
	
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
	
	let currentLayerKey = 'umd';
	let wmsLayer;
	
	function loadLayer(key) {
	  const cfg = LAYERS[key];
	  const wmsUrl = WMS_BASE + '/' + cfg.workspace + '/wms';
	  $("#targetDiv").html("<strong>" + wmsUrl + "</strong>");
	
	  if (wmsLayer) map.removeLayer(wmsLayer);
	
	  wmsLayer = new ol.layer.Image({
	    source: new ol.source.ImageWMS({
	      url: wmsUrl,
	      params: {
	        'LAYERS': cfg.layerName,
	        'STYLES': cfg.styleName,
	        'FORMAT': 'image/png',
	        'TRANSPARENT': true,
	        'VERSION': '1.1.1'
	      },
	      ratio: 1,
	      serverType: 'geoserver'
	    })
	  });
	
	  map.addLayer(wmsLayer);
	  currentLayerKey = key;
	
	  try {
	    const legendUrl = wmsUrl +
	      '?service=WMS&request=GetLegendGraphic&format=image/png' +
	      '&layer=' + encodeURIComponent(cfg.layerName) +
	      '&style=' + encodeURIComponent(cfg.styleName) +
	      '&legend_options=' + encodeURIComponent('fontName:Open Sans;fontSize:12;forceLabels:on;dpi:150') +
	      '&_=' + Date.now();
	
	    document.getElementById('legendTitle').textContent = cfg.title;
	    document.getElementById('legendImg').src = legendUrl;
	  } catch (e) {
	    console.error('범례 URL 생성 오류:', e);
	  }
	}
	
	// 초기 로드: umd
	loadLayer('sgg');
	
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
	$('#homeBtn').on('click', function () {
	  window.location.href = 'home.do';
	});
	
    function fmt(n){ if(n==null || n==='') return '-'; return Number(n).toLocaleString(); }

    function renderSggStats(s) {
      // 타이틀
      if (s.sggNm) $('#sggTitle').text(s.sggNm);
      // 카드 값
      $('#sggSumTotal').text(fmt(s.totNmprC));
      $('#sggLsmtNmpr').text(fmt(s.lsmtNmpr));
      $('#sggTotNmprL').text(s.totNmprL ?? '-');     // 비율/증감률이면 그대로
      $('#sggMaleFeml').text(s.maleFeml ?? '-');      // 남/녀 비율 표기
      $('#sggMaleNmprCnt').text(fmt(s.maleNmpr));
      $('#sggFemlNmprCnt').text(fmt(s.femlNmpr));
      $('#sggHhCnt').text(fmt(s.hhCnt));
      $('#sggHhNmpr').text(s.hhNmpr ?? '-');
    }
	
	$(document).on('change', 'input[name="layerTree"]', function () {
		  const v = this.value;

		  // UMD 전체
		  if (v == 'umd') {
		    $('#layerSelect').val('umd').trigger('change');
		    return;
		  }
	
		  // 특정 UMD
		  if (v.indexOf('umd_') == 0) {
			const sggNm = v.substring(4);
		  }

		  // SGG 전체
		  if (v == 'sgg') {
		    $('#layerSelect').val('sgg').trigger('change');
		    $('#umdItems').empty();
		    return;
		  }

		  // 특정 SGG (예: sgg_연수구)
		  if (v.indexOf('sgg_') === 0) {
		    const sggNm = v.substring(4);
		    $('#layerSelect').val('sgg').trigger('change');

		    $('#umdLoading').show();
		    $('#umdItems').empty();

		    $.ajax({
		      url: 'getUmdListBySgg.do',
		      type: 'GET',
		      dataType: 'json',
		      data: { sggNm: sggNm },
		      success: function (data) {
		        const rm = data && data.resultMap ? data.resultMap : {};
		        if (rm.status !== 'success' || !Array.isArray(rm.getUmdListBySgg)) {
		          $('#umdItems').html('<li class="text-danger small">데이터가 없습니다.</li>');
		          return;
		        }
		        const html = rm.getUmdListBySgg.map(function (emd) {
		          const safe = String(emd || '').trim();
		          if (!safe) return '';
		          return (
		            '<li><label>' +
		              '<input type="radio" name="layerTree" value="umd_' + safe + '">' +
		              safe +
		            '</label></li>'
		          );
		        }).join('');
		        $('#umdItems').html(html);
		        $('#umdGroup').attr('open', true)[0]
		          .scrollIntoView({ behavior: 'smooth', block: 'nearest' });
		      },
		      error: function () {
		        $('#umdItems').html('<li class="text-danger small" style="padding-left:8px;">읍/면/동 목록을 불러오지 못했습니다.</li>');
		      },
		      complete: function () {
		        $('#umdLoading').hide();
		      }
		    }); // ← $.ajax 닫기
		    
		    $.ajax({
		        url: 'getSggStats.do',
		        type: 'GET',
		        dataType: 'json',
		        data: { sggNm },
		        success: function (res) {
		            const rm = res && res.resultMap ? res.resultMap : {};
		            if (rm.status !== 'success' || !rm.sgg) {
		              $('#sggStatsError').removeClass('d-none').text('시군구 통계를 불러오지 못했습니다.');
		              return;
		            }
		            $('#sggStatsError').addClass('d-none').text('');
		            renderSggStats(rm.sgg);
		          },
		        error: function () {
		          $('#sggStatsError').removeClass('d-none').text('시군구 통계를 불러오지 못했습니다.');
		        }
		      });
		    
		  } // ← if (v.startsWith('sgg_')) 닫기
		  
		  if (v === 'sgg') {
		    $('#layerSelect').val('sgg').trigger('change');
		    $('#umdItems').empty();
		    return;
		  }
		  
		}); // ← change 핸들러 닫기
	
	
	map.on('singleclick', function (evt) {
	    const coordinate = evt.coordinate;
	    const [lng, lat] = ol.proj.toLonLat(coordinate);  // EPSG:3857 → EPSG:4326 변환

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
	
	const gunguData = [
	    <c:forEach var="item" items="${gungu}" varStatus="status">
	      { name: "${item.sggNm}", value: ${item.totNmprC} }<c:if test="${!status.last}">,</c:if>
	    </c:forEach>
	  ];

	  const sggLabels = gunguData.map(item => item.name);
	  const sggData = gunguData.map(item => item.value);

	  const ctx = document.getElementById('sggPieChart').getContext('2d');

	  const sggPieChart = new Chart(ctx, {
		  type: 'pie',
		  data: {
		    labels: sggLabels,
		    datasets: [{
		      data: sggData,
		      backgroundColor: [
		        '#f39c12', '#f1c40f', '#2ecc71', '#e74c3c', '#9b59b6',
		        '#3498db', '#1abc9c', '#34495e', '#e67e22', '#95a5a6'
		      ]
		    }]
		  },
		  options: {
		    responsive: true,
		    plugins: {
		      datalabels: {
		        formatter: function(value, context) {
		          const total = context.chart.data.datasets[0].data.reduce((a, b) => a + b, 0);
		          const percentage = (value / total * 100).toFixed(1);
		          return context.chart.data.labels[context.dataIndex] + '\n' + percentage + '%';
		        },
		        color: '#000',
		        font: {
		          weight: 'bold',
		          size: 12
		        }
		      },
		      legend: {
		        display: true,
		        position: 'right'
		      },
		      title: {
		        display: true,
		        text: '군구별 총 인구 비율'
		      }
		    }
		  },
		  plugins: [ChartDataLabels] 
		});
	  
</script>
</body>
</html>
