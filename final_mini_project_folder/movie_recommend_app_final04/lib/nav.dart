import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:movie_recommend_app_final04/recommend.dart';

import 'genres.dart';
import 'home.dart';
import 'search.dart';
// import 'package:movie_recommend_final02/genres.dart';
// import 'package:movie_recommend_final02/home.dart';
// import 'package:movie_recommend_final02/search.dart';
// import "package:google_nav_bar/google_nav_bar.dart";



class Nav extends StatefulWidget {

  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget> [
    Home(),
    Recommend(),
    Genres(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(

        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      // backgroundColor: Colors.black,
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.white,
      //   selectedItemColor: Colors.black54,
      //   unselectedItemColor: Colors.grey.withOpacity(0.5),
      //   iconSize: 35,
      //   type: BottomNavigationBarType.shifting,
      //   showSelectedLabels: true,
      //   showUnselectedLabels: false,
      //   elevation: 0,
      //   items: const <BottomNavigationBarItem> [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home_outlined),
      //       label: "Home",
      //     ),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.search_outlined),
      //         label: 'Search'
      //     ),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.theater_comedy_outlined),
      //         label: 'Genres'
      //     ),
      //   ],
      //
      //   currentIndex: _selectedIndex,
      //   onTap: _onItemTap,
      //
      // ),
      // bottomNavigationBar: Container(
      //   color: Colors.black,
      //   child: Padding(
      //
      //   padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 15),
      //   child: GNav(
      //     backgroundColor: Colors.black,
      //     color: Colors.white,
      //     activeColor: Colors.white,
      //     tabBackgroundColor: Colors.grey.shade900,
      //     gap: 8,
      //     padding: EdgeInsets.all(18),
      //     iconSize: 25,
      //
      //     tabs: [
      //       GButton(
      //           icon: Icons.home_outlined,
      //       text: "Home",),
      //       GButton(
      //           icon: Icons.search_outlined,
      //       text: "Search",),
      //       GButton(
      //           icon: Icons.theater_comedy_outlined,
      //       text: "Genres"),
      //
      //     ],
      //   ),
      //   ),
      // ),

      bottomNavigationBar: Container(

        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(color: Colors.teal.shade50,

            // boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))],
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            )),

        child: SafeArea(child: GNav(rippleColor: Colors.black,
          hoverColor: Colors.grey.shade800,
          gap: 6,
          activeColor: Colors.teal.shade50,
          duration: Duration(milliseconds: 600),
          tabBackgroundColor: Colors.black87.withOpacity(0.95),
          color: Colors.black,
          padding: EdgeInsets.all(10),
          iconSize: 30,



          tabs: [
            GButton(icon: LineIcons.home, text: 'Home',),
            GButton(icon: LineIcons.search, text: 'Search',),
            GButton(icon: LineIcons.theaterMasks, text: "Genres",),
          ],
          selectedIndex: _selectedIndex,
          // onTabChange: (index) {
          // setState(() {
          //   _selectedIndex = index;
          // });
          // },
          onTabChange: _onItemTap,


        ),),
      ),
    );
  }
}
