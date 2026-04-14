import 'package:flutter/material.dart';
import '../repositories/bolo_repositories.dart';
import '../models/bolos.dart';
import '../models/carrinho.dart';
import 'login_principal.dart';
import 'carrinho_pagina.dart';
import 'detalhe_bolo.dart';
import 'sobre.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  final List<bolos> lista = boloRepository.tabela;

  String filtroTamanho = '';

  @override
  Widget build(BuildContext context) {

    final listaFiltrada = filtroTamanho.isEmpty
        ? lista
        : lista.where((b) => b.tamanho == filtroTamanho).toList();

    final boloDestaque = lista.first;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Sair"),
                content: const Text("Tem certeza que deseja sair?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Não"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPrincipal(),
                        ),
                        (route) => false,
                      );
                    },
                    child: const Text("Sim"),
                  ),
                ],
              ),
            );
          },
        ),
        title: Image.asset(
          'lib/imgs/oficinaLOGO.png',
          height: 105,
          
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CarrinhoView(),
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart),
          )
        ],
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFF1F2),
              Color(0xFFFFE4E6),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: Column(
          children: [

            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFFCDD2),
                    Color(0xFFF8BBD0),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(
                      boloDestaque.foto,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "🍰 Bolo do dia",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          boloDestaque.nome,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: Row(
                children: [
                  Expanded(child: _botaoFiltro("Menor")),
                  const SizedBox(width: 5),
                  Expanded(child: _botaoFiltro("Médio")),
                  const SizedBox(width: 5),
                  Expanded(child: _botaoFiltro("Grande")),
                  const SizedBox(width: 5),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        filtroTamanho = '';
                      });
                    },
                    icon: const Icon(Icons.refresh),
                  )
                ],
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: listaFiltrada.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.70,
                ),
                itemBuilder: (context, index) {
                  final bolo = listaFiltrada[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetalheBoloView(bolo: bolo),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: const Color.fromARGB(255, 253, 218, 218),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(18),
                              ),
                              child: Image.asset(
                                bolo.foto,
                                width: double.infinity,
                                fit: BoxFit.cover,
                
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              bolo.nome,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              bolo.ingredientes,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              "R\$ ${bolo.preco.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  final item = carrinho(
                                    bolo: bolo,
                                    quantidade: 1,
                                  );

                                  carrinhoRepo.adicionar(item);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const CarrinhoView(),
                                    ),
                                  );
                                },
                                child: const Text("Adicionar"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SobreView(),
                      ),
                    );
                  },
                  child: const Text("Sobre"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _botaoFiltro(String tamanho) {
    final selecionado = filtroTamanho == tamanho;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            selecionado ? const Color(0xFFF48FB1) : Colors.white,
        foregroundColor:
            selecionado ? Colors.white : Colors.black,
        elevation: selecionado ? 2 : 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: () {
        setState(() {
          filtroTamanho = selecionado ? '' : tamanho;
        });
      },
      child: Text(tamanho),
    );
  }
}