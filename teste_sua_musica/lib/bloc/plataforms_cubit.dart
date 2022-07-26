import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_sua_musica/models/game.dart';
import 'package:teste_sua_musica/models/plataform.dart';

import '../database/dao/plataforms_dao.dart';

class PlataformsCubit extends Cubit<List<Plataform>> {
  PlataformsCubit() : super([]);

  final PlataformDao _plataformDao = PlataformDao();

  Future getPlataformsByGame(Game game) async {
    final List<Plataform> plataforms = await _plataformDao.findAll();

    List<Plataform> plataformByGameId = [];
    for (var plataform in plataforms) {
      if (game.plataforms.isNotEmpty &&
          game.plataforms.contains(plataform.id.toString())) {
        plataformByGameId.add(plataform);
      }
    }

    emit(plataformByGameId);
  }
}
