import 'package:dio/dio.dart';

class TrailerService {
  final Dio _dio = Dio();

  Future<String?> getTrailerUrl(int movieId) async {
    try {
      final response = await _dio.get(
        'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=API_KEY');
      final videos = response.data['results'] as List;
      if (videos.isNotEmpty) {
        return 'https://www.youtube.com/watch?v=${videos[0]['key']}';
      }
      return null;
    } catch (e) {
      print("Error obteniendo el trailer: $e");
      return null;
    }
  }
}
