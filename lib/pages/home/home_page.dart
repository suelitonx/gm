import 'dart:math';
import 'package:animate_do/animate_do.dart';
import 'package:animated_react_button/animated_react_button.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:banner_carousel/banner_carousel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gamematch/models/review.dart';
import 'package:gamematch/states/game_info_state.dart';
import 'package:gamematch/states/games_state.dart';
import 'package:gamematch/states/likes_game_state.dart';

import 'package:gamematch/stores/game_info_store.dart';
import 'package:gamematch/stores/game_store.dart';
import 'package:gamematch/stores/likes_game_store.dart';
import 'package:gamematch/stores/reviews_store.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../models/game.dart';
import '../../services/auth_service.dart';
import '../../services/data.dart';
import '../../services/json_games.dart';
import '../../services/like_service.dart';
import '../../services/pocketbase_service.dart';
import '../../theme/theme_model.dart';
import '../jogos_curtidos/jogos_curtidos_page.dart';
//import 'widgets/carrousel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;

  final GameStore gameStore = GameStore();
  final GameInfoStore gameInfoStore = GameInfoStore();
  final ReviewStore reviewStore = ReviewStore();
  final LikesGameStore likesGameStore = LikesGameStore();

  final TextEditingController _controllerReview = TextEditingController();
  double currentRating = 1;

  final auth = AuthService();
  final themeService = ThemeModel.instance;
  final pbService = PocketbaseService.instance;

  bool _loading = false;
  bool _dandoLike = false;
  bool _liked = false;

  final AppinioSwiperController controller = AppinioSwiperController();
  final PageController _pageController = PageController();
  final PageController _pageControllerInfo = PageController();
  final _controller = ConfettiController(
    duration: const Duration(seconds: 1),
  );

  int i = 0;
  int currentPage = 0;
  int currentPageInfo = 0;

  @override
  void initState() {
    _scrollController = ScrollController();
    gameStore.getGames();
    themeService.addListener(_listener);

    super.initState();
  }

  void _listener() => setState(() {});

  @override
  void dispose() {
    _scrollController.dispose();
    _controller.dispose();
    controller.dispose();
    themeService.removeListener(_listener);
    _pageController.dispose();
    _pageControllerInfo.dispose();
    _controllerReview.dispose();
    likesGameStore.dispose();
    gameInfoStore.dispose();
    gameStore.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: buildDrawer(),
        appBar: currentPage == 0
            ? AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: Text("GameMatch", style: GoogleFonts.bebasNeue(fontSize: 30)),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: currentPage == 0
                      ? Builder(
                          builder: (BuildContext context) {
                            return IconButton(
                              icon: Icon(
                                Icons.menu_rounded,
                                color: themeService.isDarkMode ? Colors.white : null,
                              ),
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                              tooltip: "Menu",
                            );
                          },
                        )
                      : IconButton(
                          onPressed: () {
                            _pageController.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                          },
                          icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      auth.logout();
                    },
                    icon: const Icon(Icons.logout),
                  ),
                  const SizedBox(width: 10),
                ],
              )
            : null,
        body: SafeArea(
          child: PageView(
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: [
              ValueListenableBuilder(
                valueListenable: gameStore,
                builder: (context, state, _) {
                  if (state is LoadingGamesState || state is EmptyGamesState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ErrorGamesState) {
                    return Center(child: Text(state.error));
                  } else if (state is LoadedGamesState) {
                    return Column(
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height * 0.75,
                            maxWidth: 500,
                          ),
                          child: AppinioSwiper(
                            maxAngle: 20,
                            backgroundCardScale: 0.6,
                            controller: controller,
                            cardCount: state.games.length,
                            initialIndex: i,
                            onSwipeEnd: (previousIndex, targetIndex, activity) {
                              return _swipeEnd(previousIndex, targetIndex, activity, state.games);
                            },
                            cardBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(image: CachedNetworkImageProvider(state.games[index].thumbnail), fit: BoxFit.cover, onError: (exception, stackTrace) => const Icon(Icons.error_rounded)),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        stops: [0.7, 1],
                                        colors: [Colors.transparent, Colors.black],
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          ConfettiWidget(
                                            confettiController: _controller,
                                            blastDirection: -pi / 2,
                                            emissionFrequency: 0.02,
                                            numberOfParticles: 15,
                                            gravity: 0.8,
                                            blastDirectionality: BlastDirectionality.explosive,
                                            //shouldLoop: true,
                                            colors: const [Colors.red, Colors.blue, Colors.green, Colors.yellow],
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: AnimatedContainer(
                                              decoration: BoxDecoration(
                                                color: themeService.isDarkMode ? Colors.black : Colors.white,
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(color: Colors.black38, width: 1),
                                              ),
                                              duration: const Duration(milliseconds: 600),
                                              child: Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Text(
                                                  getGenero(state.games[index].genre),
                                                  style: GoogleFonts.nunitoSans(color: themeService.isDarkMode ? Colors.white : Colors.black, fontSize: 12),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                          GestureDetector(
                                            onTap: () async {
                                              //_shakeCard();
                                              i = index;
                                              currentPageInfo = 0;
                                              _loading = true;

                                              gameInfoStore.getGameInfo(state.games[index].id);

                                              likesGameStore.isLiked(gameID: state.games[index].id).then((value) {
                                                if (kDebugMode) {
                                                  print("Liked ${state.games[index].title}: $value");
                                                }
                                                setState(() {
                                                  _liked = value;
                                                });
                                              });

                                              await _pageController.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                                              //_pageControllerInfo.jumpToPage(0);
                                              setState(() {});

                                              Future.delayed(const Duration(milliseconds: 3000), () {
                                                _loading = false;
                                                setState(() {});
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(getIconPlataform(index), color: Colors.white),
                                                    const SizedBox(width: 10),
                                                    Expanded(
                                                      child: Text(
                                                        state.games[index].title,
                                                        style: GoogleFonts.nunitoSans(color: Colors.white, fontSize: 20),
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  state.games[index].description,
                                                  style: GoogleFonts.nunitoSans(color: Colors.white, fontSize: state.games[index].description.length < 120 ? 15 : 12),
                                                  textAlign: TextAlign.justify,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        // Bottom
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  controller.swipeLeft();
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(20),
                                  foregroundColor: Colors.red,
                                  elevation: 10,
                                ),
                                child: const Center(child: Icon(Icons.close_rounded, size: 40)),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  controller.swipeUp();
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(20),
                                  foregroundColor: Colors.blue,
                                  elevation: 10,
                                ),
                                child: const Center(child: Icon(Icons.star_rounded, size: 40)),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  controller.swipeRight();
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(20),
                                  foregroundColor: Colors.pink,
                                  elevation: 10,
                                ),
                                child: const Center(child: Icon(Icons.favorite, size: 40)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              ValueListenableBuilder(
                valueListenable: gameInfoStore,
                builder: (context, state, _) {
                  if (state is EmptyGameInfoState || state is LoadingGameInfoState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is LoadedGameInfoState) {
                    final g = state.currentGame;

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Skeletonizer(
                            enabled: _loading,
                            ignoreContainers: false,
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
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  _pageController.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
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

                                      final lService = LikeService();
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
                                      Skeletonizer(
                                        enabled: _loading,
                                        ignoreContainers: true,
                                        ignorePointers: true,
                                        child: BannerCarousel(
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
                                                      trailing: state.likes[index].tipo == 1 ? const Icon(Icons.favorite_rounded, color: Colors.pink) : const Icon(Icons.star_rounded, color: Colors.blue),
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
                  } else if (state is ErrorGameInfoState) {
                    return Center(child: Text(state.error));
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: currentPage == 1
            ? NavigationBar(
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
              )
            : null);
  }

  Widget buildDrawer() {
    return Drawer(
      elevation: 4,
      semanticLabel: "Configurações",
      width: MediaQuery.of(context).size.width * 0.85,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(pbService.pb.authStore.model.data["name"], style: GoogleFonts.nunitoSans(color: Colors.black), overflow: TextOverflow.ellipsis),
            accountEmail: Text(pbService.pb.authStore.model.data["username"] ?? "Email indisponível", style: GoogleFonts.nunitoSans(color: Colors.black), overflow: TextOverflow.ellipsis),
            currentAccountPicture: Icon(Icons.person_rounded, size: 50, color: themeService.isDarkMode ? Colors.black : Colors.white),
            decoration: BoxDecoration(color: Colors.pink.shade400),
            otherAccountsPictures: [
              IconButton(
                onPressed: () async {
                  auth.logout();
                },
                icon: Icon(Icons.logout_rounded, color: themeService.isDarkMode ? Colors.black : Colors.white),
              ),
            ],
            onDetailsPressed: null,
          ),

          //Divider(color: themeService.isDarkMode ? Colors.grey.shade800 : null),
          SwitchListTile(
            value: themeService.isDarkMode,
            onChanged: (bool value) {
              themeService.toggleTheme();
            },
            title: Text("Modo escuro", style: GoogleFonts.nunitoSans(), overflow: TextOverflow.ellipsis),
            secondary: const Icon(CupertinoIcons.moon_circle_fill),
          ),
          //Meus jogos curtidos
          ListTile(
            title: Text("Meus jogos curtidos", style: GoogleFonts.nunitoSans(), overflow: TextOverflow.ellipsis),
            leading: const Icon(Icons.favorite_rounded),
            onTap: () async {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const JogosCurtidosPage()));
            },
          ),

          Divider(color: themeService.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade400),
          ListTile(
            title: Center(child: Text("Cancelar", style: GoogleFonts.nunitoSans(color: Colors.red.shade400, fontWeight: FontWeight.bold))),
            onTap: () async {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void _swipeEnd(int previousIndex, int targetIndex, SwiperActivity activity, List<Game> jogos) async {
    switch (activity) {
      case Swipe():
        if (kDebugMode) {
          print('The card was swiped to the : ${activity.direction}');
          print('previous index: $previousIndex, target index: $targetIndex');
        }

        if (activity.direction == AxisDirection.up) {
          favoritarGame(jogos[previousIndex]);

          _controller.stop();
          _controller.play();
        } else {
          _controller.stop();
        }

        if (activity.direction == AxisDirection.right) {
          likeGame(jogos[previousIndex]);
        }

        if (activity.direction == AxisDirection.down) {
          i = previousIndex;

          if (kDebugMode) {
            print("DOWN");
          }

          gameInfoStore.getGameInfo(jogos[previousIndex].id);

          _pageController.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
          currentPageInfo = 0;
          _loading = true;

          likesGameStore.isLiked(gameID: jogos[previousIndex].id).then((value) {
            if (kDebugMode) {
              print("Liked: $value");
            }
            setState(() {
              _liked = value;
            });
          });

          controller.unswipe();

          setState(() {});

          Future.delayed(const Duration(milliseconds: 2000), () {
            _loading = false;
            setState(() {});
          });

          /*
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Você curtiu o jogo ${jogos[previousIndex].title}'),
              action: SnackBarAction(
                label: 'Desfazer',
                onPressed: () {
                  controller.unswipe();
                },
              ),
            ),
          );
          */
        }

        break;
      case Unswipe():
        if (kDebugMode) {
          print('A ${activity.direction.name} swipe was undone.');
          print('previous index: $previousIndex, target index: $targetIndex');
        }

        break;
      case CancelSwipe():
        if (kDebugMode) {
          print('A swipe was cancelled');
        }
        break;
      case DrivenActivity():
        if (kDebugMode) {
          print('Driven Activity');
        }
        break;
    }
  }
/*
  Future<void> _shakeCard() async {
    

    const double distance = 50;
    // We can animate back and forth by chaining different animations.
    await controller.animateTo(
      const Offset(-distance, 0),
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
    await controller.animateTo(
      const Offset(distance, 0),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
    // We need to animate back to the center because `animateTo` does not center
    // the card for us.
    await controller.animateTo(
      const Offset(0, 0),
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
    
  }*/

  likeGame(Game game) {
    if (kDebugMode) {
      print("Jogo curtido: ${game.title}");
    }
    likesGameStore.likeGame(gameId: game.id, type: 1);
  }

  favoritarGame(Game game) {
    if (kDebugMode) {
      print("Jogo favoritado: ${game.title}");
    }
    likesGameStore.likeGame(gameId: game.id, type: 2);
  }
}
