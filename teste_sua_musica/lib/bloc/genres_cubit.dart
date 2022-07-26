import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../database/dao/genre_dao.dart';
import '../http/games_client.dart';
import '../models/game.dart';
import '../models/genre.dart';

class GenresCubit extends Cubit<List<Genre>> {
  GenresCubit() : super([]);

  final GenreDao _genreDao = GenreDao();
  final GamesClient gamesClient = GamesClient();

  Future addGenres(Game game) async {
    final String genresId = game.genresIdToString();

    List<Genre> genres = await gamesClient.getGenresByGame(genresId);

    for (var genre in genres) {
      _genreDao.save(genre);
    }
  }

  Future getGenresByGame(Game game) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      await addGenres(game);
    }

    List<Genre> genres = await _genreDao.findAll();

    List<Genre> genreByGameId = [];
    for (var genre in genres) {
      if (game.genres.isNotEmpty && game.genres.contains(genre.id.toString())) {
        genreByGameId.add(genre);
      }
    }

    emit(genreByGameId);
  }
}
