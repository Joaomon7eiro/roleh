import 'package:flutter/material.dart';

import '../models/track.dart';

class TrackItem extends StatelessWidget {
  final Track track;

  const TrackItem(this.track);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          track.image != null
              ? Image.network(track.image, width: 200, height: 200)
              : Container(
                  color: Colors.purple.shade300,
                  width: 200,
                  height: 200,
                ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(track.name),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(track.artists[0].name),
          ),
        ],
      ),
    );
  }
}
