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
      child: Container(
        color: Colors.pink.shade50,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
                child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Escolha os gêneros músicais (max 5)",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        width: MediaQuery.of(context).size.width * 0.5,
                      ),
                      RaisedButton(
                        color: Colors.greenAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onPressed: createPlaylist,
                        child: Text(
                          "Gerar Playlist",
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    ],
                  ),
                  margin: EdgeInsets.symmetric(vertical: 20),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: _selectedGenres.length > 0
                      ? Text(
                          "Selecionados: ${_selectedGenres.toString().replaceAll("[", "").replaceAll("]", "")}",
                          style: TextStyle(
                              fontSize: 16, fontStyle: FontStyle.italic),
                        )
                      : Text(
                          "Nenhum gênero selecionado",
                          style: TextStyle(
                              fontSize: 16, fontStyle: FontStyle.italic),
                        ),
                )
              ],
            )),
            SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) => GenreItem(
                    _genres[index], onSelect, increment, decrement, exists),
                childCount: _genres.length,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 2 / 1,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 10),
            )
          ],
        ),
      ),
    ));
  }
}
