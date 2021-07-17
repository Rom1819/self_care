import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:self_care/constrains.dart';
import 'package:self_care/developers/admin/screen/health_tips/contents/lung/add_lung_tips.dart';

import 'package:self_care/models/string_extension.dart';

class LungTipsControl extends StatefulWidget {
  @override
  _LungTipsControlState createState() => _LungTipsControlState();
}

class _LungTipsControlState extends State<LungTipsControl> {
  final GlobalKey<FormState> _editLungTipsFormKey = GlobalKey();

  //  User modifying functions
  var _editOneController = TextEditingController();
  var _editTwoController = TextEditingController();
  var _editThreeController = TextEditingController();
  var _editFourController = TextEditingController();
  var _editFiveController = TextEditingController();
  var _editSixController = TextEditingController();
  var _editSevenController = TextEditingController();
  var _editEightController = TextEditingController();
  var _editNineController = TextEditingController();
  var _editTenController = TextEditingController();

  //  User modifying functions

  _editLungTips(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
              title: Text(
                'Edit Lung Care Tips',
                style: TextStyle(
                    color: Colors.blueGrey, fontWeight: FontWeight.bold),
              ),
              content: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('lungTips')
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
                        : Container(
                            child: ListView.builder(
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(12.0),
                                      child: Form(
                                        key: _editLungTipsFormKey,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              TextFormField(
                                                decoration: InputDecoration(
                                                  labelText: 'Tip : 1',
                                                ),
                                                keyboardType:
                                                    TextInputType.text,
                                                controller: _editOneController,
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'Invalid Tip';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              // Password
                                              TextFormField(
                                                decoration: InputDecoration(
                                                  labelText: 'Tip : 2',
                                                ),
                                                keyboardType:
                                                    TextInputType.text,
                                                controller: _editTwoController,
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'Invalid Tip';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              // Confirm Password
                                              TextFormField(
                                                decoration: InputDecoration(
                                                  labelText: 'Tip : 3',
                                                ),
                                                keyboardType:
                                                    TextInputType.text,
                                                controller:
                                                    _editThreeController,
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'Invalid Tip';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              //
                                              TextFormField(
                                                decoration: InputDecoration(
                                                  labelText: 'Tip : 4',
                                                ),
                                                keyboardType:
                                                    TextInputType.text,
                                                controller: _editFourController,
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'Invalid Tip';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              //
                                              TextFormField(
                                                decoration: InputDecoration(
                                                  labelText: 'Tip : 5',
                                                ),
                                                keyboardType:
                                                    TextInputType.text,
                                                controller: _editFiveController,
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'Invalid Tip';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              TextFormField(
                                                decoration: InputDecoration(
                                                  labelText: 'Tip : 6',
                                                ),
                                                keyboardType:
                                                    TextInputType.text,
                                                controller: _editSixController,
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'Invalid Tip';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              // Password
                                              TextFormField(
                                                decoration: InputDecoration(
                                                  labelText: 'Tip : 7',
                                                ),
                                                keyboardType:
                                                    TextInputType.text,
                                                controller:
                                                    _editSevenController,
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'Invalid Tip';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              // Confirm Password
                                              TextFormField(
                                                decoration: InputDecoration(
                                                  labelText: 'Tip : 8',
                                                ),
                                                keyboardType:
                                                    TextInputType.text,
                                                controller:
                                                    _editEightController,
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'Invalid Tip';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              //
                                              TextFormField(
                                                decoration: InputDecoration(
                                                  labelText: 'Tip : 9',
                                                ),
                                                keyboardType:
                                                    TextInputType.text,
                                                controller: _editNineController,
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'Invalid Tip';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              //
                                              TextFormField(
                                                decoration: InputDecoration(
                                                  labelText: 'Tip : 10',
                                                ),
                                                keyboardType:
                                                    TextInputType.text,
                                                controller: _editTenController,
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'Invalid Tip';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              SizedBox(
                                                height: 20.0,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  TextButton(
                                                      child: Text('Cancel',
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context)),
                                                  TextButton(
                                                      child: Text('Update',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      onPressed: () async {
                                                        snapshot
                                                            .data
                                                            .docs[index]
                                                            .reference
                                                            .update({
                                                          'one':
                                                              _editOneController
                                                                  .text.inCaps,
                                                          'two':
                                                              _editTwoController
                                                                  .text.inCaps,
                                                          'three':
                                                              _editThreeController
                                                                  .text.inCaps,
                                                          'four':
                                                              _editFourController
                                                                  .text.inCaps,
                                                          'five':
                                                              _editFiveController
                                                                  .text.inCaps,
                                                          'six':
                                                              _editSixController
                                                                  .text.inCaps,
                                                          'seven':
                                                              _editSevenController
                                                                  .text.inCaps,
                                                          'eight':
                                                              _editEightController
                                                                  .text.inCaps,
                                                          'nine':
                                                              _editNineController
                                                                  .text.inCaps,
                                                          'ten':
                                                              _editTenController
                                                                  .text.inCaps,
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
                                  );
                                }),
                          );
                  }));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Lung Care Tips Control',
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
        child: Icon(
          Icons.health_and_safety_outlined,
          size: 36,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddLungTips()));
        },
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('lungTips').snapshots(),
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
                              padding: EdgeInsets.all(defaultPadding),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Center(
                                      child: Container(
                                        child: Image.asset(
                                            'assets/images/lung.png'),
                                        height: 150,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          color: textColor,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Text(
                                      'Tip - 1 :  ${(snapshot.data.docs[index].get('one'))}',
                                      style: TextStyle(
                                          color: textColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Text(
                                      'Tip - 2 :  ${(snapshot.data.docs[index].get('two'))}',
                                      style: TextStyle(
                                          color: textColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Text(
                                      'Tip - 3 :  ${(snapshot.data.docs[index].get('three'))}',
                                      style: TextStyle(
                                          color: textColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Text(
                                      'Tip - 4 :  ${(snapshot.data.docs[index].get('four'))}',
                                      style: TextStyle(
                                          color: textColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Text(
                                      'Tip - 5 :  ${(snapshot.data.docs[index].get('five'))}',
                                      style: TextStyle(
                                          color: textColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Text(
                                      'Tip - 6 :  ${(snapshot.data.docs[index].get('six'))}',
                                      style: TextStyle(
                                          color: textColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Text(
                                      'Tip - 7 :  ${(snapshot.data.docs[index].get('seven'))}',
                                      style: TextStyle(
                                          color: textColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Text(
                                      'Tip - 8 :  ${(snapshot.data.docs[index].get('eight'))}',
                                      style: TextStyle(
                                          color: textColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Text(
                                      'Tip - 9 :  ${(snapshot.data.docs[index].get('nine'))}',
                                      style: TextStyle(
                                          color: textColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Text(
                                      'Tip - 10 :  ${(snapshot.data.docs[index].get('ten'))}',
                                      style: TextStyle(
                                          color: textColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
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
                                          textColor: textColor,
                                        ),
                                        // ignore: deprecated_member_use
                                        RaisedButton(
                                          onPressed: () {
                                            _editLungTips(context);
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
                                            _editSixController.text = snapshot
                                                .data.docs[index]
                                                .get('six');
                                            _editSevenController.text = snapshot
                                                .data.docs[index]
                                                .get('seven');
                                            _editEightController.text = snapshot
                                                .data.docs[index]
                                                .get('eight');
                                            _editNineController.text = snapshot
                                                .data.docs[index]
                                                .get('nine');
                                            _editTenController.text = snapshot
                                                .data.docs[index]
                                                .get('ten');
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
                                          textColor: textColor,
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
