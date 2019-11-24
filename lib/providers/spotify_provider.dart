import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'dart:convert';

import '../models/track.dart';
import '../models/user.dart';

class SpotifyProvider extends ChangeNotifier {
  var accessToken;
  var genres = [];
  List<Track> recommendations = [];
  User currentUser;
  Dio dio = Dio();

  void fetchUser() async {
    var response = await http.get('https://api.spotify.com/v1/me',
        headers: {"Authorization": 'Bearer $accessToken'});

    print(response.body);
    if (response.statusCode == 200) {
      currentUser = User.fromJson(jsonDecode(response.body));
    }
  }

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

  void fetchRecommendations(params) async {
    recommendations = [];

    var seedArtists = "";
    var seedTracks = "";
    var limit = 50;

    var queryParams = <String, dynamic>{
      ...params,
      "seed_artists": seedArtists,
      "seed_tracks": seedTracks,
      "limit": limit,
    };

    print(queryParams);
    var response;
    try {
      response = await dio.get("https://api.spotify.com/v1/recommendations",
          queryParameters: queryParams,
          options: Options(headers: {"Authorization": 'Bearer $accessToken'}));
    } catch (e) {
      print(e);
      return;
    }

    print('recommendation ${response.data}');
    if (response.statusCode == 200) {
      var recommendationsJson = response.data["tracks"];
      recommendations = [];
      for (var rec in recommendationsJson) {
        recommendations.add(Track.fromJson(rec));
      }
      notifyListeners();
      return;
    }
    print("error fetching genres");
  }

  void createPlaylist(name, uris) async {
    var response = await http.post(
      'https://api.spotify.com/v1/users/${currentUser.id}/playlists',
      headers: {
        "Authorization": 'Bearer $accessToken',
        "Content-Type": "application/json"
      },
      body: jsonEncode({"name": name}),
    );
    print(response.body);
    if (response.statusCode == 201) {
      String playlistId = jsonDecode(response.body)["id"];
      addSongsToPlaylist(playlistId, uris);
    }
  }

  void addSongsToPlaylist(playlistId, uris) async {
    print('uris=${jsonEncode(uris)}');
    var response = await http.post(
        'https://api.spotify.com/v1/playlists/$playlistId/tracks',
        headers: {
          "Authorization": 'Bearer $accessToken',
          "Content-Type": "application/json"
        },
        body: jsonEncode(uris));
    print(response.body);
    if (response.statusCode == 201) {
      print("playlist criada com sucesso");
    }
  }

  List<dynamic> get getGenres {
    return genres;
  }

  List<dynamic> get getRecommendations {
    return recommendations;
  }

  Future<bool> connectUser() async {
    var url = "https://accounts.spotify.com";
    var redirectUri = "com.joaomonteirodev.roleh://callback";
    var clientId = "ef6110c9782d4a20a6ec09da44d51911";
    var clientSecret = "b62c350a38d345e0af11adc23bc6a289";
    var responseType = "code";
    var scope = "playlist-modify-public";

    final authResult = await FlutterWebAuth.authenticate(
      url:
          "$url/authorize?client_id=$clientId&response_type=$responseType&scope=$scope&redirect_uri=$redirectUri",
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

    fetchUser();
    return accessToken != null;
  }
}
