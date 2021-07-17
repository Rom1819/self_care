import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:self_care/nearby_hospitals/screens/init_permission_check.dart';

import 'Notifiers/location_notifier.dart';
import 'Notifiers/places_notifier.dart';

class NearestHospitals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LocationNotifier()),
        ChangeNotifierProvider(create: (context) => PlacesNotifier())
      ],
      child: Container(
        child: InitialPermissionCheck(),
      ),
    );
  }
}
