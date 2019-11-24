import 'package:flutter/material.dart';

import '../widgets/advanced_item.dart';

class AdvancedPage extends StatefulWidget {
  static final routeName = "/advanced-page";

  @override
  _AdvancedPageState createState() => _AdvancedPageState();
}

class _AdvancedPageState extends State<AdvancedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Parametros Avançados"),
        backgroundColor: Colors.greenAccent,
      ),
      backgroundColor: Colors.pink.shade50,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AdvancedItem(
              name: "acousticness",
            ),
            AdvancedItem(
              name: "danceability",
            ),
            AdvancedItem(
              name: "duration_ms",
            ),
            AdvancedItem(
              name: "energy",
            ),
            AdvancedItem(
              name: "instrumentalness",
            ),
            AdvancedItem(
              name: "key",
            ),
            AdvancedItem(
              name: "liveness",
            ),
            AdvancedItem(
              name: "loudness",
            ),
            AdvancedItem(
              name: "mode",
            ),
            AdvancedItem(
              name: "popularity",
            ),
            AdvancedItem(
              name: "speechiness",
            ),
            AdvancedItem(
              name: "tempo",
            ),
            AdvancedItem(
              name: "time_signature",
            ),
            AdvancedItem(
              name: "valence",
            ),
          ],
        ),
      ),
    );
  }
}
