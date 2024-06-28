import 'dart:convert';
import 'package:gamematch/services/http/http_client.dart';
import 'package:gamematch/models/game.dart';
import 'package:gamematch/models/game_info.dart';
import 'package:gamematch/models/review_view.dart';
import 'package:gamematch/services/pocketbase_service.dart';

abstract class IGameService {
  Future<List<Game>> getGames();
  Future<GameInfo> getGameInfo({required int id});
  Future<List<ReviewView>> getReviews({required int gameId});
}

class GameService implements IGameService {
  final IHttpClient _httpClient = HttpClient();

  @override
  Future<List<Game>> getGames() async {
    final response = await _httpClient.get(url: 'https://www.freetogame.com/api/games');

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((game) => Game.fromJson(game)).toList();
    } else {
      throw Exception('Erro ao carregar os jogos');
    }
  }

  @override
  Future<GameInfo> getGameInfo({required int id}) async {
    final response = await _httpClient.get(url: 'https://www.freetogame.com/api/game?id=$id');

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return GameInfo.fromJson(data);
    } else {
      print(response.toString());
      throw Exception('Erro ao carregar o jogo');
    }
  }

  @override
  Future<List<ReviewView>> getReviews({required int gameId}) async {
    List<ReviewView> reviews = [];

    final pbService = PocketbaseService.instance;

    await pbService.pb.collection('reviewsjogos').getList(filter: "jogo = '$gameId'").then((lista) {
      if (lista.items.isNotEmpty) {
        reviews.addAll(lista.items.map((r) => ReviewView.fromRM(r)).toList());
      }
    });

    return reviews;
  }
}
