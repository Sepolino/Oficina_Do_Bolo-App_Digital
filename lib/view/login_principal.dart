import 'package:flutter/material.dart';
import 'package:flutter_games/models/user.dart';
import 'cadastro.dart';
import 'recuperarsenha.dart';
import '../repositories/bolo_repositories.dart';
import 'home.dart';

class LoginPrincipal extends StatefulWidget {
  const LoginPrincipal({super.key});

  @override
  State<LoginPrincipal> createState() => _LoginPrincipalState();
}

class _LoginPrincipalState extends State<LoginPrincipal> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
  String email = _emailController.text;
  String password = _passwordController.text;

  if (email.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Preencha todos os campos")),
    );
    return;
  }

  final usuarioEncontrado = userRepository.tabelauser.firstWhere(
  (u) => u.email == email && u.password == password,
  orElse: () => user(username: '', email: '', password: '', tel: ''),
);

if (usuarioEncontrado.email.isEmpty) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Email ou senha incorretos")),
  );
  return;
}

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => const HomeView(),
    ),
  );
}

  void _irParaCadastro() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegisterView(),
      ),
    );
  }

  void _irParaRecuperarSenha() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RecuperarSenhaView(),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: const Color.fromARGB(255, 255, 233, 235),
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/imgs/oficina.png',
              height: 220,
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Senha",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 8),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _irParaRecuperarSenha,
                child: const Text("Esqueceu a senha?"),
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _login,
                child: const Text("Entrar"),
              ),
            ),

            const SizedBox(height: 12),

            TextButton(
              onPressed: _irParaCadastro,
              child: const Text("Não tem conta? Cadastre-se"),
            ),
          ],
        ),
      ),
    );
  }
}