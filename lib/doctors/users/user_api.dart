import 'package:flutter/material.dart';
import 'package:ua_mobile_health/core/network/network_handler.dart';

class UserApi extends NetworkHandler {
//Students
  Future<Map> getDoctors({BuildContext context}) async {
    String route = 'user/doctors';
    Map<String, dynamic> header = {};
    return await httpGet(
      route: route,
      header: header,
      authRequired: true,
      hasCustomUrl: false,
      successSnacbar: false,
      alertDialog: false,
      context: context,
    );
  }

  Future<Map> getUser({BuildContext context, String doctorId}) async {
    String route = 'user/profile/$doctorId';
    Map<String, dynamic> header = {};
    return await httpGet(
      route: route,
      header: header,
      authRequired: true,
      hasCustomUrl: false,
      successSnacbar: false,
      alertDialog: false,
      context: context,
    );
  }

  Future<Map> updateProfilePic(
      {Map<String, dynamic> data, BuildContext context}) async {
    String route = 'user/profile/update/picture';
    Map<String, dynamic> header = {};
    return await imageUpload(
      data: data,
      route: route,
      header: header,
      authRequired: true,
      hasCustomUrl: false,
      successSnacbar: false,
      alertDialog: false,
      context: context,
    );
  }

  Future<Map> updateProfile(
      {Map<String, dynamic> data, BuildContext context}) async {
    String route = 'user/profile/update';
    Map<String, dynamic> header = {};
    return await httpPatch(
      data: data,
      route: route,
      header: header,
      authRequired: true,
      hasCustomUrl: false,
      successSnacbar: false,
      alertDialog: false,
      context: context,
    );
  }
}
