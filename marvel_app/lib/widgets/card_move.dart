import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:marvel_app/Model/moveModel.dart';


class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.movie});
  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4),
      child: GestureDetector(
       
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black26,
            title: AutoSizeText(
              movie.title,
              minFontSize: 16,
              maxFontSize: double.infinity,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              "${movie.duration} min",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.end,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              movie.coverUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}