import 'package:flutter/material.dart';
import 'package:gamematch/models/game_info.dart';

import '../services/game_service.dart';

class GameInfoStore {
  final service = GameService();

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<String> error = ValueNotifier<String>('');

  final ValueNotifier<GameInfo> currentGame = ValueNotifier<GameInfo>(GameInfo(id: -1, title: ''));

  getGameInfo(int id) async {
    isLoading.value = true;

    try {
      final data = await service.getGameInfo(id: id);
      currentGame.value = data;

      //print(data.screenshots);
      //print(data.requeriments);
    } catch (e) {
      error.value = 'Erro ao carregar o jogo';
    }

    isLoading.value = false;
  }
}
