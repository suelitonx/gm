import 'package:animate_do/animate_do.dart';
import 'package:animated_react_button/animated_react_button.dart';
import 'package:banner_carousel/banner_carousel.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gamematch/pages/chat_page.dart';
import 'package:gamematch/services/like_service.dart';
import 'package:gamematch/states/game_info_state.dart';
import 'package:gamematch/stores/game_info_store.dart';
import 'package:gamematch/stores/reviews_store.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

import '../models/review_model.dart';
import '../services/json_games.dart';
import '../services/pocketbase_service.dart';
import '../states/likes_game_state.dart';
import '../stores/likes_game_store.dart';

class UniqueGamePage extends StatefulWidget {
  final int idJogo;
  final String nomeJogo;

  const UniqueGamePage({super.key, required this.idJogo, required this.nomeJogo});

  @override
  State<UniqueGamePage> createState() => _UniqueGamePageState();
}

class _UniqueGamePageState extends State<UniqueGamePage> {
  final store = GameInfoStore();
  final lService = LikeService();
  final pbService = PocketbaseService.instance;
  final likesGameStore = LikesGameStore();
  final reviewStore = ReviewStore();
  final PageController _pageControllerInfo = PageController();

  final TextEditingController _controllerReview = TextEditingController();
  double currentRating = 1;

  bool _dandoLike = false;
  bool _liked = true;
  int currentPageInfo = 0;

  @override
  void initState() {
    store.getGameInfo(widget.idJogo);
    super.initState();
  }

  @override
  void dispose() {
    _pageControllerInfo.dispose();
    _controllerReview.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: store,
        builder: (context, state, _) {
          if (state is LoadingGameInfoState || state is EmptyGameInfoState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoadedGameInfoState) {
            final g = state.currentGame;

            return Column(
              children: [
                Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Image.network(
                      g.thumbnail,
                      colorBlendMode: BlendMode.darken,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill,
                      loadingBuilder: (context, child, loadingProgress) {
                        return loadingProgress == null ? child : const SizedBox(height: 300, child: Center(child: CircularProgressIndicator()));
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(g.title, style: GoogleFonts.nunitoSans(fontSize: 20, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                            Text(g.developer, style: GoogleFonts.nunitoSans(fontSize: 16), overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          AnimatedReactButton(
                            onPressed: () async {
                              //API Calls

                              setState(() {
                                _dandoLike = true;
                              });

                              final (r, l) = await lService.likeGame(gameId: g.id, tipo: 1);

                              if (r) {
                                if (!context.mounted) return;
                                likesGameStore.getLikes(gameId: g.id);

                                ElegantNotification.success(
                                  title: Text("Sucesso", style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black)),
                                  description: Text(l == true ? "Jogo curtido com sucesso." : "Jogo descurtido com sucesso.", style: GoogleFonts.nunitoSans(fontSize: 15, color: Colors.black)),
                                ).show(context);
                              } else {
                                if (!context.mounted) return;
                                ElegantNotification.error(
                                  title: Text("Erro", style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black)),
                                  description: Text("Erro ao curtir/descurtir o jogo.", style: GoogleFonts.nunitoSans(fontSize: 15, color: Colors.black)),
                                ).show(context);
                              }

                              setState(() {
                                _liked = l;
                                _dandoLike = false;
                              });
                            },
                            defaultColor: _liked ? Colors.red : Colors.grey,
                            reactColor: !_liked ? Colors.red : Colors.grey,
                          ),
                          Visibility(
                            visible: _dandoLike,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView(
                    controller: _pageControllerInfo,
                    onPageChanged: (index) {
                      setState(() {
                        currentPageInfo = index;
                      });
                      if (index == 1) {
                        reviewStore.getReviews(g.id);
                      } else if (index == 2) {
                        likesGameStore.getLikes(gameId: g.id);
                      }
                    },
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReadMoreText(
                                g.description,
                                trimCollapsedText: ' Ler mais',
                                trimExpandedText: ' Ler menos',
                                trimMode: TrimMode.Line,
                                trimLines: 3,
                                style: GoogleFonts.nunitoSans(fontSize: 14),
                                moreStyle: GoogleFonts.nunitoSans(fontSize: 14, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(height: 10),
                              BannerCarousel(
                                banners: g.screenshots.map((e) => BannerModel(imagePath: e, id: e.hashCode.toString())).toList(),
                                customizedIndicators: const IndicatorModel.animation(
                                  width: 20,
                                  height: 5,
                                  spaceBetween: 2,
                                  widthAnimation: 50,
                                ),
                                activeColor: Colors.pink,
                                //disableColor: Colors.white,
                                animation: true,
                                borderRadius: 10,
                                height: 200,
                                //onTap: (id) => print(id),
                                //onPageChanged: (index) => print(index),
                                indicatorBottom: true,
                              ),
                              const SizedBox(height: 10),
                              Text("Information", style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.bold)),
                              ListTile(
                                title: Text("Release Date", style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.bold)),
                                subtitle: Text(g.releaseDateFormatted, style: GoogleFonts.nunitoSans(fontSize: 15)),
                                leading: const Icon(Icons.calendar_today_rounded),
                              ),
                              ListTile(
                                title: Text("Publisher", style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.bold)),
                                subtitle: Text(g.publisher, style: GoogleFonts.nunitoSans(fontSize: 15)),
                                leading: const Icon(Icons.business_rounded),
                              ),
                              ListTile(
                                title: Text("Genre", style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.bold)),
                                subtitle: Text(g.genre, style: GoogleFonts.nunitoSans(fontSize: 15)),
                                leading: const Icon(Icons.videogame_asset_rounded),
                              ),
                              ListTile(
                                title: Text("Plataform", style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.bold)),
                                subtitle: Text(g.platform, style: GoogleFonts.nunitoSans(fontSize: 15)),
                                leading: Icon(getIconFromPlataform(g.platform)),
                              ),

                              //Requisitos minimos
                              const SizedBox(height: 10),
                              if ((g.requeriments["os"] != null && g.requeriments["os"] != "-") || (g.requeriments["processor"] != null && g.requeriments["processor"] != "-")) Text("Minimum Requirements", style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.bold)),
                              if (g.requeriments["os"] != null && g.requeriments["os"] != "-")
                                ListTile(
                                  leading: const Icon(CupertinoIcons.desktopcomputer),
                                  title: Text("OS", style: GoogleFonts.nunitoSans(fontSize: 14, fontWeight: FontWeight.bold)),
                                  subtitle: Text(g.requeriments["os"], style: GoogleFonts.nunitoSans(fontSize: 14)),
                                ),
                              if (g.requeriments["processor"] != null && g.requeriments["processor"] != "-")
                                ListTile(
                                  leading: const Icon(Icons.computer_rounded),
                                  title: Text("Processor", style: GoogleFonts.nunitoSans(fontSize: 14, fontWeight: FontWeight.bold)),
                                  subtitle: Text(g.requeriments["processor"], style: GoogleFonts.nunitoSans(fontSize: 14)),
                                ),
                              if (g.requeriments["memory"] != null && g.requeriments["memory"] != "-")
                                ListTile(
                                  leading: const Icon(Icons.memory_rounded),
                                  title: Text("Memory", style: GoogleFonts.nunitoSans(fontSize: 14, fontWeight: FontWeight.bold)),
                                  subtitle: Text(g.requeriments["memory"], style: GoogleFonts.nunitoSans(fontSize: 14)),
                                ),
                              if (g.requeriments["graphics"] != null && g.requeriments["graphics"] != "-")
                                ListTile(
                                  leading: const Icon(Icons.videogame_asset),
                                  title: Text("Graphics", style: GoogleFonts.nunitoSans(fontSize: 14, fontWeight: FontWeight.bold)),
                                  subtitle: Text(g.requeriments["graphics"], style: GoogleFonts.nunitoSans(fontSize: 14)),
                                ),
                              if (g.requeriments["storage"] != null && g.requeriments["storage"] != "-")
                                ListTile(
                                  leading: const Icon(Icons.storage_rounded),
                                  title: Text("Storage", style: GoogleFonts.nunitoSans(fontSize: 14, fontWeight: FontWeight.bold)),
                                  subtitle: Text(g.requeriments["storage"], style: GoogleFonts.nunitoSans(fontSize: 14)),
                                ),
                              //Avaliações
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Card(
                                elevation: 5,
                                child: TextField(
                                  controller: _controllerReview,
                                  decoration: InputDecoration(
                                    hintText: "Escreva sua review (opcional)",
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    RatingBar.builder(
                                      itemSize: 30,
                                      initialRating: currentRating,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: false,
                                      itemCount: 5,
                                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star_rounded,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        currentRating = rating;
                                      },
                                    ),
                                    const SizedBox(width: 10),
                                    IconButton(
                                      onPressed: () async {
                                        //O usuário só pode ter uma avaliação para cada jogo, vamos verificar isso

                                        final r = Review(
                                          avaliacao: currentRating,
                                          usuario: pbService.pb.authStore.model.id,
                                          jogo: g.id,
                                          comentario: _controllerReview.text.trim(),
                                        );
                                        final resultado = await reviewStore.addReview(r);

                                        if (resultado == false && context.mounted) {
                                          ElegantNotification.error(
                                            title: Text("Erro", style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black)),
                                            description: Text("Você já avaliou esse jogo.", style: GoogleFonts.nunitoSans(fontSize: 15, color: Colors.black)),
                                          ).show(context);
                                        }
                                      },
                                      icon: const Icon(Icons.send_rounded),
                                    ),
                                  ],
                                ),
                              ),
                              Text("Reviews", style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.bold)),
                              AnimatedBuilder(
                                animation: Listenable.merge([
                                  reviewStore.reviews,
                                  reviewStore.isLoading,
                                  reviewStore.error,
                                ]),
                                builder: (context, _) {
                                  if (reviewStore.isLoading.value) return const Center(child: CircularProgressIndicator());

                                  if (reviewStore.error.value.isNotEmpty) return Center(child: Text(reviewStore.error.value));

                                  if (reviewStore.reviews.value.isEmpty) {
                                    return Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          "Nenhuma review encontrada.\nO que acha de ser o First?!",
                                          style: GoogleFonts.nunitoSans(fontSize: 16),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  }

                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: reviewStore.reviews.value.length,
                                    itemBuilder: (context, index) {
                                      final r = reviewStore.reviews.value[index];

                                      return Card(
                                        elevation: 5,
                                        child: ListTile(
                                          title: Text(r.usuario, style: GoogleFonts.nunitoSans(fontSize: 16, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                                          subtitle: r.comentario.isEmpty
                                              ? null
                                              : ReadMoreText(
                                                  r.comentario,
                                                  trimCollapsedText: ' Ler mais',
                                                  trimExpandedText: ' Ler menos',
                                                  trimMode: TrimMode.Line,
                                                  trimLines: 2,
                                                  style: GoogleFonts.nunitoSans(fontSize: 14),
                                                  moreStyle: GoogleFonts.nunitoSans(fontSize: 14, fontWeight: FontWeight.bold),
                                                  lessStyle: GoogleFonts.nunitoSans(fontSize: 14, fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.justify,
                                                ),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(Icons.star_rounded, color: Colors.amber),
                                              Text("${r.avaliacao.round()}/5"),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ValueListenableBuilder(
                                valueListenable: likesGameStore,
                                builder: (context, state, _) {
                                  if (state is LoadingLikesGameState || state is EmptyLikesGameState) {
                                    return const Center(child: CircularProgressIndicator());
                                  } else if (state is LoadedLikesGameState) {
                                    if (state.likes.isEmpty) {
                                      return Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(
                                            "Nenhuma curtida encontrada.\nSeja o primeiro a curtir!",
                                            style: GoogleFonts.nunitoSans(fontSize: 16),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      );
                                    }

                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: state.likes.length,
                                      itemBuilder: (context, index) {
                                        return FadeInLeft(
                                          child: Card(
                                            elevation: 5,
                                            child: ListTile(
                                              leading: CircleAvatar(
                                                backgroundColor: Colors.pink,
                                                child: Center(
                                                  child: Text(state.likes[index].usuario[0], style: GoogleFonts.nunitoSans(fontSize: 20, color: Colors.white)),
                                                ),
                                              ),
                                              title: Text(state.likes[index].usuario, style: GoogleFonts.nunitoSans(fontSize: 16, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                                              subtitle: Text("${state.likes[index].tipo == 1 ? 'Gostou' : 'Favoritou'} em ${state.likes[index].updated}", style: GoogleFonts.nunitoSans(fontSize: 12), overflow: TextOverflow.ellipsis),
                                              //trailing: state.likes[index].tipo == 1 ? const Icon(Icons.favorite_rounded, color: Colors.pink) : const Icon(Icons.star_rounded, color: Colors.blue),
                                              trailing: state.likes[index].usuarioID == pbService.pb.authStore.model.id
                                                  ? null
                                                  : IconButton(
                                                      onPressed: () {
                                                        Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                            builder: (context) => ChatPage(
                                                              pb: pbService,
                                                              idDestinatario: state.likes[index].usuarioID,
                                                              nomeDestinatario: state.likes[index].usuario,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      icon: const Icon(Icons.chat_rounded),
                                                    ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text("Erro ao carregar o jogo"));
          }
        },
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageInfo,
        onDestinationSelected: (index) {
          setState(() {
            currentPageInfo = index;
          });
          _pageControllerInfo.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
        },
        indicatorColor: Theme.of(context).colorScheme.primary,
        destinations: [
          NavigationDestination(
            icon: currentPageInfo != 0 ? const Icon(CupertinoIcons.info_circle) : const Icon(CupertinoIcons.info_circle_fill),
            label: 'Informações',
          ),
          NavigationDestination(
            icon: currentPageInfo != 1 ? const Icon(CupertinoIcons.star) : const Icon(CupertinoIcons.star_fill),
            label: 'Reviews',
          ),
          NavigationDestination(
            icon: Icon(currentPageInfo != 2 ? CupertinoIcons.person_2 : CupertinoIcons.person_2_fill),
            label: 'Pessoas',
          ),
          /*
                  NavigationDestination(
                    icon: Badge(child: Icon(currentPageInfo != 2 ? CupertinoIcons.person_2 : CupertinoIcons.person_2_fill)),
                    label: 'Pessoas',
                  ),
                  */
        ],
      ),
    );
  }
}
