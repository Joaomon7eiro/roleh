import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/spotify_provider.dart';
import '../widgets/artist_item.dart';

class ArtistPage extends StatefulWidget {
  @override
  _ArtistPageState createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SpotifyProvider>(context);
    var artists = provider.getSearchArtists;

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          child: TextField(
            onSubmitted: (value) {
              Provider.of<SpotifyProvider>(context).search("artist", value);
            },
            controller: searchController,
            decoration: InputDecoration(
              labelText: "Buscar Artistas",
              suffixIcon: IconButton(
                onPressed: () {
                  Provider.of<SpotifyProvider>(context)
                      .search("artist", searchController.text);
                },
                icon: Icon(Icons.search),
              ),
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1 / 1.15),
            itemCount: artists.length,
            itemBuilder: (context, index) {
              return ArtistItem(artists[index]);
            },
          ),
        )
      ],
    );
  }
}
