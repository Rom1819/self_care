import 'package:flutter/material.dart';
import 'package:self_care/constrains.dart';

// ignore: must_be_immutable
class CustomListTile extends StatelessWidget {
  IconData icon;
  String title;
  Function onTap;

  CustomListTile(this.icon, this.title, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: textLightColor))),
        child: InkWell(
          splashColor: backgroundColor,
          onTap: onTap,
          child: Container(
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        title,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    )
                  ],
                ),
                Icon(Icons.arrow_right)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
