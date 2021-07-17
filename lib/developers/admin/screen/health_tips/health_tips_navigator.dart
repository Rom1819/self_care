import 'package:flutter/material.dart';
import 'package:self_care/developers/admin/screen/health_tips/contents/brain/brain_tips_control.dart';
import 'package:self_care/developers/admin/screen/health_tips/contents/eye/eye_tips_control.dart';
import 'package:self_care/developers/admin/screen/health_tips/contents/heart/heart_tips_control.dart';
import 'package:self_care/developers/admin/screen/health_tips/contents/kidney/kidney_tips_control.dart';
import 'package:self_care/developers/admin/screen/health_tips/contents/liver/liver_tips_control.dart';
import 'package:self_care/developers/admin/screen/health_tips/contents/lung/lung_tips_control.dart';
import 'package:self_care/developers/admin/screen/health_tips/contents/teeth/teeth_tips_control.dart';
import 'package:self_care/healthTips/models/constants.dart';

class HealthTipsNavigator extends StatelessWidget {
  final Constants constants;

  const HealthTipsNavigator({Key key, this.constants}) : super(key: key);

  Widget goto() {
    if (constants.id == 0) {
      return BrainTipsControl();
    } else if (constants.id == 1) {
      return HeartTipsControl();
    } else if (constants.id == 2) {
      return KidneyTipsControl();
    } else if (constants.id == 3) {
      return LiverTipsControl();
    } else if (constants.id == 4) {
      return EyeTipsControl();
    } else if (constants.id == 5) {
      return LungTipsControl();
    } else {
      return TeethTipsControl();
    }
  }

  @override
  Widget build(BuildContext context) {
    return goto();
  }
}
