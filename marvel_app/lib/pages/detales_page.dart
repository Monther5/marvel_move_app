import 'package:flutter/material.dart';
import 'package:marvel_app/Model/moveModel.dart';

class DetailedMoviePage extends StatelessWidget {
  const DetailedMoviePage({super.key, required this.movie});
  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title, style: const TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                  height: size.height * 0.7,
                  width: size.width,
                  child: Image.network(
                    movie.coverUrl,
                    fit: BoxFit.fill,
                  )),
            ),
            Text(
              movie.overview!,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
            Text(movie.duration.toString()),
            Text(movie.releaseDate.toString()),
          ],
        ),
      ),
    );
  }
}