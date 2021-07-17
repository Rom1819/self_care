import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:self_care/constrains.dart';

import 'package:self_care/models/string_extension.dart';

class UserFeedback extends StatefulWidget {
  @override
  _UserFeedbackState createState() => _UserFeedbackState();
}

class _UserFeedbackState extends State<UserFeedback> {
  final GlobalKey<FormState> _feedbackReplyFormKey = GlobalKey();

  //  User modifying functions
  var _userFeedbackController = TextEditingController();
  var _adminReplyController = TextEditingController();

  bool uploading = false;
  double val = 0;

  CollectionReference replyRef;

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

  //  User modifying functions

  _adminReply(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: Text(
              'Reply to Users',
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
            ),
            content: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Container(
                padding: EdgeInsets.all(12.0),
                child: Form(
                  key: _feedbackReplyFormKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          decoration:
                              InputDecoration(labelText: 'User Feedback'),
                          keyboardType: TextInputType.text,
                          maxLines: 5,
                          readOnly: true,
                          controller: _userFeedbackController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Feedback is Empty!';
                            }
                            if (value.length < 5) {
                              return 'Invalid Feedback!';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Reply Box',
                              hintText:
                                  'Write your reply in more than 4 characters!',
                              hintStyle: TextStyle(color: textColor),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(defaultPadding))),
                          keyboardType: TextInputType.text,
                          maxLines: 3,
                          controller: _adminReplyController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Write something first...';
                            }
                            if (value.length < 5) {
                              return 'Write at least in 5 letters...';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                child: Text('Cancel',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold)),
                                onPressed: () => Navigator.pop(context)),
                            TextButton(
                                child: Text('Send Reply',
                                    style: TextStyle(
                                        color: backgroundColor,
                                        fontWeight: FontWeight.bold)),
                                onPressed: () async {
                                  sendReply();
                                })
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Future sendReply() async {
    if (!_feedbackReplyFormKey.currentState.validate()) {
      return;
    }
    _feedbackReplyFormKey.currentState.save();

    try {
      var result = replyRef.add({
        'user': _userFeedbackController.text.inCaps,
        'admin': _adminReplyController.text.inCaps,
      });
      if (result != null) {
        var msg = 'Feedback Reply Successful!';
        print('$result : $msg');
        Navigator.of(context).pop();

      }
    } catch (error) {
      var errorMessage = 'Authentication Failed. Please Try Again.';
      _showErrorDialog(errorMessage);
    }
  }

  @override
  void initState() {
    super.initState();
    replyRef = FirebaseFirestore.instance.collection('feedbackReplyList');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'User Feedback Control',
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
        stream:
            FirebaseFirestore.instance.collection('feedbackList').snapshots(),
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
                                    Text(
                                      'User :  ${(snapshot.data.docs[index].get('user'))}',
                                      style: TextStyle(
                                          color: textColor,
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
                                          textColor: textColor,
                                        ),
                                        // ignore: deprecated_member_use
                                        RaisedButton(
                                          onPressed: () {
                                            _adminReply(context);
                                            _userFeedbackController.text =
                                                snapshot.data.docs[index]
                                                    .get('user');
                                            snapshot.data.docs[index].reference.delete();
                                          },
                                          child: Text('Reply',
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
