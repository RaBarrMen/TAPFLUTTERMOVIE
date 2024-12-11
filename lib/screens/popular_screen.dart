import 'package:flutter/material.dart';
import 'package:flutter_rbm/network/api_popular.dart';
import 'package:flutter_rbm/screens/MovieDetailScreen.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  ApiPopular apiPopular = ApiPopular();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Popular Movies'),
      ),
      body: FutureBuilder(
        future: apiPopular.getAllPopular(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              itemCount: snapshot.data!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                final movie = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    // Navegar a la pantalla de detalles
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailScreen(movie: movie),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            movie.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        },
      ),
    );
  }
}
