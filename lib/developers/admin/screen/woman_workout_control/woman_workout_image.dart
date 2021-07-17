import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:self_care/constrains.dart';

import 'package:self_care/models/string_extension.dart';

class WomanWorkoutImage extends StatefulWidget {
  @override
  _WomanWorkoutImageState createState() => _WomanWorkoutImageState();
}

class _WomanWorkoutImageState extends State<WomanWorkoutImage> {
  final GlobalKey<FormState> _womanWorkoutImageFormKey = GlobalKey();
  var _titleController = TextEditingController();
  var _oneController = TextEditingController();
  var _twoController = TextEditingController();
  var _threeController = TextEditingController();
  var _fourController = TextEditingController();
  var _fiveController = TextEditingController();

  bool uploading = false;
  double val = 1/2;

  CollectionReference imgRef;
  firebase_storage.Reference ref;

  List<File> _image = [];
  final picker = ImagePicker();

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

  chooseImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedFile?.path));
    });
    if (pickedFile.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image.add(File(response.file.path));
      });
    } else {
      print(response.file);
    }
  }

  Future uploadFile() async {
    if (!_womanWorkoutImageFormKey.currentState.validate()) {
      return;
    }
    _womanWorkoutImageFormKey.currentState.save();

    try {
      ref = firebase_storage.FirebaseStorage.instance.ref().child(
          'womanworkout/${Path.basename(_image[_image.length - 1].path)}');
      var result =
          await ref.putFile(_image[_image.length - 1]).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          imgRef.add({
            'url': value,
            'title': _titleController.text.capitalizeFirstOfEach,
            'one': _oneController.text.inCaps,
            'two': _twoController.text.inCaps,
            'three': _threeController.text.inCaps,
            'four': _fourController.text.inCaps,
            'five': _fiveController.text.inCaps,
          });
        });
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
    imgRef = FirebaseFirestore.instance.collection('womanWorkoutImage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Woman Workout Image',
          style: TextStyle(
              fontSize: 21, color: textColor, fontWeight: FontWeight.bold),
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
                    _image.isEmpty
                        ? Container(
                            margin: EdgeInsets.all(3.0),
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                                color: backgroundColor,
                                borderRadius: BorderRadius.circular(12.0)),
                            child: Center(
                              child: IconButton(
                                  icon:
                                      Icon(Icons.add_photo_alternate_outlined),
                                  color: Colors.white,
                                  iconSize: 48.0,
                                  onPressed: () {
                                    // ignore: unnecessary_statements
                                    !uploading ? chooseImage() : null;
                                  }),
                            ),
                          )
                        : Stack(
                            children: [
                              Container(
                                height: 180,
                                decoration: BoxDecoration(
                                    color: backgroundColor,
                                    borderRadius: BorderRadius.circular(12.0),
                                    image: DecorationImage(
                                        image: FileImage(
                                            _image[_image.length - 1]),
                                        fit: BoxFit.cover)),
                              ),
                              Positioned(
                                right: 0.0,
                                bottom: 0.0,
                                child: new FloatingActionButton(
                                  child:
                                      Icon(Icons.add_photo_alternate_outlined),
                                  onPressed: () {
                                    // ignore: unnecessary_statements
                                    !uploading ? chooseImage() : null;
                                  },
                                ),
                              ),
                            ],
                          ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(15.0),
                      child: Form(
                        key: _womanWorkoutImageFormKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Title : ',
                                    hintText: 'Enter the Title'),
                                keyboardType: TextInputType.text,
                                controller: _titleController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Invalid Step';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Impact : 1',
                                    hintText: 'Enter impact - 1'),
                                keyboardType: TextInputType.text,
                                controller: _oneController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Invalid Step';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Impact : 2',
                                    hintText: 'Enter impact - 2'),
                                keyboardType: TextInputType.text,
                                controller: _twoController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Invalid Step';
                                  }
                                  return null;
                                },
                              ),
                              // Confirm Password
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Step : 1',
                                    hintText: 'Enter Step - 1'),
                                keyboardType: TextInputType.text,
                                controller: _threeController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Invalid Step';
                                  }
                                  return null;
                                },
                              ),
                              //
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Step : 2',
                                    hintText: 'Enter Step - 2'),
                                keyboardType: TextInputType.text,
                                controller: _fourController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Invalid Step';
                                  }
                                  return null;
                                },
                              ),
                              //
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Step : 3',
                                    hintText: 'Enter Step - 3'),
                                keyboardType: TextInputType.text,
                                controller: _fiveController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Invalid Step';
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
                                fontSize: 20,
                                color: backgroundColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CircularProgressIndicator(
                            value: val,
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
