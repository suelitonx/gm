class Game {
  final int id;
  final String title;
  final String thumbnail;
  final String shortDescription;
  final String gameUrl;
  final String genre;
  final String platform;
  final String publisher;
  final String developer;
  final String releaseDate;

  Game({
    required this.id,
    required this.title,
    this.thumbnail = '',
    this.shortDescription = '',
    this.gameUrl = '',
    this.genre = '',
    this.platform = '',
    this.publisher = '',
    this.developer = '',
    this.releaseDate = '',
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      title: json['title'],
      thumbnail: json['thumbnail'] ?? '',
      shortDescription: json['short_description'] ?? '',
      gameUrl: json['game_url'] ?? '',
      genre: json['genre'] ?? 'fps',
      platform: json['platform'] ?? 'pc',
      publisher: json['publisher'] ?? '',
      developer: json['developer'] ?? '',
      releaseDate: json['release_date'] ?? '2024-01-01',
    );
  }

  //Pegar a data "release_date" (somente os primeiros 4 caracteres)
  String get releaseYear => releaseDate.substring(0, 4);

  //"short_description": "A free to play MMORPG set in the world of J.R.R. Tolkien's \r\nclassic fantasy saga.",
  //Pegar a descrição "short_description" (substituir \r\n e \" por espaço)
  String get description => shortDescription.replaceAll('\r\n', ' ').replaceAll('\\', '');
}
