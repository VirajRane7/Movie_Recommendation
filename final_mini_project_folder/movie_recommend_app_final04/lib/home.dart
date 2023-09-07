// import 'package:flutter/material.dart';
// import "package:tmdb_api/tmdb_api.dart";
// import 'dart:convert';
//
// class Home extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     // return Scaffold(
//     //   // backgroundColor: Colors.black,
//     //
//     // );
//     return Center(
//
//       child: Text('Home Screen',style: TextStyle(color: Colors.white)),
//     );
//
//   }
// }


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:movie_recommend_final02/utils/text.dart';
// import 'package:movie_recommend_final02/widgets/toprated.dart';
// import 'package:movie_recommend_final02/widgets/trending.dart';
import 'package:tmdb_api/tmdb_api.dart';

import 'widgets/toprated.dart';
import 'widgets/trending.dart';
import 'widgets/tv.dart';
// import 'package:movie_recommend_final02/widgets/tv.dart';
// import 'function.dart';

void main()=> runApp(new MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Home(),
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(brightness: Brightness.dark,
      // primaryColor: Colors.green),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List trendingmovies = [];
  List topRatedMovies = [];
  List tv = [];
  final String apiKey = '6093b0d449df6df004eea1cd6b2e2165';
  final String readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2MDkzYjBkNDQ5ZGY2ZGYwMDRlZWExY2Q2YjJlMjE2NSIsInN1YiI6IjY0MjZkMzczMDFiMWNhMDA5N2ZkMGNmZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.0pMvY9VuTXKXvWRaXoX_QLly10-xbgt9FTIBx6fOD40';


  @override
  void initState(){
    loadmovies();
    super.initState();
  }



  loadmovies()async{
    TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apiKey, readAccessToken),
        logConfig: ConfigLogger(
          showLogs: true,
          showErrorLogs: true,
        ));

    Map trendingResult = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topRatedResult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map tvResult = await tmdbWithCustomLogs.v3.tv.getPopular();
    // print(trendingResult);
    setState(() {
      trendingmovies = trendingResult['results'];
      topRatedMovies = topRatedResult['results'];
      tv = tvResult['results'];
    });
    print(tv);


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        backgroundColor: Colors.transparent,

        // title: modified_text(text:"Movie Recommendation App", color: Colors.white, size: 25,),
        title: Text("Movie Recommendation App", style: GoogleFonts.cabin(
            color : Colors.white, fontSize:25, fontWeight: FontWeight.bold
        ),),
      ),
      body: ListView(
        children: [
          TV(tv: tv),
          TopRated(topRated: topRatedMovies,),
          TrendingMovies(trending: trendingmovies,),

        ],
      ),
    );
  }
}


