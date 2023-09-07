import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'function.dart';
// import 'package:movie_recommend_final02/function.dart';




class Genres extends StatefulWidget {
  const Genres({Key? key}) : super(key: key);

  @override
  State<Genres> createState() => _GenresState();
}

class _GenresState extends State<Genres> {
  String url = "";
  var data;
  List<dynamic> output = [];

  Widget quoteTemplate(output) {
    return Card(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              output,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(
              height: 6,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,

        // title: modified_text(text:"Movie Recommendation App", color: Colors.white, size: 25,),
        title: Text("Search By Genres", style: GoogleFonts.cabin(
            color : Colors.white, fontSize:25, fontWeight: FontWeight.bold
        ),),
      ),
      body: Center(

          child: SingleChildScrollView(
            child: Container(
              // width: 450,
              padding: EdgeInsets.all(20),
              child: Column(

                children: [
                  Container(
                    width: 290,
                    child: DropdownButtonFormField(
                        isExpanded: true,
                        decoration: InputDecoration(
                          // contentPadding: EdgeInsets.symmetric(
                          //   horizontal: 10,
                          //   vertical: 3
                          // ),

                          enabledBorder: OutlineInputBorder(

                            borderSide: BorderSide(color: Colors.teal.shade50, width: 2),
                            borderRadius: BorderRadius.circular(20),


                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueGrey.shade400, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        dropdownColor: Colors.blueGrey.shade400,
                        menuMaxHeight: 300,
                        style: TextStyle(color: Colors.white),
                        items: [
                          DropdownMenuItem(child: Text("-SELECT GENRE-", style:TextStyle(fontWeight: FontWeight.bold,) ,),value :"",),
                          DropdownMenuItem(child: Text("Drama", style:TextStyle(fontWeight: FontWeight.bold,) ,), value: "Drama",),
                          DropdownMenuItem(child: Text("Action", style:TextStyle(fontWeight: FontWeight.bold,) ,),value: "Action",),
                          DropdownMenuItem(child: Text("Fantasy", style:TextStyle(fontWeight: FontWeight.bold,) ,),value:"Fantasy"),
                          DropdownMenuItem(child: Text("Comedy", style:TextStyle(fontWeight: FontWeight.bold,) ,), value: "Comedy",),
                          DropdownMenuItem(child: Text("Thriller", style:TextStyle(fontWeight: FontWeight.bold,) ,),value: "Thriller",),
                          DropdownMenuItem(child: Text("Adventure", style:TextStyle(fontWeight: FontWeight.bold,) ,),value:"Adventure"),
                          DropdownMenuItem(child: Text("Crime", style:TextStyle(fontWeight: FontWeight.bold,) ,), value: "Crime",),
                          DropdownMenuItem(child: Text("Science Fiction", style:TextStyle(fontWeight: FontWeight.bold,) ,),value: "Science Fiction",),
                          DropdownMenuItem(child: Text("Horror", style:TextStyle(fontWeight: FontWeight.bold,) ,),value:"Horror"),
                          DropdownMenuItem(child: Text("Family", style:TextStyle(fontWeight: FontWeight.bold,) ,), value: "Family",),
                          DropdownMenuItem(child: Text("Mystery", style:TextStyle(fontWeight: FontWeight.bold,) ,),value: "Mystery",),
                          DropdownMenuItem(child: Text("Animation", style:TextStyle(fontWeight: FontWeight.bold,) ,),value:"Animation"),
                          DropdownMenuItem(child: Text("History", style:TextStyle(fontWeight: FontWeight.bold,) ,), value: "History",),
                          DropdownMenuItem(child: Text("Music", style:TextStyle(fontWeight: FontWeight.bold,) ,),value: "Music",),
                          DropdownMenuItem(child: Text("War", style:TextStyle(fontWeight: FontWeight.bold,) ,),value:"War"),
                          DropdownMenuItem(child: Text("Documentary", style:TextStyle(fontWeight: FontWeight.bold,) ,), value: "Documentary",),
                          DropdownMenuItem(child: Text("Western", style:TextStyle(fontWeight: FontWeight.bold,) ,),value: "Western",),
                          DropdownMenuItem(child: Text("Foreign", style:TextStyle(fontWeight: FontWeight.bold,) ,),value:"Foreign"),
                        ],
                        onChanged: (value) {
                          // http://192.168.207.114:5000
                          url = "http://192.168.61.114:5001/api?query=" + value.toString();
                        }),
                  ),
                  // TextField(
                  //   style: TextStyle(color: Colors.white),
                  //   onChanged: (value) {
                  //     url = "http://127.0.0.1:5000/api?query=" + value.toString();
                  //   },
                  // ),
                  TextButton(
                      onPressed: () async {
                        data = await fetchdata(url);
                        var decoded = jsonDecode(data);
                        setState(() {
                          output = decoded;
                        });
                      },
                      child: Text(
                        'Fetch Movies',
                        // style: TextStyle(fontSize: 20),
                        style: GoogleFonts.comicNeue(
                            color : Colors.blueGrey.shade400, fontSize:20,fontWeight: FontWeight.bold
                        ),
                      )),


                  GridView.count(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      physics: ScrollPhysics(),

                      mainAxisSpacing: 0,
                      crossAxisSpacing: 2,
                      childAspectRatio: 2/4.5,
                      children: output.map(
                              (e) => Column(children: [
                            Card(

                              // elevation: 20.0,
                              child: new Container(
                                child: Image.network(e['poster_link_w342'],),
                              ),
                            ),
                            // Image.network(e['poster_link_w185'],),
                            // Text(player['poster_link_w185']),
                            Text(e['title'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              // style: GoogleFonts.openSans(
                              //     color : Colors.grey, fontSize:18
                              // ),
                              style: GoogleFonts.openSans(color: Colors.white,fontSize: 15,decorationColor: Colors.redAccent,

                              ),)
                            // Text(e['title'], style: TextStyle(color: Colors.white,fontSize: 15),)
                          ])).toList()
                  )

                  // Column(
                  //
                  //   children: output.map((e) {
                  //     // return Text(e[0]+e[1]);
                  //     return Card(child: Center(child: Text(e[0]),),);
                  //   }).toList(),
                  // )
                ],
              ),
            ),
          )),
    );
  }
}
