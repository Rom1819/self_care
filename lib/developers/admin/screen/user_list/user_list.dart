import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:self_care/constrains.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'User List',
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
        stream: FirebaseFirestore.instance.collection('userList').snapshots(),
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2 +
                                              15,
                                          child: Text(
                                            'Name',
                                            style: TextStyle(
                                                color: backgroundColor,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4 -
                                              30,
                                          child: Text(
                                            'Age',
                                            style: TextStyle(
                                                color: backgroundColor,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4 -
                                              20,
                                          child: Text(
                                            'Gender',
                                            style: TextStyle(
                                                color: backgroundColor,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width /
                                              2 +
                                              15,
                                          child: Text(
                                            '${(snapshot.data.docs[index].get('name'))}',
                                            style: TextStyle(
                                                color: textColor, fontSize: 18.0),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width /
                                              4 - 30,
                                          child: Text(
                                            '${(snapshot.data.docs[index].get('age'))}',
                                            style: TextStyle(
                                                color: textColor, fontSize: 18.0),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width /
                                              4 - 20,
                                          child: Text(
                                            '${(snapshot.data.docs[index].get('gender'))}',
                                            style: TextStyle(
                                                color: textColor, fontSize: 18.0),
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.0,
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
