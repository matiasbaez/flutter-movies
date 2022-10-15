import 'package:flutter/material.dart';
import 'package:movies/src/providers/movies_provider.dart';
import 'package:provider/provider.dart';

// Custom imports
import 'src/pages/pages.dart';

void main() => runApp(const AppState());

// Create a global state for the app to manage all provider
class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => MoviesProvider(), lazy: false) // lazy false to create the instance immediately
      ],
      child: MyApp(),
    );
  }
}

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
