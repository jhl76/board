<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>🐶 강아지 랜덤 사진 게시판 🐾</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="bg-light">

  <div class="container mt-5 text-center">
    <h1 class="mb-4">🐶 강아지 랜덤 사진🐾</h1>

    <div id="dogImageBox" class="mb-4">
      <img id="dogImage" src="" class="img-fluid rounded shadow" alt="멍멍이" style="max-height: 400px;">
    </div>

    <button id="reloadBtn" class="btn btn-primary">새로운 멍멍이 보기 🐕</button>
  </div>

  <script>
    function loadDogImage() {
      $.get("https://dog.ceo/api/breeds/image/random", function(data) {
        $("#dogImage").attr("src", data.message);
      });
    }

    $(function() {
      loadDogImage();
      $("#reloadBtn").click(function() {
        loadDogImage();
      });
    });
  </script>

</body>
</html>
