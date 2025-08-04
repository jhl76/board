<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>rOne</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
</head>
<body>
<div id="barChart" style="min-width:300px;height:400px;margin:0 auto;"></div>
<div id="pieChart" style="min-width:300px;height:400px;margin:0 auto;"></div>

<table style="border: 2px solid gray; width: 700px; text-align: center;">
	<colgroup>
		<col width="30%">
		<col width="40%">
		<col width="30%">
	</colgroup>
	<thead>
		<tr>
			<th style="border: 2px solid gray; text-align: center;">ITM_ID</th>
			<th style="border: 2px solid gray; text-align: center;">항목명</th>
			<th style="border: 2px solid gray; text-align: center;">지수값</th>
		</tr>
	</thead>
	<tbody id="grid"></tbody>
</table>

<script type="text/javascript">
	$.ajax({
		url : 'proxy.do', 
		type: 'GET',
		dataType: 'text',
		success: function (responseText) {
			let response;
			try {
				response = JSON.parse(responseText);
			} catch (e) {
				console.error("1차 파싱 오류", e);
				return;
			}

			let rawData = response.resultMap?.data;
			if (!rawData) {
				console.error("resultMap 또는 data 없음", response);
				return;
			}

			let parsedData;
			try {
				parsedData = typeof rawData === 'string' ? JSON.parse(rawData) : rawData;
			} catch (e) {
				console.error("2차 파싱 오류", e);
				return;
			}

			console.log("최종 파싱된 데이터", parsedData);
			drawGrid(parsedData);
			drawBarChart(parsedData);
			drawPieChart(parsedData);
		},
		error: function (result) {}
	});

	function drawBarChart(jsonData) {
	    const rows = jsonData.SttsApiTblData[1].row;
	    if (!rows) return;

	    const dataArray = rows.map(row => [
	        row.CLS_FULLNM || row.CLS_NM || '항목없음',
	        parseFloat(row.DTA_VAL) || 0
	    ]);

	    Highcharts.chart('barChart', {
	        chart: { type: 'column' },
	        title: { text: '지역별 수치' },
	        xAxis: { type: 'category' },
	        yAxis: {
	            title: { text: '값' }
	        },
	        series: [{
	            name: '데이터 값',
	            data: dataArray
	        }]
	    });
	}

	function drawPieChart(jsonData) {
	    const rows = jsonData.SttsApiTblData[1].row;
	    if (!rows) return;

	    const dataArray = rows.map(row => ({
	        name: row.CLS_FULLNM || row.CLS_NM || '항목없음',
	        y: parseFloat(row.DTA_VAL) || 0
	    }));

	    Highcharts.chart('pieChart', {
	        chart: { type: 'pie' },
	        title: { text: '지역별 비율' },
	        tooltip: {
	            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
	        },
	        series: [{
	            name: '비율',
	            colorByPoint: true,
	            data: dataArray
	        }]
	    });
	}

	function drawGrid(jsonData) {
		var rows = jsonData.SttsApiTblData[1].row;
	    if (rows) {
	        var html = '';
	        $.each(rows, function(idx, row) {
	            html += '<tr>';
	            html += '<td style="border: 2px solid gray;">' + row.ITM_ID + '</td>';
	            html += '<td style="border: 2px solid gray;">' + (row.CLS_NM || row.ITM_NM) + '</td>';
	            html += '<td style="border: 2px solid gray;">' + row.DTA_VAL + '</td>';
	            html += '</tr>';
	        });
	        $('#grid').html(html);
	    } else {
	        console.error("❌ rows가 없습니다. 실제 구조:", jsonData);
	    }
	}
</script>
</body>
</html>
