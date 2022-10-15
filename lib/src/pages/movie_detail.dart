import 'package:flutter/material.dart';

import 'package:movies/src/models/models.dart';
import 'package:movies/src/widgets/widgets.dart';

class MovieDetailPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppBar(movie),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 10.0),
              _postTitle(context, movie),
              _description(context, movie),
              _description(context, movie),
              _description(context, movie),
              CastingCards( movie.id )
            ])
          )
        ],
      ),
    );
  }

  Widget _createAppBar(Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.teal,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only( bottom: 10, left: 10, right: 10),
          color: Colors.black12,
          child: Text(
              movie.title,
              style: TextStyle( fontSize: 16 ),
              textAlign: TextAlign.center,
            ),
        ),

        background: FadeInImage(
          placeholder: AssetImage('assets/img/loading.gif'),
          image: NetworkImage(movie.backgroundImg),
          fit: BoxFit.cover,
          fadeInDuration: Duration(milliseconds: 50),
        ),
      ),
    );
  }

  Widget _postTitle(BuildContext context, Movie movie) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final screenSize = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only( top: 20 ),
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
           Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.postImg),
                height: 150.0,  
              ),
            ),
          ),

          SizedBox(width: 20.0),

          ConstrainedBox(
            constraints: BoxConstraints( maxWidth: screenSize.width - 190 ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(movie.title, style: textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2),
                Text(movie.originalTitle, style: textTheme.subtitle1, overflow: TextOverflow.ellipsis, maxLines: 2),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_outline, size: 35, color: Colors.grey),
                    SizedBox(width: 5),
                    Text(movie.voteAverage.toString(), style: textTheme.headline6)
                  ],
                )
              ],
            )
          )
        ],
      ),
    );
  }

  Widget _description(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}