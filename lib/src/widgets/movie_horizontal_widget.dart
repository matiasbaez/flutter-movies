import 'package:flutter/material.dart';

import 'package:movies/src/models/models.dart';

class MovieHorizontalWidget extends StatelessWidget {
  
  String? title;
  List<Movie> movies;

  final Function nextPage;
  final _pageCtrl = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  MovieHorizontalWidget({
    this.title,
    required this.movies,
    required this.nextPage
  });
  
  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;

    _pageCtrl.addListener(() {
      if (_pageCtrl.position.pixels >= _pageCtrl.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    return Container(
      width: double.infinity,
      height: screenSize.height * 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          if (title != null)
          Padding(
            padding: EdgeInsets.symmetric( horizontal: 20 ),
            child: Text(title!, style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold )),
          ),

          const SizedBox( height: 5 ),

          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: _pageCtrl,
              itemCount: movies.length,
              itemBuilder: (BuildContext context, int index) =>  _card(context, movies[index]),
            ),
          )

        ],
      )
    );

  }

  Widget _card(BuildContext context, Movie movie) {

    movie.heroId = 'poster-${ movie.id }';

    final card = Container(
      width: 130,
      height: 190,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(movie.postImg),
                fit: BoxFit.cover,
                width: 130,
                height: 190,
              ),
            )
          ),
          SizedBox(height: 5.0),
          Text(
            movie.title,
            maxLines: 2,
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

}