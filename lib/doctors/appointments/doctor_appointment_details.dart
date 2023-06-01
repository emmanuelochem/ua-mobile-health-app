import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';
import 'package:ua_mobile_health/core/ui/typography_style.dart';
import 'package:ua_mobile_health/doctors/appointments/appointment_api.dart';
import 'package:ua_mobile_health/doctors/appointments/booking_successful.dart';
import 'package:ua_mobile_health/doctors_routes.dart';
import 'package:ua_mobile_health/widgets/action_button.dart';
import 'package:ua_mobile_health/widgets/custom_appbar.dart';
import 'package:ua_mobile_health/widgets/empty_data_notice.dart';

class DoctorAppointentDetails extends StatefulWidget {
  const DoctorAppointentDetails({Key key, @required this.appointmentId})
      : super(key: key);
  final String appointmentId;

  @override
  _AppointentDetailsState createState() => _AppointentDetailsState();
}

class _AppointentDetailsState extends State<DoctorAppointentDetails> {
  bool _isLoading = false;
  bool isLoaded = false;
  Map appointmentMapData;
  Future<Map> getAppointment() async {
    setState(() {
      isLoaded = false;
    });
    DoctorAppointmentApi appointmentApi = DoctorAppointmentApi();
    var res = await appointmentApi
        .getAppointmentById(
            context: context, appointmentId: widget.appointmentId)
        .then((value) {
      if (value != null) {
        setState(() {
          isLoaded = true;
          appointmentMapData = value['data'];
        });
        return value['data'];
      } else {
        return null;
      }
    });
    return res;
  }

  Future<Map> futureData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureData = getAppointment();
  }

  @override
  Widget build(BuildContext context) {
    DateFormat formatDate = DateFormat('yMMMMd');
    return Scaffold(
      backgroundColor: UIColors.white,
      appBar: const CustomAppBar(
        appTitle: 'Appointment details6',
        icon: Icon(Icons.arrow_back_ios),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 0.058.sw, vertical: 0.10.sw),
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
                Map appointmentData = querySnapshot.data ?? {};
                // print(list[0]['summary']);
                return appointmentData.isEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          EmptyDataNotice(
                            icon: IconlyLight.close_square,
                            message:
                                'Appointment Information not available at the moment.',
                          ),
                        ],
                      )
                    : Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Doctor Information",
                                  style: TypographyStyle.heading5.copyWith(),
                                ),
                                SizedBox(
                                  height: 0.02.sh,
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: 0.17.sh,
                                      width: 0.17.sh,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          image: const DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/brands/emmanuel.jpeg"))),
                                    ),
                                    SizedBox(
                                      width: 0.06.sw,
                                    ),
                                    SizedBox(
                                      //height: 220,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            '${appointmentData['doctor']['firstname']} ${appointmentData['doctor']['lastname']}',
                                            style: TypographyStyle.heading5
                                                .copyWith(
                                              color: UIColors.secondary200,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 0.005.sh,
                                          ),
                                          Text(
                                            "${appointmentData['doctor']['email']}",
                                            style: TypographyStyle.bodySmall
                                                .copyWith(
                                              color: UIColors.secondary200,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 0.005.sh,
                                          ),
                                          Text(
                                            "${appointmentData['doctor']['specialization']}",
                                            style: TypographyStyle.bodySmall
                                                .copyWith(
                                              color: UIColors.secondary200,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 0.005.sh,
                                          ),
                                          Text(
                                            "${appointmentData['doctor']['qualification']}",
                                            style: TypographyStyle.bodySmall
                                                .copyWith(
                                              color: UIColors.secondary200,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 0.01.sh,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              IconTile(
                                                backColor: UIColors.primary
                                                    .withOpacity(.2),
                                                icon: IconlyBold.message,
                                              ),
                                              IconTile(
                                                backColor: UIColors.primary
                                                    .withOpacity(.2),
                                                icon: IconlyBold.call,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 0.02.sh,
                                ),
                                SizedBox(
                                  height: 0.015.sh,
                                ),
                                Text(
                                  "${appointmentData['doctor']['biography']}",
                                  style: TypographyStyle.bodyMediumn.copyWith(
                                    color: UIColors.secondary200,
                                  ),
                                ),
                                SizedBox(
                                  height: 0.02.sh,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 26,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Appointment Information",
                                  style: TypographyStyle.heading5.copyWith(),
                                ),
                                SizedBox(
                                  height: 0.02.sh,
                                ),
                                DoctorInfoBlock(
                                  title: 'Schedule for',
                                  desc: formatDate.format(
                                      DateTime.parse(appointmentData['date'])),
                                  icon: PhosphorIcons.calendar,
                                ),
                                DoctorInfoBlock(
                                  title: 'Time',
                                  desc: '${appointmentData['time']}',
                                  icon: PhosphorIcons.timer,
                                ),
                                DoctorInfoBlock(
                                  title: 'Status',
                                  desc: '${appointmentData['status']}',
                                  icon: PhosphorIcons.check,
                                ),
                                DoctorInfoBlock(
                                  title: 'Health Note',
                                  desc: '${appointmentData['note']}',
                                  icon: PhosphorIcons.book,
                                ),
                                DoctorInfoBlock(
                                  title: 'Booked On',
                                  desc: formatDate.format(DateTime.parse(
                                      appointmentData['createdAt'])),
                                  icon: PhosphorIcons.clock,
                                ),
                                SizedBox(
                                  height: 0.1.sh,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
              }
            }),
      ),
      bottomSheet: !isLoaded
          ? const SizedBox()
          : Container(
              height: 0.093.sh,
              decoration: BoxDecoration(
                  color: UIColors.white,
                  border: Border(
                    top: BorderSide(color: UIColors.secondary500),
                  )),
              padding: EdgeInsets.symmetric(
                  horizontal: 0.048.sw, vertical: 0.028.sw),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ActionButton(
                    isLoading: _isLoading,
                    text: 'Complete Appointment',
                    backgroundColor: UIColors.primary100,
                    textColor: UIColors.white,
                    shape: ButtonShape.capsule,
                    size: ButtonSizes.large,
                    onPressed: () async {
                      Map<String, dynamic> data = {
                        "appointmentId": widget.appointmentId,
                        "doctorId": appointmentMapData['doctor']['_id'],
                        "studentId": appointmentMapData['student']['_id'],
                        "status": "completed",
                      };
                      setState(() {
                        _isLoading = true;
                      });
                      DoctorAppointmentApi appointmentApi =
                          DoctorAppointmentApi();
                      var res = await appointmentApi.completeAppointment(
                          context: context, data: data);
                      if (res != null) {
                        if (context.mounted) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoctorAppointmentBooked(
                                  data: res,
                                  onContinue: () {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            DoctorsRoutes.home,
                                            (Route<dynamic> route) => false);
                                  }),
                            ),
                          );
                        }
                      }

                      setState(() {
                        _isLoading = false;
                      });
                    },
                  ),
                ],
              ),
            ),
    );
  }
}

class DoctorInfoBlock extends StatelessWidget {
  const DoctorInfoBlock({
    Key key,
    @required this.title,
    @required this.desc,
    @required this.icon,
  }) : super(key: key);

  final String title;
  final String desc;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 0.02.sh,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                icon,
                color: UIColors.secondary100,
              ),
              SizedBox(
                width: 0.020.sh,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: TypographyStyle.bodyMediumn.copyWith(
                        color: UIColors.secondary100,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(
                      height: 0.003.sh,
                    ),
                    Text(
                      (desc == '') ? '---' : desc,
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      style: TypographyStyle.bodySmall.copyWith(
                        color: UIColors.secondary300,
                        fontSize: 14.sp,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class IconTile extends StatelessWidget {
  final IconData icon;
  final Color backColor;

  const IconTile({Key key, this.icon, this.backColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: Container(
        height: 0.045.sh,
        width: 0.045.sh,
        decoration: BoxDecoration(
          color: backColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(
          icon,
          size: 20,
          color: UIColors.primary,
        ),
      ),
    );
  }
}
