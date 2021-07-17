import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:self_care/constrains.dart';
import 'package:self_care/medic_alert/database/reminder_repository.dart';
import 'package:self_care/medic_alert/models/calendar_day_model.dart';
import 'package:self_care/medic_alert/models/pill.dart';
import 'package:self_care/medic_alert/notifications/notifications.dart';
import 'package:self_care/medic_alert/screens/add_new_medicine/add_new_medicine.dart';
import 'package:self_care/medic_alert/screens/reminder_home/calendar.dart';
import 'package:self_care/medic_alert/screens/reminder_home/medicines_list.dart';

class ReminderHome extends StatefulWidget {
  @override
  _ReminderHomeState createState() => _ReminderHomeState();
}

class _ReminderHomeState extends State<ReminderHome> {
  //-------------------| Flutter notifications |-------------------
  final Notifications _notifications = Notifications();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  //===============================================================

  //--------------------| List of Pills from database |----------------------
  List<Pill> allListOfPills = <Pill>[];
  final ReminderRepository _repository = ReminderRepository();
  List<Pill> dailyPills = <Pill>[];

  //=========================================================================

  //-----------------| Calendar days |------------------
  final CalendarDayModel _days = CalendarDayModel();
  List<CalendarDayModel> _daysList;

  //====================================================

  //handle last choose day index in calendar
  int _lastChooseDay = 0;

  @override
  void initState() {
    super.initState();
    initNotifies();
    setData();
    _daysList = _days.getCurrentDays();
  }

  //init notifications
  Future initNotifies() async => flutterLocalNotificationsPlugin =
      await _notifications.initNotifies(context);

  //--------------------GET ALL DATA FROM DATABASE---------------------
  Future setData() async {
    allListOfPills.clear();
    (await _repository.getAllData("Pills")).forEach((pillMap) {
      allListOfPills.add(Pill().pillMapToObject(pillMap));
    });
    chooseDay(_daysList[_lastChooseDay]);
  }

  //===================================================================

  @override
  Widget build(BuildContext context) {
    final double deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    final Widget addButton = FloatingActionButton(
      elevation: 2.0,
      onPressed: () async {
        //refresh the pills from database
        await Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddNewMedicine()))
            .then((_) => setData());
      },
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 32.0,
      ),
      backgroundColor: backgroundColor,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Medicine Alert',
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
      floatingActionButton: addButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  height: deviceHeight * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Calendar(
                        chooseDay,
                        _daysList,
                      ),
                      ShakeAnimatedWidget(
                        enabled: true,
                        duration: Duration(milliseconds: 2000),
                        curve: Curves.linear,
                        shakeAngle: Rotation.deg(z: 30),
                        child: Icon(
                          Icons.notifications_none,
                          size: 42.0,
                          color: backgroundColor,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: deviceHeight * 0.01,
                ),
                dailyPills.isEmpty
                    ? Center(
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          height: 70.0,
                          // ignore: deprecated_member_use
                          child: WavyAnimatedTextKit(
                            textAlign: TextAlign.center,
                            textStyle: TextStyle(
                                fontSize: 32.0,
                                fontWeight: FontWeight.bold,
                                color: backgroundColor),
                            text: ["Loading..."],
                            isRepeatingAnimation: true,
                            speed: Duration(milliseconds: 150),
                          ),
                        ),
                      )
                    : MedicinesList(
                        dailyPills, setData, flutterLocalNotificationsPlugin)
              ],
            ),
          ),
        ),
      ),
    );
  }

  //-------------------------| Click on the calendar day |-------------------------

  void chooseDay(CalendarDayModel clickedDay) {
    setState(() {
      _lastChooseDay = _daysList.indexOf(clickedDay);
      _daysList.forEach((day) => day.isChecked = false);
      CalendarDayModel chooseDay = _daysList[_daysList.indexOf(clickedDay)];
      chooseDay.isChecked = true;
      dailyPills.clear();
      allListOfPills.forEach((pill) {
        DateTime pillDate =
            DateTime.fromMicrosecondsSinceEpoch(pill.time * 1000);
        if (chooseDay.dayNumber == pillDate.day &&
            chooseDay.month == pillDate.month &&
            chooseDay.year == pillDate.year) {
          dailyPills.add(pill);
        }
      });
      dailyPills.sort((pill1, pill2) => pill1.time.compareTo(pill2.time));
    });
  }

//===============================================================================

}
