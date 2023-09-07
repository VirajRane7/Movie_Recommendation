import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'utils/text.dart';
// import 'package:movie_recommend_final02/utils/text.dart';

class Description extends StatelessWidget {
  // const Description({Key? key}) : super(key: key);
  final String name, description, bannerurl, posterurl, vote, launch_on;

  const Description({super.key, required this.name, required this.description, required this.bannerurl, required this.posterurl, required this.vote, required this.launch_on});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: ListView(
          children: [
            Container(
              height: 250,
              child: Stack(
                children: [
                  Positioned(child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(bannerurl, fit: BoxFit.cover,),
                  )),
                  Positioned(
                      bottom: 10,
                      child: modified_text(text: '⭐ Average Rating - '+vote, color: Colors.white, size: 18,)),
                ],
              ),
            ),
            SizedBox(height: 15,),
            Container(padding: EdgeInsets.all(10),
              child: modified_text(text: name!= null?name:"Loading..", color: Colors.white, size: 24,),
            ),
            Container(padding: EdgeInsets.only(left: 10),
              child: modified_text(text: "releasing on: "+launch_on,size: 14,color: Colors.white,),),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  height: 200,
                  width: 100,
                  child: Image.network(posterurl),
                ),
                Flexible(
                  child: Container(
                    // child: modified_text(text: description,size: 18,color: Colors.white,),
                    child: Text(description,style: GoogleFonts.comicNeue(
                        color : Colors.white, fontSize:18
                    ),),
                  ),
                ),

              ],
            )
          ],
        ),
      ),

    );
  }
}
