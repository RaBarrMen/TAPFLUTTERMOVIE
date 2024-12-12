import 'package:flutter/material.dart';
import 'package:flutter_rbm/detail_movie/FavoriteService.dart';
import 'package:flutter_rbm/screens/FavoriteMoviesScreens.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:flutter_rbm/network/api_popular.dart';
import 'package:flutter_rbm/models/popular_models.dart';

class MovieDetailScreen extends StatefulWidget {
  final PopularModel movie;

  const MovieDetailScreen({required this.movie, super.key});

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late YoutubePlayerController _controller;
  bool isFavorite = false;
  List<String> actors = [];

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
      ),
    );
    _loadTrailer();
    _checkFavorite();
    _loadCast();  
  }

  String? _extractYoutubeId(String url) {
    final Uri? uri = Uri.tryParse(url);
    if (uri != null) {
      if (uri.queryParameters.containsKey('v')) {
        return uri.queryParameters['v'];
      } else if (uri.pathSegments.isNotEmpty) {
        return uri.pathSegments.last; 
      }
    }
    return null;
  }

  void _loadTrailer() async {
    final url = await ApiPopular().getTrailer(widget.movie.id);
    if (url != null) {
      print('URL del tráiler: $url');
      final videoId = _extractYoutubeId(url);
      if (videoId != null) {
        _controller.loadVideoById(videoId: videoId); 
      }
    }
  }

  void _checkFavorite() async {
    final favorites = await FavoriteService().getFavorites();
    print('Favoritos actuales: $favorites');
    setState(() {
      isFavorite = favorites.contains(widget.movie.id);
    });
  }

  void _toggleFavorite() async {
    if (isFavorite) {
      await FavoriteService().removeFavorite(widget.movie.id);
    } else {
      await FavoriteService().addFavorite(widget.movie.id);
    }
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  void _loadCast() async {
    final cast = await ApiPopular().getCast(widget.movie.id);
    setState(() {
      actors = cast;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.black,
            ),
            onPressed: _toggleFavorite,
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoriteMoviesScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  'https://image.tmdb.org/t/p/original/${widget.movie.backdropPath}',
                  height: 250,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                Container(
                  height: 250,
                  color: Colors.black.withOpacity(0.5),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Text(
                    widget.movie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            YoutubePlayer(
              controller: _controller,
              aspectRatio: 16 / 9,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(widget.movie.overview),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 20),
                  const SizedBox(width: 5),
                  Text('${widget.movie.voteAverage} / 10'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Actores:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  actors.isEmpty
                      ? const CircularProgressIndicator()
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: actors.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(actors[index]),
                            );
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
