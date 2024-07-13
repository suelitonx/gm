import 'package:flutter/foundation.dart';
import 'package:gamematch/models/mensagem_model.dart';
import 'package:gamematch/services/mensagens_service.dart';
import 'package:gamematch/states/mensagens_state.dart';

import '../services/pocketbase_service.dart';

class MensagensStore extends ValueNotifier<MensagensState> {
  MensagensStore() : super(EmptyMensagensState());

  final service = MensagensService();
  final pbService = PocketbaseService.instance;

  Future<void> buscarMensagens(String idDestinatario) async {
    value = LoadingMensagensState();

    try {
      final mensagens = await service.buscarMensagens(idDestinatario);
      value = LoadedMensagensState(mensagens);
      if (kDebugMode) {
        print('Mensagens carregadas com sucesso! ${mensagens.length}');
      }
    } catch (e) {
      value = ErrorMensagensState(e.toString());
    }
  }

  Future<String> enviarMensagem(String idUsuario, String mensagem) async {
    String result = '';

    await service.enviarMensagem(MensagemModel(usuarioEnviou: service.pbService.pb.authStore.model.id, usuarioRecebeu: idUsuario, mensagem: mensagem)).then((value) {
      result = value;
    }).catchError((e) {
      if (kDebugMode) {
        print('Erro ao enviar mensagem: $e');
      }
    });

    return result;
  }

  Future<void> subscribeMensagens(String idDestinatario) async {
    pbService.pb.collection('mensagens').subscribe(
      '*',
      filter: '(usuario_enviou = "$idDestinatario" && usuario_recebeu = "${pbService.pb.authStore.model.id}") || (usuario_enviou = "${pbService.pb.authStore.model.id}" && usuario_recebeu = "$idDestinatario")',
      (e) {
        if (e.action == 'create') {
          if (e.record != null) {
            if (value is LoadedMensagensState) {
              final mensagens = (value as LoadedMensagensState).mensagens;
              mensagens.add(rmToMensagemModel(e.record!));
              value = LoadedMensagensState(mensagens);
            }
          }
        }
      },
    );
  }

  Future<void> unsubscribeMensagens() async {
    if (kDebugMode) {
      print('Unsubscribing mensagens');
    }
    pbService.pb.collection('mensagens').unsubscribe();
  }
}
