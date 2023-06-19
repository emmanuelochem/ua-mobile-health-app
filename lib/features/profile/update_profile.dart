import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:ua_mobile_health/core/logics/formValidationLogics.dart';
import 'package:ua_mobile_health/core/logics/generalLogics.dart';
import 'package:ua_mobile_health/core/providers/doctor_data_provider.dart';
import 'package:ua_mobile_health/core/ui/typography_style.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';
import 'package:ua_mobile_health/features/users/user_api.dart';
import 'package:ua_mobile_health/widgets/action_button.dart';
import 'package:ua_mobile_health/widgets/dropdown_input.dart';
import 'package:ua_mobile_health/widgets/dropdown_model.dart';
import 'package:ua_mobile_health/widgets/snack_bar.dart';
import 'package:ua_mobile_health/widgets/text_input.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  bool isSignIn = true;
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

    _fnController.text = doctorDataProvider.profile['firstname'];
    _lnController.text = doctorDataProvider.profile['lastname'];
    _passController.text = doctorDataProvider.profile['password'];
    _emailController.text = doctorDataProvider.profile['email'];
    _phoneController.text = doctorDataProvider.profile['phone'];
    _biographyController.text = doctorDataProvider.profile['biography'];
    _specializationController.text =
        doctorDataProvider.profile['specialization'];
    _qualificationController.text = doctorDataProvider.profile['qualification'];
    _addressController.text = doctorDataProvider.profile['address'];
    _facultyController.text = doctorDataProvider.profile['faculty'];
    _departmentController.text = doctorDataProvider.profile['department'];
    _levelController.text = doctorDataProvider.profile['level'];
    _matricController.text = doctorDataProvider.profile['matric_no'];
  }

  File imageCamera;
  bool _isUploading = false;
  Future imageUpload(BuildContext context) async {
    setState(() {
      _isUploading = true;
    });

    UserApi userApi = UserApi();
    Map<String, dynamic> data = {
      "photo": await MultipartFile.fromFile(
        imageCamera.path,
        filename: path.basename(imageCamera.path),
      ),
    };
    if (context.mounted) {}
    await userApi.updateProfilePic(context: context, data: data).then(
      (value) {
        if (value != null) {
          setState(() {
            _isUploading = false;
          });
          GeneralLogics.setDoctorData(doctorDataProvider, value['userData']);
          FlushBar.showSnackBar(
            context: context,
            type: FlushbarType.success,
            message: value['message'],
          );

          return;
        } else {
          setState(() {
            _isUploading = false;
          });
          FlushBar.showSnackBar(
            context: context,
            type: FlushbarType.error,
            message: 'An error occured',
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !_isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: Colors.black),
            centerTitle: false,
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
                          Navigator.pop(context);
                        }),
            ),
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Text(
              'Update Profile',
              style: TextStyle(color: Colors.black, fontSize: 18.sp),
            )),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 0.04.sh, horizontal: 0.05.sw),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Update Profile',
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
                  'Please provide the information you want to update.',
                  textAlign: TextAlign.start,
                  style: TypographyStyle.bodyMediumn.copyWith(
                    fontSize: 15.sp,
                    color: UIColors.secondary300,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 1.sw,
                  child: GestureDetector(
                    onTap: () async {
                      await GeneralLogics.takePicture().then((value) async {
                        if (value == null) return;
                        setState(() {
                          imageCamera = value;
                        });
                        await imageUpload(context);
                      });
                    },
                    child: Container(
                      height: 0.2.sh,
                      padding: EdgeInsets.all(0.046.sh),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: UIColors.secondary600,
                        border: Border.all(
                          color: imageCamera == null
                              ? Colors.transparent
                              : UIColors.secondary600,
                        ),
                        image: imageCamera != null ||
                                (doctorDataProvider.profile['photo'] != null ||
                                    doctorDataProvider.profile['photo'] != '')
                            ? DecorationImage(
                                fit: BoxFit.cover,
                                image: (doctorDataProvider.profile['photo'] !=
                                            null ||
                                        doctorDataProvider.profile['photo'] !=
                                            '')
                                    ? NetworkImage(
                                        doctorDataProvider.profile['photo'])
                                    : FileImage(imageCamera),
                              )
                            : null,
                      ),
                      child: _isUploading
                          ? SizedBox(
                              width: 0.01.sh,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : Icon(
                              Iconsax.user,
                              size: 0.04.sh,
                              color: imageCamera == null &&
                                      (doctorDataProvider.profile['photo'] ==
                                              null ||
                                          doctorDataProvider.profile['photo'] ==
                                              '')
                                  ? UIColors.secondary400
                                  : Colors.transparent,
                            ),
                    ),
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
                  hintText: 'Password (Optional)',
                  //validator: FormValidation.isPassword,
                  textController: _passController,
                  inputType: InputType.password,
                  //hideText: true,
                ),
                SizedBox(
                  height: 0.050.sh,
                ),
                Text(
                    'Update ${doctorDataProvider.profile['is_student'] ? 'Academic' : 'Medical'} Information',
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
                  height: 0.020.sh,
                ),
                Visibility(
                  visible: doctorDataProvider.profile['is_student'],
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
                        initialValue: _facultyController.text,
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
                        initialValue: _departmentController.text,
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
                        initialValue: _levelController.text,
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
              ],
            ),
          ),
        ),
        bottomSheet: Container(
          height: 0.093.sh,
          decoration: BoxDecoration(
              color: UIColors.white,
              border: Border(
                top: BorderSide(color: UIColors.secondary500),
              )),
          padding:
              EdgeInsets.symmetric(horizontal: 0.048.sw, vertical: 0.028.sw),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ActionButton(
                text: 'Submit',
                backgroundColor: UIColors.primary,
                textColor: UIColors.white,
                shape: ButtonShape.capsule,
                size: ButtonSizes.large,
                isLoading: _isLoading,
                onPressed: _isLoading
                    ? null
                    : () async {
                        if (_formKey.currentState.validate()) {
                          UserApi authApi = UserApi();
                          Map<String, dynamic> data = {
                            "firstname": _fnController.text,
                            "lastname": _lnController.text,
                            "email": _emailController.text,
                            "phone": _phoneController.text,
                            // "is_student": doctorDataProvider.profile['is_student'],
                            // "user_type":
                            //     doctorDataProvider.profile['is_student'] ? "student" : "doctor",
                            "biography": _biographyController.text,
                            "specialization": _specializationController.text,
                            "qualification": _qualificationController.text,
                            "address": _addressController.text,
                            "faculty": _facultyController.text,
                            "department": _departmentController.text,
                            "level": _levelController.text,
                            "matric_no": _matricController.text,
                          };

                          if (_passController.text.isNotEmpty) {
                            data["password"] = _passController.text;
                          }
                          setState(() {
                            _isLoading = true;
                          });
                          await authApi
                              .updateProfile(data: data, context: context)
                              .then((value) async {
                            if (value != null) {
                              GeneralLogics.setDoctorData(
                                  doctorDataProvider, value['userData']);
                              if (context.mounted) {
                                ///dialog
                                GeneralLogics.showNotice(
                                  context: context,
                                  canDismiss: false,
                                  heading: 'Okay, Got It!',
                                  msg: value['message'],
                                  type: 'success',
                                  onContinue: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
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
    );
  }
}
