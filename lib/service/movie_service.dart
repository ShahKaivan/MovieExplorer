import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';
import '../models/genre.dart';

class TMDBService {
  final String apiKey =
      'f1668445f37fb512351506bf131ae393'; // Replace with your TMDB API key
  final String baseUrl = 'https://api.themoviedb.org/3';
  final String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  Map<int, String> genreMap = {};

  Future<void> initializeGenres() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/genre/movie/list?api_key=$apiKey'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final genres =
            (data['genres'] as List).map((genre) => Genre.fromJson(genre));

        for (var genre in genres) {
          genreMap[genre.id] = genre.name;
        }
      }
    } catch (e) {
      print('Error loading genres: $e');
    }
  }

  List<String> getGenreNames(List<dynamic> genreIds) {
    return genreIds
        .map((id) => genreMap[id] ?? '')
        .where((name) => name.isNotEmpty)
        .toList();
  }

  Future<List<Movie>> searchMovies(String query) async {
    if (query.isEmpty) return [];

    try {
      if (genreMap.isEmpty) {
        await initializeGenres();
      }

      final response = await http.get(
        Uri.parse(
            '$baseUrl/search/movie?api_key=$apiKey&query=$query&include_adult=false'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['results'];

        return results.map((movieData) {
          List<String> genres = getGenreNames(movieData['genre_ids'] ?? []);
          return Movie.fromJson(movieData, genres);
        }).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to search movies: $e');
    }
  }
}
