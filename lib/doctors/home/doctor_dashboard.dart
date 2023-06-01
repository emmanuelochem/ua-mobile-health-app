import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:ua_mobile_health/core/providers/doctor_data_provider.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';
import 'package:ua_mobile_health/doctors/appointments/new_appointment_page.dart';
import 'package:ua_mobile_health/doctors/home/doctor_home_page.dart';
import 'package:ua_mobile_health/doctors/home/my_account.dart';
import 'package:ua_mobile_health/doctors/users/student_doctors_page.dart';

class DoctorDashboardPage extends StatefulWidget {
  const DoctorDashboardPage({Key key}) : super(key: key);

  @override
  _AppHomePageState createState() => _AppHomePageState();
}

class _AppHomePageState extends State<DoctorDashboardPage> {
  int _pageIndex = 0;
  final GlobalKey<ScaffoldState> _homeKey = GlobalKey(); // Create a key

  DoctorDataProvider doctorDataProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
    doctorDataProvider = context.read<DoctorDataProvider>();
  }

  static final List<Widget> _doctorPages = <Widget>[
    const DoctorHomePage(),
    const NewDoctorManageAppointments(),
    const NewDoctorManageAppointments(),
    const MyAccountPage(),
  ];

  static final List<Widget> _studentPages = <Widget>[
    const DoctorHomePage(),
    const DoctorsPage(),
    const NewDoctorManageAppointments(),
    const MyAccountPage(),
  ];

  void _onTabbed(int index) {
    setState(() {
      _pageIndex = index;
      _pageController.jumpToPage(_pageIndex);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          key: _homeKey,
          extendBodyBehindAppBar: true,
          body: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: doctorDataProvider.profile['is_student']
                ? _studentPages
                : _doctorPages,
          ),
          bottomNavigationBar: Container(
            padding:
                EdgeInsets.symmetric(vertical: 0.015.sh, horizontal: 0.058.sw),
            color: UIColors.white,
            child: GNav(
                selectedIndex: _pageIndex,
                onTabChange: _onTabbed,
                backgroundColor: UIColors.white,
                color: UIColors.primary,
                activeColor: UIColors.white,
                tabBackgroundColor: UIColors.primary,
                tabActiveBorder:
                    Border.all(color: UIColors.primary, width: 0.001.sh),
                haptic: true,
                tabBorderRadius: 15.r,
                tabBorder: Border.all(color: Colors.transparent, width: 1),
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 100),
                gap: 8,
                iconSize: 24.sp,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                tabs: [
                  const GButton(
                    icon: IconlyBold.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: IconlyBold.user_3,
                    text: doctorDataProvider.profile['is_student']
                        ? 'Doctors'
                        : 'Patients',
                  ),
                  const GButton(
                    icon: IconlyBold.calendar,
                    text: 'Appointments',
                  ),
                  const GButton(
                    icon: IconlyBold.profile,
                    text: 'Profile',
                  )
                ]),
          )),
    );
  }
}
