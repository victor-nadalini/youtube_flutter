import 'package:flutter/material.dart';

// função delegate necessaria para o showSearch(context: context, delegate:  )--
class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) { // acoes do usuario ------
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: (){
          query = "";
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return
      IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: (){
          close(context, "");
        },
      );
  }

  @override
  Widget buildResults(BuildContext context) {
    //print("resultado: pesquisa realizada");
    close(context, query);
    return Container(

    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //print("resultado: digitado $query");
    List<String> lista = [];

    if( query.isNotEmpty ){
      lista = [
         "Satoro gojo",
          "todo e itadori",
         "feliz páscoa",
         "akame ga kill"
      ].where(
          (texto) => texto.toLowerCase().startsWith(query.toLowerCase())
      ).toList();

      return ListView.builder(
          itemCount:  lista.length,
          itemBuilder: (context, index){

            return ListTile(
              onTap: (){
                close(context, lista[index]);
              },
              title: Text(lista[index]),
            );
          }
      );
        }else{
      return const Center(
        child: Text("Nenhum resultado para a pesquisa"),
      );
    }
   }
  
}
