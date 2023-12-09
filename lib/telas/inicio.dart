import 'package:flutter/material.dart';
import 'package:youtube/Api.dart';
import 'package:youtube/model/video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Inicio extends StatefulWidget {
  final String pesquisa;

  Inicio(this.pesquisa);

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  late YoutubePlayerController _controller;

  // Função que lista os vídeos
  Future<List<Video>> _listarVideos(String pesquisa) async {
    Api api = Api();
    return api.pesquisar(pesquisa);
  }
// metodos chamados para executar funções gerais e iniciais do projeto como fechar e abrir
  @override
  // carregar algum dado que tenha que usar uma unica vez fazer configurações iniciais
  void initState() {
    super.initState();
    print("chamado 1 initState");
    _controller = YoutubePlayerController(
      initialVideoId: '', // Pode ser vazio, pois será definido dinamicamente ao clicar no vídeo
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  //  para construir a interface precisa de dependenciais como listagem de videos
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("chamado 2 didChangeDependencies");

  }

  // tem a função de parar a função utilizada
  @override
  // cancelar processos que gastariam muitos recursos como a troca de telas
  void dispose() {
    _controller.dispose();
    super.dispose();
    print("chamado 3 dispose");
  }

  @override
  void didUpdateWidget(covariant Inicio oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("chamado 2 didUpdateWidget");

  }

  @override
  // faz a contrução da interface
  Widget build(BuildContext context) {
    print("chamado 3 build");
    // Retornando os vídeos
    return FutureBuilder<List<Video>>(
      future: _listarVideos(widget.pesquisa),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasData) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  List<Video>? videos = snapshot.data;
                  Video video = videos![index];

                  return GestureDetector(
                    onTap: () {
                      // Abrir o player ao ser clicado
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Scaffold(
                            appBar: AppBar(
                              title: Text(video.titulo),
                            ),
                            body: Center(
                              child: YoutubePlayer(
                                controller: YoutubePlayerController(
                                  initialVideoId: YoutubePlayer.convertUrlToId(video.id) ?? '',
                                  flags: const YoutubePlayerFlags(
                                    autoPlay: true,
                                    mute: false,
                                  ),
                                ),
                                showVideoProgressIndicator: true,
                                onReady: () {
                                  // Executar quando o player estiver pronto.
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(video.imagem),
                            ),
                          ),
                        ),
                        // Chama o título e o nome do canal
                        ListTile(
                          title: Text(video.titulo),
                          subtitle: Text(video.canal),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                  height: 2,
                  color: Colors.grey,
                ),
                itemCount: snapshot.data!.length,
              );
            } else {
              return const Center(
                child: Text("Nenhum dado a ser exibido!"),
              );
            }
            break;
        }
      },
    );
  }
}
