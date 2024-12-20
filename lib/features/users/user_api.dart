import 'package:flutter/material.dart';
import 'package:ua_mobile_health/core/network/network_handler.dart';

class UserApi extends NetworkHandler {
  Future<Map> getRecords({BuildContext context, String studentId}) async {
    String route = 'user/record/$studentId';
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

  Future<Map> addRecord(
      {BuildContext context, Map<String, dynamic> data}) async {
    String route = 'user/record';
    Map<String, dynamic> header = {};
    return await httpPut(
      route: route,
      data: data,
      header: header,
      authRequired: true,
      hasCustomUrl: false,
      successSnacbar: false,
      alertDialog: false,
      context: context,
    );
  }

  Future<Map> updateRecord({
    BuildContext context,
    String recordId,
    Map<String, dynamic> data,
  }) async {
    String route = 'user/record/$recordId';
    Map<String, dynamic> header = {};
    return await httpPost(
      route: route,
      data: data,
      header: header,
      authRequired: true,
      hasCustomUrl: false,
      successSnacbar: false,
      alertDialog: false,
      context: context,
    );
  }

  Future<Map> deleteRecord({BuildContext context, String recordId}) async {
    String route = 'user/record/$recordId';
    Map<String, dynamic> header = {};
    return await httpDelete(
      route: route,
      data: {},
      header: header,
      authRequired: true,
      hasCustomUrl: false,
      successSnacbar: false,
      alertDialog: false,
      context: context,
    );
  }

  Future<Map> addRating(
      {Map<String, dynamic> data, BuildContext context}) async {
    String route = 'user/review';
    Map<String, dynamic> header = {};
    return await httpPut(
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

  Future<Map> getReviews({BuildContext context, String doctorId}) async {
    String route = 'user/review/$doctorId';
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

  Future<Map> likeUnlike({BuildContext context, String doctorId}) async {
    String route = 'user/likeDislike/$doctorId';
    Map<String, dynamic> header = {};
    return await httpPut(
      route: route,
      data: {},
      header: header,
      authRequired: true,
      hasCustomUrl: false,
      successSnacbar: true,
      alertDialog: false,
      context: context,
    );
  }

  Future<Map> getStudents({BuildContext context}) async {
    String route = 'user/students';
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
