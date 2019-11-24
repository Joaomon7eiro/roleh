import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart' as frs;

import '../providers/filter_provider.dart';

class AdvancedItem extends StatefulWidget {
  final String name;
  final String label1;
  final String label2;
  const AdvancedItem({this.name, this.label1, this.label2});
  @override
  _AdvancedItemState createState() => _AdvancedItemState();
}

class _AdvancedItemState extends State<AdvancedItem> {
  RangeValues _values;
  var _min;
  var _max;
  var _start;
  var _end;
  var _division;
  bool _isInt = false;

  @override
  void initState() {
    super.initState();
    var provider = Provider.of<FilterProvider>(context, listen: false);
    _division = provider.filterDivisions[widget.name];
    _min = provider.filterMinMaxValues["min_${widget.name}"].toDouble();
    _max = provider.filterMinMaxValues["max_${widget.name}"].toDouble();
    _start = provider.filterValues["min_${widget.name}"];
    _end = provider.filterValues["max_${widget.name}"];
    if (_start is int) {
      _isInt = true;
    }
    _values = RangeValues(_start.toDouble(), _end.toDouble());
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<FilterProvider>(context, listen: false);
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(widget.name),
              //Text(widget.name),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.2,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(_values.start.toStringAsFixed(2)),
                ),
              ),
              frs.RangeSlider(
                showValueIndicator: true,
                lowerValue: _values.start,
                upperValue: _values.end,
                onChangeEnd: (start, end) {
                  if (_isInt) {
                    provider.filterValues["min_${widget.name}"] = start.toInt();
                    provider.filterValues["max_${widget.name}"] = end.toInt();
                  } else {
                    provider.filterValues["min_${widget.name}"] = start;
                    provider.filterValues["max_${widget.name}"] = end;
                  }
                },
                divisions: _division,
                onChanged: (start, end) {
                  setState(() {
                    _values = RangeValues(start, end);
                  });
                },
                max: _max,
                min: _min,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.2,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(_values.end.toStringAsFixed(2)),
                ),
              ),
            ],
          ),
          Divider()
        ],
      ),
    );
  }
}
