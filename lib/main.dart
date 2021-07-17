import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:self_care/developers/admin/screen/admin_panel.dart';
import 'package:self_care/developers/developers.dart';

import 'package:self_care/screen/home_screen.dart';
import 'constrains.dart';
import 'developers/admin/models/authentication.dart';
import 'developers/admin/screen/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _firebaseApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
        ChangeNotifierProvider.value(
        value: Authentication()),
    ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Self Care',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(bodyColor: textColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: _firebaseApp,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            print('You have an error! ${snapshot.error.toString()}');
            return Text('Something went wrong!');
          } else if (snapshot.hasData) {
            print('Firebase integration successful!');
            return HomeScreen();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      routes: {
        LoginScreen.routeName: (ctx) => LoginScreen(),
        AdminPanel.routeName : (ctx) => AdminPanel(),
        HomeScreen.routeName : (ctx) => HomeScreen(),
        Developers.routeName : (ctx) => Developers(),
      },
    ),
    );
  }
}
