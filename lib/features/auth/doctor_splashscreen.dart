import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ua_mobile_health/core/logics/generalLogics.dart';
import 'package:ua_mobile_health/core/providers/doctor_data_provider.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';
import 'package:ua_mobile_health/features/auth/doctor_auth_api.dart';
import 'package:ua_mobile_health/routes.dart';

class DoctorSplashScreenPage extends StatefulWidget {
  const DoctorSplashScreenPage({Key key}) : super(key: key);

  @override
  State<DoctorSplashScreenPage> createState() => _DoctorSplashScreenPageState();
}

class _DoctorSplashScreenPageState extends State<DoctorSplashScreenPage> {
  bool isStarting = true;
  Future<void> pageLoaded(BuildContext context) async {
    Future.delayed(const Duration(seconds: 4), () async {
      handleDestination(context);
    });
  }

  handleDestination(context) async {
    var authToken = await GeneralLogics.getToken();
    DoctorDataProvider doctorDataProvider =
        Provider.of<DoctorDataProvider>(context, listen: false);
    if (authToken == null) {
      Navigator.pushReplacementNamed(
        context,
        Routes.welcome,
      );
    } else {
      UserAuthApi request = UserAuthApi();
      await request.getDoctorData(context: context).then((value) async {
        if (value != null) {
          GeneralLogics.setDoctorData(doctorDataProvider, value['userData']);
          if (context.mounted) {
            Navigator.pushReplacementNamed(
              context,
              Routes.home,
              arguments: <String, dynamic>{},
            );
          }
        } else {
          GeneralLogics.removeUserData();
          Navigator.pushReplacementNamed(
            context,
            Routes.welcome,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isStarting) {
      pageLoaded(context);
      isStarting = false;
    }
    return Scaffold(
      backgroundColor: UIColors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/brands/uniabuja_logo.png',
                width: 0.55.sw,
              ),
            ),
          )
        ],
      ),
    );
  }
}
