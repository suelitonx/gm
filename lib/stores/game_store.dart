import 'package:flutter/material.dart';
import 'package:gamematch/services/game_service.dart';
import 'package:gamematch/states/games_state.dart';
import '../services/pocketbase_service.dart';

class GameStore extends ValueNotifier<GamesState> {
  GameStore() : super(EmptyGamesState());

  final service = GameService();
  final pbService = PocketbaseService.instance;

  Future<void> getGames({bool somenteMeusJogos = false}) async {
    value = LoadingGamesState();

    try {
      final data = await service.getGames();

      List<int> jogosExcluidosDaLista = [];

      await pbService.pb.collection('jogos_likes').getFirstListItem('id="${pbService.pb.authStore.model.id}"').then((value) {
        if (value.id.isNotEmpty) {
          final l = value.data["liked_games"].split(",").map((e) => int.parse(e)).toList();
          for (var item in l) {
            jogosExcluidosDaLista.add(item);
          }
        }
      }).catchError((_) {});

      if (somenteMeusJogos == true) {
        data.removeWhere((element) => !jogosExcluidosDaLista.contains(element.id));
      } else {
        data.removeWhere((element) => jogosExcluidosDaLista.contains(element.id));
      }

      value = LoadedGamesState(data);
    } catch (e) {
      value = ErrorGamesState(e.toString());
    }
  }
}
