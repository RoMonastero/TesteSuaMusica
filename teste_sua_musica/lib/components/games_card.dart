import 'package:flutter/material.dart';
import 'package:teste_sua_musica/models/game.dart';

import '../http/games_client.dart';
import '../models/cover.dart';

class GamesCard extends StatelessWidget {
  final Game game;
  final GamesClient gamesClient = GamesClient();
  GamesCard({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: Container(
          decoration:
              BoxDecoration(border: Border.all(color: Colors.grey[400]!)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FutureBuilder<Cover>(
                  future: gameImage(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                        if (snapshot.hasData) {
                          Cover cover = snapshot.data!;
                          return Image.network(
                            'https:${cover.url}',
                          );
                        } else {
                          return const Text('No Image Found');
                        }

                      default:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                    }
                  }),
              Text(
                game.name,
                style: const TextStyle(
                  
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Cover> gameImage() async {
    return gamesClient.getGameImage(game.id);
  }
}
