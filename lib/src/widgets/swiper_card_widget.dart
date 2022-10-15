import 'package:flutter/material.dart';

import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:movies/src/models/movie_model.dart';

class SwiperCardWidget extends StatelessWidget {
  
  final List<Movie> movies;

  SwiperCardWidget({required this.movies});
  
  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(movies[index].getPostImg()),
              fit: BoxFit.cover,
            ),
          );
        },
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.4,
        autoplay: true,
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        // scrollDirection: Axis.horizontal,
        // pagination: new SwiperPagination(alignment: Alignment.bottomCenter),
        // control: new SwiperControl(),
      ),
    );
  }
}