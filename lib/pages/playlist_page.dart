import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/spotify_provider.dart';
import '../providers/filter_provider.dart';
import '../models/track.dart';
import '../widgets/playlist_track_item.dart';

class PlaylistPage extends StatefulWidget {
  static final routeName = "/playlist-page";

  @override
  _PlaylistPageState createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  List<Track> recommendations = [];
  TextEditingController _textController = TextEditingController();
  var currentParams;

  void savePlaylist(context) {
    var provider = Provider.of<SpotifyProvider>(context, listen: false);
    List<String> uris = recommendations.map((rec) {
      return rec.uri;
    }).toList();
    var urisFormat = {"uris": uris};
    var playlistName = _textController.text.isEmpty
        ? currentParams["seed_genres"]
        : _textController.text;

    provider.createPlaylist(playlistName, urisFormat);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var params = ModalRoute.of(context).settings.arguments;
    var provider = Provider.of<SpotifyProvider>(context);
    if (currentParams != params) {
      currentParams = params;
      provider.fetchRecommendations(params);
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
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(labelText: "Nome da Playlist"),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return PlaylistTrackItem(recommendations[index]);
                }, childCount: recommendations.length),
              )
            ],
          ),
        ),
      ),
    );
  }
}
