import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/games_cubit.dart';
import '../bloc/tab_cubit.dart';
import '../screens/home.dart';

class HomeContainer extends StatelessWidget {
  const HomeContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TabCubit>(
          create: (BuildContext context) => TabCubit(),
        ),
        BlocProvider<GamesCubit>(
          create: (BuildContext context) => GamesCubit(),
        ),
      ],
      child: const MyHomePage(title: 'Game Lovers App'),
    );
  }
}
