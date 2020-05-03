import 'package:explore_app/mycustomclipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong/latlong.dart';
import 'colors.dart';

class ExploreMap extends StatefulWidget {
  @override
  _ExploreMapState createState() => _ExploreMapState();
}

MapController _mapctl = MapController();
bool selected = false;
double _marker_size = 20.0;
double _border_thickness = 1.8;
double _border_thickness_outline = 0.4;

class NearbyCoffees {
  String title;
  String away;
  String reviews;

  NearbyCoffees(this.title, this.away, this.reviews);
}

class Details {
  IconData myicon;
  String title;
  Details(this.myicon, this.title);
}

List<Details> myDetails = [
  new Details(Icons.location_on, "3601 S Gaffey St. San Pedro"),
  new Details(Icons.phone, "+1223-548-7785"),
  new Details(Icons.link, "www.dinocoffee.com")
];

List<NearbyCoffees> myArray = [
  new NearbyCoffees("Dinosaur Coffee", "3km", "15"),
  new NearbyCoffees("Civil Coffee", "6km", "23")
];

class _ExploreMapState extends State<ExploreMap> {
  double zoom = 15.0;
  LatLng centerLoc = new LatLng(51.5, -0.09);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          new FlutterMap(
            mapController: _mapctl,
            options: new MapOptions(
              center: centerLoc,
              zoom: zoom,
            ),
            layers: [
              new TileLayerOptions(
                urlTemplate:
                    'https://server.arcgisonline.com/ArcGIS/rest/services/Canvas/World_Light_Gray_Base/MapServer/tile/{z}/{y}/{x}',
                subdomains: ['a', 'b', 'c'],
                tileProvider: NonCachingNetworkTileProvider(),
              ),
              new PolylineLayerOptions(polylines: [
                new Polyline(
                    color: orangeColor,
                    strokeWidth: 5,
                    points: selected
                        ? [
                            new LatLng(51.499686, -0.095958),
                            new LatLng(51.499914, -0.095483),
                            new LatLng(51.498745, -0.092608),
                            new LatLng(51.499540, -0.090773),
                            new LatLng(51.498845, -0.090055),
                            new LatLng(51.498908, -0.089938),
                            new LatLng(51.498946, -0.089500),
                            new LatLng(51.498878, -0.089033),
                            new LatLng(51.498617, -0.088557),
                            new LatLng(51.498902, -0.088203),
                            new LatLng(51.498775, -0.087974),
                            new LatLng(51.498831, -0.087886)
                          ]
                        : [])
              ]),
              new MarkerLayerOptions(
                markers: [
                  new Marker(
                    width: _marker_size * 1.5,
                    height: _marker_size * 1.5,
                    point: new LatLng(51.499686, -0.095958),
                    builder: (ctx) => CurrentLoc(),
                  ),
                  new Marker(
                    width: _marker_size,
                    height: _marker_size,
                    point: new LatLng(51.5, -0.09),
                    builder: (ctx) => MarkerWidget(false),
                  ),
                  new Marker(
                    width: _marker_size,
                    height: _marker_size,
                    point: new LatLng(51.501335, -0.092747),
                    builder: (ctx) => MarkerWidget(false),
                  ),
                  new Marker(
                    width: _marker_size,
                    height: _marker_size,
                    point: new LatLng(51.503145, -0.091094),
                    builder: (ctx) => MarkerWidget(false),
                  ),
                  new Marker(
                    width: _marker_size,
                    height: _marker_size,
                    point: new LatLng(51.502277, -0.088444),
                    builder: (ctx) => MarkerWidget(false),
                  ),
                  new Marker(
                    width: _marker_size,
                    height: _marker_size,
                    point: new LatLng(51.499165, -0.086009),
                    builder: (ctx) => MarkerWidget(false),
                  ),
                  new Marker(
                    width: selected
                        ? _marker_size *
                            (_border_thickness + _border_thickness_outline)
                        : _marker_size,
                    height: selected
                        ? _marker_size *
                            (_border_thickness + _border_thickness_outline)
                        : _marker_size,
                    point: new LatLng(51.498831, -0.087886),
                    builder: (ctx) => MarkerWidget(true),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            left: 0,
            bottom: 52,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 168,
              child: ListView.builder(
                  padding: EdgeInsets.only(left: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: myArray.length,
                  itemBuilder: (context, int index) {
                    return Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            setState(() {
                              selected = !selected;
                              centerLoc = new LatLng(51.496762, -0.087758);
                              zoom = 16.0;

                              _mapctl.move(centerLoc, zoom);
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 220,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 9.5, top: 8, bottom: 8, right: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Image.asset(
                                        'assets/images/coffee_avatar.png'),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      myArray[index].title,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            myArray[index].away + " away",
                                            style: TextStyle(
                                                color: orangeColor,
                                                fontFamily: 'HelveticaWorld',
                                                fontSize: 15),
                                          ),
                                          Text(
                                            myArray[index].reviews + " reviews",
                                            style: TextStyle(
                                                color: greyColor,
                                                fontFamily: 'ITCAvant'),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        )
                      ],
                    );
                  }),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 20,
                            height: 30,
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    selected = false;
                                  });
                                  Future.delayed(
                                      const Duration(milliseconds: 500), () {
                                    Navigator.pop(context);
                                  });
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 60,
                            height: 30,
                            child: Center(
                                child: Text(
                              'Nearby Coffee shops',
                              style: TextStyle(
                                  fontFamily: 'HelveticaWorld', fontSize: 20),
                            )),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Colors.white.withOpacity(1),
                    Colors.white.withOpacity(0.95),
                    Colors.white.withOpacity(0.7),
                    Colors.white.withOpacity(0.1)
                  ])),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            bottom: selected ? 0 : -MediaQuery.of(context).size.height / 1.5,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selected = !selected;
                  if (!selected) {
                    centerLoc = new LatLng(51.5, -0.09);
                    zoom = 15.0;
                  }
                  _mapctl.move(centerLoc, zoom);
                });
              },
              child: ClipPath(
                clipper: MyCustomClipper(),
                child: Container(
                  alignment: selected
                      ? Alignment.center
                      : AlignmentDirectional.topCenter,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Dinosaur Coffee',
                          style:
                              TextStyle(fontSize: 28, fontFamily: 'ITCAvant'),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          '3km away - 10min',
                          style: TextStyle(
                              color: orangeColor,
                              fontFamily: 'HelveticaWorld',
                              fontSize: 16),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: (MediaQuery.of(context).size.height / 2) + 9,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 40,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 116,
                                child: ListView.builder(
                                    padding: EdgeInsets.only(left: 20),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 3,
                                    itemBuilder: (context, int index) {
                                      return Row(
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(24),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                      blurRadius: 5)
                                                ]),
                                            child: Image.asset(
                                                'assets/images/coffee_det' +
                                                    (index + 1).toString() +
                                                    ".png"),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                        ],
                                      );
                                    }),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Reviews',
                                      style: TextStyle(
                                          fontFamily: 'HelveticaWorld',
                                          fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.star,
                                          color: orangeColor,
                                          size: 20,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: orangeColor,
                                          size: 20,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: orangeColor,
                                          size: 20,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: orangeColor,
                                          size: 20,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: greyColor,
                                          size: 20,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Details',
                                            style: TextStyle(
                                                fontFamily: 'HelveticaWorld',
                                                fontSize: 15)),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        DetailScreen()
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  double myheight = 20 * myDetails.length.toDouble() +
      (10 * (myDetails.length - 1).toDouble());
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: myheight,
      child: ListView.builder(
        padding: EdgeInsets.all(0),
        itemCount: myDetails.length,
        itemBuilder: (context, int index) {
          return Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    myDetails[index].myicon,
                    color: greyColor,
                    size: 18,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    myDetails[index].title,
                    style: TextStyle(
                        color: greyColor, fontSize: 14, fontFamily: 'ITCAvant'),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              )
            ],
          );
        },
      ),
    );
  }
}

class MarkerWidget extends StatefulWidget {
  bool isSelected;
  MarkerWidget(this.isSelected);
  @override
  _MarkerWidgetState createState() => _MarkerWidgetState();
}

class _MarkerWidgetState extends State<MarkerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: (widget.isSelected && selected)
          ? _marker_size * (_border_thickness + _border_thickness_outline)
          : _marker_size,
      height: (widget.isSelected && selected)
          ? _marker_size * (_border_thickness + _border_thickness_outline)
          : _marker_size,
      decoration: BoxDecoration(
          border: (widget.isSelected && selected)
              ? Border.all(color: Colors.orange.withOpacity(0.3), width: 6)
              : null,
          borderRadius: BorderRadius.circular((selected
                  ? _marker_size *
                      (_border_thickness + _border_thickness_outline)
                  : _marker_size)) /
              2),
      child: Container(
        width: (widget.isSelected && selected)
            ? _marker_size * _border_thickness
            : _marker_size,
        height: (widget.isSelected && selected)
            ? _marker_size * _border_thickness
            : _marker_size,
        decoration: BoxDecoration(
            border: (widget.isSelected && selected)
                ? Border.all(color: Colors.orange.withOpacity(0.5), width: 6)
                : null,
            borderRadius: BorderRadius.circular((selected
                    ? _marker_size *
                        (_border_thickness + _border_thickness_outline)
                    : _marker_size)) /
                2),
        child: new Container(
          width: _marker_size,
          height: _marker_size,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: Offset(2, 2),
                  blurRadius: 5,
                  color: Colors.black.withOpacity(0.2),
                )
              ],
              color: orangeColor,
              border: Border.all(color: Colors.white, width: 3),
              borderRadius: BorderRadius.circular((selected
                      ? _marker_size *
                          (_border_thickness + _border_thickness_outline)
                      : _marker_size)) /
                  2),
        ),
      ),
    );
  }
}

class CurrentLoc extends StatefulWidget {
  @override
  _CurrentLocState createState() => _CurrentLocState();
}

class _CurrentLocState extends State<CurrentLoc> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/navigation.png',
    );
  }
}
