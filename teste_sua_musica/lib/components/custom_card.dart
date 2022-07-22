import 'package:flutter/material.dart';
import 'package:teste_sua_musica/models/cover.dart';
import 'package:teste_sua_musica/models/game.dart';

class CustomCard extends StatelessWidget {
  final Game game;
  final Cover? cover;
  const CustomCard({Key? key, required this.game, this.cover})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.grey[400]!)),
        child: Column(
          mainAxisAlignment: cover != null
              ? MainAxisAlignment.spaceAround
              : MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            cover != null
                ? Image.network(
                    'https:${cover!.url}',
                  )
                : const Text('No Image Found'),
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
    );
  }
}
