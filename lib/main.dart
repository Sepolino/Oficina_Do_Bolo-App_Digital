import 'package:flutter/material.dart';
import 'view/login_principal.dart';
import 'view/cadastro.dart';
import 'view/home.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Oficina do Bolo',
      initialRoute: 'login',

      routes: {
        'login': (context) => const LoginPrincipal(),
        'cadastro': (context) => const RegisterView(),
        'home': (context) => const HomeView(), // 👈 ADICIONA AQUI
      },
    );
  }
}