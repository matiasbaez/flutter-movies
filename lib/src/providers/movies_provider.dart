import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

// Importaciones personalizadas
import 'package:movies/src/models/movie_model.dart';

class MoviesProvider {
  String _apiKey    = '6ef9e1e754f7bf348499c926e6fe57b3';
  String _url       = 'api.themoviedb.org';
  String _language  = 'es';

  int _pagePopulares = 0;
  bool _loading = false;
  List<Movie> _popular = [];
  // Broadcast -> multiple listener
  final _streamPopularCtrl = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularSink => _streamPopularCtrl.sink.add;

  Stream<List<Movie>> get popularStream => _streamPopularCtrl.stream;

  void disposeStreams() {
    _streamPopularCtrl?.close();
  }

  Future<List<Movie>> getInTheaters() async {

    final url = Uri.https(_url, '/3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language
    });

    return await _getHTTP(url);
  }

  Future<List<Movie>> getPopular() async {

    if (_loading) return [];

    _loading = true;
    _pagePopulares++;

    final url = Uri.https(_url, '/3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _pagePopulares.toString()
    });

    final response = await _getHTTP(url);
    _popular.addAll(response);
    popularSink(_popular);

    _loading = false;

    return response;
  }

  Future<List<Movie>> _getHTTP(Uri url) async {
    final res = await http.get(url);
    final decodedData = jsonDecode(res.body);

    final movies = new Movies.fromJsonList(decodedData['results']);
    
    return movies.items;
  }
}