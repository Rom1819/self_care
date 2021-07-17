import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:self_care/constrains.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:self_care/models/string_extension.dart';

class FeedbackHome extends StatefulWidget {
  @override
  _FeedbackHomeState createState() => _FeedbackHomeState();
}

class _FeedbackHomeState extends State<FeedbackHome> {
  final GlobalKey<FormState> _feedbackFormKey = GlobalKey();
  var _feedbackController = TextEditingController();

  bool uploading = false;
  double val = 0;

  CollectionReference feedbackRef;

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

  Future sendFeedback() async {
    if (!_feedbackFormKey.currentState.validate()) {
      return;
    }
    _feedbackFormKey.currentState.save();

    try {
      var result = feedbackRef.add({
        'user': _feedbackController.text.inCaps,
      });
      if (result != null) {
        var msg = 'Message sent successfully!';
        print('$result : $msg');
        SnackBar(
          padding: EdgeInsets.all(defaultPadding),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultPadding)),
          content: Text(
            msg,
            style: TextStyle(color: backgroundColor),
          ),
          backgroundColor: Colors.white60,
          duration: Duration(seconds: 3),
        );
      }
    } catch (error) {
      var errorMessage = 'Authentication Failed. Please Try Again.';
      _showErrorDialog(errorMessage);
    }
  }

  @override
  void initState() {
    super.initState();
    feedbackRef = FirebaseFirestore.instance.collection('feedbackList');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Feedback",
            style: TextStyle(
                fontSize: 24, color: textColor, fontWeight: FontWeight.bold)),
        iconTheme: IconThemeData(color: textColor),
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
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //  Feedback List
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(defaultPadding)),
                child: Container(
                  height: MediaQuery.of(context).size.height * (2 / 3),
                  color: Colors.white60,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('feedbackReplyList')
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
                                            color: backgroundColor,
                                            fontSize: 20),
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
                                  physics: BouncingScrollPhysics(),
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.all(defaultPadding / 2),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: Container(
                                          padding:
                                              EdgeInsets.all(defaultPadding),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'User :  ${(snapshot.data.docs[index].get('user'))}',
                                                  style: TextStyle(
                                                      color: textColor,
                                                      fontSize: 18.0),
                                                ),
                                                SizedBox(
                                                  height: 15.0,
                                                ),
                                                Text(
                                                  'Admin :  ${(snapshot.data.docs[index].get('admin'))}',
                                                  style: TextStyle(
                                                      color: textColor,
                                                      fontSize: 18.0),
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
                ),
              ),

              SizedBox(
                height: 10.0,
              ),

              //  Send Feedback Message
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(defaultPadding)),
                child: Container(
                  height: MediaQuery.of(context).size.height * (1 / 3),
                  color: Colors.white60,
                  child: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Stack(
                      children: [
                        Container(
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Form(
                                    key: _feedbackFormKey,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          labelText: 'Feedback Box',
                                          hintText:
                                              'Write your message in at least 5 letters',
                                          hintStyle:
                                              TextStyle(color: textColor),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      defaultPadding))),
                                      keyboardType: TextInputType.text,
                                      maxLines: 5,
                                      controller: _feedbackController,
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
                                  ),
                                ),

                                SizedBox(
                                  height: 15.0,
                                ),

                                // ignore: deprecated_member_use
                                RaisedButton(
                                  onPressed: () {
                                    sendFeedback();
                                    _feedbackController.clear();
                                  },
                                  child: Text('Send Feedback',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      )),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  elevation: 8.0,
                                  color: Colors.white,
                                  textColor: backgroundColor,
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
                                              color: backgroundColor,
                                              fontSize: 20),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                backgroundColor),
                                      )
                                    ],
                                  ),
                                ),
                              ))
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
