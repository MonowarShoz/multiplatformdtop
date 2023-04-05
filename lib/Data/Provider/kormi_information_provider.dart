import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:multiplatformdtop/Data/Repository/auth_repo.dart';

import 'package:first_package/first_package.dart';
import '../../util/show_custom_snakbar.dart';
import '../Api Services/responseApi/api_response.dart';
import '../Model/data_access_param.dart';
import '../Model/staff_information_model.dart';

class KormiInformationProvider with ChangeNotifier {
  final AuthRepo? authRepo;

  KormiInformationProvider(
    this.authRepo,
  );

  DataAccessParam? _dataAccessParam;

  DataAccessParam? get dataAccessParam => _dataAccessParam;

  List<StaffInformationModel> _staffInformationModel = [];

  List<StaffInformationModel> get staffInformationModel => _staffInformationModel;
  List<StaffInformationModel> _tempStaffList = [];
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future kormiData(BuildContext context) async {
    _dataAccessParam = null;
    _staffInformationModel = [];
    _tempStaffList = [];
    _isLoading = true;
    //notifyListeners();
    _dataAccessParam = DataAccessParam(
      comCod: "2501",
      procName: "dbo.SP_MICR_REPORT_CODEBOOK_01",
      procID: "STAFFLIST01",
    );
    var encryptedKormiData = CodeUtil.convertToBase64(_dataAccessParam!);
    ApiResponse apiResponse = await authRepo!.apiProcess(data1: encryptedKormiData);
    _isLoading = false;

    if (apiResponse.response != null && (apiResponse.response!.statusCode == 200 || apiResponse.response!.statusCode == 201)) {
      _staffInformationModel = [];
      _tempStaffList = [];
      String decompressedJson = CodeUtil.decompr(apiResponse.response!.data.toString());

      var jsonStaff = jsonDecode(decompressedJson.toString());
      if (jsonStaff.containsKey("ErrorTable")) {
        for (var element in jsonStaff["ErrorTable"]) {
          showInfoBar(context, 'Error', element["errormessage"]);
          // showCustomSnackBar(element["errormessage"], context);
        }
      } else {
        for (var element in jsonStaff['Table']) {
          _staffInformationModel.add(StaffInformationModel.fromJson(element));
        }
      }
      // var jsonStaff = jsonDecode(apiResponse.response!.data);

      _tempStaffList = staffInformationModel;
      // log(json);
    } else {
      if (!context.mounted) return;
      showInfoBar(context, 'Error', 'Failed to Connect to Internet');
    }
    notifyListeners();
  }

  Future<List<StaffInformationModel>> getKormiData(BuildContext context) async {
    _dataAccessParam = null;
    List<StaffInformationModel> staffList = [];
    _tempStaffList = [];
    _isLoading = true;
    _dataAccessParam = DataAccessParam(
      comCod: "2501",
      procName: "dbo.SP_MICR_REPORT_CODEBOOK_01",
      procID: "STAFFLIST01",
    );
    var encryptedKormiData = CodeUtil.convertToBase64(_dataAccessParam!);
    ApiResponse apiResponse = await authRepo!.apiProcess(data1: encryptedKormiData);
    _isLoading = false;
    if (apiResponse.response != null && (apiResponse.response!.statusCode == 200 || apiResponse.response!.statusCode == 201)) {
      staffList = [];
      _tempStaffList = [];
      String decompressedJson = CodeUtil.decompr(apiResponse.response!.data.toString());

      var jsonStaff = jsonDecode(decompressedJson.toString());
      if (jsonStaff.containsKey("ErrorTable")) {
        for (var element in jsonStaff["ErrorTable"]) {
          showInfoBar(context, 'Error', element["errormessage"]);
          // showCustomSnackBar(element["errormessage"], context);
        }
      } else {
        for (var element in jsonStaff['Table']) {
          staffList.add(StaffInformationModel.fromJson(element));
        }
      }
      // var jsonStaff = jsonDecode(apiResponse.response!.data);

      _tempsearchList = staffList;
      // log(json);
    } else {
      showInfoBar(context, 'Error', 'Failed to Connect to Internet');
    }
    notifyListeners();

    return staffList;
  }

  bool isKormiSearch = false;

  List<StaffInformationModel> _tempsearchList = [];
  List<StaffInformationModel> get tempsearchList => _tempsearchList;

  List<StaffInformationModel> searchFutureStaffData(List<StaffInformationModel> searchList, String query) {
    List<StaffInformationModel> tsearchList = searchList
        .where((element) =>
            element.lName!.toLowerCase().contains(query.toLowerCase()) ||
            element.stafid!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return tsearchList;
  }

  searchStaffData(String query) {
    if (query.isEmpty) {
      _staffInformationModel.clear();
      _staffInformationModel = _tempStaffList;

      isKormiSearch = false;
      notifyListeners();
    } else {
      _staffInformationModel = [];
      isKormiSearch = true;
      _tempStaffList.forEach((item) async {
        if ((item.lName!.toLowerCase().contains(query.toLowerCase())) ||
            (item.stafid!.toLowerCase().contains(query.toLowerCase()))) {
          _staffInformationModel.add(item);
        }
      });
      notifyListeners();
    }
  }
}
