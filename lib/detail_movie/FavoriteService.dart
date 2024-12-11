/* import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  Future<List<int>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = prefs.getStringList('favoriteIds') ?? [];
    return favoriteIds.map((id) => int.parse(id)).toList();
  }

  Future<void> addFavorite(int movieId) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = prefs.getStringList('favoriteIds') ?? [];
    favoriteIds.add(movieId.toString());
    await prefs.setStringList('favoriteIds', favoriteIds);
  }

  Future<void> removeFavorite(int movieId) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = prefs.getStringList('favoriteIds') ?? [];
    favoriteIds.remove(movieId.toString());
    await prefs.setStringList('favoriteIds', favoriteIds);
  }
} */
