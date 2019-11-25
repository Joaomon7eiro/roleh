import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/filter_provider.dart';
import '../models/artist.dart';

class ArtistItem extends StatefulWidget {
  final Artist artist;
  const ArtistItem(this.artist);

  @override
  _ArtistItemState createState() => _ArtistItemState();
}

class _ArtistItemState extends State<ArtistItem>
    with AutomaticKeepAliveClientMixin {
  bool isSelected = false;
  var key = "seed_artists";

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var provider = Provider.of<FilterProvider>(context);

    return InkWell(
      onTap: () {
        setState(() {
          isSelected = provider.handleTap(widget.artist.uri, key);
        });
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            widget.artist.image != null
                ? Opacity(
                    opacity: isSelected ? 0.5 : 1,
                    child: Image.network(
                      widget.artist.image,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    color: Colors.purple.shade300,
                    width: 200,
                    height: 200,
                  ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(widget.artist.name),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
