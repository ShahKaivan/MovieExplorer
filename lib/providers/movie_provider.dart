import 'package:flutter/foundation.dart';
import '../models/movie.dart';
import '../service/movie_service.dart';

class MovieProvider with ChangeNotifier {
  final TMDBService _tmdbService = TMDBService();
  List<Movie> _movies = [];
  bool _isLoading = false;
  String _error = '';

  List<Movie> get movies => _movies;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      _movies = [];
      notifyListeners();
      return;
    }

    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      _movies = await _tmdbService.searchMovies(query);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
