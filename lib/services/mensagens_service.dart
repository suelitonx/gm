import 'package:flutter/foundation.dart';
import 'package:gamematch/models/mensagem_model.dart';

import 'pocketbase_service.dart';

class MensagensService {
  final pbService = PocketbaseService.instance;

  Future<String> enviarMensagem(MensagemModel msg) async {
    String result = '';

    await pbService.pb.collection('mensagens').create(body: msg.toMap()).then((value) {
      result = value.id;
    }).catchError((e) {
      if (kDebugMode) {
        print('Erro ao enviar mensagem: $e');
      }
    });

    return result;
  }

  Future<List<MensagemModel>> buscarMensagens(String idUsuario) async {
    List<MensagemModel> mensagens = [];

    await pbService.pb
        .collection('mensagens')
        .getList(
          page: 1,
          perPage: 100,
          filter: '(usuario_enviou = "$idUsuario" && usuario_recebeu = "${pbService.pb.authStore.model.id}") || (usuario_enviou = "${pbService.pb.authStore.model.id}" && usuario_recebeu = "$idUsuario")',
        )
        .then((value) {
      if (value.items.isNotEmpty) {
        mensagens = value.items.map((e) => rmToMensagemModel(e)).toList();
      }
    }).catchError((e) {
      if (kDebugMode) {
        print('Erro ao buscar mensagens: $e');
      }
    });

    return mensagens;
  }
}
