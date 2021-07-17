import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:self_care/constrains.dart';
import 'package:self_care/developers/admin/screen/admin_panel.dart';
import 'package:self_care/developers/admin/screen/carousel_control/add_carousel_images.dart';

class CarouselControl extends StatefulWidget {
  @override
  _CarouselControlState createState() => _CarouselControlState();
}

class _CarouselControlState extends State<CarouselControl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Carousel Control',
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_a_photo_outlined),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddCarouselImages()));
        },
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('carouselImage').snapshots(),
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
                            style: TextStyle(
                              fontSize: 20,
                              color: backgroundColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CircularProgressIndicator(
                          value: 2 / 7,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(backgroundColor),
                        )
                      ],
                    ),
                  ),
                ))
              : Container(
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(defaultPadding / 2),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(defaultPadding / 2),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Center(
                                      child: Container(
                                        height: 180,
                                        decoration: BoxDecoration(
                                            color: Colors.blueGrey,
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
                                      height: 25.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(),
                                        // ignore: deprecated_member_use
                                        RaisedButton(
                                          onPressed: () {
                                            return showDialog(
                                                context: context,
                                                barrierDismissible: true,
                                                builder: (param) {
                                                  return AlertDialog(
                                                    actions: [
                                                      TextButton(
                                                          child: Text('Cancel',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blueGrey,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context)),
                                                      TextButton(
                                                          child: Text('Delete',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          onPressed: () async {
                                                            snapshot
                                                                .data
                                                                .docs[index]
                                                                .reference
                                                                .delete()
                                                                .whenComplete(() => Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                CarouselControl())));
                                                          }),
                                                    ],
                                                    title: Text(
                                                      'Are you really want to delete the data?',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.blueGrey,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  );
                                                });
                                          },
                                          child: Text('Delete',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold)),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          color: Colors.white,
                                          textColor: Colors.blueGrey,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                );
        },
      ),
    );
  }
}
