import 'package:flutter/material.dart';
import 'package:self_care/models/Properties.dart';

import '../constrains.dart';

class Features extends StatelessWidget {
  final Properties properties;
  final Function press;

  const Features({
    Key key,
    this.properties,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(defaultPadding / 4),
              child: Image.asset(properties.image),
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding / 4),
            child: Text(
              properties.title,
              style: TextStyle(
                  color: textLightColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 11),
            ),
          )
        ],
      ),
    );
  }
}
