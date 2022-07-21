import 'package:flutter/material.dart';

import '../http/games_client.dart';
import '../models/game.dart';
import '../models/plataform.dart';

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
                return ListView.builder(
                  itemCount: games.length,
                  itemBuilder: (context, index) {
                    Game game = games[index];
                    return Text(game.name);
                  },
                );
              } else {
                return const Text("No Games in this Plataform");
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
      if (game.platforms.isNotEmpty && game.platforms.contains(plataform.id)) {
        gamesByPlataformId.add(game);
      }
    }

    return gamesByPlataformId;
  }
}
