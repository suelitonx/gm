import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import '../../theme/theme_model.dart';
import '../controllers/login_controller.dart';

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
      // Fundo da página com imagem
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://static1.thegamerimages.com/wordpress/wp-content/uploads/2021/07/Steam-Library.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Camada com efeito de desfoque no retângulo central
            Center(
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    width: 700, // Largura do retângulo
                    height: 550, // Altura do retângulo
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white.withOpacity(0.4),
                    ),
                    child: buildVerticalLogin(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildVerticalLogin() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            themeService.toggleTheme();
          },
          child: Image.asset(
            "assets/gamematch.png",
            width: 200,
          ),
        ),
        FadeInRight(child: buildForms()),
      ],
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
          backgroundColor: const Color.fromARGB(255, 44, 205, 214), // Cor de fundo do botão
        ),
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Text(
                      texto,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunitoSans(
                        fontSize: 17,
                        color: Colors.white, // Cor do texto do botão
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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
        style: GoogleFonts.nunitoSans(
          color: Colors.blueGrey, // Cor do texto
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20), // Ajustando o padding interno
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: (rotateIcon == false)
                ? Icon(icone, color: Colors.blueGrey) // Cor do ícone
                : RotatedBox(quarterTurns: numberRotation, child: Icon(icone, color: Colors.blueGrey)), // Cor do ícone rotacionado
          ),
          alignLabelWithHint: false,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(25),
          ),
          hintText: hintText,
          hintStyle: GoogleFonts.nunitoSans(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5), // Cor do texto de dica (hint)
          ),
          filled: true,
          fillColor: Colors.white, // Cor de fundo do campo
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
              style: GoogleFonts.nunitoSans(
                color: const Color.fromARGB(255, 0, 0, 0), // Alterado para um tom de verde azulado
              ),
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () => setState(() => c.cadastro = !c.cadastro),
            child: Text(
              c.cadastro ? "Já tem conta? Faça o login" : "Não tem conta? Cadastre-se",
              style: GoogleFonts.nunitoSans(
                color: const Color.fromARGB(255, 0, 0, 0), // Alterado para um tom de verde azulado
              ),
            ),
          ),
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
