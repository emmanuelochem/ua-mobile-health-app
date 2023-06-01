import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:ua_mobile_health/core/logics/formValidationLogics.dart';
import 'package:ua_mobile_health/core/logics/generalLogics.dart';
import 'package:ua_mobile_health/core/providers/doctor_data_provider.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';
import 'package:ua_mobile_health/core/ui/typography_style.dart';
import 'package:ua_mobile_health/doctors/auth/doctor_auth_api.dart';
import 'package:ua_mobile_health/doctors_routes.dart';
import 'package:ua_mobile_health/widgets/action_button.dart';
import 'package:ua_mobile_health/widgets/text_input.dart';

class DoctorLoginPage extends StatefulWidget {
  const DoctorLoginPage({Key key}) : super(key: key);

  @override
  State<DoctorLoginPage> createState() => _DoctorLoginPageState();
}

class _DoctorLoginPageState extends State<DoctorLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'student1@gmail.com');
  final _passController = TextEditingController(text: '123456');

  bool _isLoading = false;

  DoctorDataProvider doctorDataProvider;

  @override
  void initState() {
    super.initState();
    doctorDataProvider = context.read<DoctorDataProvider>();
  }

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
        body: SingleChildScrollView(
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
                  'Welcome',
                  style: TypographyStyle.heading3.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Sign in to your account',
                  style: TypographyStyle.bodyMediumn.copyWith(
                      //fontSize: 16.sp,
                      //fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: 0.03.sh),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      TextInputField(
                        hintText: 'Email Address',
                        validator: FormValidation.isEmail,
                        textController: _emailController,
                        inputType: InputType.number,
                      ),
                      TextInputField(
                        hintText: 'Password',
                        validator: FormValidation.isPassword,
                        textController: _passController,
                        inputType: InputType.password,
                        //hideText: true,
                      ),
                      SizedBox(height: 0.04.sh),
                      ActionButton(
                        text: 'Continue',
                        backgroundColor: UIColors.primary,
                        textColor: UIColors.white,
                        shape: ButtonShape.squircle,
                        size: ButtonSizes.large,
                        isLoading: _isLoading,
                        onPressed: _isLoading
                            ? null
                            : () async {
                                if (_formKey.currentState.validate()) {
                                  UserAuthApi authApi = UserAuthApi();
                                  Map<String, String> data = {
                                    "email": _emailController.text,
                                    "password": _passController.text
                                  };
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  await authApi
                                      .login(data: data, context: context)
                                      .then((value) async {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    if (value != null) {
                                      GeneralLogics.saveToken(value['token']);
                                      GeneralLogics.setDoctorData(
                                          doctorDataProvider,
                                          value['userData']);
                                      if (context.mounted) {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          DoctorsRoutes.home,
                                          arguments: <String, dynamic>{},
                                        );
                                      }
                                    } else {
                                      // log(value.toString());
                                    }
                                  });
                                } else {
                                  //validation error
                                }
                              },
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
}
