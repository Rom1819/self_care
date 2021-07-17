import 'package:flutter/material.dart';
import 'package:self_care/bmi/bmi_calculator.dart';
import 'package:self_care/healthTips/health_tips.dart';
import 'package:self_care/man_workout/man_workout.dart';
import 'package:self_care/medic_alert/screens/reminder_home/reminder_home.dart';
import 'package:self_care/woman_workout/woman_workout.dart';
import 'package:self_care/nearby_hospitals/nearby_hospitals.dart';

import 'Properties.dart';

class Direct extends StatelessWidget {
  final Properties properties;

  const Direct({Key key, this.properties}) : super(key: key);

  Widget goto() {
    if (properties.id == 0) {
      return BMICalculator();
    } else if (properties.id == 1) {
      return ReminderHome();
    } else if (properties.id == 2) {
      return HealthTips();
    } else if (properties.id == 3) {
      return ManWorkout();
    } else if (properties.id == 4) {
      return WomanWorkout();
    } else {
      return NearestHospitals();
    }
  }

  @override
  Widget build(BuildContext context) {
    return goto();
  }
}
