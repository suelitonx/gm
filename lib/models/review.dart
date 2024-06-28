import 'package:pocketbase/pocketbase.dart';

class Review {
  String created;
  String id;
  String comentario;
  double avaliacao;
  String usuario;
  int jogo;

  Review({
    this.created = '',
    this.id = '',
    this.comentario = '',
    required this.avaliacao,
    required this.usuario,
    required this.jogo,
  });

  factory Review.fromRM(RecordModel rm) {
    return Review(
      created: rm.created,
      id: rm.id,
      comentario: rm.getStringValue('comentario', ''),
      avaliacao: rm.getDoubleValue('avaliacao', 1),
      usuario: rm.getStringValue('usuario', ''),
      jogo: rm.getIntValue('jogo', 0),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'comentario': comentario,
      'avaliacao': avaliacao,
      'usuario': usuario,
      'jogo': jogo,
    };
  }
}
