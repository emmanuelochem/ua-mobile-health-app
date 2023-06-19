import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ua_mobile_health/core/ui/typography_style.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';
import 'package:ua_mobile_health/features/meeting/meeting_homescreen.dart';
import 'package:ua_mobile_health/routes.dart';

class HomeAppointmentCard extends StatelessWidget {
  final Map appointment;

  const HomeAppointmentCard({
    Key key,
    @required this.appointment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat formatDate = DateFormat('MMMMd');
    DateFormat format = DateFormat('y-MM-dd');
    var todayDate = format.format(DateTime.now());
    //todayDate = appointment['date'];
    // var otherDate = todayDate;
    // log(todayDate);
    // log(appointment['date']);
    return GestureDetector(
      onTap: () {
        if (todayDate != appointment['date']) {
          Navigator.pushNamed(
            context,
            Routes.appointmentDetails,
            arguments: <String, dynamic>{
              'appointmentId': appointment['_id'].toString()
            },
          );
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MeetingHomeScreen(),
              ));
        }
      },
      child: Container(
        width: 0.410.sw,
        margin: EdgeInsets.only(right: 0.038.sw),
        decoration: BoxDecoration(
          color: todayDate != appointment['date']
              ? UIColors.primary.withOpacity(.2)
              : UIColors.primary,
          borderRadius: BorderRadius.circular(24.r),
        ),
        padding: EdgeInsets.all(
          0.016.sh,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 0.055.sh,
                  width: 0.1.sw,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: UIColors.white,
                    border: Border.all(
                      width: 3,
                      color: UIColors.white,
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(appointment['student']['photo']),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      appointment['time'],
                      style: TypographyStyle.bodySmall.copyWith(
                          color: todayDate != appointment['date']
                              ? UIColors.secondary100
                              : UIColors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w800),
                    ),
                    Text(
                      formatDate.format(DateTime.parse(appointment['date'])),
                      style: TypographyStyle.bodySmall.copyWith(
                          color: todayDate != appointment['date']
                              ? UIColors.secondary100
                              : UIColors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Text(
              "${appointment['student']['firstname']} ${appointment['student']['lastname']}",
              style: TypographyStyle.bodyMediumn.copyWith(
                  color: todayDate != appointment['date']
                      ? UIColors.secondary100
                      : UIColors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 0.02.sh,
            ),
            GestureDetector(
              onTap: () {
                if (todayDate != appointment['date']) {
                  Navigator.pushNamed(
                    context,
                    Routes.appointmentDetails,
                    arguments: <String, dynamic>{
                      'appointmentId': appointment['_id'].toString()
                    },
                  );
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MeetingHomeScreen(),
                      ));
                }
              },
              child: Container(
                width: 1.sw,
                // height: 0.03.sh,
                padding: EdgeInsets.symmetric(
                    vertical: 0.008.sh, horizontal: 0.004.sh),
                decoration: BoxDecoration(
                    color: todayDate != appointment['date']
                        ? const Color.fromARGB(255, 142, 182, 159)
                        : UIColors.white,
                    borderRadius: BorderRadius.circular(10.r)),
                child: Text(
                  todayDate != appointment['date']
                      ? 'View Info'
                      : 'Join The Call',
                  textAlign: TextAlign.center,
                  style: TypographyStyle.bodySmall.copyWith(
                      color: UIColors.secondary100,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
