import 'package:flutter/material.dart';

class PlaylistPage extends StatelessWidget {
  static final routeName = "/playlist-page";

  @override
  Widget build(BuildContext context) {
    var genres = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: SafeArea(
        child: Text("$genres"),
      ),
    );
  }
}
