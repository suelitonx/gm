import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../states/games_state.dart';

import 'jogos_curtidos_controller.dart';

class JogosCurtidosPage extends StatefulWidget {
  const JogosCurtidosPage({super.key});

  @override
  State<JogosCurtidosPage> createState() => _JogosCurtidosPageState();
}

class _JogosCurtidosPageState extends State<JogosCurtidosPage> {
  final JogosCurtidosController c = JogosCurtidosController();

  @override
  void initState() {
    c.getGames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Jogos curtidos", style: GoogleFonts.bebasNeue(fontSize: 30)),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: c.gameStore,
                builder: (context, value, child) {
                  if (value is LoadingGamesState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (value is LoadedGamesState) {
                    return ListView.builder(
                      itemCount: value.games.length,
                      itemBuilder: (context, index) {
                        final item = value.games[index];
                        return ListTile(
                          title: Text(item.title),
                          leading: CircleAvatar(
                            child: CachedNetworkImage(
                              imageUrl: item.thumbnail,
                              imageBuilder: (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                              placeholder: (context, url) => const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.close_rounded),
                            onPressed: () {
                              c.likesGameStore.likeGame(gameId: value.games[index].id);
                              c.getGames();
                            },
                            tooltip: "Descurtir",
                          ),
                        );
                      },
                    );
                  } else if (value is ErrorGamesState) {
                    return Center(child: Text(value.error));
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
