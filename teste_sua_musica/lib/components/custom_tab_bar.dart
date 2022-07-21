import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final List<Widget> tabs;

  const CustomTabBar({Key? key, required this.tabs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TabBar(
        isScrollable: true,
        tabs: tabs,
      ),
    );
  }
}
