import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sqflite/sqflite.dart';
import 'package:teste_sua_musica/database/dao/games_dao.dart';

import '../database/app_database.dart';
import '../http/games_client.dart';
import '../models/game.dart';
import '../models/plataform.dart';
import 'games_card.dart';

class CustomContent extends StatelessWidget {
  final Plataform plataform;
  final GamesClient gamesClient = GamesClient();
  final GamesDao _gamesDao = GamesDao();

  CustomContent({Key? key, required this.plataform}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Game>>(
        initialData: const [],
        future: getGamesByPlataformId(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              List<Game>? games = snapshot.data ?? [];

              if (games.isNotEmpty) {
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
              return const Center(
                child: Text("No Games in this Plataform"),
              );
          }
        });
  }

  Future addGames() async {
    List<Game> games = await gamesClient.getGames();
    for (var game in games) {
      _gamesDao.save(game);
    }
  }

  Future<List<Game>> getGamesByPlataformId() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      await addGames();
    }
    List<Game> games = await _gamesDao.findAll();
    List<Game> gamesByPlataformId = [];
    for (var game in games) {
      if (game.plataforms.isNotEmpty &&
          game.plataforms.contains(plataform.id.toString())) {
        gamesByPlataformId.add(game);
      }
    }

    return gamesByPlataformId;
  }
}
