import 'package:flutter/material.dart';
import 'package:ua_mobile_health/core/network/network_handler.dart';

class UserAuthApi extends NetworkHandler {
//Students
  Future<Map> register(
      {Map<String, dynamic> data, BuildContext context}) async {
    String route = 'auth/register';
    Map<String, dynamic> header = {};
    return await httpPost(
        route: route,
        data: data,
        header: header,
        authRequired: false,
        hasCustomUrl: false,
        successSnacbar: false,
        alertDialog: false,
        context: context);
  }

  Future<Map> login({Map<String, dynamic> data, BuildContext context}) async {
    String route = 'auth/login';
    Map<String, dynamic> header = {};
    return await httpPost(
        route: route,
        data: data,
        header: header,
        authRequired: false,
        hasCustomUrl: false,
        successSnacbar: false,
        alertDialog: false,
        context: context);
  }

  Future<Map> getDoctorData({BuildContext context}) async {
    String route = 'user/data';
    Map<String, dynamic> header = {};
    return await httpGet(
      route: route,
      header: header,
      authRequired: true,
      hasCustomUrl: false,
      successSnacbar: false,
      alertDialog: true,
      context: context,
    );
  }
}
