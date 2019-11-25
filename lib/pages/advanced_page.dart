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
              title: "Acústico",
              label1: "Som gravado",
              label2: "Som acústico",
            ),
            AdvancedItem(
              name: "danceability",
              title: "Dançante",
              label1: "Não mesmo",
              label2: "Muito dançante",
            ),
//            AdvancedItem(
//              name: "duration_ms",
//            ),
            AdvancedItem(
              name: "energy",
              title: "Energia",
              label1: "Calma",
              label2: "Agitada",
            ),
            AdvancedItem(
              name: "instrumentalness",
              title: "Instrumental",
              label1: "Com Vocal",
              label2: "Sem Vocal",
            ),

            AdvancedItem(
              name: "liveness",
              title: "Ao vivo",
              label1: "Som gravado",
              label2: "Som ao vivo",
            ),
//            AdvancedItem(
//              name: "loudness",
//            ),
            AdvancedItem(
              name: "valence",
              title: "Sensação",
              label1: "Triste",
              label2: "Feliz",
            ),
            AdvancedItem(
              name: "popularity",
              title: "Popularidade atualmente",
              label1: "Toca em barzinhos",
              label2: "Turnê Mundial",
            ),
//            AdvancedItem(
//              name: "speechiness",
//              title: "acousticness",
//              label1: "acousticness",
//              label2: "acousticness",
//            ),
            AdvancedItem(
              name: "tempo",
              title: "BPM",
              label1: "Lenta",
              label2: "Rápida",
            ),
            AdvancedItem(
              name: "key",
              title: "Tom da música",
              label1: "DÓ",
              label2: "SÍ",
            ),
            AdvancedItem(
              name: "mode",
              title: "Escala da música",
              label1: "Menor",
              label2: "Maior",
            ),
//            AdvancedItem(
//              name: "time_signature",
//            ),
          ],
        ),
      ),
    );
  }
}
