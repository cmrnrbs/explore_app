import 'dart:ui';
import 'dart:math' as math;
import 'package:explore_app/colors.dart';
import 'package:explore_app/explore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

List<String> myArray = [
  'assets/images/restaurant.png',
  'assets/images/gym.png',
  'assets/images/coffee.png',
  'assets/images/groceries.png',
  'assets/images/hotel.png',
  'assets/images/attractions.png'
];

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Explore App',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 110,
            left: -40,
            child: Transform.rotate(
              angle: -math.pi / 12,
              child: SvgPicture.asset(
                'assets/images/map-black-48dp.svg',
                height: 144,
                color: greyColor.withOpacity(0.2),
              ),
            ),
          ),
          Positioned(
              bottom: -250,
              left: -50,
              child: Image.asset('assets/images/circlemap.png')),
          Positioned(
            top: 84.5,
            left: 20,
            child: Container(
              width: MediaQuery.of(context).size.width - 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Hi John,',
                        style: TextStyle(
                            fontFamily: 'BwNista',
                            fontSize: 30,
                            color: orangeColor),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'What are you\nLooking for?',
                        style: TextStyle(
                            fontFamily: 'BwNista',
                            fontSize: 20,
                            color: greyColor),
                      ),
                    ],
                  ),
                  Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2), blurRadius: 4)
                      ], borderRadius: BorderRadius.circular(36)),
                      child: Image.asset('assets/images/avatar.png'))
                ],
              ),
            ),
          ),
          Positioned(
            top: 240,
            left: 4,
            child: Container(
              width: MediaQuery.of(context).size.width - 8,
              height: MediaQuery.of(context).size.height - 240,
              child: GridView.count(
                padding: EdgeInsets.all(0),
                crossAxisCount: 2,
                childAspectRatio: 154 / 120,
                children: List.generate(6, (index) {
                  return Center(
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ExploreMap()));
                      },
                      child: Container(
                        child: Image.asset(myArray[index]),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(4, 4),
                                  spreadRadius: 0,
                                  blurRadius: 8,
                                  color: Colors.black.withOpacity(0.2))
                            ]),
                      ),
                    ),
                  );
                }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
