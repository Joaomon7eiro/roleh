import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/spotify_provider.dart';
import '../widgets/genre_item.dart';

class GenrePage extends StatefulWidget {
  @override
  _GenrePageState createState() => _GenrePageState();
}

class _GenrePageState extends State<GenrePage> {
  var _genres = [];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SpotifyProvider>(context);
    _genres = provider.getGenres;

    return GridView.builder(
      padding: EdgeInsets.all(20),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 2 / 1,
          crossAxisSpacing: 5,
          mainAxisSpacing: 10),
      itemCount: _genres.length,
      itemBuilder: (context, index) => GenreItem(_genres[index]),
    );
  }
}
