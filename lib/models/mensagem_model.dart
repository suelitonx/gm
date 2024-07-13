import 'package:pocketbase/pocketbase.dart';

class MensagemModel {
  String id;
  String usuarioEnviou;
  String usuarioRecebeu;
  String nomeUsuarioRecebeu;
  String nomeUsuarioEnviou;
  String mensagem;
  String created;
  String updated;

  MensagemModel({
    this.id = '',
    required this.usuarioEnviou,
    required this.usuarioRecebeu,
    required this.mensagem,
    this.nomeUsuarioEnviou = '',
    this.nomeUsuarioRecebeu = '',
    this.created = '',
    this.updated = '',
  });

  //toMap
  Map<String, dynamic> toMap() {
    return {
      'usuario_enviou': usuarioEnviou,
      'usuario_recebeu': usuarioRecebeu,
      'mensagem': mensagem,
    };
  }
}

MensagemModel rmToMensagemModel(RecordModel rm, {bool view = false}) {
  if (view) {
    return MensagemModel(
      id: rm.id,
      usuarioEnviou: rm.getStringValue('id_usuario_enviou', ''),
      usuarioRecebeu: rm.getStringValue('id_usuario_recebeu', ''),
      nomeUsuarioEnviou: rm.getStringValue('nome_usuario_enviou', ''),
      nomeUsuarioRecebeu: rm.getStringValue('nome_usuario_recebeu', ''),
      mensagem: rm.getStringValue('mensagem', ''),
      created: rm.created,
    );
  }

  return MensagemModel(
    id: rm.id,
    usuarioEnviou: rm.getStringValue('usuario_enviou', ''),
    usuarioRecebeu: rm.getStringValue('usuario_recebeu', ''),
    mensagem: rm.getStringValue('mensagem', ''),
    created: rm.updated,
    updated: rm.created,
  );
}
