import 'package:flutter/material.dart';
import 'package:self_care/constrains.dart';
import 'package:self_care/healthTips/models/constants.dart';

class HealthTipsDashboard extends StatelessWidget {
  final Constants constants;
  final Function onTap;

  const HealthTipsDashboard({Key key, this.constants, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            height: 100,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withAlpha(100), blurRadius: 1.0),
                ]),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        constants.name,
                        style: const TextStyle(
                            fontSize: 20,
                            color: textColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        constants.tag,
                        style: const TextStyle(
                            fontSize: 14, color: textLightColor),
                      )
                    ],
                  ),
                  Image.asset(
                    constants.image,
                    height: double.infinity,
                  )
                ],
              ),
            )));
  }
}
