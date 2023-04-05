import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../util/app_constants.dart';
import '../Api Services/Dio/dio_client.dart';
import '../Api Services/exception/api_error_handler.dart';
import '../Api Services/responseApi/api_response.dart';

class AuthRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.dioClient, required this.sharedPreferences});

  Future<ApiResponse> login() async {
    try {
      final response =
          await dioClient.post(AppConstants.jwtTokenUri, data: {"UserId": "user001", "Password": "12345678", "Expirhour": 2});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> apiProcess({String? data1}) async {
    try {
      final response = await dioClient.post(
        "dbAsyncRequest",
        data: '"$data1"',
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  // for  user token
  Future<void> saveUserToken(String? token) async {
    dioClient.token = token!;
    dioClient.dio!.options.headers = {'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $token'};

    try {
      await sharedPreferences.setString(AppConstants.TOKEN, token);
    } catch (e) {
      rethrow;
    }
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }

  Future<void> cleanBarearToken() async {
    await sharedPreferences.remove(AppConstants.TOKEN);
  }

  // for  Remember Email
  Future<void> saveUserNumberAndPassword({required String username, required String password}) async {
    try {
      await sharedPreferences.setString(AppConstants.USER_PASSWORD, password);
      await sharedPreferences.setString(AppConstants.USER_EMAIL, username);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  String getUserName() {
    return sharedPreferences.getString(AppConstants.USER_EMAIL) ?? "";
  }

  String getUserPassword() {
    return sharedPreferences.getString(AppConstants.USER_PASSWORD) ?? "";
  }

  Future<bool> clearUserNumberAndPassword() async {
    await sharedPreferences.remove(AppConstants.USER_PASSWORD);
    return await sharedPreferences.remove(AppConstants.USER_EMAIL);
  }

  // Future<ApiResponse> heatStudApi() async {
  //   try {
  //     // final response = await dioClient.get('users/2');
  //     final response = await dioClient.get('student');
  //     return ApiResponse.withSuccess(response);
  //   } catch (e) {
  //     return ApiResponse.withError(ApiErrorHandler.getMessage(e));
  //   }
  // }

  // for menu section
}
