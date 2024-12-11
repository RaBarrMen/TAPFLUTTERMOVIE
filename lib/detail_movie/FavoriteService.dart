import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  Future<List<int>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorites') ?? [];
    return favorites.map(int.parse).toList();
  }

  Future<void> addFavorite(int movieId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorites') ?? [];
    if (!favorites.contains(movieId.toString())) {
      favorites.add(movieId.toString());
      await prefs.setStringList('favorites', favorites);
      print('Película añadida a favoritos: $movieId');
    }
  }

  Future<void> removeFavorite(int movieId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorites') ?? [];
    favorites.remove(movieId.toString());
    await prefs.setStringList('favorites', favorites);
    print('Película eliminada de favoritos: $movieId');
  }

  void debugFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    print('Favoritos guardados: ${prefs.getStringList('favorites')}');
  }
}
