import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:self_care/constrains.dart';

import 'package:self_care/models/string_extension.dart';

class AddEyeTips extends StatefulWidget {
  @override
  _AddEyeTipsState createState() => _AddEyeTipsState();
}

class _AddEyeTipsState extends State<AddEyeTips> {
  final GlobalKey<FormState> _eyeTipsFormKey = GlobalKey();
  var _oneController = TextEditingController();
  var _twoController = TextEditingController();
  var _threeController = TextEditingController();
  var _fourController = TextEditingController();
  var _fiveController = TextEditingController();
  var _sixController = TextEditingController();
  var _sevenController = TextEditingController();
  var _eightController = TextEditingController();
  var _nineController = TextEditingController();
  var _tenController = TextEditingController();

  bool uploading = false;
  double val = 5/9;

  CollectionReference tipsRef;

  _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('An Error Occurred!'),
              content: Text(msg),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text('OK')),
              ],
            ));
  }

  Future uploadFile() async {
    if (!_eyeTipsFormKey.currentState.validate()) {
      return;
    }
    _eyeTipsFormKey.currentState.save();

    try {
      var result = tipsRef.add({
        'one': _oneController.text.inCaps,
        'two': _twoController.text.inCaps,
        'three': _threeController.text.inCaps,
        'four': _fourController.text.inCaps,
        'five': _fiveController.text.inCaps,
        'six': _sixController.text.inCaps,
        'seven': _sevenController.text.inCaps,
        'eight': _eightController.text.inCaps,
        'nine': _nineController.text.inCaps,
        'ten': _tenController.text.inCaps,
      });
      if (result != null) {
        print('$result : Data stored successfully!');
      }
    } catch (error) {
      var errorMessage = 'Authentication Failed. Please Try Again.';
      _showErrorDialog(errorMessage);
    }
  }

  @override
  void initState() {
    super.initState();
    tipsRef = FirebaseFirestore.instance.collection('eyeTips');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Add Eye Care Tips',
          style: TextStyle(
              fontSize: 22, color: textColor, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: SvgPicture.asset(
            "assets/icons/back.svg",
            color: textColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  uploading = true;
                });
                uploadFile().whenComplete(() => Navigator.pop(context));
              },
              padding: EdgeInsets.only(right: 12.0),
              icon: Icon(
                Icons.cloud_upload_outlined,
                color: textColor,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: [
            Container(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(15.0),
                      child: Form(
                        key: _eyeTipsFormKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Tip : 1',
                                    hintText: 'Enter Tip - 1'),
                                keyboardType: TextInputType.text,
                                controller: _oneController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Invalid Tips';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Tip : 2',
                                    hintText: 'Enter Tip - 2'),
                                keyboardType: TextInputType.text,
                                controller: _twoController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Invalid Tips';
                                  }
                                  return null;
                                },
                              ),
                              // Confirm Password
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Tip : 3',
                                    hintText: 'Enter Tip - 3'),
                                keyboardType: TextInputType.text,
                                controller: _threeController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Invalid Tips';
                                  }
                                  return null;
                                },
                              ),
                              //
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Tip : 4',
                                    hintText: 'Enter Tip - 4'),
                                keyboardType: TextInputType.text,
                                controller: _fourController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Invalid Tips';
                                  }
                                  return null;
                                },
                              ),
                              //
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Tip : 5',
                                    hintText: 'Enter Tip - 5'),
                                keyboardType: TextInputType.text,
                                controller: _fiveController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Invalid Tips';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Tip : 6',
                                    hintText: 'Enter Tip - 6'),
                                keyboardType: TextInputType.text,
                                controller: _sixController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Invalid Tips';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Tip : 7',
                                    hintText: 'Enter Tip - 7'),
                                keyboardType: TextInputType.text,
                                controller: _sevenController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Invalid Tips';
                                  }
                                  return null;
                                },
                              ),
                              // Confirm Password
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Tip : 8',
                                    hintText: 'Enter Tip - 8'),
                                keyboardType: TextInputType.text,
                                controller: _eightController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Invalid Tips';
                                  }
                                  return null;
                                },
                              ),
                              //
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Tip : 9',
                                    hintText: 'Enter Tip - 9'),
                                keyboardType: TextInputType.text,
                                controller: _nineController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Invalid Tips';
                                  }
                                  return null;
                                },
                              ),
                              //
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Tip : 10',
                                    hintText: 'Enter Tip - 10'),
                                keyboardType: TextInputType.text,
                                controller: _tenController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Invalid Tips';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            uploading
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
                              'Uploading...',
                              style: TextStyle(
                                  color: backgroundColor, fontSize: 20),
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
                : Container(),
          ],
        ),
      ),
    );
  }
}
