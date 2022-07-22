import 'package:flutter/material.dart';

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
              padding: const EdgeInsets.all(16),
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
                  padding: const EdgeInsets.all(8.0),
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
                      const Text('Genre: Aqui vão os generos'),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text('Plataforms: Aqui vão as plataformas'),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: size.width,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(game.summary),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
