import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ua_mobile_health/ai/ai_home.dart';
import 'package:ua_mobile_health/core/providers/doctor_data_provider.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';
import 'package:ua_mobile_health/core/ui/typography_style.dart';
import 'package:ua_mobile_health/doctors_routes.dart';
import 'package:ua_mobile_health/meeting/meeting_homescreen.dart';
import 'package:ua_mobile_health/widgets/empty_data_notice.dart';

class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({Key key}) : super(key: key);

  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends State<DoctorHomePage> {
  DoctorDataProvider doctorDataProvider;
  @override
  void initState() {
    super.initState();
    doctorDataProvider = context.read<DoctorDataProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: UIColors.white,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Good morning, \n${doctorDataProvider.profile['firstname']}",
                style: TypographyStyle.bodyMediumn.copyWith(
                  fontSize: 27.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 0.03.sh,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AIHomePage(),
                    ),
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
                  decoration: BoxDecoration(
                      color: UIColors.secondary500,
                      borderRadius: BorderRadius.circular(14)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        PhosphorIcons.magnifying_glass,
                        color: UIColors.secondary300,
                        size: 0.025.sh,
                      ),
                      SizedBox(
                        width: 0.030.sw,
                      ),
                      Text(
                        "Ask our health A.I a question",
                        style: TypographyStyle.bodyMediumn.copyWith(
                            color: UIColors.secondary300,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 0.04.sh,
              ),
              Visibility(
                visible: doctorDataProvider.appointments.length > 0,
                replacement: const EmptyDataNotice(
                    icon: PhosphorIcons.calendar_blank,
                    message: 'You do not have an appointment yet'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Upcoming consultations",
                          style: TypographyStyle.bodyMediumn.copyWith(
                              fontSize: 15.sp, fontWeight: FontWeight.w700),
                        ),
                        const Icon(
                          PhosphorIcons.arrow_right,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 0.02.sh,
                    ),
                    SizedBox(
                      height: 0.253.sh,
                      child: ListView.builder(
                          itemCount: doctorDataProvider.appointments.length,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return SpecialistTile(
                              appointment:
                                  doctorDataProvider.appointments[index],
                            );
                          }),
                    ),
                    SizedBox(
                      height: 0.03.sh,
                    ),
                    Text(
                      "Categories",
                      style: TextStyle(
                          color: Colors.black87.withOpacity(0.8),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 0.01.sh,
                    ),
                    Column(
                      children: List.generate(
                        doctorDataProvider.appointments.length,
                        (index) => AppointmentTile(
                            appointment:
                                doctorDataProvider.appointments[index]),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SpecialistTile extends StatelessWidget {
  final Map appointment;

  const SpecialistTile({
    Key key,
    @required this.appointment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat formatDate = DateFormat('MMMMd');
    DateFormat format = DateFormat('y-MM-d');
    var todayDate = format.format(DateTime.now());
    todayDate = appointment['date'];
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          DoctorsRoutes.appointmentDetails,
          arguments: <String, dynamic>{
            'appointmentId': appointment['_id'].toString()
          },
        );
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MeetingHomeScreen(),
                    ));
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
                  'Join The Call',
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

class AppointmentTile extends StatelessWidget {
  const AppointmentTile({Key key, @required this.appointment})
      : super(key: key);
  final Map appointment;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => const AppointmentPage()));
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
              "assets/images/brands/user_avatar.png",
              height: 50,
            ),
            const SizedBox(
              width: 17,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${appointment['doctor']['firstname']} ${appointment['doctor']['lastname']}',
                  style: TypographyStyle.bodySmall.copyWith(
                    color: UIColors.primary,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),
                ),
                Text(
                  appointment['doctor']['specialization'].toString(),
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
