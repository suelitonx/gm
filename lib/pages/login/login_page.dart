import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/theme_model.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final c = LoginController();

  final themeService = ThemeModel.instance;

  @override
  void initState() {
    themeService.addListener(() => setState(() {}));
    c.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    c.userController.dispose();
    c.passController.dispose();
    c.nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(child: buildVerticalLogin())),
    );
  }

  Widget buildVerticalLogin() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              themeService.toggleTheme();
            },
            child: Image.asset(
              "assets/gamematch.png",
              //width: MediaQuery.of(context).size.width * 0.7,
              width: 300,
            ),
          ),
          //FadeInLeft(child: buildTextAnim()),
          FadeInRight(child: buildForms()),
        ],
      ),
    );
  }

  Widget buildForms() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Visibility(visible: c.cadastro, child: _textBox("Nome", c.nameController, Icons.person_rounded)),
        _textBox("Email", c.userController, Icons.email_rounded),
        _textBox("Senha", c.passController, Icons.key_rounded, rotateIcon: true, numberRotation: 3, pass: true),
        _buildButtonLogin(c.cadastro ? "CADASTRAR" : "ENTRAR", () => c.login(context), isLoading: c.entrando, pTop: 0),
        _lembrarEsqueceu(),
      ],
    );
  }

  Widget _buildButtonLogin(String texto, Function()? funcao, {double pTop = 10, bool isLoading = false}) {
    return Padding(
      padding: EdgeInsets.only(top: pTop),
      child: ElevatedButton(
        onPressed: isLoading == true ? () {} : funcao,
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          elevation: 3,
          shadowColor: Colors.black,
          minimumSize: const Size.fromHeight(60),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(child: Text(texto, textAlign: TextAlign.center, style: GoogleFonts.nunitoSans(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold))),
                  const Icon(Icons.arrow_forward_rounded, color: Colors.white),
                ],
              ),
      ),
    );
  }

  Widget _textBox(String hintText, TextEditingController controller, IconData icone, {bool rotateIcon = false, int numberRotation = 1, void Function()? funcaoSub, bool pass = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        onSubmitted: funcaoSub != null
            ? (value) {
                funcaoSub();
              }
            : null,
        controller: controller,
        obscureText: pass,
        keyboardType: TextInputType.text,
        style: GoogleFonts.nunitoSans(),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 25),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: (rotateIcon == false) ? Icon(icone) : RotatedBox(quarterTurns: numberRotation, child: Icon(icone)),
          ),
          alignLabelWithHint: false,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(25),
          ),
          hintText: hintText,
          hintStyle: GoogleFonts.nunitoSans(),
          labelStyle: GoogleFonts.nunitoSans(),
          fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          filled: true,

          //errorText: "Senha inválida.",
          //errorStyle: GoogleFonts.nunitoSans(color: Colors.red, fontSize: 15),
          /*
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(25),
          ),
          */
        ),
      ),
    );
  }

  Widget _lembrarEsqueceu() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Checkbox(
            shape: const CircleBorder(),
            value: c.lembrar,
            onChanged: (valor) {
              setState(() {
                c.lembrar = valor!;
              });
            },
          ),
          InkWell(
            onTap: () {
              setState(() {
                c.lembrar = !c.lembrar;
              });
            },
            child: Text(
              "Lembrar",
              style: GoogleFonts.nunitoSans(color: themeService.isDarkMode ? Colors.white : Colors.black),
            ),
          ),
          const Spacer(),
          TextButton(onPressed: () => setState(() => c.cadastro = !c.cadastro), child: Text(c.cadastro ? "Já tem conta? Faça o login" : "Não tem conta? Cadastre-se", style: GoogleFonts.nunitoSans()))
        ],
      ),
    );
  }

  /*
  Widget buildTextAnim() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: AnimatedTextKit(
          pause: const Duration(milliseconds: 100),
          animatedTexts: [
            ColorizeAnimatedText('DESCUBRA OS MELHORES JOGOS', textStyle: c.colorizeTextStyle, colors: LoginController.colorizeColors, textAlign: TextAlign.center),
            ColorizeAnimatedText('BASEADOS NOS QUE VOCÊ AMA', textStyle: c.colorizeTextStyle, colors: LoginController.colorizeColors, textAlign: TextAlign.center),
            ColorizeAnimatedText('SEJA BEM VINDO(A)', textStyle: c.colorizeTextStyle, colors: LoginController.colorizeColors, textAlign: TextAlign.center),
            //ColorizeAnimatedText('POO 2 (2024.1)', textStyle: c.colorizeTextStyle, colors: LoginController.colorizeColors, textAlign: TextAlign.center, speed: const Duration(milliseconds: 100)),
          ],
          isRepeatingAnimation: true,
          onTap: () {},
        ),
      ),
    );
  }
  */
}
