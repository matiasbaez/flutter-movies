import 'package:flutter/material.dart';

import 'package:movies/src/providers/movies_provider.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/widgets/widgets.dart';

class HomePage extends StatelessWidget {

  final moviesProvider = MoviesProvider();

  @override
  Widget build(BuildContext context) {

    moviesProvider.getPopular();

    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas'),
        backgroundColor: Colors.indigoAccent,
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){}
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperCards(),
            _popular(context),
          ]
        )
      ),
    );
  }

  Widget _swiperCards() {
    
    return FutureBuilder(
      future: moviesProvider.getInTheaters(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

        if (snapshot.hasData) return SwiperCardWidget(movies: snapshot.data as List<Movie>);

        return Container(
          height: 400.0,
          child: Center(
            child: CircularProgressIndicator()
          )
        );
      },
    );
  }

  Widget _popular(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('Populares', style: Theme.of(context).textTheme.subtitle1)
          ),
          StreamBuilder(
            stream: moviesProvider.popularStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontalWidget(
                  movies: snapshot.data,
                  nextPage: moviesProvider.getPopular
                );
              }

              return Container(
                height: 400.0,
                child: Center(
                  child: CircularProgressIndicator()
                )
              );
            },
          ),
        ],
      ),
    );
  }
}