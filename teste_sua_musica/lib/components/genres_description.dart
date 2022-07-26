import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_sua_musica/components/text_description.dart';
import 'package:teste_sua_musica/models/game.dart';

import '../bloc/genres_cubit.dart';
import '../models/genre.dart';

class GenresDescription extends StatelessWidget {
  final Game game;
  const GenresDescription({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.read<GenresCubit>().getGenresByGame(game),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return BlocBuilder<GenresCubit, List<Genre>>(
                  builder: (context, state) {
                List<Genre>? genres = state;
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
              });

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
        });
  }
}
