import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:movie_recommend_final02/utils/text.dart';

import '../description.dart';
import '../utils/text.dart';

class TopRated extends StatelessWidget {


  final List topRated;

  const TopRated({super.key, required this.topRated});
  // const TrendingMovies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // modified_text(text: 'Top Rated Movies', color: Colors.white, size: 18,),
          Text('Top Rated Movies', style: GoogleFonts.openSans(
              color : Colors.grey, fontSize:18
          ),),
          SizedBox(height: 10,),
          Container(height: 270,
            child: ListView.builder(
                itemCount: topRated.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index){
                  return InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context)=> Description(
                                  name: topRated[index]['title'],
                                  description: topRated[index]['overview'],
                                  bannerurl: 'https://image.tmdb.org/t/p/w500'+topRated[index]['backdrop_path'],
                                  posterurl: 'https://image.tmdb.org/t/p/w500'+topRated[index]['poster_path'],
                                  vote: topRated[index]['vote_average'].toString(),
                                  launch_on: topRated[index]['release_date'])));
                    },
                    child:
                    topRated[index]['title']!= null?
                    Container(
                      width: 140,
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'http://image.tmdb.org/t/p/w500' + topRated[index]['poster_path']
                                  )
                              ),
                            ),
                          ),
                          Container(child: modified_text(text: topRated[index]['title']!= null?
                          topRated[index]['title']:'Loading', color: Colors.white, size: 15,),)
                        ],
                      ),
                    ): Container(),
                  );
                }),
          )
        ],
      ),
    );
  }
}
