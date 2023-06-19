// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ua_mobile_health/core/ui/typography_style.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';
import 'package:ua_mobile_health/features/consultants/patients_details.dart';

class PatientsProfileCard extends StatelessWidget {
  const PatientsProfileCard({
    Key key,
    this.appointment,
  }) : super(key: key);

  final Map appointment;

  @override
  Widget build(BuildContext context) {
    //log(appointment.toString());
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PatientsDetails(
                      doctor: appointment['_id'],
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
            color: UIColors.white, borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        margin: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: <Widget>[
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  color: UIColors.white,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage(appointment['photo']))),
            ),
            SizedBox(
              width: 0.040.sw,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${appointment['firstname']} ${appointment['lastname']}',
                              style: TypographyStyle.bodySmall.copyWith(
                                  color: UIColors.primary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp,
                                  height: 0),
                            ),
                          ),
                          // Icon(
                          //   appointment['likes']
                          //           .contains(doctorDataProvider.profile['_id'])
                          //       ? PhosphorIcons.heart_fill
                          //       : PhosphorIcons.heart,
                          //   size: 0.025.sh,
                          //   color: appointment['likes']
                          //           .contains(doctorDataProvider.profile['_id'])
                          //       ? Colors.red
                          //       : UIColors.primary,
                          // )
                        ],
                      ),
                      SizedBox(
                        height: 0.001.sh,
                      ),
                      Text(
                        '${appointment['department']}',
                        style: TypographyStyle.bodySmall.copyWith(
                          fontSize: 13.sp,
                          height: 0,
                          fontWeight: FontWeight.w500,
                          color: UIColors.secondary300,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 0.003.sh,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${appointment['matric_no']}',
                        style: TypographyStyle.bodySmall.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: UIColors.secondary300,
                        ),
                      ),
                      Text(
                        '${appointment['level']}00 Level',
                        style: TypographyStyle.bodySmall.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: UIColors.secondary300,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
