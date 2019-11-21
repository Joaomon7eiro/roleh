import 'package:flutter/material.dart';

class GenreItem extends StatefulWidget {
  final genre;
  final Function onSelect;
  final Function increment;
  final Function decrement;
  final Function exists;
  const GenreItem(
      this.genre, this.onSelect, this.increment, this.decrement, this.exists);

  @override
  _GenreItemState createState() => _GenreItemState();
}

class _GenreItemState extends State<GenreItem>
    with AutomaticKeepAliveClientMixin {
  Color selectedColor = Colors.green.shade600;
  Color defaultColor = Colors.green.shade300;
  bool isSelected = false;

  void handleTap() {
    var exists = widget.exists(widget.genre);

    var number = widget.onSelect();
    if (number < 5) {
      if (exists) {
        widget.decrement(widget.genre);
      } else {
        widget.increment(widget.genre);
      }
      setState(() {
        isSelected = !exists;
      });
    } else {
      if (exists) {
        widget.decrement(widget.genre);
        setState(() {
          isSelected = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        color: isSelected ? selectedColor : defaultColor,
        margin: EdgeInsets.all(10),
        child: Center(
          child: Text(
            widget.genre,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      onTap: handleTap,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
