import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:self_care/constrains.dart';
import 'package:self_care/developers/admin/screen/health_tips/health_tips_navigator.dart';
import 'package:self_care/healthTips/health_tips_dashboard.dart';
import 'package:self_care/healthTips/models/constants.dart';

class HealthTipsControl extends StatefulWidget {
  @override
  _HealthTipsControlState createState() => _HealthTipsControlState();
}

class _HealthTipsControlState extends State<HealthTipsControl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Health Tips Control',
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
      body: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: constant.length,
          itemBuilder: (context, index) => HealthTipsDashboard(
                constants: constant[index],
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HealthTipsNavigator(
                              constants: constant[index],
                            ))),
              )),
    );
  }
}
