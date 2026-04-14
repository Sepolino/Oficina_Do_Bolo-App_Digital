import 'package:flutter/material.dart';

class SobreView extends StatelessWidget {
  const SobreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sobre")),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Objetivo: O app foi feito para simular um desenvolvimento de cardápio digital/online para uma loja especializada em bolos.\n"),
              Text("Aluno: Marcus Vínicius Milan da Silva"),
              Text("Disciplina: Programação para Dispositívos Móveis\nInstituição: FATEC\nProfessor: Rodrigo Plotz"),
            ],
          ),
        ),
      ),
    );
  }
}