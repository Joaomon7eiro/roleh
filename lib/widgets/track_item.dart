import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/filter_provider.dart';
import '../models/track.dart';

class TrackItem extends StatefulWidget {
  final Track track;

  const TrackItem(this.track);

  @override
  _TrackItemState createState() => _TrackItemState();
}

class _TrackItemState extends State<TrackItem>
    with AutomaticKeepAliveClientMixin {
  bool isSelected = false;
  var key = "seed_tracks";

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var provider = Provider.of<FilterProvider>(context);

    return InkWell(
      onTap: () {
        setState(() {
          isSelected = provider.handleTap(widget.track.id, key);
        });
      },
      child: Container(
        width: 200,
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            widget.track.image != null
                ? Opacity(
                    opacity: isSelected ? 0.5 : 1,
                    child: Image.network(widget.track.image),
                  )
                : Container(
                    color: Colors.purple.shade300,
                    width: 200,
                    height: 200,
                  ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(widget.track.name),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(widget.track.artists[0].name),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
