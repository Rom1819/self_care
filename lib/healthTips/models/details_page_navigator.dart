import 'package:flutter/material.dart';
import 'package:self_care/healthTips/details_screen/brain_tips_home.dart';
import 'package:self_care/healthTips/details_screen/eye_tips_home.dart';
import 'package:self_care/healthTips/details_screen/heart_tips_home.dart';
import 'package:self_care/healthTips/details_screen/kidney_tips_home.dart';
import 'package:self_care/healthTips/details_screen/liver_tips_home.dart';
import 'package:self_care/healthTips/details_screen/lung_tips_home.dart';
import 'package:self_care/healthTips/details_screen/teeth_tips_home.dart';
import 'package:self_care/healthTips/models/constants.dart';

class DetailsPageNavigator extends StatelessWidget {
  final Constants constants;

  const DetailsPageNavigator({Key key, this.constants}) : super(key: key);

  Widget goto() {
    if (constants.id == 0) {
      return BrainTipsHome();
    } else if (constants.id == 1) {
      return HeartTipsHome();
    } else if (constants.id == 2) {
      return KidneyTipsHome();
    } else if (constants.id == 3) {
      return LiverTipsHome();
    } else if (constants.id == 4) {
      return EyeTipsHome();
    } else if (constants.id == 5) {
      return LungTipsHome();
    } else {
      return TeethTipsHome();
    }
  }

  @override
  Widget build(BuildContext context) {
    return goto();
  }
}
