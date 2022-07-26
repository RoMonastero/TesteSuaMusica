import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_sua_musica/models/game.dart';
import 'package:teste_sua_musica/models/plataform.dart';

import '../database/dao/games_dao.dart';
import '../http/games_client.dart';

class GamesCubit extends Cubit<List<Game>> {
  GamesCubit() : super([]);

  final GamesClient _gamesClient = GamesClient();
  final GamesDao _gamesDao = GamesDao();

  Future addGames() async {
    List<Game> games = await _gamesClient.getGames();
    for (var game in games) {
      _gamesDao.save(game);
    }
  }

  Future getGamesByPlataformId(Plataform plataform) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      await addGames();
    }
    List<Game> games = await _gamesDao.findAll();
    List<Game> gamesByPlataformId = [];
    for (var game in games) {
      if (game.plataforms.isNotEmpty &&
          game.plataforms.contains(plataform.id.toString())) {
        gamesByPlataformId.add(game);
      }
    }

    emit(gamesByPlataformId);
  }
}
