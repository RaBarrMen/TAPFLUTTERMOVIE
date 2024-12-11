import 'package:flutter/material.dart';
import 'package:flutter_rbm/detail_movie/FavoriteService.dart';
import 'package:flutter_rbm/models/popular_models.dart';
import 'package:flutter_rbm/network/api_popular.dart';
import 'package:flutter_rbm/screens/MovieDetailScreen.dart';

class FavoriteMoviesScreen extends StatefulWidget {
  const FavoriteMoviesScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteMoviesScreen> createState() => _FavoriteMoviesScreenState();
}

class _FavoriteMoviesScreenState extends State<FavoriteMoviesScreen> {
  final ApiPopular _apiPopular = ApiPopular();
  List<PopularModel> _favoriteMovies = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavoriteMovies();
  }

  Future<void> _loadFavoriteMovies() async {
    try {
      // Obtener IDs de películas favoritas desde SharedPreferences
      final favoriteIds = await FavoriteService().getFavorites();

      // Obtener todas las películas populares
      final allMovies = await _apiPopular.getAllPopular();

      // Filtrar las películas favoritas según sus IDs
      final favorites = allMovies.where((movie) => favoriteIds.contains(movie.id)).toList();

      setState(() {
        _favoriteMovies = favorites;
        _isLoading = false;
      });
    } catch (error) {
      print('Error cargando películas favoritas: $error');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas Favoritas'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _favoriteMovies.isEmpty
              ? const Center(
                  child: Text('No tienes películas favoritas.'),
                )
              : ListView.builder(
                  itemCount: _favoriteMovies.length,
                  itemBuilder: (context, index) {
                    final movie = _favoriteMovies[index];
                    return ListTile(
                      leading: Image.network(
                        'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(movie.title),
                      subtitle: Text('${movie.voteAverage} / 10'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetailScreen(movie: movie),
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}
