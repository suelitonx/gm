import 'package:pocketbase/pocketbase.dart';

class ChatsViewModel {
  String id;
  String idUsuarioEnviou;
  String idUsuarioRecebeu;
  String nomeUsuarioRecebeu;
  String nomeUsuarioEnviou;

  ChatsViewModel({
    this.id = '',
    required this.idUsuarioEnviou,
    required this.idUsuarioRecebeu,
    required this.nomeUsuarioRecebeu,
    required this.nomeUsuarioEnviou,
  });
}

ChatsViewModel rmToChatsViewModel(RecordModel rm) {
  return ChatsViewModel(
    id: rm.id,
    idUsuarioEnviou: rm.getStringValue('id_usuario_enviou', ''),
    idUsuarioRecebeu: rm.getStringValue('id_usuario_recebeu', ''),
    nomeUsuarioEnviou: rm.getStringValue('nome_usuario_enviou', ''),
    nomeUsuarioRecebeu: rm.getStringValue('nome_usuario_recebeu', ''),
  );
}
