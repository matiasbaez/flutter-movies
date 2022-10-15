// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:movies/src/models/models.dart';

class SwiperCardWidget extends StatelessWidget {
  
  final List<Movie> movies;

  SwiperCardWidget({super.key, required this.movies});
  
  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;

    if (movies.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: screenSize.height * 0.5,
        child: Center(
          child: CircularProgressIndicator()
        )
      );
    }

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      width: double.infinity,
      height: screenSize.height * 0.5,
      child: Swiper(
        itemWidth: screenSize.width * 0.7,
        itemHeight: screenSize.height * 0.4,
        autoplay: true,
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemBuilder: (_, int index) {
          final movie = movies[index];
          movie.heroId = 'swiper-${ movie.id }';

          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'detail', arguments: movie),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(movie.postImg),
                  fit: BoxFit.cover,
                ),
              )
            )
          );
        }
      ),
    );
  }
}