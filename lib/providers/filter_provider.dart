import 'package:flutter/material.dart';

class FilterProvider extends ChangeNotifier {
  var _maxSelected = 5;
  List<String> selectedFilters = [];

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
    "min_energy": 0.0,
    "max_energy": 1.0,
    "min_instrumentalness": 0.0,
    "max_instrumentalness": 1.0,
    "min_key": 0,
    "max_key": 11,
    "min_liveness": 0.0,
    "max_liveness": 1.0,
    "min_tempo": 0.0,
    "max_tempo": 300.0,
    "min_mode": 0,
    "max_mode": 1,
    "min_popularity": 0,
    "max_popularity": 100,
    "min_valence": 0.0,
    "max_valence": 1.0,
    //   "min_duration_ms": 0,
//    "max_duration_ms": Duration(minutes: 10).inMilliseconds,
//    "min_loudness": -60.0,
//    "max_loudness": 0.0,
//    "min_speechiness": 0.0,
//    "max_speechiness": 1.0,
//    "min_time_signature": 0,
//    "max_time_signature": 100,
  };

  void addFilter(filter) {
    if (selectedFilters.length < _maxSelected) {
      selectedFilters.add(filter);
      notifyListeners();
    }
  }

  void removeFilter(filter) {
    if (selectedFilters.length > 0) {
      selectedFilters.remove(filter);
      notifyListeners();
    }
  }

  bool checkFilterExists(filter) {
    return selectedFilters.contains(filter);
  }

  int get selectedFiltersNumber {
    return selectedFilters.length;
  }
}
