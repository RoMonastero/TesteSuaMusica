import 'package:flutter/material.dart';
import '../components/genres_description.dart';
import '../components/plataforms_description.dart';
import '../models/cover.dart';
import '../models/game.dart';

class GameContent extends StatelessWidget {
  final Game game;
  final Cover? cover;

  const GameContent({Key? key, required this.game, this.cover})
      : super(key: key);

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
                      GenresDescription(
                        game: game,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      PlataformsDescription(
                        game: game,
                      ),
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
}
