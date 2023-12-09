// bibliotecas ----------------------------------------------------------------
// ignore_for_file: constant_identifier_names, file_names, unused_import

import 'package:flutter/foundation.dart';
import "package:http/http.dart" as http;
import "dart:convert";

import 'package:youtube/model/video.dart';
// chave da api do youtube -----------------------------------------------------

const CHAVE_YOUTUBE_API = "AIzaSyA0mqeNINwtUXPZr1eMYSYjz8qnwvajVfM";
const ID_CANAL = "UCBXB45ORThkUTEzzB932kVw";
const URL_BASE = "www.googleapis.com";

// função de pesquisa de parametros --------------------------------------------
class Api {

  Future<List<Video>> pesquisar(String pesquisa) async {
    http.Response response = await http.get(
      Uri.https(
        URL_BASE,
        "/youtube/v3/search",
        {
          "part": "snippet",
          "type": "video",
          "maxResults": "20",
          "order": "date",
          "key": CHAVE_YOUTUBE_API,
          "channelId": ID_CANAL,
          "q": pesquisa,
        },
      ));
    // teste se funcionou ------------------------------------------------------

    if (response.statusCode == 200) {
      // ignore: avoid_print
      Map<String, dynamic> dadosJson = json.decode(response.body);
      // percorrera cada um dos videos --------------------------------------
          List<Video> videos = dadosJson["items"].map<Video>(
              (map){
                return Video.fromJson(map);
                //return Video.converterJson(map);
              }

          ).toList();
          //apenas retorna os videos -------------------------------------------
          return Future.value(videos);

      /*for( var video in dadosJson["items"]){
        print("Resultado: " + video.toString());
      }*/
          //print("Resultado: ${dadosJson["items"]}" );
    } else {
      return Future.value([]);
    }
  }
}
