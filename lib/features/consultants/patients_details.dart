import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:recase/recase.dart';
import 'package:ua_mobile_health/core/constants/app_constants.dart';
import 'package:ua_mobile_health/core/providers/doctor_data_provider.dart';
import 'package:ua_mobile_health/core/ui/typography_style.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';
import 'package:ua_mobile_health/features/consultants/add_record.dart';
import 'package:ua_mobile_health/features/consultants/records_tab.dart';
import 'package:ua_mobile_health/features/users/user_api.dart';
import 'package:ua_mobile_health/routes.dart';
import 'package:ua_mobile_health/widgets/action_button.dart';
import 'package:ua_mobile_health/widgets/empty_data_notice.dart';

class PatientsDetails extends StatefulWidget {
  const PatientsDetails({Key key, @required this.doctor}) : super(key: key);
  final String doctor;

  @override
  _DoctorsInfoState createState() => _DoctorsInfoState();
}

class _DoctorsInfoState extends State<PatientsDetails>
    with TickerProviderStateMixin {
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

  final List _tabNames = [
    'Information',
    'Records',
    'Appointment History',
  ];

  TabController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doctorDataProvider = context.read<DoctorDataProvider>();
    _controller = TabController(vsync: this, length: _tabNames.length);
    futureData = getDoctor();
  }

  Future likeUSer() async {
    setState(() {
      isLoaded = false;
    });
    String userId = userData['_id'];
    UserApi userApi = UserApi();
    var res = await userApi
        .likeUnlike(context: context, doctorId: userId)
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

  bool _reviewLoading = false;
  List reviews = [];
  Future getReviews() async {
    setState(() {
      _reviewLoading = true;
    });
    String userId = userData['_id'];
    UserApi userApi = UserApi();
    var res = await userApi
        .getReviews(context: context, doctorId: userId)
        .then((value) {
      if (value != null) {
        setState(() {
          _reviewLoading = false;
          reviews = value['data'];
        });
        return value['data'];
      } else {
        return null;
      }
    });
    return res;
  }

  DoctorDataProvider doctorDataProvider;
  int activeTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: UIColors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Patient Information',
          style: TypographyStyle.heading5.copyWith(
            fontSize: 18.sp,
            color: UIColors.secondary,
          ),
        ),
        leading: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 0.010.sh,
            vertical: 0.010.sh,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: UIColors.secondary600.withOpacity(.5),
              border: Border.all(
                width: 1,
                color: UIColors.secondary500,
              )),
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: SvgPicture.asset(
              'assets/icons/navigator_back.svg',
              height: 0.016.sh,
            ),
            iconSize: 0.02.sh,
            color: Colors.white,
          ),
        ),
        actions: const [],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: 0.058.sw,
          vertical: 0.00.sw,
        ),
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
                Map patientData = querySnapshot.data ?? {};
                // print(list[0]['summary']);
                return patientData.isEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          EmptyDataNotice(
                            icon: IconlyLight.close_square,
                            message:
                                'Patient Information not available at the moment.',
                          ),
                        ],
                      )
                    : Container(
                        padding: EdgeInsets.only(
                          top: 0.03.sh,
                          bottom: 0.04.sh,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        height: 0.14.sh,
                                        width: 0.14.sh,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              patientData['photo'],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 0.05.sw,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              '${patientData['firstname']} ${patientData['lastname']}',
                                              style: TypographyStyle.heading5
                                                  .copyWith(
                                                color: UIColors.secondary100,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 0.005.sh,
                                            ),
                                            Text(
                                              ReCase(patientData['matric_no'])
                                                  .sentenceCase,
                                              style: TypographyStyle.bodySmall
                                                  .copyWith(
                                                color: UIColors.secondary,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 0.02.sh,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Expanded(
                                                  child: IconBox(
                                                    backColor: UIColors.primary
                                                        .withOpacity(.1),
                                                    title: 'Call',
                                                    icon: PhosphorIcons
                                                        .phone_call,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: IconBox(
                                                    backColor: UIColors.primary
                                                        .withOpacity(.1),
                                                    title: 'SMS',
                                                    icon:
                                                        PhosphorIcons.envelope,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 0.02.sh,
                                ),
                                TabBar(
                                  controller: _controller,
                                  indicatorColor: UIColors.primary,
                                  labelColor: UIColors.primary,
                                  unselectedLabelColor: Colors.black54,
                                  tabs: List.generate(
                                    _tabNames.length,
                                    (index) => Tab(text: _tabNames[index]),
                                  ),
                                  indicatorWeight: 2,
                                  onTap: (value) {
                                    if (value == 1) {
                                      getReviews();
                                    }
                                    setState(() {
                                      activeTab = value;
                                    });
                                  },
                                ),
                                Visibility(
                                  visible: activeTab == 0,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 0.02.sh,
                                      ),
                                      Text(
                                        "Academic Information",
                                        style: TypographyStyle.heading5
                                            .copyWith(
                                                fontSize: 16.sp,
                                                color: UIColors.secondary200),
                                      ),
                                      SizedBox(
                                        height: 0.02.sh,
                                      ),
                                      DoctorInfoBlock(
                                        title: 'Matric No.',
                                        desc: '${patientData['matric_no']}',
                                        icon: PhosphorIcons.hash,
                                      ),
                                      DoctorInfoBlock(
                                        title: 'Faculty',
                                        desc: '${patientData['faculty']}',
                                        icon: PhosphorIcons.buildings,
                                      ),
                                      DoctorInfoBlock(
                                        title: 'Department',
                                        desc: '${patientData['department']}',
                                        icon: PhosphorIcons.bank,
                                      ),
                                      DoctorInfoBlock(
                                        title: 'Level',
                                        desc: '${patientData['level']}00 Lvl',
                                        icon: PhosphorIcons.graduation_cap,
                                      ),
                                      DoctorInfoBlock(
                                        title: 'Joined On',
                                        desc: AppConstants.formatDate.format(
                                            DateTime.parse(
                                                patientData['createdAt'])),
                                        icon: PhosphorIcons.clock,
                                      ),
                                      SizedBox(
                                        height: 0.1.sh,
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                    visible: activeTab == 1,
                                    child: _reviewLoading
                                        ? SizedBox(
                                            height: 0.5.sh,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                color: UIColors.primary,
                                              ),
                                            ),
                                          )
                                        : Column(
                                            children: [
                                              SizedBox(
                                                height: 0.016.sh,
                                              ),
                                              ActionButton(
                                                onPressed: () async {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const Addtodo(
                                                                  // studentId:
                                                                  //     userData['_id'],
                                                                  ))).then(
                                                      (value) async {
                                                    await getReviews();
                                                  });
                                                },
                                                text: 'Add Record',
                                                shape: ButtonShape.squircle,
                                                size: ButtonSizes.small,
                                                fontSize: 12.sp,
                                                backgroundColor: UIColors
                                                    .primary
                                                    .withOpacity(.1),
                                                textColor: UIColors.primary,
                                                iconColor: UIColors.white,
                                              ),
                                              reviews.isEmpty == false
                                                  ? Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(30.0),
                                                          child: Center(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      18.0),
                                                              child: Column(
                                                                children: [
                                                                  Icon(
                                                                    PhosphorIcons
                                                                        .book,
                                                                    size:
                                                                        0.2.sw,
                                                                    color: UIColors
                                                                        .primary100,
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        0.02.sh,
                                                                  ),
                                                                  Text(
                                                                      'Add a new record for this patient.',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TypographyStyle
                                                                          .bodySmall
                                                                          .copyWith(
                                                                              fontSize: 15.sp,
                                                                              color: UIColors.primary100))
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  : const Listdata(),
                                            ],
                                          )),
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
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "NGN 30",
                    style: TypographyStyle.heading5.copyWith(
                        fontSize: 14.sp, color: UIColors.secondary200),
                  ),
                  SizedBox(
                    width: 0.05.sw,
                  ),
                  Expanded(
                    child: ActionButton(
                      isLoading: false,
                      text: 'Book Appointment',
                      backgroundColor: UIColors.primary,
                      textColor: UIColors.white,
                      shape: ButtonShape.capsule,
                      size: ButtonSizes.xxxxxm,
                      onPressed: () {
                        //init payment
                        Navigator.pushNamed(
                          context,
                          Routes.bookAppointment,
                          arguments: <String, dynamic>{'doctor': widget.doctor},
                        );
                      },
                    ),
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

class IconBox extends StatelessWidget {
  final IconData icon;
  final Color backColor;
  final String title;
  final Function onPress;

  const IconBox({
    Key key,
    this.icon,
    this.title,
    this.backColor,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 0.01.sh, horizontal: 0.02.sh),
        decoration: BoxDecoration(
          color: backColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 25,
              color: UIColors.primary,
            ),
            SizedBox(
              width: 0.02.sw,
            ),
            Text(
              title.toString(),
              style: TypographyStyle.bodySmall.copyWith(
                fontSize: 13.sp,
                color: UIColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
