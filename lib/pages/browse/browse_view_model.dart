import 'package:flutter/material.dart';

import '../../core/constants.dart';
import '../../core/network_layer/api_manager.dart';
import '../../core/network_layer/firebase_utils.dart';
import '../../models/details_model.dart';
import '../../models/genre_model.dart';

class BrowseViewModel extends ChangeNotifier {
  List<GenreModel> _genres = [];
  List<DetailsModel> _movies = [];

  List<GenreModel> get genres => _genres;
  List<DetailsModel> get movies => _movies;

  getGenres() async {
    try {
      var response = await ApiManager.fetchCategories();
      _genres = response.genres;
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  getMovies(int selectedGenreId) async {
    try {
      var response =
          await ApiManager.discoverMoviesByGenre(genreId: selectedGenreId);

       var movies = response.results!;

      _movies = await Constants.getDetails(movies);

      var favoriteMovies = await FirestoreUtils.getDataFromFirestore();

      for (int i = 0; i < _movies.length; i++) {
        for (int j = 0; j < favoriteMovies.length; j++) {
          if (_movies[i].id == favoriteMovies[j].id) {
            _movies[i].isFavorite = true;
            break;
          }
        }
      }

      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  bookmarkButtonPressed(DetailsModel model) {
    model.isFavorite = !model.isFavorite;
    (model.isFavorite)
        ? FirestoreUtils.addDataToFirestore(model)
        : FirestoreUtils.deleteDataFromFirestore(model);
    notifyListeners();
  }
}
