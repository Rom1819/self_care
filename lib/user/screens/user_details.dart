import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:self_care/user/models/user.dart';
import 'package:self_care/user/services/user_service.dart';
import 'package:self_care/models/string_extension.dart';

import '../../constrains.dart';

class UserDetails extends StatefulWidget {
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final GlobalKey<FormState> _editFormKey = GlobalKey();

  double height = 0;
  double weight = 0;
  String result = "";
  String category = "";

  var user;
  var _user = User();
  var _userService = UserService();

  // ignore: deprecated_member_use
  List<User> _userList = List<User>();

  void initState() {
    super.initState();
    getUsers();
  }

  getUsers() async {
    // ignore: deprecated_member_use
    _userList = List<User>();
    var users = await _userService.readUser();
    users.forEach((user) {
      setState(() {
        var userModel = User();
        userModel.id = user['id'];
        userModel.name = user['name'];
        userModel.age = user['age'];
        userModel.gender = user['gender'];
        userModel.weight = user['weight'];
        userModel.height = user['height'];
        userModel.bmi = user['bmi'];
        userModel.bmiSts = user['bmiSts'];

        _userList.add(userModel);
      });
    });
  }

  //  User modifying functions
  var _editNameController = TextEditingController();
  var _editAgeController = TextEditingController();
  var _editGenderController = TextEditingController();
  var _editWeightController = TextEditingController();
  var _editHeightController = TextEditingController();

  //  User modifying functions

  _editUserData(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: [
              TextButton(
                  child: Text('Cancel',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold)),
                  onPressed: () => Navigator.pop(context)),
              TextButton(
                  child: Text('Update',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold)),
                  onPressed: () async {
                    setState(() {
                      height = double.parse(_editHeightController.value.text);
                      weight = double.parse(_editWeightController.value.text);
                      calculateBMI(height, weight);
                    });
                    _update();
                  }),
            ],
            title: Text(
              'Edit User Information',
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
            ),
            content: Form(
              key: _editFormKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Name', hintText: 'Enter modifying name'),
                      keyboardType: TextInputType.name,
                      controller: _editNameController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Invalid Name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Age', hintText: 'Enter modifying age'),
                      keyboardType: TextInputType.number,
                      controller: _editAgeController,
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
                          hintText: 'Enter modifying gender'),
                      keyboardType: TextInputType.text,
                      controller: _editGenderController,
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
                          hintText: 'Enter modifying weight in KG'),
                      keyboardType: TextInputType.number,
                      controller: _editWeightController,
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
                          hintText: 'Enter modifying height CM'),
                      keyboardType: TextInputType.number,
                      controller: _editHeightController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Invalid Height';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _editUser(BuildContext context, userId) async {
    user = await _userService.readUserById(userId);
    setState(() {
      _editNameController.text = user[0]['name'] ?? 'No Name';
      _editAgeController.text = (user[0]['age']).toString() ?? 'No Age';
      _editGenderController.text =
          (user[0]['gender']).toString() ?? 'No Gender';
      _editWeightController.text =
          (user[0]['weight']).toString() ?? 'No Weight';
      _editHeightController.text =
          (user[0]['height']).toString() ?? 'No Height';
    });
    _editUserData(context);
  }

  //  Error alert
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

  //  Authentication
  Future<void> _update() async {
    if (!_editFormKey.currentState.validate()) {
      return;
    }
    _editFormKey.currentState.save();

    _user.id = user[0]['id'];
    _user.name = (_editNameController.text).capitalizeFirstOfEach;
    _user.age = int.parse(_editAgeController.value.text);
    _user.gender = (_editGenderController.text).capitalizeFirstOfEach;
    _user.weight = double.parse(_editWeightController.value.text);
    _user.height = double.parse(_editHeightController.value.text);
    _user.bmi = double.parse(result);
    _user.bmiSts = (category).capitalizeFirstOfEach;

    try {
      var result = await _userService.updateUser(_user);
      if (result > 0) {
        print('User updated successfully! : $result');
        Navigator.pop(context);
        getUsers();
      }
    } catch (error) {
      var errorMessage = 'Authentication Failed. Please Try Again.';
      _showErrorDialog(errorMessage);
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'User Info',
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
      body: Container(
        color: backgroundColor,
        child: ListView.builder(
            itemCount: _userList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(12.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Name :  ${_userList[index].name}',
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Age :  ${(_userList[index].age).toString()} years',
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Gender :  ${_userList[index].gender}',
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Weight :  ${(_userList[index].weight).toString()} KG',
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Height :  ${(_userList[index].height).toString()} CM',
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'BMI :  ${(_userList[index].bmi).toString()} ',
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'BMI Status :  ${_userList[index].bmiSts}',
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(),
                              // ignore: deprecated_member_use
                              RaisedButton(
                                onPressed: () {
                                  _editUser(context, _userList[index].id);
                                },
                                child: Text('Edit',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
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
      ),
    );
  }
}
