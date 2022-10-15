
import 'dart:convert';

class Movies {

  List<Movie> items = [];

  Movies();

  Movies.fromJsonList( List<dynamic> jsonList  ) {

    if ( jsonList == null ) return;

    for ( var item in jsonList  ) {
      final movie = new Movie.fromJsonMap(item);
      items.add( movie );
    }

  }

}

class Movie {
  int voteCount;
  int id;
  bool video;
  double voteAverage;
  String title;
  double popularity;
  String? posterPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String? backdropPath;
  bool adult;
  String overview;
  String? releaseDate;

  Movie({
    required this.voteCount,
    required this.id,
    required this.video,
    required this.voteAverage,
    required this.title,
    required this.popularity,
    this.posterPath,
    required this.originalLanguage,
    required this.originalTitle,
    required this.genreIds,
    this.backdropPath,
    required this.adult,
    required this.overview,
    this.releaseDate,
  });

  factory Movie.fromJsonMap( Map<String, dynamic> json ) => Movie(

    voteCount        : json['vote_count'],
    id               : json['id'],
    video            : json['video'],
    voteAverage      : json['vote_average'] / 1,
    title            : json['title'],
    popularity       : json['popularity'] / 1,
    posterPath       : json['poster_path'],
    originalLanguage : json['original_language'],
    originalTitle    : json['original_title'],
    genreIds         : json['genre_ids'].cast<int>(),
    backdropPath     : json['backdrop_path'],
    adult            : json['adult'],
    overview         : json['overview'],
    releaseDate      : json['release_date'],

  );

  getPostImg() {
    if (posterPath == null) return 'https://cdn11.bigcommerce.com/s-hcp6qon/stencil/26c38110-5b4f-0138-d43f-0242ac11000e/icons/icon-no-image.svg';
    return 'https://image.tmdb.org/t/p/w500$posterPath';
  }

  getBackgroundImg() {
    if (backdropPath == null) return 'https://cdn11.bigcommerce.com/s-hcp6qon/stencil/26c38110-5b4f-0138-d43f-0242ac11000e/icons/icon-no-image.svg';
    return 'https://image.tmdb.org/t/p/original$backdropPath';
  }

}