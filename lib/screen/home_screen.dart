import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:self_care/constrains.dart';
import 'package:self_care/developers/developers.dart';
import 'package:self_care/feedback/feedback.dart';
import 'package:self_care/models/Direct.dart';
import 'package:self_care/models/Properties.dart';
import 'package:self_care/user/models/navigate.dart';

import 'custom_List_Tile.dart';
import 'dashBoard.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Self Care",
            style: TextStyle(
                fontSize: 24, color: textColor, fontWeight: FontWeight.bold)),
        iconTheme: IconThemeData(color: textColor),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: defaultPadding / 2),
            icon: Icon(Icons.feedback_outlined, color: textColor),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FeedbackHome()));
            },
          ),
          IconButton(
            padding: EdgeInsets.only(right: defaultPadding / 2),
            icon: Icon(Icons.person, color: textColor),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Navigate()));
            },
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Container(
                child: Column(
                  children: [
                    Material(
                      borderRadius: BorderRadius.circular(50.0),
                      elevation: 8.0,
                      child: Padding(
                        padding: EdgeInsets.all(0),
                        child: Image.asset(
                          'assets/icons/logo.png',
                          height: 85,
                          width: 85,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Text(
                        'Self Care',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    )
                  ],
                ),
              ),
              decoration: BoxDecoration(color: backgroundColor),
            ),
            CustomListTile(
                Icons.person,
                "Body Mass Index",
                () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Direct(
                                    properties: property[0],
                                  )))
                    }),
            CustomListTile(
                Icons.person,
                "Medic Alert",
                () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Direct(
                                    properties: property[1],
                                  )))
                    }),
            CustomListTile(
                Icons.person,
                "Health Tips",
                () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Direct(
                                    properties: property[2],
                                  )))
                    }),
            CustomListTile(
                Icons.person,
                "Man Workout",
                () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Direct(
                                    properties: property[3],
                                  )))
                    }),
            CustomListTile(
                Icons.person,
                "Woman Workout",
                () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Direct(
                                    properties: property[4],
                                  )))
                    }),
            CustomListTile(
                Icons.local_hospital_outlined,
                "Nearest Hospitals",
                () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Direct(
                                    properties: property[5],
                                  )))
                    }),
            SizedBox(
              height: 100.0,
            ),
            CustomListTile(
                Icons.developer_mode_outlined,
                "Developers",
                () => {
                      Navigator.of(context)
                          .pushReplacementNamed(Developers.routeName)
                    }),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 160,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('carouselImage')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  return !snapshot.hasData
                      ? Center(
                          child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  child: Text(
                                    'Loading...',
                                    style: TextStyle(
                                        color: backgroundColor, fontSize: 20),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      backgroundColor),
                                )
                              ],
                            ),
                          ),
                        ))
                      : CarouselSlider.builder(
                          slideBuilder: (index) {
                            return Center(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: backgroundColor,
                                    borderRadius: BorderRadius.circular(12.0),
                                    image: DecorationImage(
                                        image: NetworkImage(snapshot
                                            .data.docs[index]
                                            .get('url')),
                                        fit: BoxFit.cover)),
                              ),
                            );
                          },
                          slideTransform: CubeTransform(rotationAngle: 0.0),
                          slideIndicator: null,
                          enableAutoSlider: true,
                          unlimitedMode: true,
                          autoSliderTransitionCurve: Curves.fastOutSlowIn,
                          autoSliderTransitionTime:
                              Duration(milliseconds: 1000),
                          itemCount: snapshot.data.docs.length);
                },
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              child: Expanded(
                child: GridView.builder(
                    itemCount: property.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: defaultPadding,
                      crossAxisSpacing: defaultPadding,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) => Features(
                          properties: property[index],
                          press: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Direct(
                                        properties: property[index],
                                      ))),
                        )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
