import 'package:flutter/material.dart';
import 'package:roleh/providers/filter_provider.dart';
import 'package:provider/provider.dart';

class GenreItem extends StatefulWidget {
  final genre;
  const GenreItem(this.genre);

  @override
  _GenreItemState createState() => _GenreItemState();
}

class _GenreItemState extends State<GenreItem>
    with AutomaticKeepAliveClientMixin {
  Color selectedColor = Colors.amber.shade600;
  Color defaultColor = Colors.amberAccent;
  bool isSelected = false;

  void handleTap(FilterProvider provider) {
    var exists = provider.checkFilterExists(widget.genre);

    var number = provider.selectedFiltersNumber;
    if (number < 5) {
      if (exists) {
        provider.removeFilter(widget.genre);
      } else {
        provider.addFilter(widget.genre);
      }
      setState(() {
        isSelected = !exists;
      });
    } else {
      if (exists) {
        provider.removeFilter(widget.genre);
        setState(() {
          isSelected = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var provider = Provider.of<FilterProvider>(context);

    return InkWell(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          color: isSelected ? selectedColor : defaultColor,
          child: Center(
            child: Text(
              widget.genre,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      onTap: () {
        handleTap(provider);
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
