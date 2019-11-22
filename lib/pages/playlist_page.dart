import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/spotify_provider.dart';
import '../models/track.dart';
import '../widgets/track_item.dart';

class PlaylistPage extends StatefulWidget {
  static final routeName = "/playlist-page";

  @override
  _PlaylistPageState createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  List<Track> recommendations = [];
  var currentGenres;

  void savePlaylist(context) {
    var provider = Provider.of<SpotifyProvider>(context);
    List<String> uris = recommendations.map((rec) {
      return rec.uri;
    }).toList();
    var urisFormat = {"uris": uris};
    provider.createPlaylist("$currentGenres", urisFormat);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var genres = ModalRoute.of(context).settings.arguments;
    var provider = Provider.of<SpotifyProvider>(context);
    if (currentGenres != genres) {
      currentGenres = genres;
      provider.clearRecommendations();
      provider.fetchRecommendations(genres);
    }
    recommendations = provider.recommendations;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          color: Colors.pink.shade50,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Container(
                  width: 50,
                  margin: EdgeInsets.all(10),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Colors.greenAccent,
                    onPressed: () {
                      savePlaylist(context);
                    },
                    child: Text(
                      "Salvar Playlist",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return TrackItem(recommendations[index]);
                }, childCount: recommendations.length),
              )
            ],
          ),
        ),
      ),
    );
  }
}
