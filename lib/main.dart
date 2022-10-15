import 'package:flutter/material.dart';
import 'package:movies/src/providers/movies_provider.dart';

// Custom imports
import 'src/pages/pages.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: '/',
      routes: {
        '/' : ( _ ) => HomePage(),
        'detail' : ( _ ) => MovieDetailPage(),
      },
      theme: ThemeData.light()
    );
  }
}
