
// classe contendo informações do video -------------------------------------
class Video {

  late String id;
  late String titulo;
  late String descricao;
  late String imagem;
  late String canal;

  Video({required this.id, required this.titulo, required this.descricao, required this.imagem, required this.canal});

  // cria um contrutor para o video ----------------------------------------
  /*
    static converterJson(Map<String, dynamic> json){
    return Video(
      id: json["id"]["videoId"],
      titulo: json["snippet"]["title"],
      imagem: json["snippet"]["thumbnails"]["high"]["url"],
      canal: json["snippet"]["channelId"],

    );
  }*/
 // cria a função que chama o video -------------------------------------------
  factory Video.fromJson(Map<String, dynamic> json){
    return Video(
      id: json["id"]["videoId"],
      titulo: json["snippet"]["title"],
      imagem: json["snippet"]["thumbnails"]["high"]["url"],
      canal: json["snippet"]["channelTitle"],
      descricao: json["snippet"]["description"],
    );
  }
}