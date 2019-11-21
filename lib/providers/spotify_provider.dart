import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'dart:convert';

class SpotifyProvider extends ChangeNotifier {
  var accessToken;
  var genres = [];

  void fetchAvailableGenreSeeds() async {
    var response = await http.get(
        "https://api.spotify.com/v1/recommendations/available-genre-seeds",
        headers: {"Authorization": 'Bearer $accessToken'});

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      genres = jsonDecode(response.body)["genres"];
      notifyListeners();
      return;
    }
    print("error fetching genres");
  }

  void fetchRecommendations(genre) async {
    var seedArtists = "";
    var seedGenres = "$genre,chill,classical";
    var seedTracks = "";

    var response = await http.get(
        "https://api.spotify.com/v1/recommendations?seed_artists=$seedArtists&seed_genres=$seedGenres&seed_tracks=$seedTracks",
        headers: {"Authorization": 'Bearer $accessToken'});

    print('recommendation ${response.body}');
    var jsonLen = jsonDecode(response.body)["tracks"].length;
    print('recommendation  len $jsonLen');
  }

  List<dynamic> get getGenres {
    return genres;
  }

  Future<bool> connectUser() async {
    var url = "https://accounts.spotify.com";
    var redirectUri = "com.joaomonteirodev.roleh://callback";
    var clientId = "ef6110c9782d4a20a6ec09da44d51911";
    var clientSecret = "b62c350a38d345e0af11adc23bc6a289";
    var responseType = "code";

    final authResult = await FlutterWebAuth.authenticate(
      url:
          "$url/authorize?client_id=$clientId&response_type=$responseType&redirect_uri=$redirectUri",
      callbackUrlScheme: "com.joaomonteirodev.roleh",
    );

    var code = Uri.parse(authResult).queryParameters['code'];
    print('code $code');

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
    var responseJson = jsonDecode(response.body);
    accessToken = responseJson['access_token'];
    print('responseJson = ${response.body}');
    print('access_token = $accessToken');

    return accessToken != null;
  }
}
