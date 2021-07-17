import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:self_care/constrains.dart';
import 'package:self_care/developers/admin/screen/login_screen.dart';

class Developers extends StatelessWidget {
  static const routeName = '/dev';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Developers',
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            padding: EdgeInsets.all(12.0),
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Material(
                      borderRadius: BorderRadius.circular(50.0),
                      elevation: 8.0,
                      child: Padding(
                        padding: EdgeInsets.all(0),
                        child: Image.asset(
                          'assets/icons/dev.jpg',
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'Name : Ruman Mahamud',
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: textLightColor)))),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'ID : 192138',
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: textLightColor)))),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'Batch : MIT 21st',
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: textLightColor)))),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'Supervised By : Dr. Shafiul Alam Khan \nProfessor & Director, IIT, DU.',
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: textLightColor)))),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'About : This application was submitted to Institute of Information Technology, University of Dhaka as an MIT final project.',
                          style: TextStyle(color: textColor, fontSize: 18.0),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: textLightColor)))),
                  SizedBox(
                    height: 30.0,
                  ),
                  InkWell(
                    onLongPress: () {
                      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Center(
                            child: Text(
                              '©All the rights are reserved!',
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 18.0),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: textLightColor)))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
