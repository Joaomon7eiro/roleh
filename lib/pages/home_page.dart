import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roleh/pages/playlist_page.dart';

import '../providers/spotify_provider.dart';
import '../widgets/genre_item.dart';

class HomePage extends StatefulWidget {
  static final routeName = "/home-page";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var maxSelected = 5;

  var _genres;
  var _selectedGenres = [];

  void increment(genre) {
    if (_selectedGenres.length < maxSelected) {
      setState(() {
        _selectedGenres.add(genre);
      });
    }
  }

  void decrement(genre) {
    if (_selectedGenres.length > 0) {
      setState(() {
        _selectedGenres.remove(genre);
      });
    }
  }

  bool exists(genre) {
    return _selectedGenres.contains(genre);
  }

  int onSelect() {
    return _selectedGenres.length;
  }

  void createPlaylist() {
    print(_selectedGenres);
    if (_selectedGenres.length > 0) {
      String genresString = _selectedGenres
          .toString()
          .substring(1, _selectedGenres.toString().length - 1);
      Navigator.pushNamed(context, PlaylistPage.routeName,
          arguments: genresString.replaceAll(" ", ""));
    }
  }

  @override
  void initState() {
    super.initState();
    Provider.of<SpotifyProvider>(context, listen: false)
        .fetchAvailableGenreSeeds();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SpotifyProvider>(context);
    _genres = provider.getGenres;

    return Scaffold(
        body: SafeArea(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
              child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Escolha os generos"),
                  RaisedButton(
                    onPressed: createPlaylist,
                    child: Text("criar playlist"),
                  )
                ],
              ),
              Text("${_selectedGenres.toString()}")
            ],
          )),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) => GenreItem(
                  _genres[index], onSelect, increment, decrement, exists),
              childCount: _genres.length,
            ),
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
          )
        ],
      ),
    ));
  }
}
