import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Custom imports
import 'package:movies/src/models/models.dart';
import 'package:movies/src/helpers/debouncer.dart';


class MoviesProvider extends ChangeNotifier {
  final String _apiKey    = '6ef9e1e754f7bf348499c926e6fe57b3';
  final String _url       = 'api.themoviedb.org';
  final String _language  = 'es';

  int _pagePopulares = 0;
  bool _loading = false;
  List<Movie> popularMovies = [];
  List<Movie> playingNowMovies = [];
  Map<int, List<Cast>> moviesCast = {};

  final debouncer = Debouncer(
    duration: Duration( milliseconds: 500 ),
  );

  final StreamController<List<Movie>> _suggestionStreamContoller = new StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => this._suggestionStreamContoller.stream;

  MoviesProvider() {
    getInTheaters();
    getPopular();
  }

  getInTheaters() async {

    final data = await getJsonData('/3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(data);

    playingNowMovies = nowPlayingResponse.results;

    notifyListeners();

  }

  getPopular() async {

    if (_loading) return [];

    _loading = true;
    _pagePopulares++;

    final data = await getJsonData('/3/movie/popular', _pagePopulares);
    final popularResponse = PopularResponse.fromJson(data);

    popularMovies = [ ...popularMovies, ...popularResponse.results ];

    _loading = false;

    notifyListeners();

  }

  Future<List<Cast>> getMovieCast( int movieId ) async {

    if( moviesCast.containsKey(movieId) ) return moviesCast[movieId]!;

    final jsonData = await getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson( jsonData );

    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovies( String query ) async {

    final url = Uri.https( _url, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query
    });

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson( response.body );

    return searchResponse.results;
  }

  void getSuggestionsByQuery( String searchTerm ) {

    debouncer.value = '';
    debouncer.onValue = ( value ) async {
      // print('Tenemos valor a buscar: $value');
      final results = await this.searchMovies(value);
      this._suggestionStreamContoller.add( results );
    };

    final timer = Timer.periodic(Duration(milliseconds: 300), ( _ ) { 
      debouncer.value = searchTerm;
    });

    Future.delayed(Duration( milliseconds: 301)).then(( _ ) => timer.cancel());
  }

  Future<String> getJsonData(String endpoint, [int page = 1]) async {

    final url = Uri.https(_url, endpoint, {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page'
    });

    final response = await http.get(url);

    return response.body;
  }

}