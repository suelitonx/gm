import 'package:gamematch/models/like.dart';
import 'package:gamematch/services/pocketbase_service.dart';
import 'package:pocketbase/pocketbase.dart';

class LikeService {
  final pbService = PocketbaseService.instance;

  //Função para curtir/descurtir um jogo
  Future<(bool resultado, bool liked)> likeGame({required int gameId, int tipo = 1}) async {
    final user = pbService.pb.authStore.model;
    RecordModel like = RecordModel();

    bool r = false;
    bool l = false;

    await pbService.pb.collection('likes').getFirstListItem("jogo = '$gameId' && usuario = '${user.id}'").then((value) {
      if (value.id.isNotEmpty) {
        like = value;
        l = like.getBoolValue('valor', false);
      }
    }).catchError((_) {});

    // Se o jogo já foi curtido, atualiza o valor
    if (like.id.isNotEmpty) {
      await pbService.pb.collection('likes').update(like.id, body: {'valor': !like.getBoolValue('valor', false), 'tipo': tipo}).then((value) {
        l = value.getBoolValue('valor', false);
        r = true;
      }).catchError((_) {
        r = false;
      });
    } else {
      // Se o jogo ainda não foi curtido, cria um novo like
      final body = <String, dynamic>{"usuario": user.id, "jogo": gameId, "tipo": tipo, "valor": true};

      await pbService.pb.collection('likes').create(body: body).then((value) {
        r = true;
        l = value.getBoolValue('valor', false);
      }).catchError((e) {
        r = false;
      });
    }

    return (r, l);
  }

  //Função para listar todas as curtidas de um jogo
  Future<(bool result, List<Like> listLike)> getLikes({required int gameId}) async {
    List<Like> likes = [];
    bool r = false;

    await pbService.pb.collection('likes_view').getList(filter: "jogo = '$gameId'").then((lista) {
      r = true;
      if (lista.items.isNotEmpty) {
        //Map para converter RecordModel em Like
        likes = lista.items.map((r) {
          //Variável para pegar a data e formatar para dd/MM/yyyy HH:mm
          String data = DateTime.parse(r.updated).toLocal().toString();

          //Função que converte RecordModel em Like
          return Like(
            usuario: r.getStringValue('name', 'Anônimo'),
            jogo: r.getIntValue('jogo', 0),
            tipo: r.getIntValue('tipo', 0),
            valor: true,
            updated: '${data.substring(8, 10)}/${data.substring(5, 7)}/${data.substring(0, 4)} ${data.substring(11, 16)}',
          );
        }).toList();
      }
    }).catchError((_) {
      r = false;
    });

    return (r, likes);
  }

  //Função que verifica se o jogo foi curtido pelo usuário
  Future<bool> isLiked({required int gameId}) async {
    final user = pbService.pb.authStore.model;
    bool liked = false;

    await pbService.pb.collection('likes').getFirstListItem("jogo = '$gameId' && usuario = '${user.id}'").then((value) {
      if (value.id.isNotEmpty) {
        liked = value.getBoolValue('valor', false);
      }
    }).catchError((_) {});

    return liked;
  }
}
