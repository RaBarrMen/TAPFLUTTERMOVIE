import 'package:flutter/material.dart';
import 'package:flutter_rbm/models/popular_models.dart';

class MovieDetailScreen extends StatelessWidget {
  final PopularModel movie;

  const MovieDetailScreen({required this.movie, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Image.network(
                  'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
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
                    movie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                movie.overview,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber),
                  const SizedBox(width: 5),
                  Text('${movie.voteAverage} / 10'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
