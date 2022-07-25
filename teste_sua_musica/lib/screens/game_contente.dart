import 'package:flutter/material.dart';
import 'package:teste_sua_musica/models/genre.dart';
import 'package:teste_sua_musica/models/plataform.dart';

import '../components/text_description.dart';
import '../http/games_client.dart';
import '../models/cover.dart';
import '../models/game.dart';

class GameContent extends StatelessWidget {
  final Game game;
  final Cover? cover;
  final GamesClient gamesClient = GamesClient();

  GameContent({Key? key, required this.game, this.cover}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: cover != null
                  ? Image.network(
                      'https:${cover!.url}',
                      scale: 0.5,
                    )
                  : SizedBox(
                      child: const Center(child: Text('No Image Found')),
                      height: size.height * 0.2,
                    ),
            ),
            SizedBox(
              width: size.width,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        game.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      FutureBuilder<List<Genre>>(
                          future: getGenresByGame(),
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.done:
                                List<Genre>? genres = snapshot.data ?? [];
                                if (genres.isNotEmpty) {
                                  return TextDescription(
                                    contents: genres,
                                    contentType: 'Genres',
                                  );
                                } else {
                                  return const Text(
                                    'Genre: ',
                                    style: TextStyle(fontSize: 16),
                                  );
                                }

                              case ConnectionState.waiting:
                                return const Text(
                                  'Genre: ...',
                                  style: TextStyle(fontSize: 16),
                                );

                              default:
                                return const Text(
                                  'Genre: ...',
                                  style: TextStyle(fontSize: 16),
                                );
                            }
                          }),
                      const SizedBox(
                        height: 12,
                      ),
                      FutureBuilder<List<Plataform>>(
                          future: getPlataformsByGame(),
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.done:
                                List<Plataform>? plataforms =
                                    snapshot.data ?? [];
                                if (plataforms.isNotEmpty) {
                                  return TextDescription(
                                    contents: plataforms,
                                    contentType: 'Plataforms',
                                  );
                                } else {
                                  return const Text(
                                    'Plataforms: ',
                                    style: TextStyle(fontSize: 16),
                                  );
                                }

                              case ConnectionState.waiting:
                                return const Text(
                                  'Plataforms: ...',
                                  style: TextStyle(fontSize: 16),
                                );

                              default:
                                return const Text(
                                  'Plataforms: ...',
                                  style: TextStyle(fontSize: 16),
                                );
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: size.width,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    game.summary,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<List<Plataform>> getPlataformsByGame() async {
    final String plataformsId = game.plataformsIdToString();

    final List<Plataform> plataforms =
        await gamesClient.getPlataformsByGame(plataformsId);

    return plataforms;
  }

  Future<List<Genre>> getGenresByGame() async {
    final String genresId = game.genresIdToString();

    final List<Genre> genres = await gamesClient.getGenresByGame(genresId);

    return genres;
  }
}
