class GameInfo {
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
  final String description;

  final List<dynamic> screenshots;
  final Map<String, dynamic> requeriments;

  GameInfo({
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
    this.description = '',
    this.requeriments = const {},
    this.screenshots = const [],
  });

  factory GameInfo.fromJson(Map<String, dynamic> json) {
    return GameInfo(
      id: json['id'],
      title: json['title'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      shortDescription: json['short_description'] ?? '',
      gameUrl: json['game_url'] ?? '',
      genre: json['genre'] ?? 'fps',
      platform: json['platform'] ?? 'pc',
      publisher: json['publisher'] ?? '',
      developer: json['developer'] ?? '',
      releaseDate: json['release_date'] ?? '2024-01-01',
      description: json['description'] ?? '',
      requeriments: json['minimum_system_requirements'] ??
          {
            "os": "-",
            "processor": "-",
            "memory": "-",
            "graphics": "-",
            "storage": "-",
          },
      screenshots: json['screenshots'] != null
          ? json['screenshots'].map((s) {
              if (s['image'] != null) {
                return s['image'];
              }
            }).toList()
          : [],
    );
  }

  //Data "2022-10-04" para 04-10-2022
  String get releaseDateFormatted {
    final date = releaseDate.split('-');
    return '${date[2]}/${date[1]}/${date[0]}';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'thumbnail': thumbnail,
      'short_description': shortDescription,
      'game_url': gameUrl,
      'genre': genre,
      'platform': platform,
      'publisher': publisher,
      'developer': developer,
      'release_date': releaseDate,
      'description': description,
      'minimum_system_requirements': requeriments,
      'screenshots': screenshots,
    };
  }
}
