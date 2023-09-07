import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../description.dart';
// import 'package:movie_recommend_final02/description.dart';
// import 'package:movie_recommend_final02/utils/text.dart';

class TrendingMovies extends StatelessWidget {


  final List trending;

  const TrendingMovies({super.key, required this.trending});
  // const TrendingMovies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Trending Movies', style: GoogleFonts.openSans(
              color : Colors.grey, fontSize:18
          ),),
          // modified_text(text: 'Trending Movies', color: Colors.white, size: 18,),
          SizedBox(height: 10,),
          Container(height: 270,
            child: ListView.builder(
                itemCount: trending.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index){
                  return InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context)=> Description(
                                  name: trending[index]['title'],
                                  description: trending[index]['overview'],
                                  bannerurl: 'https://image.tmdb.org/t/p/w500'+trending[index]['backdrop_path'],
                                  posterurl: 'https://image.tmdb.org/t/p/w500'+trending[index]['poster_path'],
                                  vote: trending[index]['vote_average'].toString(),
                                  launch_on: trending[index]['release_date'])));
                    },
                    child:
                    trending[index]['title']!= null?
                    Container(
                      width: 140,
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'http://image.tmdb.org/t/p/w500' + trending[index]['poster_path']
                                  )
                              ),
                            ),
                          ),
                          Container(child:
                          Text(trending[index]['title']!= null?
                          trending[index]['title']:'Loading',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: GoogleFonts.nunito(
                              color : Colors.white, fontSize:15,
                            ),),
                            // modified_text(text: trending[index]['title']!= null?
                            // trending[index]['title']:'Loading', color: Colors.white, size: 15,)

                          )
                        ],
                      ),
                    ):Container(),
                  );
                }),
          )
        ],
      ),
    );
  }
}
