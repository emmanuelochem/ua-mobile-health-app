import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';
import 'package:ua_mobile_health/routes.dart';
import 'package:ua_mobile_health/widgets/action_button.dart';

class DoctorWelcomePage extends StatelessWidget {
  const DoctorWelcomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final random = Random();
    var i = random.nextInt([1, 2, 3, 4, 5, 6].length);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/brands/wbg$i.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // BackdropFilter(
          //   filter: ImageFilter.blur(
          //     sigmaX: 1,
          //     sigmaY: 0,
          //   ),
          // child:
          Container(
            // color: Colors.black.withOpacity(0.75),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(29, 51, 149, 87),
                  Color.fromARGB(255, 0, 0, 0),
                ],
              ),
            ),
          ),
          // ),
          Container(
            padding:
                EdgeInsets.symmetric(vertical: 0.04.sh, horizontal: 0.07.sw),
            height: 1.sh,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Image.asset('assets/brand/tymsbook_w.png', width: 110),
                SizedBox(height: 0.15.sh),
                Column(
                  children: [
                    const Text(
                      "On-Campus Medical Consultation",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontFamily: 'Adieu',
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Efficient health services for students.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 0.045.sh),
                    ActionButton(
                      isLoading: false,
                      text: 'Login to account',
                      backgroundColor: UIColors.primary100,
                      textColor: UIColors.white,
                      shape: ButtonShape.squircle,
                      size: ButtonSizes.large,
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Routes.login,
                        );
                      },
                    ),
                    SizedBox(height: 0.01.sh),
                    ActionButton(
                      isLoading: false,
                      text: 'Create new account',
                      backgroundColor: UIColors.primary500,
                      textColor: UIColors.white,
                      shape: ButtonShape.squircle,
                      size: ButtonSizes.large,
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Routes.register,
                          arguments: <String, dynamic>{'isStudent': true},
                        );
                      },
                    ),
                    SizedBox(height: 0.07.sh),
                    // SizedBox(height: 0.01.sh),
                    // ActionButton(
                    //   isLoading: false,
                    //   text: 'Register (Doctor)',
                    //   backgroundColor: UIColors.primary500,
                    //   textColor: UIColors.primaryDarkest,
                    //   shape: ButtonShape.capsule,
                    //   size: ButtonSizes.large,
                    //   onPressed: () {
                    //     Navigator.pushNamed(
                    //       context,
                    //       Routes.register,
                    //       arguments: <String, dynamic>{'isStudent': false},
                    //     );
                    //   },
                    // ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
