import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:gamematch/services/pocketbase_service.dart';
import 'package:google_fonts/google_fonts.dart';

import '../states/mensagens_state.dart';
import '../stores/mensagens_store.dart';

class ChatPage extends StatefulWidget {
  final PocketbaseService pb;
  final String idDestinatario;
  final String nomeDestinatario;

  const ChatPage({super.key, required this.pb, required this.idDestinatario, required this.nomeDestinatario});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late types.User _usuario;
  late types.User _destinatario;

  final storeMensagens = MensagensStore();

  @override
  void initState() {
    _usuario = types.User(
      id: widget.pb.pb.authStore.model.id,
      firstName: widget.pb.pb.authStore.model.data["name"],
      lastName: "",
    );

    _destinatario = types.User(
      id: widget.idDestinatario,
      firstName: widget.nomeDestinatario,
      lastName: "",
    );

    storeMensagens.addListener(_listener);

    storeMensagens.buscarMensagens(widget.idDestinatario);

    storeMensagens.subscribeMensagens(widget.idDestinatario);

    super.initState();
  }

  @override
  void dispose() {
    storeMensagens.removeListener(_listener);
    storeMensagens.unsubscribeMensagens();
    super.dispose();
  }

  void _listener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nomeDestinatario, style: GoogleFonts.dosis()),
      ),
      body: ValueListenableBuilder(
        valueListenable: storeMensagens,
        builder: (context, value, _) {
          if (value is LoadingMensagensState || value is EmptyMensagensState) {
            return const Center(child: CircularProgressIndicator());
          } else if (value is LoadedMensagensState) {
            return Chat(
              dateIsUtc: true,
              showUserNames: true,
              bubbleRtlAlignment: BubbleRtlAlignment.left,
              messages: value.mensagens
                  .map((e) {
                    return types.TextMessage(
                      author: e.usuarioEnviou == widget.pb.pb.authStore.model.id ? _usuario : _destinatario,
                      text: e.mensagem,
                      id: e.id,
                    );
                  })
                  .toList()
                  .reversed
                  .toList(),
              nameBuilder: (p0) {
                return Text(
                  p0.firstName!,
                  style: GoogleFonts.dosis(fontWeight: FontWeight.bold, color: Colors.black),
                );
              },
              onSendPressed: (t) async {
                final r = await storeMensagens.enviarMensagem(widget.idDestinatario, t.text);

                if (r.isEmpty && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Erro ao enviar mensagem"),
                    backgroundColor: Colors.red,
                  ));
                }
              },
              user: _usuario,
            );
          } else {
            return const Center(child: Text("Erro ao carregar mensagens"));
          }
        },
      ),
    );
  }
}
