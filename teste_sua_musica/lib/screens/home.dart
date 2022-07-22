import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:teste_sua_musica/components/content_view.dart';
import 'package:teste_sua_musica/components/custom_tab.dart';
import 'package:teste_sua_musica/database/dao/plataforms_dao.dart';
import 'package:teste_sua_musica/http/games_client.dart';
import 'package:teste_sua_musica/models/plataform.dart';

import '../components/custom_content.dart';
import '../components/custom_tab_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final GamesClient gamesClient = GamesClient();
  TabController? tabController;
  List<ContentView> contentViews = [];
  final PlataformDao _dao = PlataformDao();

  Future addPlataforms() async {
    List<Plataform> plataforms = await gamesClient.getPlataforms();
    for (var plataform in plataforms) {
      _dao.save(plataform);
    }
  }

  Future addTabs() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      await addPlataforms();
    }

    contentViews = [];
    List<Plataform> plataforms = await _dao.findAll();
    for (var plataform in plataforms) {
      contentViews.add(
        ContentView(
            tab: CustomTab(title: plataform.name),
            content: CustomContent(
              plataform: plataform,
            )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                initialData: _dao.findAll(),
                future: addTabs(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      return DefaultTabController(
                        length: contentViews.length,
                        child: Column(
                          children: [
                            CustomTabBar(
                              tabs: contentViews.map((e) => e.tab).toList(),
                            ),
                            Expanded(
                              child: TabBarView(
                                  children: contentViews
                                      .map((e) => e.content)
                                      .toList()),
                            ),
                          ],
                        ),
                      );

                    default:
                      return Container();
                  }
                }),
          ),
        ],
      ),
    );
  }
}
