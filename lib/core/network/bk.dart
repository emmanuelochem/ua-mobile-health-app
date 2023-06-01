import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ua_mobile_health/core/network/network_config.dart';
import 'package:ua_mobile_health/core/network/network_interceptor.dart';
import 'package:ua_mobile_health/core/network/network_logger.dart';

class NetworkHandler {
  //Config Url
  String apiUrl = NetworkConfig.baseUrl;

  Future httpGet({
    @required String route,
    Map<String, dynamic> header,
    bool authRequired = true,
    bool hasCustomUrl = false,
  }) async {
    route = hasCustomUrl ? route : apiUrl + route;
    Dio dio = Dio(
      BaseOptions(
        baseUrl: apiUrl,
        connectTimeout: 60000,
        receiveTimeout: 60000,
        responseType: ResponseType.json,
      ),
    )..interceptors.addAll([
        AuthorizationInterceptor(auth: authRequired),
        LoggerInterceptor(),
      ]);
    //try {
    return await dio
        .get(
          route,
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status <= 500;
            },
          ),
        )
        .timeout(const Duration(seconds: 60))
        .then((response) {
      if (response != null) {
        if (response.data["status"] == "success") {
          return response.data;
        } else {
          return response.data["message"];
        }
      }
      return null;
    }).catchError((error) {
      return error.toString();
    });
    // } on DioError catch (err) {
    //   final errorMessage = DioException.fromDioError(err).toString();
    //   throw errorMessage;
    // } catch (e) {
    //   log(e);
    //   throw e.toString();
    // }
  }

  Future httpPost(
      {@required String route,
      Map<String, dynamic> header,
      @required Map<String, dynamic> data,
      bool authRequired = true,
      bool hasCustomUrl = false}) async {
    route = hasCustomUrl ? route : apiUrl + route;
    Dio dio = Dio(
      BaseOptions(
        baseUrl: apiUrl,
        connectTimeout: 60000,
        receiveTimeout: 60000,
        responseType: ResponseType.json,
      ),
    )..interceptors.addAll([
        AuthorizationInterceptor(auth: authRequired),
        LoggerInterceptor(),
      ]);
    String formData = jsonEncode(data);
    //try {
    return await dio
        .post(
          route,
          data: formData,
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status <= 500;
            },
          ),
        )
        .timeout(
          const Duration(seconds: 60),
        )
        .then((response) {
      if (response != null) {
        if (response.data["status"] == "success") {
          return response.data;
        }
        return response.data['message'];
      }
      return null;
    }).catchError((error) {
      return null;
    });
  }

  Future httpPatch(
      {@required String route,
      Map<String, dynamic> header,
      @required Map<String, dynamic> data,
      bool authRequired = true,
      bool hasCustomUrl = false,
      @required BuildContext context}) async {
    route = hasCustomUrl ? route : apiUrl + route;
    Dio dio = Dio(
      BaseOptions(
        baseUrl: apiUrl,
        connectTimeout: 60000,
        receiveTimeout: 60000,
        responseType: ResponseType.json,
      ),
    )..interceptors.addAll([
        AuthorizationInterceptor(auth: authRequired),
        LoggerInterceptor(),
      ]);
    String formData = jsonEncode(data);
    //try {
    return await dio
        .patch(
          route,
          data: formData,
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status <= 500;
            },
          ),
        )
        .timeout(
          const Duration(seconds: 60),
        )
        .then((response) {
      if (response != null) {
        if (response.data["status"] == "success") {
          return response.data;
        }
        return response.data['message'];
      }
      return null;
    }).catchError((error) {
      return error.toString();
    });
    //   return response.data;
    // } on DioError catch (err) {
    //   final errorMessage = DioException.fromDioError(err).toString();
    //   throw errorMessage;
    // } catch (e) {
    //   log(e);
    //   throw e.toString();
    // }
  }

  Future httpDelete(
      {@required String route,
      Map<String, dynamic> header,
      @required Map<String, dynamic> data,
      bool authRequired = true,
      bool hasCustomUrl = false}) async {
    route = hasCustomUrl ? route : apiUrl + route;
    Dio dio = Dio(
      BaseOptions(
        baseUrl: apiUrl,
        connectTimeout: 60000,
        receiveTimeout: 60000,
        responseType: ResponseType.json,
      ),
    )..interceptors.addAll([
        AuthorizationInterceptor(auth: authRequired),
        LoggerInterceptor(),
      ]);
    String formData = jsonEncode(data);
    // try {
    return await dio
        .delete(
          route,
          data: formData,
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status <= 500;
            },
          ),
        )
        .timeout(
          const Duration(seconds: 60),
        )
        .then((response) {
      if (response != null) {
        if (response.data["status"] == "success") {
          return response.data;
        }
        return response.data['message'];
      }

      return null;
    }).catchError((error) {
      return error.toString();
    });
    //   return response.data;
    // } on DioError catch (err) {
    //   final errorMessage = DioException.fromDioError(err).toString();
    //   throw errorMessage;
    // } catch (e) {
    //   log(e);
    //   throw e.toString();
    // }
  }
}
