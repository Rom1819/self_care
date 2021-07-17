import 'package:flutter/material.dart';
import 'package:self_care/user/models/user.dart';
import 'package:self_care/user/screens/user_details.dart';
import 'package:self_care/user/screens/user_form.dart';
import 'package:self_care/user/services/user_service.dart';

class Navigate extends StatefulWidget {
  @override
  _NavigateState createState() => _NavigateState();
}

class _NavigateState extends State<Navigate> {
  var _userService = UserService();

  List<User> _userList = <User>[];

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

        _userList.add(userModel);
      });
    });
  }

  Widget goto() {
    int i = _userList.length;
    print('Number of users : $i');
    if (i > 0) {
      return UserDetails();
    } else
      return UserForm();
  }

  @override
  Widget build(BuildContext context) {
    return goto();
  }
}
