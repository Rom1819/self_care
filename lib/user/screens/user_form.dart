import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:self_care/user/models/user.dart';
import 'package:self_care/user/screens/user_details.dart';
import 'package:self_care/user/services/user_service.dart';
import 'package:self_care/models/string_extension.dart';

import '../../constrains.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _nameController = TextEditingController();
  var _ageController = TextEditingController();
  var _genderController = TextEditingController();
  var _weightController = TextEditingController();
  var _heightController = TextEditingController();

  CollectionReference userRef;

  double height = 0;
  double weight = 0;
  String result = "";
  String category = "";

  var _user = User();
  var _userService = UserService();

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

  void calculateBMI(double height, double weight) {
    double finalResult = weight / pow((height / 100), 2);
    String bmi = finalResult.toStringAsFixed(2);
    setState(() {
      result = bmi;

      if (finalResult <= 16.0) {
        category = "Severely Underweight";
      } else if (finalResult >= 16.0 && finalResult < 18.5) {
        category = "Underweight";
      } else if (finalResult >= 18.5 && finalResult < 25.0) {
        category = "Normal";
      } else if (finalResult >= 25.0 && finalResult < 30.0) {
        category = "Overweight";
      } else if (finalResult >= 30.0 && finalResult < 35.0) {
        category = "Obese";
      } else if (finalResult >= 35.0 && finalResult < 40.0) {
        category = "Severely Obese";
      } else {
        category = "Extremely Obese";
      }
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    _user.name = (_nameController.text).capitalizeFirstOfEach;
    _user.age = int.parse(_ageController.value.text);
    _user.gender = (_genderController.text).capitalizeFirstOfEach;
    _user.weight = double.parse(_weightController.value.text);
    _user.height = double.parse(_heightController.value.text);
    _user.bmi = double.parse(result);
    _user.bmiSts = (category).capitalizeFirstOfEach;

    try {
      var result = await _userService.saveUser(_user);
      if (result > 0) {
        var firebaseResult = userRef.add({
          'name': (_nameController.text).capitalizeFirstOfEach,
          'age': int.parse(_ageController.value.text),
          'gender': (_genderController.text).capitalizeFirstOfEach,
        });
        if (firebaseResult != null) {
          print('$result : Data stored successfully!');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => UserDetails()));
        }
      }
    } catch (error) {
      var errorMessage = 'Authentication Failed. Please Try Again.';
      _showErrorDialog(errorMessage);
    }
  }

  @override
  void initState() {
    super.initState();
    userRef = FirebaseFirestore.instance.collection('userList');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'User Registration',
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
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: backgroundColor),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(15.0),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Name',
                                hintText: 'Enter Your Full Name'),
                            keyboardType: TextInputType.name,
                            controller: _nameController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Invalid Name';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Age', hintText: 'Enter Your Age'),
                            keyboardType: TextInputType.number,
                            controller: _ageController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Invalid Age';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Gender',
                                hintText: 'Enter Your Gender'),
                            keyboardType: TextInputType.text,
                            controller: _genderController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Invalid Gender';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Weight',
                                hintText: 'Enter Your Weight in KG'),
                            keyboardType: TextInputType.number,
                            controller: _weightController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Invalid Weight';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Height',
                                hintText: 'Enter Your Height in CM'),
                            keyboardType: TextInputType.number,
                            controller: _heightController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Invalid Height';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          // ignore: deprecated_member_use
                          RaisedButton(
                            child: Text(
                              'Submit',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onPressed: () async {
                              setState(() {
                                height =
                                    double.parse(_heightController.value.text);
                                weight =
                                    double.parse(_weightController.value.text);
                                calculateBMI(height, weight);
                              });
                              _submit();
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 8.0,
                            color: Colors.white,
                            textColor: textColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
