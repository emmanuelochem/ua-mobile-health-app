// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:ua_mobile_health/core/providers/doctor_data_provider.dart';
import 'package:ua_mobile_health/core/ui/typography_style.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';
import 'package:ua_mobile_health/routes.dart';

class ConsultantsProfileCard extends StatelessWidget {
  const ConsultantsProfileCard({
    Key key,
    this.appointment,
  }) : super(key: key);

  final Map appointment;

  @override
  Widget build(BuildContext context) {
    DoctorDataProvider doctorDataProvider = context.read<DoctorDataProvider>();
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.docDetails,
          arguments: <String, dynamic>{'id': appointment['_id']},
        );
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => const AppointmentPage()));
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
                  image: const DecorationImage(
                      image: AssetImage("assets/images/brands/emmanuel.jpeg"))),
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
                          Icon(
                            appointment['likes']
                                    .contains(doctorDataProvider.profile['_id'])
                                ? PhosphorIcons.heart_fill
                                : PhosphorIcons.heart,
                            size: 0.025.sh,
                            color: appointment['likes']
                                    .contains(doctorDataProvider.profile['_id'])
                                ? Colors.red
                                : UIColors.primary,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 0.001.sh,
                      ),
                      Text(
                        appointment['specialization'].toString(),
                        style: TypographyStyle.bodySmall.copyWith(
                          fontSize: 13.sp,
                          height: 0,
                          fontWeight: FontWeight.w500,
                          color: UIColors.primary,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 0.013.sh,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 0.005.sw),
                              child: Icon(
                                PhosphorIcons.star_fill,
                                size: 0.014.sh,
                                color: Colors.amber,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 0.005.sw),
                              child: Icon(
                                PhosphorIcons.star_fill,
                                size: 0.014.sh,
                                color: Colors.amber,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 0.005.sw),
                              child: Icon(
                                PhosphorIcons.star_fill,
                                size: 0.014.sh,
                                color: Colors.amber,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 0.005.sw),
                              child: Icon(
                                PhosphorIcons.star_fill,
                                size: 0.014.sh,
                                color: Colors.amber,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 0.013.sw),
                              child: Icon(
                                PhosphorIcons.star_fill,
                                size: 0.014.sh,
                                color: Colors.amber,
                              ),
                            ),
                            Text(
                              '153 Reviews',
                              style: TypographyStyle.bodySmall.copyWith(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                color: UIColors.secondary300,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'NGN 100',
                        style: TypographyStyle.bodySmall.copyWith(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: UIColors.primary,
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
