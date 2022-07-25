import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../http/games_client.dart';
import '../models/game.dart';
import '../models/plataform.dart';
import 'games_card.dart';

class CustomContent extends StatelessWidget {
  final Plataform plataform;
  final GamesClient gamesClient = GamesClient();

  CustomContent({Key? key, required this.plataform}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Game>>(
        future: getGamesByPlataformId(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              List<Game>? games = snapshot.data;
              if (games!.isNotEmpty) {
                return AnimationLimiter(
                  child: GridView.builder(
                    addAutomaticKeepAlives: true,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemCount: games.length,
                    itemBuilder: (context, index) {
                      Game game = games[index];
                      return GamesCard(game: game);
                    },
                  ),
                );
              } else {
                return const Center(
                  child: Text("No Games in this Plataform"),
                );
              }

            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              return const Text("No Games in this Plataform");
          }
        });
  }

  Future<List<Game>> getGamesByPlataformId() async {
    List<Game> games = await gamesClient.getGames();
    List<Game> gamesByPlataformId = [];
    for (var game in games) {
      if (game.plataforms.isNotEmpty && game.plataforms.contains(plataform.id)) {
        gamesByPlataformId.add(game);
      }
    }

    return gamesByPlataformId;
  }
}
