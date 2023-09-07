import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:movie_recommend_final02/utils/text.dart';

import '../description.dart';

class TV extends StatelessWidget {


  final List tv;

  const TV({super.key, required this.tv});
  // const TrendingMovies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // modified_text(text: 'Popular TV Shows', color: Colors.white, size: 18,),
          Text('Popular TV Shows', style: GoogleFonts.openSans(
              color : Colors.grey, fontSize:18
          ),),
          SizedBox(height: 10,),
          Container(height: 200,
            child: ListView.builder(
                itemCount: tv.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index){
                  return InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context)=> Description(
                                  name: tv[index]['original_name'],
                                  description: tv[index]['overview'],
                                  bannerurl: 'https://image.tmdb.org/t/p/w500'+tv[index]['backdrop_path'],
                                  posterurl: 'https://image.tmdb.org/t/p/w500'+tv[index]['poster_path'],
                                  vote: tv[index]['vote_average'].toString(),
                                  launch_on: tv[index]['first_air_date'])));
                    },
                    child:
                    tv[index]['backdrop_path']!= null?
                    Container(
                      padding: EdgeInsets.all(5),
                      width: 250,
                      child: Column(
                        children: [
                          Container(
                            width: 250,
                            height: 140,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage(

                                    'http://image.tmdb.org/t/p/w500' + tv[index]['backdrop_path'],

                                  ),
                                  fit: BoxFit.cover
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(child:
                          Text(tv[index]['original_name']!= null?
                          tv[index]['original_name']:'Loading',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: GoogleFonts.nunito(
                              color : Colors.white, fontSize:15,
                            ),),

                            // modified_text(text: tv[index]['original_name']!= null?
                            // tv[index]['original_name']:'Loading', color: Colors.white, size: 15,),
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
