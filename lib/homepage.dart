import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tour_guide_app/Screens/convertCurrency_screen.dart';
import 'package:tour_guide_app/Screens/favourite_screen.dart';
import 'package:tour_guide_app/Screens/guide.dart';
import 'package:tour_guide_app/Screens/login_screen.dart';
import 'package:tour_guide_app/Screens/search_screen.dart';
import 'package:tour_guide_app/home-components/Valleys.dart';
import 'package:tour_guide_app/home-components/places2.dart';
import 'package:tour_guide_app/home-components/restaurants.dart';
import 'package:tour_guide_app/testguides.dart';
import 'package:tour_guide_app/widgets/drawer.dart';

import 'home-components/tobtabbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          child: DefaultTextStyle(
            style: GoogleFonts.dangrek(
                textStyle: Theme.of(context).textTheme.displayMedium,
                fontSize: 32),
            child: Text("Jordan Tour Guide"),
            // child: AnimatedTextKit(
            //   animatedTexts: [
            //     TyperAnimatedText("JORDAN TOUR",
            //         speed: Duration(milliseconds: 400)),
            //   ],
            // ),
          ),
        ),
        actions: [
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(
          //     Icons.search,
          //     size: 30,
          //   ),
          // ),
        ],
        // actions: [Row(children: [

        //   CircleAvatar(foregroundImage: NetworkImage("https://w7.pngwing.com/pngs/340/946/png-transparent-avatar-user-computer-icons-software-developer-avatar-child-face-heroes-thumbnail.png"),),
        //              SizedBox(width: 10,),

        //   Text("username",style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic),),

        //   SizedBox(width: 150,),

        // ],)

        // ],
      ),
      body: TabBarView(controller: _tabController, children: <Widget>[
        tobTabPar(),
        FavouriteScreen(),
        SearchScreen(),
        // Test(),
        convertCurrency()
      ]),
      bottomNavigationBar: Container(
        child: TabBar(
            indicator: UnderlineTabIndicator(borderSide: BorderSide(width: 0)),
            controller: _tabController,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.other_houses),
                text: "Home",
              ),
              Tab(
                icon: Icon(Icons.favorite),
                text: "Favorite",
              ),
              Tab(
                icon: Icon(Icons.search),
                text: "Search",
              ),
              // Tab(
              //   icon: Icon(Icons.person),
              //   text: "Guides",
              // ),
              Tab(
                icon: Icon(
                  Icons.currency_exchange,
                ),
                text: "Currency",
              )
            ]),
      ),
    );
  }
}
