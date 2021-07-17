import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:self_care/constrains.dart';
import 'package:self_care/healthTips/health_tips_dashboard.dart';
import 'package:self_care/healthTips/models/constants.dart';
import 'package:self_care/healthTips/models/details_page_navigator.dart';

class HealthTips extends StatefulWidget {
  @override
  _HealthTipsState createState() => _HealthTipsState();
}

class _HealthTipsState extends State<HealthTips> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Health Tips',
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
                        builder: (context) =>
                            DetailsPageNavigator(constants: constant[index]))),
              )),
    );
  }
}
