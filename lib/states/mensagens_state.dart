//MensagensState

import 'package:gamematch/models/mensagem_model.dart';

sealed class MensagensState {}

class EmptyMensagensState extends MensagensState {}

class LoadingMensagensState extends MensagensState {}

class LoadedMensagensState extends MensagensState {
  final List<MensagemModel> mensagens;
  LoadedMensagensState(this.mensagens);
}

class ErrorMensagensState extends MensagensState {
  final String error;
  ErrorMensagensState(this.error);
}
