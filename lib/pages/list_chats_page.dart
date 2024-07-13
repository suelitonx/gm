import 'package:flutter/material.dart';
import 'package:gamematch/pages/chat_page.dart';
import 'package:gamematch/states/chats_view_state.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/pocketbase_service.dart';
import '../stores/chats_view_store.dart';

class ListChatsPage extends StatefulWidget {
  const ListChatsPage({super.key});

  @override
  State<ListChatsPage> createState() => _ListChatsPageState();
}

class _ListChatsPageState extends State<ListChatsPage> {
  final store = ChatsViewStore();
  final pbService = PocketbaseService.instance;

  @override
  void initState() {
    store.getChats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats", style: GoogleFonts.dosis()),
      ),
      body: ValueListenableBuilder(
        valueListenable: store,
        builder: (context, state, _) {
          if (state is LoadingChatViewState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoadedChatViewState) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: state.chats.length,
                itemBuilder: (context, index) {
                  final chat = state.chats[index];
                  return Card(
                    elevation: 5,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.pink,
                        child: Center(
                          child: Text(pbService.pb.authStore.model.id == chat.idUsuarioEnviou ? chat.nomeUsuarioRecebeu[0] : chat.nomeUsuarioEnviou[0], style: GoogleFonts.nunitoSans(fontSize: 20, color: Colors.white)),
                        ),
                      ),
                      title: Text(pbService.pb.authStore.model.id == chat.idUsuarioEnviou ? chat.nomeUsuarioRecebeu : chat.nomeUsuarioEnviou, style: GoogleFonts.nunitoSans(fontSize: 20), overflow: TextOverflow.ellipsis),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ChatPage(
                              pb: pbService,
                              idDestinatario: pbService.pb.authStore.model.id == chat.idUsuarioEnviou ? chat.idUsuarioRecebeu : chat.idUsuarioEnviou,
                              nomeDestinatario: pbService.pb.authStore.model.id == chat.idUsuarioEnviou ? chat.nomeUsuarioRecebeu : chat.nomeUsuarioEnviou,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text("Erro ao carregar chats"));
          }
        },
      ),
    );
  }
}
