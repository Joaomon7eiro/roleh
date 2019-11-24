import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roleh/pages/advanced_page.dart';
import 'package:roleh/pages/playlist_page.dart';

import '../providers/filter_provider.dart';
import '../providers/spotify_provider.dart';

import '../pages/genre_page.dart';
import '../pages/artist_page.dart';
import '../pages/track_page.dart';

class HomePage extends StatefulWidget {
  static final routeName = "/home-page";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedGenres;

  void createPlaylist() {
    if (_selectedGenres.length > 0) {
      String genresString = _selectedGenres
          .toString()
          .substring(1, _selectedGenres.toString().length - 1);
      String formattedGenres = genresString.replaceAll(" ", "");
      var queryParams = {
        "seed_genres": formattedGenres,
        ...Provider.of<FilterProvider>(context, listen: false).filterValues
      };
      Navigator.pushNamed(context, PlaylistPage.routeName,
          arguments: queryParams);
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
    var provider = Provider.of<FilterProvider>(context);
    _selectedGenres = provider.selectedGenres;

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.pink.shade50,
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Escolha até 5 filtros (gêneros, musicas e artistas)",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        margin: EdgeInsets.only(top: 6),
                        width: MediaQuery.of(context).size.width * 0.45,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RaisedButton(
                            color: Colors.greenAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            onPressed: createPlaylist,
                            child: Text(
                              "Gerar Playlist",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          RaisedButton(
                            color: Colors.greenAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            onPressed: () async {
                              var data = await Navigator.pushNamed(
                                  context, AdvancedPage.routeName);
                            },
                            child: Text(
                              "Avançado",
                              style: TextStyle(fontSize: 12),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: _selectedGenres.length > 0
                      ? Text(
                          "Selecionados: ${_selectedGenres.toString().replaceAll("[", "").replaceAll("]", "")}",
                          style: TextStyle(
                              fontSize: 16, fontStyle: FontStyle.italic),
                        )
                      : Text(
                          "Nenhum filtro selecionado",
                          style: TextStyle(
                              fontSize: 16, fontStyle: FontStyle.italic),
                        ),
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.pink.shade50,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 8),
                      )
                    ],
                  ),
                  child: TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.greenAccent,
                    tabs: [Text("Gêneros"), Text("Artistas"), Text("Músicas")],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: <Widget>[GenrePage(), ArtistPage(), TrackPage()],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
