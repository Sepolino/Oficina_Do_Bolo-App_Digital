import 'package:flutter/material.dart';
import '../repositories/bolo_repositories.dart';

class RecuperarSenhaView extends StatefulWidget {
  const RecuperarSenhaView({super.key});

  @override
  State<RecuperarSenhaView> createState() => _RecuperarSenhaViewState();
}

class _RecuperarSenhaViewState extends State<RecuperarSenhaView> {
  final _emailController = TextEditingController();

  void _recuperarSenha() {
    String email = _emailController.text;

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Digite seu email")),
      );
      return;
    }

    if (!email.contains("@")) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email inválido!")),
      );
      return;
    }

    // VERIFICA SE EXISTE USUÁRIO COM ESSE EMAIL
    final usuario = userRepository.tabelauser
        .where((u) => u.email == email)
        .toList();

    if (usuario.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email não cadastrado")),
      );
      return;
    }

    print("Recuperação de senha para a conta: $email");

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Instruções de recuperação enviadas."),
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 233, 235),
      appBar: AppBar(
        title: const Text("Recuperar Senha"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Digite o seu email para recuperar sua senha",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _recuperarSenha,
                child: const Text("Recuperar a Senha"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
