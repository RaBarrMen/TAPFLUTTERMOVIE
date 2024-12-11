import 'package:dio/dio.dart';
import 'package:flutter_rbm/models/popular_models.dart';

class ApiPopular {
  final Dio dio = Dio();

  // Función para obtener las películas populares
  Future<List<PopularModel>> getAllPopular() async {
    const URL =
        "https://api.themoviedb.org/3/movie/popular?api_key=5019e68de7bc112f4e4337a500b96c56&language=es-MX&page=1";
    final response = await dio.get(URL);
    final res = response.data['results'] as List;
    return res.map((movie) => PopularModel.fromMap(movie)).toList();
  }

  // Función para obtener el tráiler de la película
  Future<String?> getTrailer(int movieId) async {
    final URL =
        "https://api.themoviedb.org/3/movie/$movieId/videos?api_key=5019e68de7bc112f4e4337a500b96c56";
    final response = await dio.get(URL);
    final videos = response.data['results'] as List;
    if (videos.isNotEmpty) {
      return "https://www.youtube.com/watch?v=${videos.first['key']}";
    }
    return null;
  }

  // Función para obtener el reparto de la película
  Future<List<String>> getCast(int movieId) async {
    final URL =
        "https://api.themoviedb.org/3/movie/$movieId/credits?api_key=5019e68de7bc112f4e4337a500b96c56";
    final response = await dio.get(URL);
    final cast = response.data['cast'] as List;
    return cast.map((actor) => actor['name'] as String).toList();
  }
}

