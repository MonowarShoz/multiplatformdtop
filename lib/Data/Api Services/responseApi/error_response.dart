import 'package:flutter/cupertino.dart';

/// errors : [{"code":"l_name","message":"The last name field is required."},{"code":"password","message":"The password field is required."}]

class ErrorResponse {
  String? _errors;

  String? get errors => _errors;

  ErrorResponse({String? errors}) {
    _errors = errors!;
  }

  ErrorResponse.fromJson(dynamic json) {
    if (json != null) {
      _errors = '';
      _errors = json;
      debugPrint('test $errors');
    }
  }
}

/// code : "l_name"
/// message : "The last name field is required."
