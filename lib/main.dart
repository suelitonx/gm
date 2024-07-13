import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'services/pocketbase_service.dart';
import 'theme/theme.dart';
import 'theme/theme_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final pbService = PocketbaseService.instance;
  await pbService.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final pbService = PocketbaseService.instance;
  final themeService = ThemeModel.instance;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([pbService, themeService]),
      builder: (context, _) {
        return MaterialApp(
          title: 'APP',
          debugShowCheckedModeBanner: false,
          theme: themeService.isDarkMode ? darkMode : originalMode,
          darkTheme: darkMode,
          themeMode: themeService.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: pbService.pb.authStore.isValid ? const HomePage() : const LoginPage(),
        );
      },
    );
  }
}
