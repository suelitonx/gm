//ChatViewState

import 'package:gamematch/models/chats_view_model.dart';

sealed class ChatViewState {}

class EmptyChatViewState extends ChatViewState {}

class LoadingChatViewState extends ChatViewState {}

class LoadedChatViewState extends ChatViewState {
  final List<ChatsViewModel> chats;
  LoadedChatViewState(this.chats);
}

class ErrorChatViewState extends ChatViewState {
  final String error;
  ErrorChatViewState(this.error);
}
