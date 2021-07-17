import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:self_care/constrains.dart';

class WomanWorkout extends StatefulWidget {
  @override
  _WomanWorkoutState createState() => _WomanWorkoutState();
}

class _WomanWorkoutState extends State<WomanWorkout> {
  int i;
  CarouselSliderController carouselController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Woman Workout',
          style: TextStyle(
              fontSize: 22, color: textColor, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: SvgPicture.asset(
            "assets/icons/back.svg",
            color: textColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('womanWorkoutImage')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return !snapshot.hasData
              ? Center(
                  child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          child: Text(
                            'Loading...',
                            style:
                                TextStyle(color: backgroundColor, fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(backgroundColor),
                        )
                      ],
                    ),
                  ),
                ))
              : Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: defaultPadding / 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height - 125,
                        child: CarouselSlider.builder(
                          slideTransform: CubeTransform(rotationAngle: 0.0),
                          autoSliderTransitionCurve: Curves.fastOutSlowIn,
                          controller: carouselController,
                          itemCount: snapshot.data.docs.length,
                          slideBuilder: (index) {
                            i = index;
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Container(
                                padding: EdgeInsets.fromLTRB(
                                    defaultPadding / 2,
                                    defaultPadding / 2,
                                    defaultPadding / 2,
                                    defaultPadding),
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Center(
                                        child: Container(
                                          height: 200,
                                          decoration: BoxDecoration(
                                              color: backgroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              image: DecorationImage(
                                                  image: NetworkImage(snapshot
                                                      .data.docs[index]
                                                      .get('url')),
                                                  fit: BoxFit.cover)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30.0,
                                      ),
                                      Text(
                                        'Title :  ${(snapshot.data.docs[index].get('title'))}',
                                        style: TextStyle(
                                            color: textColor,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Text(
                                        'Impact - 1 :  ${(snapshot.data.docs[index].get('one'))}',
                                        style: TextStyle(
                                            color: textColor, fontSize: 18.0),
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Text(
                                        'Impact - 2 :  ${(snapshot.data.docs[index].get('two'))}',
                                        style: TextStyle(
                                            color: textColor, fontSize: 18.0),
                                      ),
                                      SizedBox(
                                        height: 25.0,
                                      ),
                                      Text(
                                        'Step - 1 :  ${(snapshot.data.docs[index].get('three'))}',
                                        style: TextStyle(
                                            color: textColor, fontSize: 18.0),
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Text(
                                        'Step - 2 :  ${(snapshot.data.docs[index].get('four'))}',
                                        style: TextStyle(
                                            color: textColor, fontSize: 18.0),
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Text(
                                        'Step - 3 :  ${(snapshot.data.docs[index].get('five'))}',
                                        style: TextStyle(
                                            color: textColor, fontSize: 18.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: defaultPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // ignore: deprecated_member_use
                            RaisedButton(
                              child: Text(
                                'Previous',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              onPressed: () async {
                                if (i > 1) {
                                  carouselController.previousPage(
                                    Duration(seconds: 2),
                                  );
                                }
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 8.0,
                              color: Colors.white,
                              textColor: textColor,
                            ),
                            // ignore: deprecated_member_use
                            RaisedButton(
                              child: Text(
                                'Next',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              onPressed: () async {
                                if (i < snapshot.data.docs.length - 1) {
                                  carouselController.nextPage(
                                    Duration(seconds: 2),
                                  );
                                }
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 8.0,
                              color: Colors.white,
                              textColor: textColor,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }
}
