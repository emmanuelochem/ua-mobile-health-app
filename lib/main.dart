import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ua_mobile_health/core/providers/doctor_data_provider.dart';
import 'package:ua_mobile_health/doctors_main.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

// ...

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // Widget studentApp = MultiProvider(
  //   providers: [
  //     ChangeNotifierProvider(create: (_) => StudentDataProvider()),
  //   ],
  //   child: const StudentAppMain(),
  // );

  Widget doctorApp = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => DoctorDataProvider()),
    ],
    child: const DoctorAppMain(),
  );

//runApp(studentApp);
  runApp(doctorApp);
}
