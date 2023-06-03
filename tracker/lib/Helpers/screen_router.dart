import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tracker/screens/home.dart';

import '../screens/settings.dart';

class ScreenRouter extends StatefulWidget {
  const ScreenRouter({
    Key? key,
  }) : super(key: key);

  @override
  _ScreenRouterState createState() => _ScreenRouterState();
}

class _ScreenRouterState extends State<ScreenRouter> {
  List<Widget> pages = [];

  int _selected_page = 0;

  void changePage(page_tapped) {
    setState(() {
      _selected_page = page_tapped;
    });
  }

  @override
  void initState() {
    //Put in the Pages here
    pages = [
      Home(),
      Settings(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selected_page],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        items: [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.house), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.gear), label: "Settings"),
        ],
        currentIndex: _selected_page,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: changePage,
      ),
    );
  }
}
