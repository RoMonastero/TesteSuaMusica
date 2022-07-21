import 'package:flutter/material.dart';
import 'package:teste_sua_musica/components/content_view.dart';
import 'package:teste_sua_musica/components/custom_tab.dart';
import 'package:teste_sua_musica/http/games_client.dart';
import 'package:teste_sua_musica/models/plataforms.dart';

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

  addTabs() async {
    //DESCOBRIR COMO DEIXAR O CONTROLLER DINAMICO
    //COM O DATABASE LOCAL SE TIVER O MESMO ID NAO PERMITE ADICIONAR UM NOVO DOCUMENTO
    contentViews = [];
    List<Plataforms> plataforms = await gamesClient.getPlataforms();
    for (var plataform in plataforms) {
      contentViews.add(
        ContentView(
            tab: CustomTab(title: plataform.name),
            content: SizedBox(
              child: Text(plataform.name),
              width: 100,
              height: 100,
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
      body: FutureBuilder(
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
                            children:
                                contentViews.map((e) => e.content).toList()),
                      ),
                    ],
                  ),
                );

              default:
                return Container();
            }
          }),
    );
  }
}
