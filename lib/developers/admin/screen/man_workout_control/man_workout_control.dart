import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:self_care/constrains.dart';
import 'package:self_care/developers/admin/screen/man_workout_control/man_workout_image.dart';
import 'package:self_care/models/string_extension.dart';

class ManWorkoutControl extends StatefulWidget {
  @override
  _ManWorkoutControlState createState() => _ManWorkoutControlState();
}

class _ManWorkoutControlState extends State<ManWorkoutControl> {
  final GlobalKey<FormState> _editManWorkoutImageFormKey = GlobalKey();

  //  User modifying functions
  var _editTitleController = TextEditingController();
  var _editOneController = TextEditingController();
  var _editTwoController = TextEditingController();
  var _editThreeController = TextEditingController();
  var _editFourController = TextEditingController();
  var _editFiveController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Man Workout Control',
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
              MaterialPageRoute(builder: (context) => ManWorkoutImage()));
        },
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('manWorkoutImage')
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
                                    SizedBox(
                                      height: 25.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
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
                                                                  color:
                                                                      textColor,
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
                                                                .whenComplete(() =>
                                                                    Navigator.pop(
                                                                        context));
                                                          }),
                                                    ],
                                                    title: Text(
                                                      'Are you really want to delete the data?',
                                                      style: TextStyle(
                                                          color: textColor,
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
                                        // ignore: deprecated_member_use
                                        RaisedButton(
                                          onPressed: () {
                                            _editTitleController.text = snapshot
                                                .data.docs[index]
                                                .get('title');
                                            _editOneController.text = snapshot
                                                .data.docs[index]
                                                .get('one');
                                            _editTwoController.text = snapshot
                                                .data.docs[index]
                                                .get('two');
                                            _editThreeController.text = snapshot
                                                .data.docs[index]
                                                .get('three');
                                            _editFourController.text = snapshot
                                                .data.docs[index]
                                                .get('four');
                                            _editFiveController.text = snapshot
                                                .data.docs[index]
                                                .get('five');
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                            showDialog(
                                                context: context,
                                                barrierDismissible: true,
                                                builder: (param) {
                                                  return AlertDialog(
                                                      title: Text(
                                                        'Edit User Information',
                                                        style: TextStyle(
                                                            color: textColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      content: Card(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.0),
                                                        ),
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  12.0),
                                                          child: Form(
                                                            key:
                                                                _editManWorkoutImageFormKey,
                                                            child:
                                                                SingleChildScrollView(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  TextFormField(
                                                                    decoration:
                                                                        InputDecoration(
                                                                      labelText:
                                                                          'Title : ',
                                                                    ),
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .text,
                                                                    controller:
                                                                        _editTitleController,
                                                                    validator:
                                                                        (value) {
                                                                      if (value
                                                                          .isEmpty) {
                                                                        return 'Invalid title';
                                                                      }
                                                                      return null;
                                                                    },
                                                                  ),
                                                                  TextFormField(
                                                                    decoration: InputDecoration(
                                                                        labelText:
                                                                            'Impact : 1',
                                                                        hintText:
                                                                            'Enter impact - 1'),
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .text,
                                                                    controller:
                                                                        _editOneController,
                                                                    validator:
                                                                        (value) {
                                                                      if (value
                                                                          .isEmpty) {
                                                                        return 'Invalid Step';
                                                                      }
                                                                      return null;
                                                                    },
                                                                  ),
                                                                  // Password
                                                                  TextFormField(
                                                                    decoration: InputDecoration(
                                                                        labelText:
                                                                            'Impact : 2',
                                                                        hintText:
                                                                            'Enter impact - 2'),
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .text,
                                                                    controller:
                                                                        _editTwoController,
                                                                    validator:
                                                                        (value) {
                                                                      if (value
                                                                          .isEmpty) {
                                                                        return 'Invalid Step';
                                                                      }
                                                                      return null;
                                                                    },
                                                                  ),
                                                                  // Confirm Password
                                                                  TextFormField(
                                                                    decoration: InputDecoration(
                                                                        labelText:
                                                                            'Step : 1',
                                                                        hintText:
                                                                            'Enter Step - 2'),
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .text,
                                                                    controller:
                                                                        _editThreeController,
                                                                    validator:
                                                                        (value) {
                                                                      if (value
                                                                          .isEmpty) {
                                                                        return 'Invalid Step';
                                                                      }
                                                                      return null;
                                                                    },
                                                                  ),
                                                                  //
                                                                  TextFormField(
                                                                    decoration: InputDecoration(
                                                                        labelText:
                                                                            'Step : 2',
                                                                        hintText:
                                                                            'Enter Step - 2'),
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .text,
                                                                    controller:
                                                                        _editFourController,
                                                                    validator:
                                                                        (value) {
                                                                      if (value
                                                                          .isEmpty) {
                                                                        return 'Invalid Step';
                                                                      }
                                                                      return null;
                                                                    },
                                                                  ),
                                                                  //
                                                                  TextFormField(
                                                                    decoration: InputDecoration(
                                                                        labelText:
                                                                            'Step : 3',
                                                                        hintText:
                                                                            'Enter Step - 3'),
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .text,
                                                                    controller:
                                                                        _editFiveController,
                                                                    validator:
                                                                        (value) {
                                                                      if (value
                                                                          .isEmpty) {
                                                                        return 'Invalid Step';
                                                                      }
                                                                      return null;
                                                                    },
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        20.0,
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      TextButton(
                                                                          child: Text(
                                                                              'Cancel',
                                                                              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                                                                          onPressed: () => Navigator.pop(context)),
                                                                      TextButton(
                                                                          child: Text(
                                                                              'Update',
                                                                              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                                                                          onPressed: () async {
                                                                            snapshot.data.docs[index].reference.update({
                                                                              'title': _editTitleController.text.capitalizeFirstOfEach,
                                                                              'one': _editOneController.text.inCaps,
                                                                              'two': _editTwoController.text.inCaps,
                                                                              'three': _editThreeController.text.inCaps,
                                                                              'four': _editFourController.text.inCaps,
                                                                              'five': _editFiveController.text.inCaps,
                                                                            });
                                                                            Navigator.pop(context);
                                                                          })
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ));
                                                });
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                          },
                                          child: Text('Edit',
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold)),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          elevation: 8.0,
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
