import "package:flutter/material.dart";
import 'package:self_care/constrains.dart';
import '../../models/calendar_day_model.dart';

class CalendarDay extends StatefulWidget {
  final CalendarDayModel day;
  final Function onDayClick;

  CalendarDay(this.day, this.onDayClick);

  @override
  _CalendarDayState createState() => _CalendarDayState();
}

class _CalendarDayState extends State<CalendarDay> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.day.dayLetter,
            style: TextStyle(
                color: textColor, fontSize: 17.0, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: constrains.maxHeight * 0.1,
          ),
          GestureDetector(
            onTap: () => widget.onDayClick(widget.day),
            child: CircleAvatar(
              radius: constrains.maxHeight * 0.25,
              backgroundColor:
                  widget.day.isChecked ? backgroundColor : Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  widget.day.dayNumber.toString(),
                  style: TextStyle(
                      color: widget.day.isChecked ? Colors.white : textColor,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
