import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ua_mobile_health/core/logics/generalLogics.dart';
import 'package:ua_mobile_health/core/ui/typography_style.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';
import 'package:ua_mobile_health/doctors/appointments/appointment_api.dart';
import 'package:ua_mobile_health/doctors_routes.dart';
import 'package:ua_mobile_health/widgets/empty_data_notice.dart';

class NewDoctorManageAppointments extends StatefulWidget {
  const NewDoctorManageAppointments({Key key}) : super(key: key);

  @override
  State<NewDoctorManageAppointments> createState() =>
      _ManageAppointmentsState();
}

class _ManageAppointmentsState extends State<NewDoctorManageAppointments> {
  List<dynamic> schedules = [];

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

  Future<List> futureData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureData = getAppointments();
  }

  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat('y-MM-d');
    var todayDate = format.format(DateTime.now());
    // print(todayDate);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          title: Text(
            'Appointments',
            style: TypographyStyle.heading5.copyWith(),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          //leadingWidth: 0,
          automaticallyImplyLeading: false,
        ),
        body: FutureBuilder<List>(
            future: futureData,
            builder: (BuildContext context, AsyncSnapshot<List> querySnapshot) {
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
                final messengerData = querySnapshot.data ?? [];
                List transactions = messengerData;
                List uniqueDs =
                    GeneralLogics.groupTransactionsByDate(transactions);
                List filtered =
                    GeneralLogics.getMergedTransactions(uniqueDs, transactions);
                int fLength = filtered.length;
                int length = transactions.length;

                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                      horizontal: 0.048.sw, vertical: 0.sh),
                  child: messengerData.isEmpty
                      ? const EmptyDataNotice(
                          icon: PhosphorIcons.calendar_blank,
                          message: 'Appointment not available at the moment.',
                        )
                      : Column(
                          children: List.generate(
                          fLength,
                          (i) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 0.01.sh,
                              ),
                              Text(
                                '${filtered[i]['period']}',
                                style: TypographyStyle.bodyMediumn.copyWith(
                                  color: UIColors.secondary200,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 0.015.sh,
                              ),
                              Column(
                                children: List.generate(
                                  filtered[i]['transactions'].length,
                                  (index) => GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        DoctorsRoutes.appointmentDetails,
                                        arguments: <String, dynamic>{
                                          'appointmentId': filtered[i]
                                                  ['transactions'][i]['_id']
                                              .toString()
                                        },
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 40),
                                      child: Row(
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                height: 0.060.sh,
                                                width: 0.060.sh,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color:
                                                        UIColors.secondary600,
                                                    image: const DecorationImage(
                                                        image: NetworkImage(
                                                            'https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png'))),
                                              ),
                                              SizedBox(
                                                width: 0.02.sh,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Video consultstion',
                                                    style: TypographyStyle
                                                        .bodySmall
                                                        .copyWith(
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          UIColors.secondary300,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 0.008.sh,
                                                  ),
                                                  Text(
                                                    '${filtered[i]['transactions'][index]['student']['firstname']} ${filtered[i]['transactions'][index]['student']['lastname']}',
                                                    style: TypographyStyle
                                                        .bodyMediumn
                                                        .copyWith(
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color:
                                                          UIColors.secondary100,
                                                      height: 1,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 0.008.sh,
                                                  ),
                                                  Text(
                                                    '${filtered[i]['transactions'][index]['date']} (${filtered[i]['transactions'][index]['time']})',
                                                    style: TypographyStyle
                                                        .bodySmall
                                                        .copyWith(
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          UIColors.secondary300,
                                                      height: 1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          filtered[i]['transactions'][index]
                                                      ['date'] ==
                                                  todayDate
                                              ? Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    color: UIColors.primary,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Icon(
                                                    PhosphorIcons
                                                        .video_camera_fill,
                                                    color: UIColors.white,
                                                    size: 17,
                                                  ),
                                                )
                                              : const SizedBox()
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                );
              }
            }));
  }
}
