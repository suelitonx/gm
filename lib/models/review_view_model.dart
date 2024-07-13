import 'package:pocketbase/pocketbase.dart';

class ReviewView {
  String id;
  String comentario;
  String created;
  double avaliacao;
  String usuario;

  ReviewView({
    required this.id,
    required this.avaliacao,
    required this.usuario,
    this.comentario = '',
    this.created = '',
  });

  factory ReviewView.fromRM(RecordModel rm) {
    return ReviewView(
      id: rm.id,
      comentario: rm.getStringValue('comentario', ''),
      created: rm.getStringValue('created', ''),
      avaliacao: rm.getDoubleValue('avaliacao', 1.0),
      usuario: rm.getStringValue('name', ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'comentario': comentario,
      'created': created,
      'avaliacao': avaliacao,
      'usuario': usuario,
    };
  }
}
