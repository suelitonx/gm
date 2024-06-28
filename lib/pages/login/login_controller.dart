import 'package:flutter/material.dart';
import 'package:gamematch/services/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginController extends ChangeNotifier {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  bool lembrar = true;
  bool entrando = false;
  bool cadastro = false;

  final auth = AuthService();

  static const colorizeColors = [
    Colors.red,
    Colors.yellow,
    Colors.cyan,
    Colors.orange,
  ];

  final colorizeTextStyle = GoogleFonts.bebasNeue(
    fontSize: 40.0,
  );

  Future<void> login(BuildContext context) async {
    entrando = true;
    notifyListeners();

    final r = cadastro ? await auth.register(email: userController.text.trim(), senha: passController.text, name: nameController.text.trim()) : await auth.login(email: userController.text.trim(), senha: passController.text);

    if (r == false && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Não foi possível fazer o ${cadastro ? 'cadastro' : 'login'}.')));
    }

    if (context.mounted) {
      if (cadastro && r == true) {
        login(context);
      } else {
        entrando = false;
        notifyListeners();
      }
    }
  }
}
