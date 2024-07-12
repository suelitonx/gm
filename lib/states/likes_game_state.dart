//LikesGameState

import 'package:gamematch/models/like.dart';

sealed class LikesGameState {}

class EmptyLikesGameState extends LikesGameState {}

class LoadingLikesGameState extends LikesGameState {}

class LoadedLikesGameState extends LikesGameState {
  final List<Like> likes;
  LoadedLikesGameState(this.likes);
}

class ErrorLikesGameState extends LikesGameState {
  final String error;
  ErrorLikesGameState(this.error);
}
