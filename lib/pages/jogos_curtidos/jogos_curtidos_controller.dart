import 'package:flutter/foundation.dart';

import '../../stores/game_store.dart';
import '../../stores/likes_game_store.dart';

class JogosCurtidosController extends ChangeNotifier {
  final gameStore = GameStore();

  final likesGameStore = LikesGameStore();

  Future<void> getGames() async {
    await gameStore.getGames(somenteMeusJogos: true);
    notifyListeners();
  }
}
