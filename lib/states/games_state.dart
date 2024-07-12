//GamesState
import 'package:gamematch/models/game.dart';

sealed class GamesState {}

class EmptyGamesState extends GamesState {}

class LoadingGamesState extends GamesState {}

class LoadedGamesState extends GamesState {
  final List<Game> games;
  LoadedGamesState(this.games);
}

class ErrorGamesState extends GamesState {
  final String error;
  ErrorGamesState(this.error);
}
