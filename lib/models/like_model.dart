import 'package:pocketbase/pocketbase.dart';

class Like {
  String id;
  String usuario;
  String usuarioID;
  int jogo;
  int tipo;
  bool valor;
  String created;
  String updated;

  Like({
    this.id = '',
    required this.usuario,
    required this.jogo,
    required this.tipo,
    required this.valor,
    this.usuarioID = '',
    this.created = '',
    this.updated = '',
  });

  //toMap
  Map<String, dynamic> toMap() {
    return {
      'usuario': usuario,
      'jogo': jogo,
      'tipo': tipo,
      'valor': valor,
    };
  }
}

//RecordModel to Like
Like rmToLike(RecordModel rm) {
  return Like(
    id: rm.id,
    usuario: rm.getStringValue('usuario', ''),
    jogo: rm.getIntValue('jogo', 0),
    tipo: rm.getIntValue('tipo', 0),
    valor: rm.getBoolValue('valor', false),
    created: rm.created,
    updated: rm.updated,
  );
}
