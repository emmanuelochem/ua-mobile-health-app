import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';
import 'package:ua_mobile_health/core/ui/typography_style.dart';
import 'package:ua_mobile_health/features/booking/appointment_api.dart';
import 'package:ua_mobile_health/routes.dart';
import 'package:ua_mobile_health/widgets/action_button.dart';
import 'package:ua_mobile_health/widgets/empty_data_notice.dart';

class ManageAppointments extends StatefulWidget {
  const ManageAppointments({Key key}) : super(key: key);

  @override
  State<ManageAppointments> createState() => _ManageAppointmentsState();
}

class _ManageAppointmentsState extends State<ManageAppointments>
    with TickerProviderStateMixin {
  TabController _controller;
  bool isLoaded = false;
  List<dynamic> appointments = [];
  Future<List> futureData;

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
          appointments = value['data'];
        });
        return value['data'];
      } else {
        return null;
      }
    });
    return res;
  }

  final List _tabNames = [
    'Upcoming',
    'Past',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(vsync: this, length: _tabNames.length);
    futureData = getAppointments();
  }

  int activeTab = 0;
  @override
  Widget build(BuildContext context) {
    // _tabNames = [
    //   'Upcoming',
    //   'Past',
    // ];
    List alldoctors = [];
    List favourite = [];

    for (var item in appointments) {
      if (item['status'] == 'upcoming') {
        alldoctors.add(item);
      } else {
        favourite.add(item);
      }
    }
    return DefaultTabController(
      length: _tabNames.length,
      initialIndex: activeTab,
      child: Scaffold(
        backgroundColor: UIColors.secondary600,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: UIColors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Appointments',
            style: TypographyStyle.heading5.copyWith(
              fontSize: 18.sp,
              color: UIColors.secondary,
            ),
          ),
          bottom: TabBar(
            controller: _controller,
            indicatorColor: UIColors.primary,
            labelColor: UIColors.primary,
            unselectedLabelColor: Colors.black54,
            tabs: List.generate(
              _tabNames.length,
              (index) => Tab(text: _tabNames[index]),
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding:
              EdgeInsets.symmetric(horizontal: 0.058.sw, vertical: 0.058.sw),
          child: FutureBuilder(
              future: futureData,
              builder: (context, querySnapshot) {
                if (querySnapshot.hasError) {
                  return const Text('Error occured');
                }
                if (querySnapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: 0.7.sh,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: UIColors.primary,
                      ),
                    ),
                  );
                } else {
                  List doctorsData = querySnapshot.data ?? [];
                  // print(list[0]['summary']);
                  return doctorsData.isEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            EmptyDataNotice(
                              icon: IconlyBold.user_3,
                              message: 'Doctors not available at the moment.',
                            ),
                          ],
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.only(top: 0.0.sh),
                          itemCount: appointments.length,
                          itemBuilder: ((context, index) {
                            var schedule = appointments[index];
                            return AppointmentCard(appointment: schedule);
                          }),
                        );
                }
              }),
        ),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({
    this.appointment,
    Key key,
  }) : super(key: key);

  final Map appointment;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.appointmentDetails,
          arguments: <String, dynamic>{'appointmentId': appointment['_id']},
        );
      },
      child: Container(
        decoration: BoxDecoration(
            color: UIColors.white, borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            Row(
              children: <Widget>[
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
                                  appointment['doctor']['firstname'] +
                                      ' ' +
                                      appointment['doctor']['lastname'],
                                  style: TypographyStyle.bodySmall.copyWith(
                                      color: UIColors.primary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp,
                                      height: 0),
                                ),
                              ),
                              // Icon(
                              //   PhosphorIcons.heart_fill,
                              //   size: 0.025.sh,
                              //   color: Colors.red,
                              // )
                            ],
                          ),
                          SizedBox(
                            height: 0.001.sh,
                          ),
                          Text(
                            appointment['doctor']['specialization'],
                            style: TypographyStyle.bodySmall.copyWith(
                              fontSize: 13.sp,
                              height: 0,
                              fontWeight: FontWeight.w500,
                              color: UIColors.secondary300,
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
                          // Text(
                          //   'NGN 100',
                          //   style: TypographyStyle.bodySmall
                          //       .copyWith(
                          //     fontSize: 15.sp,
                          //     fontWeight: FontWeight.w600,
                          //     color: UIColors.primary,
                          //   ),
                          // )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 0.040.sw,
                ),
                Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                      color: UIColors.white,
                      borderRadius: BorderRadius.circular(13),
                      image: const DecorationImage(
                          image: AssetImage(
                              "assets/images/brands/emmanuel.jpeg"))),
                ),
              ],
            ),
            SizedBox(
              height: 0.02.sh,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.019.sh),
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                width: 1,
                color: UIColors.secondary500,
              ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        PhosphorIcons.calendar,
                        size: 0.02.sh,
                        color: UIColors.secondary200.withOpacity(.8),
                      ),
                      SizedBox(width: 0.013.sw),
                      Text(
                        'Mon, Jan 22',
                        style: TypographyStyle.bodySmall.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: UIColors.secondary300,
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        PhosphorIcons.clock,
                        size: 0.02.sh,
                        color: UIColors.secondary200,
                      ),
                      SizedBox(width: 0.013.sw),
                      Text(
                        '10:30 AM',
                        style: TypographyStyle.bodySmall.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: UIColors.secondary300,
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: UIColors.primary,
                        ),
                      ),
                      SizedBox(width: 0.013.sw),
                      Text(
                        'Confirmed',
                        style: TypographyStyle.bodySmall.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: UIColors.secondary300,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),

            //

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ActionButton(
                    onPressed: () async {},
                    text: 'Cancel',
                    shape: ButtonShape.capsule,
                    size: ButtonSizes.xxxm,
                    backgroundColor: UIColors.secondary600,
                    textColor: UIColors.secondary100,
                    // iconColor: UIColors.neutralWhite,
                  ),
                ),
                SizedBox(width: 0.040.sw),
                Expanded(
                  child: ActionButton(
                    onPressed: () async {},
                    text: 'Reschedule',
                    shape: ButtonShape.capsule,
                    size: ButtonSizes.xxxm,
                    backgroundColor: UIColors.primary,
                    textColor: UIColors.white,
                    // iconColor: UIColors.neutralWhite,
                  ),
                ),
              ],
            ),
          ],
        ),

        //
      ),
    );
  }
}
