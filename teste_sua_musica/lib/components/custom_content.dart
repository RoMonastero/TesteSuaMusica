import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../bloc/games_cubit.dart';
import '../models/game.dart';
import '../models/plataform.dart';
import 'games_card.dart';

class CustomContent extends StatelessWidget {
  final Plataform plataform;

  const CustomContent({Key? key, required this.plataform}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<GamesCubit>().getGamesByPlataformId(plataform);
      },
      child: FutureBuilder(
          initialData: const [],
          future: context.read<GamesCubit>().getGamesByPlataformId(plataform),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return BlocBuilder<GamesCubit, List<Game>>(
                    builder: (context, state) {
                  List<Game>? games = state;
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
                });

              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              default:
                return const Center(
                  child: Text("No Games in this Plataform"),
                );
            }
          }),
    );
  }
}
