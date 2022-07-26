import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_sua_musica/components/text_description.dart';
import 'package:teste_sua_musica/models/game.dart';

import '../bloc/plataforms_cubit.dart';
import '../models/plataform.dart';

class PlataformsDescription extends StatelessWidget {
  final Game game;
  const PlataformsDescription({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.read<PlataformsCubit>().getPlataformsByGame(game),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return BlocBuilder<PlataformsCubit, List<Plataform>>(
                  builder: (context, state) {
                List<Plataform>? plataforms = state;
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
              });

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
        });
  }
}
