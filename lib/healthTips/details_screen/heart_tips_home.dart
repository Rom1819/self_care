import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:self_care/constrains.dart';

class HeartTipsHome extends StatefulWidget {
  @override
  _HeartTipsHomeState createState() => _HeartTipsHomeState();
}

class _HeartTipsHomeState extends State<HeartTipsHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Heart Care Tips',
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
        stream: FirebaseFirestore.instance.collection('heartTips').snapshots(),
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
                                            'assets/images/heart.png'),
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
                                          color: textColor, fontSize: 18.0),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Text(
                                      'Tip - 2 :  ${(snapshot.data.docs[index].get('two'))}',
                                      style: TextStyle(
                                          color: textColor, fontSize: 18.0),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Text(
                                      'Tip - 3 :  ${(snapshot.data.docs[index].get('three'))}',
                                      style: TextStyle(
                                          color: textColor, fontSize: 18.0),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Text(
                                      'Tip - 4 :  ${(snapshot.data.docs[index].get('four'))}',
                                      style: TextStyle(
                                          color: textColor, fontSize: 18.0),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Text(
                                      'Tip - 5 :  ${(snapshot.data.docs[index].get('five'))}',
                                      style: TextStyle(
                                          color: textColor, fontSize: 18.0),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Text(
                                      'Tip - 6 :  ${(snapshot.data.docs[index].get('six'))}',
                                      style: TextStyle(
                                          color: textColor, fontSize: 18.0),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Text(
                                      'Tip - 7 :  ${(snapshot.data.docs[index].get('seven'))}',
                                      style: TextStyle(
                                          color: textColor, fontSize: 18.0),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Text(
                                      'Tip - 8 :  ${(snapshot.data.docs[index].get('eight'))}',
                                      style: TextStyle(
                                          color: textColor, fontSize: 18.0),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Text(
                                      'Tip - 9 :  ${(snapshot.data.docs[index].get('nine'))}',
                                      style: TextStyle(
                                          color: textColor, fontSize: 18.0),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Text(
                                      'Tip - 10 :  ${(snapshot.data.docs[index].get('ten'))}',
                                      style: TextStyle(
                                          color: textColor, fontSize: 18.0),
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
