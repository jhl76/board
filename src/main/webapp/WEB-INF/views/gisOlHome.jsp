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
</style>
</head>
<body>

<div class="container">
  <br><br><h3>QGIS - GeoServer EPSG:5186 (OpenLayers)</h3>
  <div id="targetDiv"></div><br>

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
	
	loadLayer('umd');
	
	$('#layerSelect').on('change', function () {
	  loadLayer($(this).val());
	});
	
	$('#toggleLegend').on('click', function () {
	  $('#legendBox').toggle();
	  $(this).text($('#legendBox').is(':visible') ? '범례 닫기' : '범례 보기');
	});
	
	$('#homeBtn').on('click', function () {
	  window.location.href = 'home.do';
	});
</script>
</body>
</html>
