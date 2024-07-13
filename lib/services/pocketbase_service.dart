//import 'package:fetch_client/fetch_client.dart';
import 'package:flutter/foundation.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PocketbaseService extends ChangeNotifier {
  //Variável privada que armazena a instância do PocketBase
  late PocketBase _pb;
  //Método getter que retorna a instância do PocketBase
  PocketBase get pb => _pb;

  //Variável privada que armazena a instância da classe PocketbaseService
  static final PocketbaseService _instance = PocketbaseService._();
  //Método getter que retorna a instância da classe PocketbaseService
  static PocketbaseService get instance => _instance;

  //Construtor privado da classe PocketbaseService
  PocketbaseService._();

  //Método que inicializa a instância do PocketBase
  Future<void> init() async {
    //Verifica se a instância do PocketBase já foi inicializada
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    //Cria uma instância de AsyncAuthStore
    final store = AsyncAuthStore(
      save: (String data) async => prefs.setString('pb_auth', data),
      initial: prefs.getString('pb_auth'),
      clear: () async => prefs.remove('pb_auth'),
    );

    //Inicializa a instância do PocketBase
    _pb = PocketBase(
      'https://poo2.pockethost.io',
      authStore: store,
      //httpClientFactory: kIsWeb ? () => FetchClient(mode: RequestMode.cors) : null,
    );

    //Verifica se o token de autenticação é válido
    if (_pb.authStore.isValid) {
      //Atualiza o token de autenticação
      await _pb.collection('users').authRefresh().then((result) {
        //Salva o token de autenticação
        _pb.authStore.save(result.token, result.record);
      }).catchError((dynamic error) {
        //Limpa o token de autenticação
        _pb.authStore.clear();
      });
    }

    //Adiciona um listener para o evento onChange da instância de AuthStore do PocketBase
    _pb.authStore.onChange.listen((event) {
      //Verifica se o token de autenticação está vazio
      if (event.token.isEmpty) {
        //Acaba com a inscrição do evento de tempo real
        _pb.realtime.unsubscribe();
      }
      notifyListeners();
    });
  }
}
