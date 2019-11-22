import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roleh/pages/home_page.dart';
import '../providers/spotify_provider.dart';

class AuthPage extends StatefulWidget {
  static final routeName = "/";

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  void connect() async {
    var isConnected = await Provider.of<SpotifyProvider>(context, listen: false)
        .connectUser();
    if (isConnected) {
      print("deu bao");
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    } else {
      print("deu ruim");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.pink.shade50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "Gerador de Playlists",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.greenAccent,
              onPressed: connect,
              child: Text("Entrar"),
            ),
          ],
        ),
      ),
    );
  }
}
