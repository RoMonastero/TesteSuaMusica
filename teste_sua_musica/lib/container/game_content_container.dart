import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_sua_musica/models/cover.dart';

import '../bloc/genres_cubit.dart';
import '../bloc/plataforms_cubit.dart';
import '../models/game.dart';
import '../screens/game_contente.dart';

class GameContentContainer extends StatelessWidget {
  final Game game;
  final Cover? cover;
  const GameContentContainer({Key? key, required this.game, this.cover})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GenresCubit>(
          create: (BuildContext context) => GenresCubit(),
        ),
        BlocProvider<PlataformsCubit>(
          create: (BuildContext context) => PlataformsCubit(),
        ),
      ],
      child: GameContent(
        game: game,
        cover: cover,
      ),
    );
  }
}
