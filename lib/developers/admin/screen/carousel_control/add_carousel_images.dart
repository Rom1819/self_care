import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:self_care/constrains.dart';

class AddCarouselImages extends StatefulWidget {
  @override
  _AddCarouselImagesState createState() => _AddCarouselImagesState();
}

class _AddCarouselImagesState extends State<AddCarouselImages> {
  bool uploading = false;
  double val = 0;

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
    int i = 1;
    var result;

    try {
      for (var img in _image) {
        setState(() {
          val = i / _image.length;
        });

        ref = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('carousel/${Path.basename(img.path)}');
        result = await ref.putFile(img).whenComplete(() async {
          await ref.getDownloadURL().then((value) {
            imgRef.add({
              'url': value,
            });
          });
        });
      }
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
    imgRef = FirebaseFirestore.instance.collection('carouselImage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Carousel Image',
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
              color: textColor,
              padding: EdgeInsets.only(right: defaultPadding),
              icon: Icon(Icons.cloud_upload_outlined)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Stack(
          children: [
            Center(
              child: Container(
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: _image.length + 1,
                    itemBuilder: (context, index) {
                      return index == 0
                          ? Container(
                              margin: EdgeInsets.all(3.0),
                              height: 180,
                              decoration: BoxDecoration(
                                  color: backgroundColor,
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: Center(
                                child: IconButton(
                                    icon: Icon(
                                        Icons.add_photo_alternate_outlined),
                                    color: Colors.white,
                                    iconSize: 52.0,
                                    onPressed: () {
                                      // ignore: unnecessary_statements
                                      !uploading ? chooseImage() : null;
                                    }),
                              ),
                            )
                          : Container(
                              height: 180,
                              margin: EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                  color: backgroundColor,
                                  borderRadius: BorderRadius.circular(12.0),
                                  image: DecorationImage(
                                      image: FileImage(_image[index - 1]),
                                      fit: BoxFit.cover)),
                            );
                    }),
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
