import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  static final routeName = "/";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _accessToken;

  @override
  void initState() {
    super.initState();
    authenticate();
  }

  void authenticate() async {
    var url = "https://accounts.spotify.com";
    var redirectUri = "com.joaomonteirodev.roleh://callback";
    var clientId = "ef6110c9782d4a20a6ec09da44d51911";
    var clientSecret = "b62c350a38d345e0af11adc23bc6a289";
    var responseType = "code";

    final result = await FlutterWebAuth.authenticate(
      url:
          "$url/authorize?client_id=$clientId&response_type=$responseType&redirect_uri=$redirectUri",
      callbackUrlScheme: "com.joaomonteirodev.roleh",
    );

    var code = Uri.parse(result).queryParameters['code'];
    print('token $code');

    Map<String, String> body = {
      'grant_type': 'authorization_code',
      'code': code,
      'redirect_uri': redirectUri,
    };
    var bytes = utf8.encode('$clientId:$clientSecret');
    var base64Auth = base64.encode(bytes);

    var response = await http.post(
      '$url/api/token',
      body: body,
      headers: {
        "Authorization": 'Basic  $base64Auth',
      },
    );
    _accessToken = jsonDecode(response.body);
    print('response ${response.body}');
    print('at ${_accessToken['access_token']}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlatButton(
          color: Colors.green,
          onPressed: () async {},
          child: Text("login"),
        ),
      ),
    );
  }
}
