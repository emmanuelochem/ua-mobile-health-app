import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:ua_mobile_health/core/logics/formValidationLogics.dart';
import 'package:ua_mobile_health/core/logics/generalLogics.dart';
import 'package:ua_mobile_health/core/providers/doctor_data_provider.dart';
import 'package:ua_mobile_health/core/ui/typography_style.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';
import 'package:ua_mobile_health/features/auth/doctor_auth_api.dart';
import 'package:ua_mobile_health/routes.dart';
import 'package:ua_mobile_health/widgets/action_button.dart';
import 'package:ua_mobile_health/widgets/dropdown_input.dart';
import 'package:ua_mobile_health/widgets/dropdown_model.dart';
import 'package:ua_mobile_health/widgets/text_input.dart';

class DoctorRegisterPage extends StatefulWidget {
  const DoctorRegisterPage({Key key, this.isStudent = true}) : super(key: key);
  final bool isStudent;

  @override
  State<DoctorRegisterPage> createState() => _DoctorRegisterPageState();
}

class _DoctorRegisterPageState extends State<DoctorRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _fnController = TextEditingController();
  final _lnController = TextEditingController();
  final _passController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _biographyController = TextEditingController();
  final _specializationController = TextEditingController();
  final _qualificationController = TextEditingController();
  final _addressController = TextEditingController();
  final _facultyController = TextEditingController();
  final _departmentController = TextEditingController();
  final _levelController = TextEditingController();
  final _matricController = TextEditingController();

  bool _isLoading = false;

  List<DropdownModel> facultyList = [
    DropdownModel(name: 'Faculty of Engineering', value: '1')
  ];

  List<DropdownModel> departmentList = [
    DropdownModel(name: 'Mechanical Engineering', value: '1'),
    DropdownModel(name: 'Chemical Engineering', value: '2'),
    DropdownModel(name: 'Electrical Engineering', value: '3'),
    DropdownModel(name: 'Civil Engineering', value: '4')
  ];

  List<DropdownModel> levelList = [
    DropdownModel(name: '100', value: '1'),
    DropdownModel(name: '200', value: '2'),
    DropdownModel(name: '300', value: '3'),
    DropdownModel(name: '400', value: '4'),
    DropdownModel(name: '500', value: '5')
  ];

  DoctorDataProvider doctorDataProvider;
  @override
  void initState() {
    super.initState();
    doctorDataProvider = context.read<DoctorDataProvider>();
  }

  @override
  Widget build(BuildContext context) {
    _isLoading = false;
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
                          Routes.welcome,
                        );
                      }),
          ),
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 0.058.sw,
              vertical: 0.02.sh,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Profile',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 18.sp,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Please provide a valid information',
                    textAlign: TextAlign.start,
                    style: TypographyStyle.bodyMediumn.copyWith(
                      fontSize: 15.sp,
                      color: UIColors.secondary300,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextInputField(
                    hintText: 'Firstname',
                    validator: FormValidation.isEmpty,
                    textController: _fnController,
                    inputType: InputType.number,
                  ),
                  TextInputField(
                    hintText: 'Lastname',
                    validator: FormValidation.isEmpty,
                    textController: _lnController,
                    inputType: InputType.number,
                  ),
                  TextInputField(
                    hintText: 'Phone No.',
                    validator: FormValidation.isEmpty,
                    textController: _phoneController,
                    inputType: InputType.number,
                  ),
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
                  SizedBox(
                    height: 0.050.sh,
                  ),
                  Text(
                      '${widget.isStudent ? 'Academic' : 'Medical'} Information',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 18.sp)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Please provide a valid information to avoid suspension.',
                    textAlign: TextAlign.start,
                    style: TypographyStyle.bodyMediumn.copyWith(
                      fontSize: 15.sp,
                      color: UIColors.secondary300,
                    ),
                  ),
                  SizedBox(
                    height: 0.0030.sh,
                  ),
                  Visibility(
                    visible: widget.isStudent,
                    replacement: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextInputField(
                          hintText: 'Qualification',
                          validator: FormValidation.isEmpty,
                          textController: _qualificationController,
                          inputType: InputType.number,
                        ),
                        TextInputField(
                          hintText: 'Specialization',
                          validator: FormValidation.isEmpty,
                          textController: _specializationController,
                          inputType: InputType.number,
                        ),
                        TextInputField(
                          hintText: 'Biography',
                          validator: FormValidation.isEmpty,
                          textController: _biographyController,
                          inputType: InputType.textarea,
                        ),
                        TextInputField(
                          hintText: 'Office Address',
                          validator: FormValidation.isEmpty,
                          textController: _addressController,
                          inputType: InputType.textarea,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextInputField(
                          hintText: 'Matric No.',
                          validator: FormValidation.isEmpty,
                          textController: _matricController,
                          inputType: InputType.number,
                        ),
                        DropDownInput(
                          enabled: !_isLoading,
                          fieldTitle: 'Faculty',
                          hintText: 'Faculty',
                          sheetTitle: 'Faculty',
                          showSearch: true,
                          searchPlaceholder: 'Search faculty here',
                          optionsList: facultyList,
                          validator: (val) {
                            if (val == null || val.value.isEmpty) {
                              return 'Faculty is required';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            setState(() {
                              _facultyController.text = value.name;
                              //print(brandController.text);
                            });

                            return value;
                          },
                        ),
                        DropDownInput(
                          enabled: !_isLoading,
                          fieldTitle: 'Department',
                          hintText: 'Department',
                          sheetTitle: 'Department',
                          showSearch: true,
                          searchPlaceholder: 'Search department here',
                          optionsList: departmentList,
                          validator: (val) {
                            if (val == null || val.value.isEmpty) {
                              return 'Department is required';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            setState(() {
                              _departmentController.text = value.name;
                              //print(brandController.text);
                            });

                            return value;
                          },
                        ),
                        DropDownInput(
                          enabled: !_isLoading,
                          fieldTitle: 'Level',
                          hintText: 'Level',
                          sheetTitle: 'Level',
                          showSearch: true,
                          searchPlaceholder: 'Search level here',
                          optionsList: levelList,
                          validator: (val) {
                            if (val == null || val.value.isEmpty) {
                              return 'Level is required';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            setState(() {
                              _levelController.text = value.name;
                              //print(brandController.text);
                            });

                            return value;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 0.04.sh),
                  ActionButton(
                    text: 'Continue',
                    backgroundColor: UIColors.primary,
                    textColor: UIColors.white,
                    shape: ButtonShape.capsule,
                    size: ButtonSizes.large,
                    isLoading: _isLoading,
                    onPressed: _isLoading
                        ? null
                        : () async {
                            if (_formKey.currentState.validate()) {
                              UserAuthApi authApi = UserAuthApi();
                              Map<String, dynamic> data = {
                                "firstname": _fnController.text,
                                "lastname": _lnController.text,
                                "email": _emailController.text,
                                "phone": _phoneController.text,
                                "password": _passController.text,
                                "is_student": widget.isStudent,
                                "user_type":
                                    widget.isStudent ? "student" : "doctor",
                                "biography": _biographyController.text,
                                "specialization":
                                    _specializationController.text,
                                "qualification": _qualificationController.text,
                                "address": _addressController.text,
                                "faculty": _facultyController.text,
                                "department": _departmentController.text,
                                "level": _levelController.text,
                                "matric_no": _matricController.text,
                              };
                              setState(() {
                                _isLoading = true;
                              });
                              await authApi
                                  .register(data: data)
                                  .then((value) async {
                                if (value != null) {
                                  GeneralLogics.saveToken(value['token']);
                                  GeneralLogics.setDoctorData(
                                      doctorDataProvider, value['userData']);
                                  if (context.mounted) {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      Routes.home,
                                      arguments: <String, dynamic>{},
                                    );
                                  }
                                } else {
                                  log(value.toString());
                                }
                                setState(() {
                                  _isLoading = false;
                                });
                              });
                            } else {}
                          },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
