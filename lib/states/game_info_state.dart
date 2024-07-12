//GameInfoState
import 'package:gamematch/models/game_info.dart';

sealed class GameInfoState {}

class EmptyGameInfoState extends GameInfoState {}

class LoadingGameInfoState extends GameInfoState {}

class LoadedGameInfoState extends GameInfoState {
  final GameInfo currentGame;
  LoadedGameInfoState(this.currentGame);
}

class ErrorGameInfoState extends GameInfoState {
  final String error;
  ErrorGameInfoState(this.error);
}
