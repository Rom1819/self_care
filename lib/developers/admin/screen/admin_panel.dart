import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:self_care/constrains.dart';
import 'package:self_care/developers/admin/screen/carousel_control/carousel_control.dart';
import 'package:self_care/developers/admin/screen/health_tips/health_tips_control.dart';
import 'package:self_care/developers/admin/screen/man_workout_control/man_workout_control.dart';
import 'package:self_care/developers/admin/screen/user_feedback/user_feedback.dart';
import 'package:self_care/developers/admin/screen/user_list/user_list.dart';
import 'package:self_care/developers/admin/screen/woman_workout_control/woman_workout_control.dart';
import 'package:self_care/screen/home_screen.dart';

class AdminPanel extends StatefulWidget {
  static const routeName = '/admin';
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Admin Panel',
          style: TextStyle(
              fontSize: 22, color: textColor, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: SvgPicture.asset(
            "assets/icons/back.svg",
            color: textColor,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: GridView(
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: defaultPadding,
            crossAxisSpacing: defaultPadding,
            childAspectRatio: 0.75,
          ),
          children: [
            //  User
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => UserList()));
              },
              child: Container(
                padding: EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Center(
                        child: Text(
                          'Contents',
                          style: TextStyle(
                              color: textLightColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('userList')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          return !snapshot.hasData
                              ? Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        backgroundColor),
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.all(defaultPadding),
                                  child: Center(
                                    child: Text(
                                      '${snapshot.data.docs.length}',
                                      style: TextStyle(
                                          color: textColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 48),
                                    ),
                                  ),
                                );
                        }),
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Center(
                        child: Text(
                          'User',
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),

            //  Carousel Control
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CarouselControl()));
              },
              child: Container(
                padding: EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Center(
                        child: Text(
                          'Contents',
                          style: TextStyle(
                              color: textLightColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('carouselImage')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          return !snapshot.hasData
                              ? Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        backgroundColor),
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.all(defaultPadding),
                                  child: Center(
                                    child: Text(
                                      '${snapshot.data.docs.length}',
                                      style: TextStyle(
                                          color: textColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 48),
                                    ),
                                  ),
                                );
                        }),
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Center(
                        child: Text(
                          'Carousel',
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),

            //  Man Workout Control
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ManWorkoutControl()));
              },
              child: Container(
                padding: EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Center(
                        child: Text(
                          'Contents',
                          style: TextStyle(
                              color: textLightColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('manWorkoutImage')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          return !snapshot.hasData
                              ? Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        backgroundColor),
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.all(defaultPadding),
                                  child: Center(
                                    child: Text(
                                      '${snapshot.data.docs.length}',
                                      style: TextStyle(
                                          color: textColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 48),
                                    ),
                                  ),
                                );
                        }),
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Center(
                        child: Text(
                          'Man Workout',
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),

            //  Woman Workout Control
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => WomanWorkoutControl()));
              },
              child: Container(
                padding: EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Center(
                        child: Text(
                          'Contents',
                          style: TextStyle(
                              color: textLightColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('womanWorkoutImage')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          return !snapshot.hasData
                              ? Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        backgroundColor),
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.all(defaultPadding),
                                  child: Center(
                                    child: Text(
                                      '${snapshot.data.docs.length}',
                                      style: TextStyle(
                                          color: textColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 48),
                                    ),
                                  ),
                                );
                        }),
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Center(
                        child: Text(
                          'Woman Workout',
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),

            //  Health Tips Control
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HealthTipsControl()));
              },
              child: Container(
                padding: EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Center(
                        child: Text(
                          'Contents',
                          style: TextStyle(
                              color: textLightColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Center(
                        child: Text(
                          '7',
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 48),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Center(
                        child: Text(
                          'Health Tips',
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),

            //  user Feedback Control
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => UserFeedback()));
              },
              child: Container(
                padding: EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Center(
                        child: Text(
                          'Contents',
                          style: TextStyle(
                              color: textLightColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('feedbackList')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          return !snapshot.hasData
                              ? Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        backgroundColor),
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.all(defaultPadding),
                                  child: Center(
                                    child: Text(
                                      '${snapshot.data.docs.length}',
                                      style: TextStyle(
                                          color: textColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 48),
                                    ),
                                  ),
                                );
                        }),
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Center(
                        child: Text(
                          'User Feedback',
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
