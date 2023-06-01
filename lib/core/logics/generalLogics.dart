import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:ua_mobile_health/core/providers/doctor_data_provider.dart';
import 'package:ua_mobile_health/core/providers/studentsDataProvider.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';
import 'package:ua_mobile_health/doctors_routes.dart';
import 'package:ua_mobile_health/widgets/action_button.dart';
import 'package:ua_mobile_health/widgets/notice_dialog.dart';
import 'package:ua_mobile_health/widgets/snack_bar.dart';
import 'package:image_picker/image_picker.dart';

class GeneralLogics {
  static Future<File> takePicture() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final XFile image = await picker.pickImage(source: ImageSource.gallery);
    final file = File(image.path);
    return file;
  }

  static void setDoctorData(DoctorDataProvider doctorDataProvider, Map data) {
    doctorDataProvider.setData(data);
  }

  static void setUserData(StudentDataProvider studentDataProvider, Map data) {
    studentDataProvider.setData(data);
    //log(data.toString());
  }

  static Future<void> logoutFunction(
      {BuildContext context, bool isStudent = false}) async {
    GeneralLogics.removeUserData().then((value) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          isStudent ? DoctorsRoutes.login : DoctorsRoutes.login,
          (Route<dynamic> route) => false);
    });
  }

  static Future<void> removeUserData() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: "token");
    await storage.delete(key: "businessId");
  }

  static Future<void> refreshUserData(BuildContext context) async {
    String token = await GeneralLogics.getToken();
    // print(token);
    if (token == null) {
      // GeneralLogics.showMessage(
      //     'Your session has expired, please login again.', Colors.red, context);
      // GeneralLogics.logoutFunction(context);
    } else {
      // DashboardApi request = DashboardApi();
      // request.getUserData(context: context, addUUId: false).then((res) async {
      //   // print(res['data']);
      //   if (res != null) {
      //     await SqfliteCrud().saveData(data: res['data']);
      //   } else {
      //     // Navigator.pushReplacementNamed(context, '/login');
      //   }
      // });
    }
  }

  static Future<void> saveToken(String token) async {
    const storage = FlutterSecureStorage();

    await storage.write(key: "token", value: token);
  }

  static Future<String> getToken() async {
    const storage = FlutterSecureStorage();
    return (await storage.read(key: "token"));
  }

  static void showMessageNew(
      String message, FlushbarType type, BuildContext context) {
    FlushBar.showSnackBar(context: context, type: type, message: message);
  }

  static Future<void> showAlertNew(
      BuildContext context, heading, msg, String type) {
    String img;
    switch (type) {
      case 'success':
        img = 'blue_success_check';
        break;

      case 'error':
        img = 'danger_notice';
        break;
      case 'pending':
        img = 'hour_glass';
        break;
      case 'logout':
        img = 'logout_door';
        break;
      case 'settings':
        img = 'admin_settings';
        break;
      case 'sad':
        img = 'sad_emoji';
        break;
      default:
    }
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) => ImportantNoticeDialog(
              dialogBackground: UIColors.white,
              titleFontSize: 25.sp,
              title: '$heading',
              svgFilePath: 'assets/icons/$img.png',
              message: '$msg',
              titleMessageSpace: 0.012.sh,
              iconHeight: 0.081.sh,
              buttonText: 'Ok, close',
              buttonTextColor: UIColors.white,
              buttonSize: ButtonSizes.small,
              buttonBackgroundColor: UIColors.primary,
              buttonShape: ButtonShape.squircle,
              buttonAction: () {
                Navigator.pop(context);
              },
            ));
  }

  static Future<void> showNotice({
    BuildContext context,
    heading,
    msg,
    String type,
    bool canDismiss = true,
    Function onContinue,
    Function onCancel,
    String onCancelText = 'Ok, close',
    String onContinueText = 'Ok, close',
  }) {
    String img;
    switch (type) {
      case 'success':
        img = 'blue_success_check';
        break;

      case 'error':
        img = 'danger_notice';
        break;
      case 'pending':
        img = 'hour_glass';
        break;
      case 'logout':
        img = 'logout_door';
        break;
      case 'settings':
        img = 'admin_settings';
        break;
      case 'sad':
        img = 'sad_emoji';
        break;
      default:
    }
    return showDialog(
        barrierDismissible: canDismiss,
        context: context,
        builder: (BuildContext context) => ImportantNoticeDialog(
              dialogBackground: UIColors.white,
              titleFontSize: 25.sp,
              title: '$heading',
              svgFilePath: 'assets/icons/$img.png',
              message: '$msg',
              titleMessageSpace: 0.012.sh,
              iconHeight: 0.081.sh,
              buttonText: onContinueText,
              buttonTextColor: UIColors.white,
              buttonSize: ButtonSizes.small,
              buttonBackgroundColor: UIColors.primary,
              buttonShape: ButtonShape.squircle,
              buttonAction: onContinue,
              secondButtonBackgroundColor: UIColors.secondary500,
              secondButtonSize: ButtonSizes.small,
              secondButtonTextColor: UIColors.primary,
              secondButtonShape: ButtonShape.squircle,
              secondButtonText: onCancelText,
              secondButtonAction: onCancel,
            ));
  }

  static String getInitials(String string, {int limitTo}) {
    var buffer = StringBuffer();
    var wordList = string.trim().split(' ');

    if (string.isEmpty) {
      return string;
    }

    // Take first character if string is a single word
    if (wordList.length <= 1) {
      return string.characters.first;
    }

    /// Fallback to actual word count if
    /// expected word count is greater
    if (limitTo != null && limitTo > wordList.length) {
      for (var i = 0; i < wordList.length; i++) {
        buffer.write(wordList[i][0]);
      }
      return buffer.toString();
    }

    // Handle all other cases
    for (var i = 0; i < (limitTo ?? wordList.length); i++) {
      buffer.write(wordList[i][0]);
    }
    return buffer.toString();
  }

  static List groupTransactionsByDate(List transactions) {
    List uniqueDates = [];
    // List transactions2 = transactions;
    for (var t in transactions) {
      DateFormat format = DateFormat('yMMMd');
      var date = format.format(DateTime.parse(t['date']));
      // var date = t['date'];
      // if (!uniqueDates.firstWhere((element) => element == date)) {
      //   uniqueDates.add(date);
      // }
      // try {
      //   uniqueDates.firstWhere((element) => element['a'] == date);

      var ud =
          uniqueDates.where((element) => element == getDisplayDate(t['date']));

      if (ud.isEmpty) {
        uniqueDates.add(getDisplayDate(t['date']));
      }
      // } catch (e) {
      //   uniqueDates.add({'a': date, 'b': t['date']});
      // }
    }

    return uniqueDates;
  }

  static List getMergedTransactions(List uniqueDates, List transactions) {
    List mergedTransactions = [];
    // ignore: avoid_function_literals_in_foreach_calls
    uniqueDates.forEach((element) {
      var tdata = transactions.where((el) {
        DateFormat format1 = DateFormat('yMMMd');
        var date1 = format1.format(DateTime.parse(el['date']));
        return getDisplayDate(el['date']) == element;
      });
      // if (tdata.length > 0) {
      var bind = {'period': element, 'transactions': tdata.toList()};
      mergedTransactions.add(bind);
      // }
    });

    return mergedTransactions;
  }

  static String getDisplayDate(String d) {
    if (d != null) {
      DateFormat format = DateFormat('yMMMd');
      var today = DateTime.now();
      var compDate = DateTime.parse(d);
      // month - 1 because January == 0
      var diff = today.difference(
          compDate); // get the difference between today(at 00:00:00) and the date
      if (format.format(compDate) == format.format(today)) {
        return "Today's Appointment";
      } else if (diff.inDays == 0) {
        return "Tomorrow";
      } else {
        return 'Upcoming'; // or format it what ever way you want
      }
    }

    return '';
  }
}
