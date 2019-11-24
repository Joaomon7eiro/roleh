import 'package:flutter/material.dart';

class FilterProvider extends ChangeNotifier {
  var _maxSelected = 5;
  List<String> selectedGenres = [];

  RangeValues acousticness = RangeValues(0, 1);
  RangeValues danceability = RangeValues(0, 1);
  RangeValues duration_ms = RangeValues(1, 10);
  RangeValues energy = RangeValues(0, 1);
  RangeValues instrumentalness = RangeValues(0, 1);
  RangeValues key = RangeValues(0, 11);
  RangeValues liveness = RangeValues(0, 1);
  RangeValues loudness = RangeValues(-60, 0);
  RangeValues mode = RangeValues(0, 1);
  RangeValues popularity = RangeValues(0, 100);
  RangeValues speechiness = RangeValues(0, 1);
  RangeValues tempo = RangeValues(1, 300);
  RangeValues time_signature = RangeValues(1, 100);
  RangeValues valence = RangeValues(0, 1);

  var filterDivisions = {
    "limit": 10,
    "acousticness": null,
    "danceability": null,
    "duration_ms": null,
    "energy": null,
    "instrumentalness": null,
    "key": 11,
    "liveness": null,
    "loudness": null,
    "mode": null,
    "popularity": 10,
    "speechiness": null,
    "tempo": 10,
    "time_signature": 10,
    "valence": null,
  };

  var filterMinMaxValues = <String, dynamic>{
    "min_acousticness": 0.0,
    "max_acousticness": 1.0,
    "min_danceability": 0.0,
    "max_danceability": 1.0,
    "min_duration_ms": 0,
    "max_duration_ms": Duration(minutes: 10).inMilliseconds,
    "min_energy": 0.0,
    "max_energy": 1.0,
    "min_instrumentalness": 0.0,
    "max_instrumentalness": 1.0,
    "min_key": 0,
    "max_key": 11,
    "min_liveness": 0.0,
    "max_liveness": 1.0,
    "min_loudness": -60.0,
    "max_loudness": 0.0,
    "min_mode": 0,
    "max_mode": 1,
    "min_popularity": 0,
    "max_popularity": 100,
    "min_speechiness": 0.0,
    "max_speechiness": 1.0,
    "min_tempo": 0.0,
    "max_tempo": 300.0,
    "min_time_signature": 0,
    "max_time_signature": 100,
    "min_valence": 0.0,
    "max_valence": 1.0,
  };

  var filterValues = <String, dynamic>{
    "min_acousticness": 0.0,
    "max_acousticness": 1.0,
    "min_danceability": 0.0,
    "max_danceability": 1.0,
    "min_duration_ms": 0,
    "max_duration_ms": Duration(minutes: 10).inMilliseconds,
    "min_energy": 0.0,
    "max_energy": 1.0,
    "min_instrumentalness": 0.0,
    "max_instrumentalness": 1.0,
    "min_key": 0,
    "max_key": 11,
    "min_liveness": 0.0,
    "max_liveness": 1.0,
    "min_loudness": -60.0,
    "max_loudness": 0.0,
    "min_mode": 0,
    "max_mode": 1,
    "min_popularity": 0,
    "max_popularity": 100,
    "min_speechiness": 0.0,
    "max_speechiness": 1.0,
    "min_tempo": 0.0,
    "max_tempo": 300.0,
    "min_time_signature": 0,
    "max_time_signature": 100,
    "min_valence": 0.0,
    "max_valence": 1.0,
  };

  void addFilter(filter) {
    if (selectedGenres.length < _maxSelected) {
      selectedGenres.add(filter);
      notifyListeners();
    }
  }

  void removeFilter(filter) {
    if (selectedGenres.length > 0) {
      selectedGenres.remove(filter);
      notifyListeners();
    }
  }

  bool checkFilterExists(filter) {
    return selectedGenres.contains(filter);
  }

  int get selectedFiltersNumber {
    return selectedGenres.length;
  }
}
