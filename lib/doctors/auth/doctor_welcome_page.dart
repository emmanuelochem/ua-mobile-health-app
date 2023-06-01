import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';
import 'package:ua_mobile_health/core/ui/typography_style.dart';
import 'package:ua_mobile_health/doctors_routes.dart';
import 'package:ua_mobile_health/students_routes.dart';
import 'package:ua_mobile_health/widgets/action_button.dart';

class DoctorWelcomePage extends StatelessWidget {
  const DoctorWelcomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.white,
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              SizedBox(
                height: 1.sh,
                width: 1.sw,
                child: CustomPaint(
                  painter: pathPainter(),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(50),
                margin: const EdgeInsets.only(top: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "On-Campus\n Medical Consultation",
                      textAlign: TextAlign.center,
                      style: TypographyStyle.heading4.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      height: 0.015.sh,
                    ),
                    Text(
                      "Efficient health services for students",
                      textAlign: TextAlign.center,
                      style: TypographyStyle.bodyMediumn.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 0.3.sh,
                right: 0.10.sw,
                child: SizedBox(
                    width: 1.sw,
                    child: Center(
                      child: Image.asset(
                        'assets/images/brands/green_doctor.png',
                        fit: BoxFit.cover,
                        height: 0.4.sh,
                      ),
                    )),
              ),
              Positioned(
                  bottom: 0.1.sh,
                  right: 0,
                  left: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 0.058.sw),
                    child: Column(
                      children: [
                        ActionButton(
                          isLoading: false,
                          text: 'Sign In',
                          backgroundColor: UIColors.primary100,
                          textColor: UIColors.white,
                          shape: ButtonShape.capsule,
                          size: ButtonSizes.large,
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              DoctorsRoutes.login,
                            );
                          },
                        ),
                        SizedBox(height: 0.02.sh),
                        ActionButton(
                          isLoading: false,
                          text: 'Register (Student)',
                          backgroundColor: UIColors.primary500,
                          textColor: UIColors.primaryDarkest,
                          shape: ButtonShape.capsule,
                          size: ButtonSizes.large,
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              DoctorsRoutes.register,
                              arguments: <String, dynamic>{'isStudent': true},
                            );
                          },
                        ),
                        SizedBox(height: 0.02.sh),
                        ActionButton(
                          isLoading: false,
                          text: 'Register (Doctor)',
                          backgroundColor: UIColors.primary500,
                          textColor: UIColors.primaryDarkest,
                          shape: ButtonShape.capsule,
                          size: ButtonSizes.large,
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              DoctorsRoutes.register,
                              arguments: <String, dynamic>{'isStudent': false},
                            );
                          },
                        ),
                      ],
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }
}

class pathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = UIColors.primary.withOpacity(.1);
    paint.style = PaintingStyle.fill;
    var path = Path();
    path.moveTo(0, size.height * 0.4);
    path.quadraticBezierTo(size.width * 0.35, size.height * 0.40,
        size.width * 0.58, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.72, size.height * 0.8,
        size.width * 0.92, size.height * 0.8);
    path.quadraticBezierTo(
        size.width * 0.98, size.height * 0.8, size.width, size.height * 0.82);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
