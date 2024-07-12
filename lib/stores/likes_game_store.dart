import 'package:flutter/foundation.dart';
import 'package:gamematch/states/likes_game_state.dart';

import '../services/like_service.dart';

class LikesGameStore extends ValueNotifier<LikesGameState> {
  LikesGameStore() : super(EmptyLikesGameState());

  final service = LikeService();

  Future<bool> likeGame({required int gameId, int type = 1}) async {
    final (r, _) = await service.likeGame(gameId: gameId, tipo: type);

    if (r == true) {
      getLikes(gameId: gameId);
    }

    return r;
  }

  Future<void> getLikes({required int gameId}) async {
    value = LoadingLikesGameState();

    final (r, l) = await service.getLikes(gameId: gameId);

    if (r == true) {
      value = LoadedLikesGameState(l);
    } else {
      value = ErrorLikesGameState('Erro ao carregar as curtidas');
    }
  }

  //Função que verifica se o usuário curtiu o jogo
  Future<bool> isLiked({required int gameID}) async {
    return await service.isLiked(gameId: gameID);
  }
}
