// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ua_mobile_health/students_routes.dart';

// class StudentAppMain extends StatelessWidget {
//   const StudentAppMain({Key key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     // ref.read(sessionCheckProvider(context));
//     return ScreenUtilInit(
//         designSize: const Size(428, 926),
//         minTextAdapt: true,
//         splitScreenMode: true,
//         builder: (ctx, _) {
//           return MaterialApp(
//             title: 'UA Mobile Health',
//             theme: ThemeData(
//               primarySwatch: Colors.blue,
//             ),
//             //home: const WelcomePage(),
//             onGenerateRoute: DoctorsRoutes.generateRoute,
//             initialRoute: DoctorsRoutes.splash,
//           );
//         });
//   }
// }
