// bibliotecas -----------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:youtube/CustomSearchDelegate.dart';
import 'package:youtube/telas/Emalta.dart';
import 'package:youtube/telas/biblioteca.dart';
import 'package:youtube/telas/inicio.dart';
import 'package:youtube/telas/inscricoes.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  // variavel inicial que muda os botões inferiores ----------------------------
  int _indiceAtual = 0;
  String? _resultado = "";

  @override
  Widget build(BuildContext context) {
    //telas que trocaram com os botões inferiores ------------------------------

    List <Widget> telas = [
      Inicio( _resultado! ),
      const Emalta(),
      const Inscricoes(),
      const biblioteca()
    ];
    // estrutura ---------------------------------------------------------------
    return Scaffold(
    // parte superior do app ---------------------------------------------------
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color:Colors.grey
        ),
        backgroundColor: Colors.white,
        title: Image.asset("img/youtube.png",
        width: 98,
        height: 22,
        ),
        //botoes ---------------------------------------------------------------
        actions: <Widget>[

          // icon de pesquisa --------------------------------------------------
          IconButton(
              onPressed: () async {
                String? res = await showSearch(context: context, delegate: CustomSearchDelegate() );
                setState(() {
                  _resultado = res;
                });
                print("resultado: digitado $res");
              },
              icon: const Icon(Icons.search)
          ),

        ],
      ),
      //conteudo do app --------------------------------------------------------
      body: Container(
        padding: const EdgeInsets.all(16),
        child: telas[_indiceAtual],
      ),
      // navegação inferior do app ---------------------------------------------
      bottomNavigationBar: BottomNavigationBar(
        // configurações dos botões inferiores ---------------------------------
        currentIndex: _indiceAtual,
        onTap: (indice){
          setState(() {
            _indiceAtual = indice;
          });
        },
        //type: BottomNavigationBarType.shifting,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        items: const[
          // botoes inferiores do app ------------------------------------------
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.whatshot),
              label: 'Em alta'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.subscriptions),
              label: 'Inscrições'
          ),
          BottomNavigationBarItem(
            //backgroundColor: Colors.red,
              icon: Icon(Icons.folder),
              label: 'Biblioteca'
          ),


        ],
      ),
    );
  }
}
