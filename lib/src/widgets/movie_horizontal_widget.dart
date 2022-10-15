import 'package:flutter/material.dart';

import 'package:movies/src/models/movie_model.dart';

class MovieHorizontalWidget extends StatelessWidget {
  
  final List<Movie> movies;
  final Function nextPage;
  final _pageCtrl = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  MovieHorizontalWidget({required this.movies, required this.nextPage});
  
  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    _pageCtrl.addListener(() {
      if (_pageCtrl.position.pixels >= _pageCtrl.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      height: _screenSize.height * 0.3,
      child: PageView.builder(
        // children: _cards(context),
        pageSnapping: false,
        controller: _pageCtrl,
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) =>  _card(context, movies[index]),
      ),
    );

  }

  Widget _card(BuildContext context, Movie movie) {
    final card = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(movie.getPostImg()),
              fit: BoxFit.cover,
              height: 120.0,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ]
      ),
    );

    return GestureDetector(
      child: card,
      onTap: () => Navigator.pushNamed(context, 'detail', arguments: movie),
    );
  }

  List<Widget> _cards(BuildContext context) {
    return movies.map((movie) => 
      Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(movie.getPostImg()),
                fit: BoxFit.cover,
                height: 120.0,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ]
        ),
      )
    ).toList();
  }
}