import 'package:flutter/material.dart';

class Inscricoes extends StatefulWidget {
  const Inscricoes({Key? key}) : super(key: key);

  @override
  State<Inscricoes> createState() => _InscricoesState();
}

class _InscricoesState extends State<Inscricoes> {
  @override
  Widget build(BuildContext context) {
    //conteudo inscrições ------------------------------------------------------
    return Container(
      child: const Center(
        child: Text("Inscrições",
          style: TextStyle(
              fontSize: 25
          ),
        ),
      ),
    );
  }
}
