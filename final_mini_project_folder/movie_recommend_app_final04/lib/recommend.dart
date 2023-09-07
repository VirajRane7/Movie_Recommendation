import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';

import 'function.dart';

class Recommend extends StatefulWidget {
  const Recommend({Key? key}) : super(key: key);

  @override
  State<Recommend> createState() => _RecommendState();
}

class _RecommendState extends State<Recommend> {
  String url1 = "";
  var data1;
  bool ret = false;

  List<dynamic> output = [];
  List<dynamic> output1 = [];

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
            )
          ],
        ),
      )
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,

        title: Text("Search Any Movie", style: GoogleFonts.cabin(
            color : Colors.white, fontSize:25, fontWeight: FontWeight.bold
        ),),
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  width: 290,
                  // child: DropdownButtonFormField(
                  //   isExpanded: true,
                  //   decoration: InputDecoration(
                  //     enabledBorder: OutlineInputBorder(
                  //       borderSide: BorderSide(color: Colors.blueGrey.shade400, width: 2),
                  //       borderRadius: BorderRadius.circular(20),
                  //     ),
                  //
                  //     focusedBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(20),
                  //
                  //     )
                  //   ),
                  // ),
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      // contentPadding: EdgeInsets.symmetric(
                      //   horizontal: 10,
                      //   vertical: 3
                      // ),

                      enabledBorder: OutlineInputBorder(

                        borderSide: BorderSide(color: Colors.blueGrey.shade400, width: 2),
                        borderRadius: BorderRadius.circular(20),


                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal.shade50, width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    onChanged: (value){
                      // http://192.168.207.114:5000
                      url1 = "http://192.168.61.114:5001/api2?query=" + value.toString();

                    },

                  ),

                ),
                TextButton(

                    onPressed: () async {
                      data1 = await fetchdata(url1);
                      // print(data1);
                      var decoded = jsonDecode(data1);
                      print(decoded[0]);
                      FocusManager.instance.primaryFocus?.unfocus();
                      setState(() {
                        // out = [[l1],[l2]]
                        output = decoded[0];
                        output1 = decoded[1];
                        ret = true;
                      });
                    },

                    child: Text(

                      'Search Movie',
                      // style: TextStyle(fontSize: 20),
                      style: GoogleFonts.comicNeue(
                          color : Colors.blueGrey.shade400, fontSize:20,fontWeight: FontWeight.bold
                      ),
                    ),
                ),
            Align(
              alignment: FractionalOffset.topLeft,
              child: Container(
                child: Text(
                  output.length > 0 ? 'Similar Movies:' : 'No Such Movies/Search Again',
                  style: TextStyle(fontSize: 22, color: Colors.white,fontWeight: FontWeight.bold),
                ),
              ),
            ),

            SizedBox(height: 15,),
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Container(
                //     color: Colors.red,
                //     child: Text(
                //       "List Of Movies:",
                //     ),
                //   ),
                // ),
                // Text("list of movies", style: TextStyle(color: Colors.white),),

            //   Text((() {
            //   if(data1==false){
            //     return "tis true";}
            //   else {
            //     return "anything but true";
            //   }
            // })(),style: TextStyle(color: Colors.white),),
            //     Container(
            //         child: output == true ? Text("Movies", style: TextStyle(color: Colors.white),) : null
            //     ),

                GridView.count(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    physics: ScrollPhysics(),

                    mainAxisSpacing: 0,
                    crossAxisSpacing: 2,
                    childAspectRatio: 2/4.5,


                  children:output.map((e) => Column(children: [
                    Card(
                      child: new Container(
                        child: GestureDetector(
                            child: Image.network(e['poster_link'],),
                      onLongPress:() {
                            Clipboard.setData(ClipboardData(text: e['movie_name']));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                    content: Text("Text copied to clipboard", ),
                              ),
                            );
                            },
                        ),

                      ),

                    ),

                    GestureDetector(
                      child: Text(e['movie_name'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      style: GoogleFonts.openSans(color: Colors.white,fontSize: 15,),),
                    onLongPress:() {
                    Clipboard.setData(ClipboardData(text: e['movie_name']));
                    ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                    content: Text("Text copied to clipboard", ),
                    ),
                    );
                    },

                    )
                  ],)).toList(),
                ),
                SizedBox(
                  height: 10,
                ),

                Align(
                  alignment: FractionalOffset.topLeft,
                  child: Container(
                    child: Text(
                      output1.length > 0 ? 'You Can Also Watch:' : '',
                      style: TextStyle(fontSize: 22, color: Colors.white,fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                GridView.count(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  physics: ScrollPhysics(),

                  mainAxisSpacing: 0,
                  crossAxisSpacing: 2,
                  childAspectRatio: 2/4.5,


                  children:output1.map((e) => Column(children: [
                    Card(
                      child: new Container(
                        child: GestureDetector(
                            child: Image.network(e['poster_link'],),
                      onLongPress:() {
                          Clipboard.setData(ClipboardData(text: e['movie_name']));
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Text copied to clipboard", ),
                                ),
                            );},
                        ),

                      ),

                    ),

                    Text(e['movie_name'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: GoogleFonts.openSans(color: Colors.white,fontSize: 15, decorationColor: Colors.redAccent),)
                  ],)).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
