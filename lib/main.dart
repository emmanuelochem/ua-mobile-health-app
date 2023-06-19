import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ua_mobile_health/core/providers/doctor_data_provider.dart';
import 'package:ua_mobile_health/routes.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

// ...

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Widget doctorApp = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => DoctorDataProvider()),
    ],
    child: const DoctorAppMain(),
  );

//runApp(studentApp);
  runApp(doctorApp);
}

class DoctorAppMain extends StatelessWidget {
  const DoctorAppMain({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (ctx, _) {
          return MaterialApp(
            title: 'UA Mobile Health',
            theme: ThemeData(
                // primarySwatch: UIColors.primary,
                ),
            //home: const WelcomePage(),
            onGenerateRoute: Routes.generateRoute,
            initialRoute: Routes.splash,
            debugShowCheckedModeBanner: false,
          );
        });
  }
}
