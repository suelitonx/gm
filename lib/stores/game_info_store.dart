import 'package:flutter/material.dart';
import 'package:gamematch/states/game_info_state.dart';

import '../services/game_service.dart';

class GameInfoStore extends ValueNotifier<GameInfoState> {
  GameInfoStore() : super(EmptyGameInfoState());

  final service = GameService();

  getGameInfo(int id) async {
    value = LoadingGameInfoState();

    try {
      final data = await service.getGameInfo(id: id);
      value = LoadedGameInfoState(data);
    } catch (e) {
      value = ErrorGameInfoState(e.toString());
    }
  }
}
