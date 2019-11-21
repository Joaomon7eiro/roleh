import 'package:flutter/material.dart';

import './pages/home_page.dart';

main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomePage.routeName,
      routes: {HomePage.routeName: (context) => HomePage()},
    );
  }
}
