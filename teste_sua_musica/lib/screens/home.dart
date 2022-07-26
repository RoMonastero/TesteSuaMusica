import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/tab_cubit.dart';
import '../components/content_view.dart';
import '../components/custom_tab_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//Adicionar a estrutura do BLOC e passar as chamadas de funcao para ele
class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
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
                future: context.read<TabCubit>().addTabs(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      return BlocBuilder<TabCubit, List<ContentView>>(
                          builder: (context, state) {
                        return DefaultTabController(
                          length: state.length,
                          child: Column(
                            children: [
                              CustomTabBar(
                                tabs: state.map((e) => e.tab).toList(),
                              ),
                              Expanded(
                                child: TabBarView(
                                    children:
                                        state.map((e) => e.content).toList()),
                              ),
                            ],
                          ),
                        );
                      });

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
