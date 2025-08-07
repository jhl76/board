<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>Kanye West 명언 게시판</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="bg-dark text-light text-center py-5">

  <h1 class="mb-4">🎤 Kanye West 명언 게시판</h1>

  <div class="container">
    <div class="card text-dark mx-auto shadow" style="max-width: 500px;">
      <div class="card-body">
        <blockquote class="blockquote mb-0">
          <p id="kanyeQuote">Loading...</p>
          <footer class="blockquote-footer mt-2">Kanye West</footer>
        </blockquote>
      </div>
    </div>

    <button id="newQuote" class="btn btn-warning mt-4">다른 명언 보기 🔁</button>
  </div>

  <script>
    function loadKanyeQuote() {
      $.get("https://api.kanye.rest", function(data) {
        $("#kanyeQuote").text(data.quote);
      });
    }

    $(function() {
      loadKanyeQuote();
      $("#newQuote").click(loadKanyeQuote);
    });
  </script>
</body>
</html>
