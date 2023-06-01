import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:recase/recase.dart';
import 'package:ua_mobile_health/core/constants/app_constants.dart';
import 'package:ua_mobile_health/core/ui/typography_style.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';
import 'package:ua_mobile_health/doctors/users/user_api.dart';
import 'package:ua_mobile_health/doctors_routes.dart';
import 'package:ua_mobile_health/widgets/action_button.dart';
import 'package:ua_mobile_health/widgets/custom_appbar.dart';
import 'package:ua_mobile_health/widgets/empty_data_notice.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({Key key, @required this.doctor}) : super(key: key);
  final String doctor;

  @override
  _DoctorsInfoState createState() => _DoctorsInfoState();
}

class _DoctorsInfoState extends State<UserDetailsPage> {
  bool isLoaded = false;
  Map userData = {};
  Future<Map> getDoctor() async {
    setState(() {
      isLoaded = false;
    });
    UserApi messengerApi = UserApi();
    var res = await messengerApi
        .getUser(context: context, doctorId: widget.doctor)
        .then((value) {
      if (value != null) {
        setState(() {
          isLoaded = true;
          userData = value['data'];
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
    futureData = getDoctor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        appTitle: 'Doctor details',
        icon: Icon(Icons.arrow_back_ios),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 0.058.sw, vertical: 0.00.sw),
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
                Map doctorsData = querySnapshot.data ?? {};
                // print(list[0]['summary']);
                return doctorsData.isEmpty
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
                                SizedBox(
                                  height: 0.02.sh,
                                ),
                                Text(
                                  "${ReCase(doctorsData['firstname']).sentenceCase} Biography",
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
                                            '${doctorsData['firstname']} ${doctorsData['lastname']}',
                                            style: TypographyStyle.heading5
                                                .copyWith(
                                              color: UIColors.secondary200,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 0.005.sh,
                                          ),
                                          Text(
                                            "${doctorsData['email']}",
                                            style: TypographyStyle.bodySmall
                                                .copyWith(
                                              color: UIColors.secondary200,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 0.005.sh,
                                          ),
                                          Text(
                                            "${doctorsData['phone']}",
                                            style: TypographyStyle.bodySmall
                                                .copyWith(
                                              color: UIColors.secondary200,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 0.005.sh,
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
                                  "${doctorsData['biography']}",
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
                                  title: 'Qualification',
                                  desc: '${doctorsData['qualification']}',
                                  icon: PhosphorIcons.book,
                                ),
                                DoctorInfoBlock(
                                  title: 'Specialization',
                                  desc: '${doctorsData['specialization']}',
                                  icon: PhosphorIcons.check,
                                ),
                                DoctorInfoBlock(
                                  title: 'Joined On',
                                  desc: AppConstants.formatDate.format(
                                      DateTime.parse(doctorsData['createdAt'])),
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
      bottomSheet: !isLoaded || userData['is_student']
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
                    isLoading: false,
                    text: 'Book Appointment',
                    backgroundColor: UIColors.primary,
                    textColor: UIColors.white,
                    shape: ButtonShape.capsule,
                    size: ButtonSizes.large,
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        DoctorsRoutes.bookAppointment,
                        arguments: <String, dynamic>{'doctor': widget.doctor},
                      );
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
        children: <Widget>[
          Row(
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
                      style: TextStyle(
                          color: Colors.black87.withOpacity(0.7),
                          fontSize: 17.sp),
                    ),
                    SizedBox(
                      height: 0.003.sh,
                    ),
                    Text(
                      desc,
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      style: const TextStyle(color: Colors.grey),
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
