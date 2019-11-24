import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/spotify_provider.dart';
import './providers/filter_provider.dart';

import './pages/auth_page.dart';
import './pages/home_page.dart';
import './pages/playlist_page.dart';
import './pages/advanced_page.dart';

main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (_) => SpotifyProvider(),
        ),
        ChangeNotifierProvider(
          builder: (_) => FilterProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AuthPage.routeName,
        routes: {
          AuthPage.routeName: (context) => AuthPage(),
          HomePage.routeName: (context) => HomePage(),
          PlaylistPage.routeName: (context) => PlaylistPage(),
          AdvancedPage.routeName: (context) => AdvancedPage(),
        },
      ),
    );
  }
}
