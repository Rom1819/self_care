import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:self_care/constrains.dart';
import 'package:self_care/medic_alert/database/reminder_repository.dart';
import 'package:self_care/medic_alert/helpers/snack_bar.dart';
import 'package:self_care/medic_alert/models/medicine_type.dart';
import 'package:self_care/medic_alert/models/pill.dart';
import 'package:self_care/medic_alert/notifications/notifications.dart';
import '../../helpers/platform_flat_button.dart';
import '../../screens/add_new_medicine/form_fields.dart';
import '../../screens/add_new_medicine/medicine_type_card.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:self_care/models/string_extension.dart';

class AddNewMedicine extends StatefulWidget {
  @override
  _AddNewMedicineState createState() => _AddNewMedicineState();
}

class _AddNewMedicineState extends State<AddNewMedicine> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final Snackbar snackbar = Snackbar();

  //medicine types
  final List<String> weightValues = ["pills", "ml", "mg"];

  //list of medicines forms objects
  final List<MedicineType> medicineTypes = [
    MedicineType("Syrup", Image.asset("assets/images/syrup.png"), true),
    MedicineType("Tablet", Image.asset("assets/images/pills.png"), false),
    MedicineType("Capsule", Image.asset("assets/images/capsule.png"), false),
    MedicineType("Cream", Image.asset("assets/images/cream.png"), false),
    MedicineType("Drops", Image.asset("assets/images/drops.png"), false),
    MedicineType("Syringe", Image.asset("assets/images/syringe.png"), false),
  ];

  //-------------Pill object------------------
  int howManyWeeks = 1;
  String selectWeight;
  DateTime setDate = DateTime.now();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  //==========================================

  //-------------- Database and notifications ------------------
  final ReminderRepository _repository = ReminderRepository();
  final Notifications _notifications = Notifications();

  //============================================================

  @override
  void initState() {
    super.initState();
    selectWeight = weightValues[0];
    initNotifies();
  }

  //init notifications
  Future initNotifies() async => flutterLocalNotificationsPlugin =
      await _notifications.initNotifies(context);

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height - 60.0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Add Medic Reminder',
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
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: deviceHeight * 0.37,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: FormFields(
                          howManyWeeks,
                          selectWeight,
                          popUpMenuItemChanged,
                          sliderChanged,
                          nameController,
                          amountController)),
                ),
                Container(
                  height: deviceHeight * 0.035,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: FittedBox(
                      child: Text(
                        "Medicine Form",
                        style: TextStyle(
                            color: textColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                Container(
                  height: 100,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      ...medicineTypes.map(
                          (type) => MedicineTypeCard(type, medicineTypeClick))
                    ],
                  ),
                ),
                SizedBox(
                  height: deviceHeight * 0.03,
                ),
                Container(
                  width: double.infinity,
                  height: deviceHeight * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: double.infinity,
                          child: PlatformFlatButton(
                            handler: () => openTimePicker(),
                            buttonChild: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 10),
                                Text(
                                  DateFormat.Hm().format(this.setDate),
                                  style: TextStyle(
                                      fontSize: 24.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(width: 5),
                                Icon(
                                  Icons.access_time,
                                  size: 30,
                                  color: textLightColor,
                                )
                              ],
                            ),
                            color: backgroundColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Container(
                          height: double.infinity,
                          child: PlatformFlatButton(
                            handler: () => openDatePicker(),
                            buttonChild: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 10),
                                Text(
                                  DateFormat("dd.MM").format(this.setDate),
                                  style: TextStyle(
                                      fontSize: 24.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.event,
                                  size: 30,
                                  color: textLightColor,
                                )
                              ],
                            ),
                            color: backgroundColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  height: deviceHeight * 0.09,
                  width: double.infinity,
                  child: PlatformFlatButton(
                    handler: () async => savePill(),
                    color: backgroundColor,
                    buttonChild: Text(
                      "Done",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 22.0),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //slider changer
  void sliderChanged(double value) =>
      setState(() => this.howManyWeeks = value.round());

  //choose popup menu item
  void popUpMenuItemChanged(String value) =>
      setState(() => this.selectWeight = value);

  //------------------------OPEN TIME PICKER (SHOW)----------------------------
  //------------------------CHANGE CHOOSE PILL TIME----------------------------

  Future<void> openTimePicker() async {
    await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
            helpText: "Choose Time")
        .then((value) {
      DateTime newDate = DateTime(
          setDate.year,
          setDate.month,
          setDate.day,
          value != null ? value.hour : setDate.hour,
          value != null ? value.minute : setDate.minute);
      setState(() => setDate = newDate);
      print(newDate.hour);
      print(newDate.minute);
    });
  }

  //====================================================================

  //-------------------------SHOW DATE PICKER AND CHANGE CURRENT CHOOSE DATE-------------------------------
  Future<void> openDatePicker() async {
    await showDatePicker(
            context: context,
            initialDate: setDate,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 100000)))
        .then((value) {
      DateTime newDate = DateTime(
          value != null ? value.year : setDate.year,
          value != null ? value.month : setDate.month,
          value != null ? value.day : setDate.day,
          setDate.hour,
          setDate.minute);
      setState(() => setDate = newDate);
      print(setDate.day);
      print(setDate.month);
      print(setDate.year);
    });
  }

  //=======================================================================================================

  //--------------------------------------SAVE PILL IN DATABASE---------------------------------------
  Future savePill() async {
    //check if medicine time is lower than actual time
    if (setDate.millisecondsSinceEpoch <=
        DateTime.now().millisecondsSinceEpoch) {
      snackbar.showSnack(
          "Check your medicine time and date", _scaffoldKey, null);
    } else {
      //create pill object
      Pill pill = Pill(
          amount: amountController.text,
          howManyWeeks: howManyWeeks,
          medicineForm: medicineTypes[medicineTypes
                  .indexWhere((element) => element.isChoose == true)]
              .name,
          name: nameController.text.capitalizeFirstOfEach,
          time: setDate.millisecondsSinceEpoch,
          type: selectWeight,
          notifyId: Random().nextInt(10000000));

      //---------------------| Save as many medicines as many user checks |----------------------
      for (int i = 0; i < howManyWeeks * 7; i++) {
        dynamic result =
            await _repository.insertData("Pills", pill.pillToMap());
        if (result == null) {
          snackbar.showSnack("Something went wrong", _scaffoldKey, null);
          return;
        } else {
          //set the notification schedule
          tz.initializeTimeZones();
          //tz.setLocalLocation(tz.getLocation('Asia'));
          await _notifications.showNotification(
              pill.name,
              pill.amount + " " + pill.medicineForm + " " + pill.type,
              time,
              pill.notifyId,
              flutterLocalNotificationsPlugin);
          setDate = setDate.add(Duration(milliseconds: 604800000));
          pill.time = setDate.millisecondsSinceEpoch;
          pill.notifyId = Random().nextInt(10000000);
        }
      }
      //---------------------------------------------------------------------------------------
      snackbar.showSnack("Saved", _scaffoldKey, null);
      Navigator.pop(context);
    }
  }

  //=================================================================================================

  //----------------------------CLICK ON MEDICINE FORM CONTAINER----------------------------------------
  void medicineTypeClick(MedicineType medicine) {
    setState(() {
      medicineTypes.forEach((medicineType) => medicineType.isChoose = false);
      medicineTypes[medicineTypes.indexOf(medicine)].isChoose = true;
    });
  }

  //=====================================================================================================

  //get time difference
  int get time =>
      setDate.millisecondsSinceEpoch -
      tz.TZDateTime.now(tz.local).millisecondsSinceEpoch;
}
