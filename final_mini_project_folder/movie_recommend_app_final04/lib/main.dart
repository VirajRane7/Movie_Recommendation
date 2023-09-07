import 'package:flutter/material.dart';

import 'nav.dart';


// import 'package:movie_recommend_final02/nav.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Recommendation System',
      home:Nav(),
    );
  }
}
