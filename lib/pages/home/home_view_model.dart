import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../../core/network_layer/api_manager.dart';
import '../../core/network_layer/firebase_utils.dart';
import '../../models/details_model.dart';

class HomeViewModel extends ChangeNotifier {
  List<DetailsModel> _popularMovies = [];
  List<DetailsModel> _newReleaseMovies = [];
  List<DetailsModel> _recommendMovies = [];
  List<DetailsModel> _similarMovies = [];

  List<DetailsModel> get popularMovies => _popularMovies;
  List<DetailsModel> get newReleaseMovies => _newReleaseMovies;
  List<DetailsModel> get recommendMovies => _recommendMovies;
  List<DetailsModel> get similarMovies => _similarMovies;

  getPopularMovies() async {
    try {
      var response = await ApiManager.fetchPopular();
      var movies = response.results!;

      _popularMovies = await Constants.getDetails(movies);

      var favoriteMovies = await FirestoreUtils.getDataFromFirestore();

      for (int i = 0; i < _popularMovies.length; i++) {
        for (int j = 0; j < favoriteMovies.length; j++) {
          if (_popularMovies[i].id == favoriteMovies[j].id) {
            _popularMovies[i].isFavorite = true;
            break;
          }
        }
      }

      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  getNewReleasesMovies() async {
    try {
      var response = await ApiManager.fetchNewReleases();
      var movies = response.results!;

      _newReleaseMovies = await Constants.getDetails(movies);

      var favoriteMovies = await FirestoreUtils.getDataFromFirestore();

      for (int i = 0; i < _newReleaseMovies.length; i++) {
        for (int j = 0; j < favoriteMovies.length; j++) {
          if (_newReleaseMovies[i].id == favoriteMovies[j].id) {
            _newReleaseMovies[i].isFavorite = true;
            break;
          }
        }
      }

      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  getRecommendMovies() async {
    try {
      var response = await ApiManager.fetchRecommend();
      var movies = response.results!;

      _recommendMovies = await Constants.getDetails(movies);

      var favoriteMovies = await FirestoreUtils.getDataFromFirestore();

      for (int i = 0; i < _recommendMovies.length; i++) {
        for (int j = 0; j < favoriteMovies.length; j++) {
          if (_recommendMovies[i].id == favoriteMovies[j].id) {
            _recommendMovies[i].isFavorite = true;
            break;
          }
        }
      }

      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  getSimilarMovies(int? movieId) async {
    try {
      var response = await ApiManager.fetchSimilar(movieId!);
      var movies = response.results!;

      _similarMovies = await Constants.getDetails(movies);

      var favoriteMovies = await FirestoreUtils.getDataFromFirestore();

      for (int i = 0; i < _similarMovies.length; i++) {
        for (int j = 0; j < favoriteMovies.length; j++) {
          if (_similarMovies[i].id == favoriteMovies[j].id) {
            _similarMovies[i].isFavorite = true;
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
