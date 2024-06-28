import 'pocketbase_service.dart';

class AuthService {
  Future<bool> login({required String email, required String senha}) async {
    final pbService = PocketbaseService.instance;
    bool r = false;

    await pbService.pb.collection('users').authWithPassword(email, senha).then((value) {
      r = true;
      pbService.pb.authStore.save(value.token, value.record);
    }).catchError((_) {
      r = false;
    });

    return r;
  }

  Future<bool> register({required String email, required String senha, required String name}) async {
    final pbService = PocketbaseService.instance;
    bool r = false;

    final body = <String, dynamic>{
      "email": email,
      "emailVisibility": true,
      "password": senha,
      "passwordConfirm": senha,
      "name": name,
    };

    await pbService.pb.collection('users').create(body: body).then((value) {
      r = true;
    }).catchError((_) {
      r = false;
    });

    return r;
  }

  logout() {
    final pbService = PocketbaseService.instance;
    pbService.pb.authStore.clear();
  }
}
