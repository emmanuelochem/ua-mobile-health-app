import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ua_mobile_health/features/ai/ai_home.dart';
import 'package:ua_mobile_health/core/providers/doctor_data_provider.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';
import 'package:ua_mobile_health/core/ui/typography_style.dart';
import 'package:ua_mobile_health/widgets/consultanst_profile_card.dart';
import 'package:ua_mobile_health/widgets/empty_data_notice.dart';
import 'package:ua_mobile_health/widgets/home_appointment_card.dart';
import 'package:ua_mobile_health/widgets/patients_profile_card.dart';

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
      backgroundColor: UIColors.secondary600,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi, ${doctorDataProvider.profile['firstname']} 👋",
                          style: TypographyStyle.bodyMediumn.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Keep Healthy!",
                          style: TypographyStyle.bodyMediumn.copyWith(
                            fontSize: 27.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 0.050.sh,
                      width: 0.050.sh,
                      decoration: BoxDecoration(
                        // shape: BoxShape.circle,
                        borderRadius: BorderRadius.circular(15.r),
                        color: UIColors.white,
                        border: Border.all(
                          width: 0,
                          color: UIColors.white,
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                              NetworkImage(doctorDataProvider.profile['photo']),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 0.03.sh,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AIHomePage(
                          username: doctorDataProvider.profile['firstname'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 13),
                    decoration: BoxDecoration(
                        color: UIColors.secondary400.withOpacity(.3),
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
                            fontWeight: FontWeight.w500,
                          ),
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
                            "Today's Appointment",
                            style: TextStyle(
                                color: Colors.black87.withOpacity(0.8),
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600),
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
                              return HomeAppointmentCard(
                                appointment:
                                    doctorDataProvider.appointments[index],
                              );
                            }),
                      ),
                      SizedBox(
                        height: 0.03.sh,
                      ),
                      Text(
                        doctorDataProvider.profile['is_student']
                            ? "Consultants"
                            : "Patients",
                        style: TextStyle(
                            color: Colors.black87.withOpacity(0.8),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 0.01.sh,
                      ),
                      Column(
                        children: List.generate(
                          doctorDataProvider.appointments.length,
                          (index) => doctorDataProvider.profile['is_student']
                              ? ConsultantsProfileCard(
                                  appointment: doctorDataProvider
                                      .appointments[index]['doctor'])
                              : PatientsProfileCard(
                                  appointment: doctorDataProvider
                                      .appointments[index]['student']),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
