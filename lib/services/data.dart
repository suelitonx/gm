class Genero {
  final String original;
  final String traducao;

  Genero(this.original, this.traducao);
}

class Ordenacao {
  final String original;
  final String traducao;

  Ordenacao(this.original, this.traducao);
}

class Plataforma {
  final String original;
  final String traducao;

  Plataforma(this.original, this.traducao);
}

final List<Genero> generos = [
  Genero("mmorpg", "MMORPG"),
  Genero("mmoarpg", "MMORPG"),
  Genero("mmoarpg", "MMORPG"),
  Genero("action rpg", "RPG de Ação"),
  Genero("shooter", "Atirador"),
  Genero("strategy", "Estratégia"),
  Genero("moba", "MOBA"),
  Genero("racing", "Corrida"),
  Genero("sports", "Esportes"),
  Genero("social", "Social"),
  Genero("sandbox", "Sandbox"),
  Genero("open-world", "Mundo aberto"),
  Genero("survival", "Sobrevivência"),
  Genero("pvp", "PVP"),
  Genero("pve", "PVE"),
  Genero("pixel", "Pixel"),
  Genero("voxel", "Voxel"),
  Genero("zombie", "Zumbi"),
  Genero("turn-based", "Baseado em turnos"),
  Genero("first-person", "1ª Pessoa"),
  Genero("third-person", "3ª Pessoa"),
  Genero("top-down", "Visão de cima"),
  Genero("tank", "Tanque"),
  Genero("space", "Espaço"),
  Genero("sailing", "Navegação"),
  Genero("side-scroller", "Rolagem lateral"),
  Genero("superhero", "Super-herói"),
  Genero("permadeath", "Morte permanente"),
  Genero("card", "Cartas"),
  Genero("card game", "Cartas"),
  Genero("battle-royale", "Battle Royale"),
  Genero("battle royale", "Battle Royale"),
  Genero("mmo", "RPG Online"),
  Genero("mmofps", "FPS Online"),
  Genero("mmotps", "TPS Online"),
  Genero("3d", "3D"),
  Genero("2d", "2D"),
  Genero("anime", "Anime"),
  Genero("fantasy", "Fantasia"),
  Genero("sci-fi", "Ficção científica"),
  Genero("fighting", "Luta"),
  Genero("action-rpg", "RPG de ação"),
  Genero("action", "Ação"),
  Genero("military", "Militar"),
  Genero("martial-arts", "Artes marciais"),
  Genero("flight", "Voo"),
  Genero("low-spec", "PC da Xuxa"),
  Genero("tower-defense", "Defesa de torre"),
  Genero("horror", "Terror"),
  Genero("mmorts", "Estratégia Online"),
];

final List<Ordenacao> ordenacao = [
  Ordenacao("relevance", "Relevância"),
  Ordenacao("release-date", "Data de Lançamento"),
  Ordenacao("popularity", "Popularidade"),
  Ordenacao("alphabetical", "Ordem Alfabética"),
];

final List<Plataforma> plataformas = [
  Plataforma("all", "Todas"),
  Plataforma("pc", "PC"),
  Plataforma("browser", "Navegador"),
];

String getGenero(String genero) {
  for (var item in generos) {
    if (item.original.toLowerCase().trim() == genero.toLowerCase().trim()) {
      return item.traducao;
    }
  }
  return genero;
}

String getOrdenacao(String ordenacaoOriginal) {
  for (var item in ordenacao) {
    if (item.original.toLowerCase().trim() == ordenacaoOriginal.toLowerCase().trim()) {
      return item.traducao;
    }
  }
  return ordenacaoOriginal;
}

String getPlataforma(String plataformaOriginal) {
  for (var item in plataformas) {
    if (item.original.toLowerCase().trim() == plataformaOriginal.toLowerCase().trim()) {
      return item.traducao;
    }
  }
  return plataformaOriginal;
}
