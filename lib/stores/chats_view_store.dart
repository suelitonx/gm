import 'package:flutter/foundation.dart';
import 'package:gamematch/states/chats_view_state.dart';
import '../services/chats_view_service.dart';
import '../services/pocketbase_service.dart';

class ChatsViewStore extends ValueNotifier<ChatViewState> {
  ChatsViewStore() : super(EmptyChatViewState());

  final service = ChatsViewService();
  final pbService = PocketbaseService.instance;

  Future<void> getChats() async {
    value = LoadingChatViewState();

    final (r, l) = await service.getChats();

    if (r) {
      value = LoadedChatViewState(l);
    } else {
      value = ErrorChatViewState('Erro ao carregar os chats');
    }
  }
}
