import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ua_mobile_health/core/logics/generalLogics.dart';
import 'package:ua_mobile_health/core/providers/doctor_data_provider.dart';
import 'package:ua_mobile_health/core/ui/typography_style.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';
import 'package:ua_mobile_health/features/profile/update_profile.dart';
import 'package:ua_mobile_health/widgets/action_button.dart';
import 'package:ua_mobile_health/widgets/my_account_option_tile.dart';
import 'package:ua_mobile_health/widgets/optionsDialog.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key key}) : super(key: key);

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  DoctorDataProvider doctorDataProvider;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    doctorDataProvider = Provider.of<DoctorDataProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    var userData = doctorDataProvider.profile;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   centerTitle: false,
      //   title: Text(
      //     'My Account',
      //     style: TypographyStyle.heading5.copyWith(),
      //   ),
      //   iconTheme: const IconThemeData(color: Colors.black),
      //   //leadingWidth: 0,
      //   automaticallyImplyLeading: false,
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 0.058.sw),
          child: Column(children: [
            //profile bio
            Container(
              margin: EdgeInsets.only(
                top: 0.05.sh,
                bottom: 0.016.sh,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 0.12.sh,
                    width: 0.12.sh,
                    child: CircleAvatar(
                      backgroundImage:
                          (userData['photo'] == null || userData['photo'] == '')
                              ? const AssetImage(
                                  'assets/images/brands/user_avatar.png')
                              : NetworkImage(userData['photo'].toString()),
                    ),
                  ),
                  SizedBox(height: 0.013.sh),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              (userData['firstname'] +
                                      ' ' +
                                      userData['lastname']) ??
                                  '',
                              style: TypographyStyle.bodyLarge.copyWith(
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w700,
                                color: UIColors.secondary,
                              )),
                        ],
                      ),
                      Text(userData['email'] ?? userData['phone'],
                          style: TypographyStyle.bodySmall.copyWith(
                            fontSize: 14.sp,
                          )),
                    ],
                  ),
                ],
              ),
            ),

            //list tiles
            Container(
                margin: EdgeInsets.only(
                  top: 0.03.sh,
                  //bottom: 0.043.sh,
                ),
                child: Column(children: [
                  MyAccountOptionTile(
                      icon: PhosphorIcons.currency_ngn_bold,
                      title: 'Add Funds',
                      actionRequired: true,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const UpdateProfile(),
                          ),
                        ).then((value) {});
                      }),
                  MyAccountOptionTile(
                      icon: PhosphorIcons.user_plus_bold,
                      title: 'Update Profile',
                      actionRequired: false,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const UpdateProfile(),
                          ),
                        ).then((value) {});
                      }),
                  SizedBox(
                    height: 0.2.sh,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ActionButton(
                          text: 'Logout',
                          shape: ButtonShape.capsule,
                          size: ButtonSizes.medium,
                          backgroundColor: const Color(0xFFFFECEC),
                          textColor: const Color(0xFFC50000),
                          iconColor: const Color(0xFFC50000),
                          //leftIconPath: 'assets/images/icons/red_logout.svg',
                          onPressed: () {
                            OptionsDialog.messageDialog(context, 'Logout',
                                'Are you sure you want to log out of your account?',
                                () {
                              Navigator.pop(context);
                              GeneralLogics.logoutFunction(
                                  context: context, isStudent: false);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ])
                //
                )
          ]),
        ),
      ),
    );
  }
}
