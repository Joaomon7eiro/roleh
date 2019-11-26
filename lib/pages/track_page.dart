import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/spotify_provider.dart';
import '../widgets/track_item.dart';

class TrackPage extends StatefulWidget {
  @override
  _TrackPageState createState() => _TrackPageState();
}

class _TrackPageState extends State<TrackPage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SpotifyProvider>(context);
    var artists = provider.getSearchTracks;

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          child: TextField(
            onSubmitted: (value) {
              Provider.of<SpotifyProvider>(context).search("track", value);
            },
            controller: searchController,
            decoration: InputDecoration(
              labelText: "Buscar Mũsicas",
              suffixIcon: IconButton(
                onPressed: () {
                  Provider.of<SpotifyProvider>(context)
                      .search("track", searchController.text);
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
                childAspectRatio: 1 / 1.2),
            itemCount: artists.length,
            itemBuilder: (context, index) {
              return TrackItem(artists[index]);
            },
          ),
        )
      ],
    );
  }
}
