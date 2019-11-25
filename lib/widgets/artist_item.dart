import 'package:flutter/material.dart';

import '../models/artist.dart';

class ArtistItem extends StatelessWidget {
  final Artist artist;
  const ArtistItem(this.artist);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          artist.image != null
              ? Image.network(artist.image, width: 200, height: 200)
              : Container(
                  color: Colors.purple.shade300,
                  width: 200,
                  height: 200,
                ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(artist.name),
          )
        ],
      ),
    );
  }
}
