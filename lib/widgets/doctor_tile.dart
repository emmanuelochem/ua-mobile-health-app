import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ua_mobile_health/core/ui/typography_style.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';
import 'package:ua_mobile_health/doctors_routes.dart';

class DoctorTile extends StatelessWidget {
  const DoctorTile({Key key, @required this.doctor}) : super(key: key);
  final Map doctor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          DoctorsRoutes.docDetails,
          arguments: <String, dynamic>{'id': doctor['_id']},
        );
      },
      child: Container(
        decoration: BoxDecoration(
            color: UIColors.primary500,
            borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        margin: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: <Widget>[
            Image.asset(
              "assets/images/brands/green_doctor.png",
              height: 50,
            ),
            const SizedBox(
              width: 17,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${doctor['firstname']} ${doctor['lastname']}',
                  style: TypographyStyle.bodySmall.copyWith(
                    color: UIColors.primary,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),
                ),
                Text(
                  doctor['specialization'].toString(),
                  style: TypographyStyle.bodySmall.copyWith(
                    fontSize: 11.sp,
                    color: UIColors.primary,
                  ),
                )
              ],
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
              decoration: BoxDecoration(
                  color: UIColors.primary,
                  borderRadius: BorderRadius.circular(13)),
              child: const Text(
                "View",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
