import 'package:gamematch/models/chats_view_model.dart';

import 'pocketbase_service.dart';

class ChatsViewService {
  final pbService = PocketbaseService.instance;

  Future<(bool r, List<ChatsViewModel>)> getChats() async {
    List<ChatsViewModel> chats = [];
    bool r = false;

    await pbService.pb.collection('msgview').getList().then((lista) {
      r = true;
      if (lista.items.isNotEmpty) {
        chats = lista.items.map((r) => rmToChatsViewModel(r)).toList();
      }
    }).catchError((e) {
      r = false;
    });

    return (r, chats);
  }
}
