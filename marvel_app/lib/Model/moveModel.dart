import 'dart:convert';

class MovieModel {
  int id;
  String title;
  DateTime releaseDate;
  String boxOffice;
  int duration;
  String? overview;
  String coverUrl;
  String? trailerUrl;
  String directedBy;
  int phase;
  String saga;
  int chronology;
  int postCreditScenes;
  String imdbId;
  DateTime updatedAt;

  static var movies;

  MovieModel({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.boxOffice,
    required this.duration,
    this.overview,
    required this.coverUrl,
    this.trailerUrl,
    required this.directedBy,
    required this.phase,
    required this.saga,
    required this.chronology,
    required this.postCreditScenes,
    required this.imdbId,
    required this.updatedAt,
  });

  factory MovieModel.fromRawJson(String str) =>
      MovieModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        id: json["id"],
        title: json["title"],
        releaseDate: DateTime.parse(json["release_date"]),
        boxOffice: json["box_office"],
        duration: json["duration"],
        overview: json["overview"],
        coverUrl: json["cover_url"],
        trailerUrl: json["trailer_url"],
        directedBy: json["directed_by"],
        phase: json["phase"],
        saga: json["saga"],
        chronology: json["chronology"],
        postCreditScenes: json["post_credit_scenes"],
        imdbId: json["imdb_id"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "release_date":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "box_office": boxOffice,
        "duration": duration,
        "overview": overview,
        "cover_url": coverUrl,
        "trailer_url": trailerUrl,
        "directed_by": directedBy,
        "phase": phase,
        "saga": saga,
        "chronology": chronology,
        "post_credit_scenes": postCreditScenes,
        "imdb_id": imdbId,
        "updated_at": updatedAt.toIso8601String(),
      };
}