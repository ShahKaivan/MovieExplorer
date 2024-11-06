import 'genre.dart';

class Movie {
  final int id;
  final String title;
  final List<String> genres;
  final double rating;
  final String posterPath;
  final String backdropPath;
  final String overview;

  Movie({
    required this.id,
    required this.title,
    required this.genres,
    required this.rating,
    required this.posterPath,
    required this.backdropPath,
    required this.overview,
  });

  factory Movie.fromJson(Map<String, dynamic> json, List<String> genres) {
    return Movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      genres: genres,
      rating: (json['vote_average'] ?? 0.0).toDouble(),
      posterPath: json['poster_path'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      overview: json['overview'] ?? '',
    );
  }
}
