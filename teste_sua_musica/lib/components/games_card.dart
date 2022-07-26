import 'package:flutter/material.dart';
import 'package:teste_sua_musica/container/game_content_container.dart';
import 'package:teste_sua_musica/models/game.dart';

import '../http/games_client.dart';
import '../models/cover.dart';
import 'custom_card.dart';
import 'loading_card.dart';

class GamesCard extends StatelessWidget {
  final Game game;
  final GamesClient _gamesClient = GamesClient();
  GamesCard({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Cover>(
        future: gameImage(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasData) {
                Cover cover = snapshot.data!;

                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => GameContentContainer(
                              game: game,
                              cover: cover,
                            ))));
                  },
                  child: CustomCard(game: game, cover: cover),
                );
              } else {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => GameContentContainer(
                              game: game,
                            ))));
                  },
                  child: CustomCard(game: game),
                );
              }

            default:
              return const LoadingCard();
          }
        });
  }

  Future<Cover> gameImage() async {
    return _gamesClient.getGameImage(game.id);
  }
}
