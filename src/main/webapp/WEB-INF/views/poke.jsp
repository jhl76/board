<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>포켓몬 도감 카드</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="bg-light text-center py-5">

  <h1 class="mb-4">🎮 포켓몬 도감</h1>

  <div class="container">
    <input type="text" id="pokeInput" class="form-control w-50 mx-auto mb-3" placeholder="포켓몬 이름 or 번호 입력 (ex: pikachu, 25)">
    <button id="searchBtn" class="btn btn-success mb-4">검색 🔍</button>

    <div id="pokeCard" class="card mx-auto shadow" style="max-width: 400px; display:none;">
      <img id="pokeImg" class="card-img-top" alt="포켓몬 이미지" />
      <div class="card-body">
        <h5 id="pokeName" class="card-title"></h5>
        <p><strong>키:</strong> <span id="pokeHeight"></span> / <strong>몸무게:</strong> <span id="pokeWeight"></span></p>
        <p><strong>타입:</strong> <span id="pokeType"></span></p>
      </div>
    </div>
  </div>

  <script>
    function loadPokemon(pokeName) {
      $.get("https://pokeapi.co/api/v2/pokemon/" + pokeName.toLowerCase(), function(data) {
        $("#pokeName").text(data.name.toUpperCase());
        $("#pokeImg").attr("src", data.sprites.front_default);
        $("#pokeHeight").text(data.height / 10 + " m");
        $("#pokeWeight").text(data.weight / 10 + " kg");
        $("#pokeType").text(data.types.map(t => t.type.name).join(", "));
        $("#pokeCard").show();
      }).fail(function() {
        alert("존재하지 않는 포켓몬입니다!");
      });
    }

    $(function() {
      $("#searchBtn").click(function() {
        const name = $("#pokeInput").val().trim();
        if (name) loadPokemon(name);
      });
    });
  </script>
</body>
</html>

