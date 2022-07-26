import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/content_view.dart';
import '../components/custom_content.dart';
import '../components/custom_tab.dart';
import '../database/dao/plataforms_dao.dart';
import '../http/games_client.dart';
import '../models/plataform.dart';

class TabCubit extends Cubit<List<ContentView>> {
  TabCubit() : super([]);

  final GamesClient _gamesClient = GamesClient();

  List<ContentView> contentViews = [];
  final PlataformDao _plataformDao = PlataformDao();

  Future addPlataforms() async {
    List<Plataform> plataforms = await _gamesClient.getPlataforms();
    for (var plataform in plataforms) {
      _plataformDao.save(plataform);
    }
  }

  Future addTabs() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      await addPlataforms();
    }

    contentViews = [];
    List<Plataform> plataforms = await _plataformDao.findAll();
    for (var plataform in plataforms) {
      contentViews.add(
        ContentView(
            tab: CustomTab(title: plataform.name),
            content: CustomContent(
              plataform: plataform,
            )),
      );
    }
    emit(contentViews);
  }
}
