import 'package:flutter/material.dart';
import 'package:gamematch/models/review_view.dart';
import 'package:gamematch/services/game_service.dart';
import '../models/game.dart';

class GameStore {
  final service = GameService();

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<Game>> games = ValueNotifier<List<Game>>([]);

  final ValueNotifier<String> error = ValueNotifier<String>('');

  final ValueNotifier<List<ReviewView>> reviews = ValueNotifier<List<ReviewView>>([]);

  getGames() async {
    isLoading.value = true;

    try {
      final data = await service.getGames();
      games.value = data;
    } catch (e) {
      error.value = 'Erro ao carregar os jogos';
    }

    isLoading.value = false;
  }

  Future<void> getReviews(int gameId) async {
    reviews.value = await service.getReviews(gameId: gameId);
    print(reviews.value.length);
  }
}
