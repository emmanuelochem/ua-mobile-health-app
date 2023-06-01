import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ua_mobile_health/core/logics/formValidationLogics.dart';
import 'package:ua_mobile_health/core/network/network_config.dart';
import 'package:ua_mobile_health/core/ui/typography_style.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';
import 'package:ua_mobile_health/doctors_routes.dart';
import 'package:ua_mobile_health/meeting/meeting_api.dart';
import 'package:ua_mobile_health/meeting/meeting_model.dart';
import 'package:ua_mobile_health/meeting/meeting_page.dart';
import 'package:ua_mobile_health/widgets/action_button.dart';
import 'package:ua_mobile_health/widgets/text_input.dart';

class MeetingHomeScreen extends StatefulWidget {
  const MeetingHomeScreen({Key key}) : super(key: key);

  @override
  State<MeetingHomeScreen> createState() => _MeetingHomeScreenState();
}

class _MeetingHomeScreenState extends State<MeetingHomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'student1@gmail.com');
  final _passController = TextEditingController(text: '123456');

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
          actions: const [],
          leading: Center(
            child: IconButton(
                icon: SvgPicture.asset(
                  'assets/icons/navigator_back.svg',
                  height: 0.016.sh,
                ),
                onPressed: _isLoading
                    ? null
                    : () {
                        Navigator.pushNamed(
                          context,
                          DoctorsRoutes.welcome,
                        );
                      }),
          ),
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 0.058.sw,
            vertical: 0.02.sh,
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Join Meeting',
                  style: TypographyStyle.heading3.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 0.03.sh),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      TextInputField(
                        hintText: 'Meeting Id',
                        validator: FormValidation.isEmpty,
                        textController: _emailController,
                        inputType: InputType.number,
                      ),
                      SizedBox(height: 0.04.sh),
                      Row(
                        children: [
                          Expanded(
                            child: ActionButton(
                              text: 'Start',
                              backgroundColor: UIColors.primary,
                              textColor: UIColors.white,
                              shape: ButtonShape.squircle,
                              size: ButtonSizes.large,
                              isLoading: _isLoading,
                              onPressed: _isLoading
                                  ? null
                                  : () async {
                                      MeetingApi meetingApi = MeetingApi();
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      Map<String, dynamic> data = {
                                        'hostId': 'ochem111',
                                        'hostName': 'Emmanuel1'
                                      };
                                      await meetingApi
                                          .startMeeting(
                                              data: data, context: context)
                                          .then((value) async {
                                        if (value != null) {
                                          await validateMeeting(value['data']);
                                        } else {
                                          log(value.toString());
                                        }
                                        setState(() {
                                          _isLoading = false;
                                        });
                                      });
                                    },
                            ),
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                            child: ActionButton(
                              text: 'Join',
                              backgroundColor: UIColors.primary,
                              textColor: UIColors.white,
                              shape: ButtonShape.squircle,
                              size: ButtonSizes.large,
                              isLoading: _isLoading,
                              onPressed: _isLoading
                                  ? null
                                  : () async {
                                      await validateMeeting(
                                          _emailController.text);
                                    },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 0.025.sh,
                ),
              ],
            ),
          ),
        ));
  }

  //6475ef8663e9535454d84831

  validateMeeting(String meetingId) async {
    MeetingApi meetingApi = MeetingApi();
    await meetingApi
        .joinMeeting(meetingId: meetingId, context: context)
        .then((value) async {
      if (value != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MeetingPage(
                hostUrl: NetworkConfig.liveUrl,
                userId: value['data']['hostId'],
                meetingId: value['data']['id'],
                name: value['data']['hostName'],
                meetingDetail: MeetingDetail.fromMap(value['data']),
              ),
            ));
      } else {
        log(value.toString());
      }
    });
  }
}
