import 'package:flutter/material.dart';

import '../models/track.dart';

class PlaylistTrackItem extends StatelessWidget {
  final Track track;

  const PlaylistTrackItem(this.track);

  Widget getArtists() {
    String artistsNames = "";
    track.artists.map((artist) {
      artistsNames += '${artist.name} ';
    }).toList();

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        artistsNames,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      height: 60,
      child: Column(
        children: <Widget>[
          Text(
            track.name,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          getArtists(),
        ],
      ),
    );
  }
}
