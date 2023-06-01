import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';
import 'package:ua_mobile_health/core/ui/typography_style.dart';
import 'package:ua_mobile_health/doctors/appointments/appointment_api.dart';
import 'package:ua_mobile_health/doctors_routes.dart';
import 'package:ua_mobile_health/widgets/action_button.dart';
import 'package:ua_mobile_health/widgets/empty_data_notice.dart';

class DoctorManageAppointments extends StatefulWidget {
  const DoctorManageAppointments({Key key}) : super(key: key);

  @override
  State<DoctorManageAppointments> createState() => _ManageAppointmentsState();
}

//enum for appointment status
enum FilterStatus { upcoming, complete, cancel, pending }

class _ManageAppointmentsState extends State<DoctorManageAppointments>
    with TickerProviderStateMixin {
  TabController _controller;

  FilterStatus status = FilterStatus.upcoming; //initial status
  final Alignment _alignment = Alignment.centerLeft;
  List<dynamic> schedules = [];

  final List _tabNames = [
    'Upcoming',
    'Pending',
    'Completed',
    'Cancelled',
  ];

  //get appointments details
  bool isLoaded = false;

  Future<List> getAppointments() async {
    setState(() {
      isLoaded = false;
    });
    DoctorAppointmentApi appointmentApi = DoctorAppointmentApi();
    var res = await appointmentApi
        .getAppointment(
      context: context,
    )
        .then((value) {
      if (value != null) {
        setState(() {
          isLoaded = true;
          schedules = value['data'];
        });
        return value['data'];
      } else {
        return null;
      }
    });
    return res;
  }

  @override
  void initState() {
    getAppointments();
    super.initState();
    _controller = TabController(vsync: this, length: _tabNames.length);
  }

  int activeTab = 0;

  @override
  Widget build(BuildContext context) {
    List upcoming = [];
    List pending = [];
    List completed = [];
    List cancelled = [];
    for (var item in schedules) {
      if (item['status'] == 'upcoming') {
        upcoming.add(item);
      } else if (item['status'] == 'pending') {
        pending.add(item);
      } else if (item['status'] == 'completed') {
        completed.add(item);
      } else {
        cancelled.add(item);
      }
    }
    return DefaultTabController(
      length: _tabNames.length,
      initialIndex: activeTab,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: UIColors.primary,
          elevation: 0,
          centerTitle: false,
          bottom: TabBar(
            indicatorColor: Colors.white,
            // indicator: BoxDecoration(
            //     borderRadius: BorderRadius.circular(0), // Creates border
            //     color: Colors.white),
            tabs: List.generate(
              _tabNames.length,
              (index) => Tab(text: _tabNames[index]),
            ),
          ),
          title: Text(
            'Appointments',
            style: TypographyStyle.heading2
                .copyWith(color: Colors.white, fontSize: 23.sp),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 0.048.sw, vertical: 0.sh),
          child: !isLoaded
              ? SizedBox(
                  height: 0.7.sh,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: UIColors.primary,
                    ),
                  ),
                )
              : TabBarView(
                  children: [
                    AppointmentCard(appointments: upcoming),
                    AppointmentCard(appointments: pending),
                    AppointmentCard(appointments: completed),
                    AppointmentCard(appointments: cancelled),
                  ],
                ),
        ),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({
    Key key,
    @required this.appointments,
  }) : super(key: key);

  final List appointments;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: appointments.isEmpty
            ? EmptyDataNotice(
                icon: PhosphorIcons.prohibit,
                message:
                    "You do not have any ${appointments[0]['status']} appointments yet.",
              )
            : ListView.builder(
                padding: EdgeInsets.only(top: 0.020.sh),
                itemCount: appointments.length,
                itemBuilder: ((context, index) {
                  var schedule = appointments[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        DoctorsRoutes.appointmentDetails,
                        arguments: <String, dynamic>{
                          'appointmentId': schedule['_id']
                        },
                      );
                    },
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: UIColors.secondary500,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      margin: EdgeInsets.only(bottom: 0.020.sh),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: UIColors.secondary500,
                                  backgroundImage:
                                      NetworkImage("${schedule['photo']}"),
                                ),
                                SizedBox(
                                  width: 0.020.sw,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${schedule['doctor']['firstname']} ${schedule['doctor']['lastname']}',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 0.005.sh,
                                    ),
                                    Text(
                                      schedule['doctor']['specialization'],
                                      style: TextStyle(
                                        color: UIColors.secondary300,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 0.015.sh,
                            ),
                            ScheduleCard(
                              date: schedule['date'],
                              time: schedule['time'],
                            ),
                            SizedBox(
                              height: 0.015.sh,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                (schedule['status'] == 'upcoming' ||
                                        schedule['status'] == 'pending' ||
                                        schedule['status'] == 'cancelled')
                                    ? Expanded(
                                        child: ActionButton(
                                          isLoading: false,
                                          text:
                                              schedule['status'] == 'cancelled'
                                                  ? 'Cancelled'
                                                  : 'Cancel',
                                          backgroundColor: UIColors.primary500,
                                          textColor: UIColors.primary100,
                                          iconColor: UIColors.primary100,
                                          shape: ButtonShape.capsule,
                                          size: ButtonSizes.xxxxxm,
                                          onPressed:
                                              schedule['status'] == 'cancelled'
                                                  ? null
                                                  : () async {},
                                        ),
                                      )
                                    : const SizedBox(),
                                (schedule['status'] == 'upcoming')
                                    ? SizedBox(
                                        width: 0.040.sw,
                                      )
                                    : const SizedBox(),
                                (schedule['status'] == 'upcoming' ||
                                        schedule['status'] == 'completed')
                                    ? Expanded(
                                        child: ActionButton(
                                          isLoading: false,
                                          text:
                                              schedule['status'] == 'completed'
                                                  ? 'Completed'
                                                  : 'Complete',
                                          backgroundColor: UIColors.secondary,
                                          textColor: UIColors.white,
                                          shape: ButtonShape.capsule,
                                          size: ButtonSizes.xxxxxm,
                                          onPressed:
                                              schedule['status'] == 'completed'
                                                  ? null
                                                  : () async {},
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ));
  }
}

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({
    Key key,
    @required this.date,
    @required this.time,
  }) : super(key: key);
  final String date;
  final String time;

  @override
  Widget build(BuildContext context) {
    DateFormat formatDate = DateFormat('yMMMMd');
    return Container(
      decoration: BoxDecoration(
        color: UIColors.secondary600,
        borderRadius: BorderRadius.circular(30.r),
      ),
      padding: const EdgeInsets.all(13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.calendar_today,
            color: UIColors.secondary200,
            size: 15,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            formatDate.format(DateTime.parse(date)),
            style: TextStyle(
              color: UIColors.secondary200,
            ),
          ),
          const Spacer(),
          Icon(
            Icons.access_alarm,
            color: UIColors.secondary200,
            size: 17,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            time,
            style: TextStyle(
              color: UIColors.secondary200,
            ),
          )
        ],
      ),
    );
  }
}
