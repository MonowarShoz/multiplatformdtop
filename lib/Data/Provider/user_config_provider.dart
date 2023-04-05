import 'dart:convert';
import 'dart:developer';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:archive/archive_io.dart';
import 'package:dartx/dartx.dart';

import 'package:crypto/crypto.dart';
import 'package:first_package/first_package.dart';
// import 'package:archive/archive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:multiplatformdtop/Data/Repository/auth_repo.dart';

import '../../helper/date_converter.dart';

import '../../util/html_code.dart';
import '../../util/image_file.dart';
import '../../util/show_custom_snakbar.dart';
import '../Api Services/responseApi/api_response.dart';
import '../Model/adc_info_model.dart';
import '../Model/data_access_param.dart';
import '../Model/group_shomiti_model.dart';
import '../Model/jwt_token_model.dart';
import '../Model/member_info_model.dart';
import '../Model/menu_model.dart';
import '../Model/response_model.dart';
import '../Model/sub_branch_details.dart';
import '../Model/user_info_model.dart';

class UserConfigProvider with ChangeNotifier {
  final AuthRepo authRepo;

  UserConfigProvider({
    required this.authRepo,
  });

  DataAccessParam? _dataAccessParam;
  DataAccessParam? get dataAccessParam => _dataAccessParam;

  JwtTokenInfo? _jwtTokenInfo;
  JwtTokenInfo? get jwtTokenInfo => _jwtTokenInfo;

  UserInfoModel? _userInfoModel;
  UserInfoModel? get userInfoModel => _userInfoModel;

  Future<ResponseModel> login(
    BuildContext context,
  ) async {
    _jwtTokenInfo = null;

    ApiResponse apiResponse = await authRepo!.login();
    ResponseModel responseModel;
    if (apiResponse.response != null && (apiResponse.response!.statusCode == 200 || apiResponse.response!.statusCode == 201)) {
      _jwtTokenInfo = JwtTokenInfo.fromJson(apiResponse.response!.data);

      authRepo!.saveUserToken(_jwtTokenInfo!.tokenstr);
      responseModel = ResponseModel(true, '${apiResponse.response}');
      debugPrint('success');
      //showCustomSnackBar('Success', context, isError: false);
    } else {
      responseModel = ResponseModel(false, '${apiResponse.error}');
      debugPrint('failed');
      //showCustomSnackBar('Success', context, isError: true);
    }
    notifyListeners();
    return responseModel;
  }

  String? _userstring;
  String? get userString => _userstring;

  bool _isLoginSuccess = false;
  bool get isLoginSuccess => _isLoginSuccess;

  bool _isLoginLoad = false;
  bool get isLoginLoad => _isLoginLoad;

  Future<ResponseModel> loginAccess(
    BuildContext context, {
    required String loginName,
    required String password,
  }) async {
    _dataAccessParam = null;
    _userInfoModel = null;
    String jsonDs1 = "";

    _dataAccessParam = DataAccessParam(
      comCod: "2501",
      procName: "dbo.SP_MICR_REPORT_CODEBOOK_01",
      procID: "USERLOGINACT01",
      parmJson1: null,
      parmJson2: null,
      parmBin01: null,
      parm01: "",
      parm02: loginName,
    );
    _isLoginLoad = true;
    var encryptedData = CodeUtil.convertToBase64(_dataAccessParam!);
    ApiResponse apiResponse = await authRepo!.apiProcess(data1: encryptedData);
    _isLoginLoad = false;
    ResponseModel responseModel;
    if (apiResponse.response != null && (apiResponse.response!.statusCode == 200 || apiResponse.response!.statusCode == 201)) {
      _userInfoModel = UserInfoModel();
      log(apiResponse.response!.data.toString());

      String decompressedJson = CodeUtil.decompr(apiResponse.response!.data.toString());

      var jsonResponse = jsonDecode(decompressedJson.toString());
      log(jsonResponse.toString());

      // var jsonResponse = jsonDecode(apiResponse.response!.data);
      for (var element in jsonResponse['Table']) {
        _userInfoModel = UserInfoModel.fromJson(element);
      }
      if (userInfoModel!.stafid != null) {
        var encodedAuthData = CodeUtil.encodedtoMd5Password(userInfoModel!.stafid! + loginName + password);
        var dashString = encodedAuthData.replaceAll('-', '');
        var finalDash = CodeUtil.addDashes(dashString);
        if (userInfoModel!.paswrd != finalDash.toUpperCase()) {
          _isLoginSuccess = false;
        } else {
          _isLoginSuccess = true;
        }
      } else {
        _isLoginSuccess = false;
      }

      responseModel = ResponseModel(true, '${apiResponse.response}');
    } else {
      responseModel = ResponseModel(false, '${apiResponse.error}');
      // showCustomSnackBar('Operation Failed', context, isError: true);
    }

    notifyListeners();
    return responseModel;
  }

//   "ComCod": "2501",
//   "ProcName": "dbo.SP_MICR_REPORT_CODEBOOK_01",
//   "ProcID": "VERSIONCHK01",
  String _versionNumber = '';
  String get versionNumber => _versionNumber;
  Future<ResponseModel> versionChk() async {
    _dataAccessParam = null;
    _dataAccessParam = DataAccessParam(
      comCod: "2501",
      procName: "dbo.SP_MICR_REPORT_CODEBOOK_01",
      procID: "VERSIONCHK01",
    );
    var encryptedverschk = CodeUtil.convertToBase64(_dataAccessParam!);
    ApiResponse apiResponse = await authRepo.apiProcess(data1: encryptedverschk);
    ResponseModel responseModel;
    if (apiResponse.response != null && (apiResponse.response!.statusCode == 200 || apiResponse.response!.statusCode == 201)) {
      String decompressedJson = CodeUtil.decompr(apiResponse.response!.data.toString());

      var jsonverschk = jsonDecode(decompressedJson.toString());
      for (var element in jsonverschk['Table']) {
        _versionNumber = element["app_version"];
      }
      versionNumber.isNotEmpty
          ? responseModel = ResponseModel(true, '${apiResponse.response}')
          : responseModel = ResponseModel(false, '${apiResponse.response}');
    } else {
      responseModel = ResponseModel(false, '${apiResponse.error}');
      // showCustomSnackBar('Version Checking Failed', context, isError: true);
    }
    notifyListeners();
    return responseModel;
  }

  String stripMargin(String s) {
    return s.splitMapJoin(
      RegExp(r'^', multiLine: true),
      onMatch: (_) => '\n',
      onNonMatch: (n) => n.trim(),
    );
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<GroupShomitiModel> _shomitiList = [];
  List<GroupShomitiModel> get shomitiList => _shomitiList;
  List<GroupShomitiModel> _pdfShomitiList = [];
  List<GroupShomitiModel> get pdfshomitiList => _pdfShomitiList;
  List<MemberInfoModel> _memberInfoList = [];
  List<MemberInfoModel> get memberInfoList => _memberInfoList;
  List<GroupShomitiModel> _tempShomitiList = [];
  List<MemberInfoModel> _tempmemberInfoList = [];

  Future groupWiseKormiProvider(BuildContext context, String branchID) async {
    _shomitiList = [];
    _tempShomitiList = [];
    _pdfShomitiList = [];
    _dataAccessParam = null;
    _isLoading = true;
    _dataAccessParam = DataAccessParam(
      comCod: "2501",
      procName: "dbo.SP_MICR_REPORT_CODEBOOK_01",
      procID: "GROUPINFOLIST01",
      parm01: branchID,
    );
    var encryptedgroupData = CodeUtil.convertToBase64(_dataAccessParam!);
    ApiResponse apiResponse = await authRepo.apiProcess(data1: encryptedgroupData);
    _isLoading = false;
    if (apiResponse.response != null && (apiResponse.response!.statusCode == 200 || apiResponse.response!.statusCode == 201)) {
      _shomitiList = [];
      _tempShomitiList = [];
      _pdfShomitiList = [];
      String decompressedJson = CodeUtil.decompr(apiResponse.response!.data.toString());

      var jsonGroup = jsonDecode(decompressedJson.toString());

      for (var element in jsonGroup['Table']) {
        _shomitiList.add(GroupShomitiModel.fromJson(element));
      }
      //_shomitiList.chunkWhile((p0, p1) => p0.kormi == p1.kormi);
      _tempShomitiList = shomitiList;
    } else {
      if (!context.mounted) return;

      showCustomSnackBar('Failed to Load Data', context, isError: true);
    }
    notifyListeners();
  }

  List<SubBranchDetails> _kormiFromBrnch = [];
  List<SubBranchDetails> get kormiFromBrnch => _kormiFromBrnch;

  List<SubBranchDetails> _tempkormiFromBrnch = [];
  List<SubBranchDetails> get tempkormiFromBrnch => _tempkormiFromBrnch;

  List<GroupShomitiModel> _kormiwiseShomiti = [];
  List<GroupShomitiModel> get kormiWiseShomiti => _kormiwiseShomiti;

  List<GroupShomitiModel> _tempkormiwiseShomiti = [];
  List<GroupShomitiModel> get tempkormiWiseShomiti => _tempkormiwiseShomiti;

  //bool isadcSearch = false;

  findkormiFromBranchList(String adcid) {
    _kormiFromBrnch = subBrnchListInfoList.where((element) => element.adcid!.contains(adcid)).toList();
    _tempkormiFromBrnch = kormiFromBrnch;
  }

  searchkormiFromBrnchData(String query) {
    if (query.isEmpty) {
      _kormiFromBrnch.clear();
      _kormiFromBrnch = tempkormiFromBrnch;

      isadcSearch = false;
      notifyListeners();
    } else {
      _kormiFromBrnch = [];
      isadcSearch = true;
      tempkormiFromBrnch.forEach((item) async {
        if ((item.lName!.toLowerCase().contains(query.toLowerCase())) ||
            (item.stafid.toString().toLowerCase().contains(query.toLowerCase()))) {
          _kormiFromBrnch.add(item);
        }
      });
      notifyListeners();
    }
  }

  kormiWiseGroupDetails(String kormiID) {
    _kormiwiseShomiti = shomitiList.where((element) => element.kormi!.contains(kormiID)).toList();
    _tempkormiwiseShomiti = kormiWiseShomiti;
  }

  searchkormiwiseShomitiData(String query) {
    if (query.isEmpty) {
      _kormiwiseShomiti.clear();
      _kormiwiseShomiti = tempkormiWiseShomiti;

      isadcSearch = false;
      notifyListeners();
    } else {
      _kormiwiseShomiti = [];
      isadcSearch = true;
      tempkormiWiseShomiti.forEach((item) async {
        if ((item.lName!.toLowerCase().contains(query.toLowerCase())) || (item.sgName!.contains(query))) {
          _kormiwiseShomiti.add(item);
        }
      });
      notifyListeners();
    }
  }

  searchShomitiData(String query) {
    if (query.isEmpty) {
      _shomitiList.clear();
      _shomitiList = _tempShomitiList;

      isadcSearch = false;
      notifyListeners();
    } else {
      _shomitiList = [];
      isadcSearch = true;
      _tempShomitiList.forEach((item) async {
        if ((item.lName!.toLowerCase().contains(query.toLowerCase())) ||
            (item.kormi!.contains(query)) ||
            (item.sgName!.contains(query)) ||
            (item.sgGroup.toString().toLowerCase().contains(query.toLowerCase()))) {
          _shomitiList.add(item);
        }
      });
      notifyListeners();
    }
  }

  Future groupMemberProvider(BuildContext context, String branchID, String groupID) async {
    _dataAccessParam = null;
    _memberInfoList = [];
    _tempmemberInfoList = [];
    _isLoading = true;
    _dataAccessParam = DataAccessParam(
      comCod: "2501",
      procName: "dbo.SP_MICR_REPORT_CODEBOOK_01",
      procID: "MEMBERINFOLIST01",
      parm01: branchID,
      parm02: groupID,
    );
    var encryptedgroupMemberData = CodeUtil.convertToBase64(_dataAccessParam!);
    ApiResponse apiResponse = await authRepo.apiProcess(data1: encryptedgroupMemberData);
    _isLoading = false;
    if (apiResponse.response != null && (apiResponse.response!.statusCode == 200 || apiResponse.response!.statusCode == 201)) {
      _memberInfoList = [];
      _tempmemberInfoList = [];
      String decompressedJson = CodeUtil.decompr(apiResponse.response!.data.toString());

      var jsonGroup = jsonDecode(decompressedJson.toString());
      //var jsonGroup = jsonDecode(apiResponse.response!.data);
      for (var element in jsonGroup['Table']) {
        _memberInfoList.add(MemberInfoModel.fromJson(element));
      }
      _tempmemberInfoList = memberInfoList;
    } else {
      showCustomSnackBar('Failed to Load Data', context, isError: true);
    }
  }

  searchMembershomiti(String query) {
    if (query.isEmpty) {
      _memberInfoList.clear();
      _memberInfoList = _tempmemberInfoList;

      isadcSearch = false;
      notifyListeners();
    } else {
      _memberInfoList = [];
      isadcSearch = true;
      _tempmemberInfoList.forEach((item) async {
        if ((item.smNameE.toString().toLowerCase().contains(query.toLowerCase())) || (item.smName!.contains(query))) {
          _memberInfoList.add(item);
        }
      });
      notifyListeners();
    }
  }

  clearInfo() {
    _kormiFromBrnch.clear();
    _shomitiList.clear();
    _selectAdcforGwkL = '';
    _selectAdcIdforBrnch = '';
    _getbrnchName = '';
    adcValuegrm = '';
  }

  bool _isHideContainer = false;
  bool get isHideContainer => _isHideContainer;
  hideContainer() {
    _isHideContainer = !_isHideContainer;
    notifyListeners();
  }

  nohideContainer() {
    _isHideContainer = false;
    notifyListeners();
  }

  String _selectAdcforGwkL = '';
  String get selectAdcforGwkL => _selectAdcforGwkL;
  setAdcForGwkl(String selval) {
    _selectAdcforGwkL = selval;
    notifyListeners();
  }
  // String setautoAdcValue(){

  // }

  String _selectAdcIdforBrnch = '';
  String get selectAdcIdforBrnch => _selectAdcIdforBrnch;
  getAdcforBrnch(String selval) {
    _selectAdcIdforBrnch = selval;
    notifyListeners();
  }

  String _getbrnchName = '';
  String get getbrnchName => _getbrnchName;
  clearName() {
    _getbrnchName = '';
    notifyListeners();
  }

  String _getbrnchID = '';
  String get getbrnchID => _getbrnchID;
  getbrnchIdfogGrpMemList({
    String? selval,
  }) {
    _getbrnchName = selval ?? '';

    notifyListeners();
  }

  String? adcValuegrm;

  getbrnchIDforMember({
    String? gID,
  }) {
    _getbrnchID = gID ?? '';

    notifyListeners();
  }

  devAreaVal(String id) {
    for (var element in adcList) {
      if (element.adcid!.substring(0, 6) == id.substring(0, 6)) {
        adcValuegrm = element.aName!;
        print('val$adcValuegrm');
      }
    }
    notifyListeners();
  }

  String? _getKormiName;
  String? get kormiName => _getKormiName;

  clearKormiName() {
    _getKormiName = '';
    notifyListeners();
  }

  getdrpKormiName(String? val) {
    _getKormiName = val;
    notifyListeners();
  }

  // List<ThanaModel> _thanaList = [];
  // List<ThanaModel> get thanaList => _thanaList;
  // List<ThanaModel> _tempthanaList = [];
  // List<ThanaModel> get tempthanaList => _tempthanaList;

  // List<ThanaModel> _divThList = [];
  // List<ThanaModel> get divThList => _divThList;

  // List<ThanaModel> _distList = [];
  // List<ThanaModel> get districtList => _distList;

  // Future areaInformationProvider(BuildContext context) async {
  //   _dataAccessParam = null;
  //   _divThList = [];

  //   _thanaList = [];
  //   _isLoading = true;
  //   //notifyListeners();
  //   _dataAccessParam = DataAccessParam(
  //     comCod: "2501",
  //     procName: "dbo.SP_MICR_REPORT_CODEBOOK_01",
  //     procID: "AREAINFOLIST01",
  //   );
  //   var encryptedADCData = CodeUtil.convertToBase64(_dataAccessParam!);
  //   ApiResponse apiResponse = await authRepo!.apiProcess(data1: encryptedADCData);
  //   _isLoading = false;

  //   if (apiResponse.response != null && (apiResponse.response!.statusCode == 200 || apiResponse.response!.statusCode == 201)) {
  //     _thanaList = [];
  //     _divThList = [];
  //     String decompressedJson = CodeUtil.decompress(apiResponse.response!.data.toString());

  //     var jsonAdc = jsonDecode(decompressedJson.toString());

  //     for (var element in jsonAdc['Table']) {
  //       _thanaList.add(ThanaModel.fromJson(element));
  //     }
  //     _tempthanaList = thanaList;
  //     _divThList = thanaList.distinctBy((element) => element.aDivid).toList();
  //     _distList = thanaList.distinctBy((element) => element.aDistrict).toList();
  //     // log(json);
  //   } else {
  //     if (!context.mounted) return;
  //     showCustomSnackBar('Failed to Load Data', context, isError: true);
  //   }
  //   notifyListeners();
  // }

  // List<ThanaModel> distListGen(String id) {
  //   var distList = [];
  //   distList = thanaList.where((element) => element.aDivid == id).toList();

  //   return [...distList];
  // }

  String _selectedDiv = '';
  String get selectedDiv => _selectedDiv;
  setdiv(String divid) {
    _selectedDiv = divid;
    notifyListeners();
  }

  clearText() {
    _selectedDiv = '';
    //notifyListeners();
  }

  // filterDivision(String query) {
  //   if (query.isEmpty) {
  //     _thanaList.clear();
  //     _thanaList = _tempthanaList;

  //     isadcSearch = false;
  //     notifyListeners();
  //   } else {
  //     _thanaList = [];
  //     isadcSearch = true;
  //     _tempthanaList.forEach((item) async {
  //       if (item.aDivid!.substring(0, 2) == query) {
  //         _thanaList.add(item);
  //       }
  //     });
  //     notifyListeners();
  //   }
  // }

  // filterDistrict(String query) {
  //   if (query.isEmpty) {
  //     _thanaList.clear();
  //     _thanaList = tempthanaList;

  //     isadcSearch = false;
  //     notifyListeners();
  //   } else {
  //     _thanaList = [];
  //     isadcSearch = true;
  //     tempthanaList.forEach((item) async {
  //       if (item.aDivid!.substring(0, 2) == query) {
  //         _thanaList.add(item);
  //       }
  //     });
  //     notifyListeners();
  //   }
  // }

  // List<UnionModel> _unionList = [];
  // List<UnionModel> get unionList => _unionList;

  // List<UnionModel> _onlyunionList = [];
  // List<UnionModel> get onlyunionList => _onlyunionList;

  // List<UnionModel> _tempOnlyUnion = [];
  // List<UnionModel> get temponlyUnion => _tempOnlyUnion;

  bool isUnionTile = false;
  bool isSubBranch = false;
  // bool get isUnionTile => _isUnionTile;

  int ourIndex = -1;
  int brIndex = -1;

  selectUnionExpand({required int index}) {
    ourIndex = index;
    if (ourIndex == index) {
      isUnionTile = !isUnionTile;
      notifyListeners();
    }
  }

  selectsubBranchBank({required int index}) {
    brIndex = index;
    if (brIndex == index) {
      isSubBranch = !isSubBranch;
      notifyListeners();
    }
  }

  // Future unionVillageInfoProvider({required String thanaID}) async {
  //   _dataAccessParam = null;
  //   _unionList = [];
  //   _onlyunionList = [];
  //   _tempOnlyUnion = [];
  //   _isLoading = true;
  //   //notifyListeners();
  //   _dataAccessParam = DataAccessParam(
  //     comCod: "2501",
  //     procName: "dbo.SP_MICR_REPORT_CODEBOOK_01",
  //     procID: "UNIONVILLINFLIST01",
  //     parm01: thanaID,
  //   );
  //   var encryptedADCData = CodeUtil.convertToBase64(_dataAccessParam!);
  //   ApiResponse apiResponse = await authRepo!.apiProcess(data1: encryptedADCData);
  //   _isLoading = false;

  //   if (apiResponse.response != null && (apiResponse.response!.statusCode == 200 || apiResponse.response!.statusCode == 201)) {
  //     _unionList = [];
  //     _onlyunionList = [];
  //     _tempOnlyUnion = [];
  //     String decompressedJson = CodeUtil.decompress(apiResponse.response!.data.toString());

  //     var jsonAdc = jsonDecode(decompressedJson.toString());

  //     for (var element in jsonAdc['Table']) {
  //       _unionList.add(UnionModel.fromJson(element));
  //     }
  //     _onlyunionList = unionList.where((element) => element.uvcode!.endsWith("00")).toList();
  //     _tempOnlyUnion = onlyunionList;
  //     //_tempthanaList = thanaList;
  //     // log(json);
  //   }
  //   notifyListeners();
  // }

  // List<UnionModel> villageInfoList(String unionId) {
  //   var unionsList = unionList
  //       .where((element) => element.uvcode!.substring(0, 2) == unionId.substring(0, 2) && !element.uvcode!.endsWith('000'))
  //       .toList();
  //   return [...unionsList];
  // }

  // searchunion(String query) {
  //   if (query.isEmpty) {
  //     _onlyunionList.clear();
  //     _onlyunionList = temponlyUnion;

  //     isadcSearch = false;
  //     notifyListeners();
  //   } else {
  //     _onlyunionList = [];
  //     isadcSearch = true;
  //     temponlyUnion.forEach((item) async {
  //       if ((item.uvname!.toLowerCase().contains(query.toLowerCase())) ||
  //           (item.uvnamb!.contains(query)) ||
  //           (item.uvcode!.toLowerCase().contains(query.toLowerCase()))) {
  //         _onlyunionList.add(item);
  //       }
  //     });
  //     notifyListeners();
  //   }
  // }

  // List<UnionModel> pdfVillageInfoList(String unionId) {
  //   var unionsList = unionList.where((element) => element.uvcode!.substring(0, 2) == unionId.substring(0, 2)).toList();
  //   return [...unionsList];
  // }

  List<AdcModel> _adcList = [];
  List<AdcModel> get adcList => _adcList;

  List<AdcModel> _adcBranchList = [];
  List<AdcModel> get adcBranchList => _adcBranchList;

  List<SubBranchDetails> _subBrnchListInfoList = [];
  List<SubBranchDetails> get subBrnchListInfoList => _subBrnchListInfoList;

  List<AdcModel> _tempAdcList = [];
  List<AdcModel> get tempAdcList => _tempAdcList;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future adcInformationProvider(BuildContext context, String dbVersionNumber) async {
    _dataAccessParam = null;

    _adcList = [];
    _adcBranchList = [];
    _subBrnchListInfoList = [];
    _isLoading = true;
    //notifyListeners();
    _dataAccessParam = DataAccessParam(
      comCod: "2501",
      procName: "dbo.SP_MICR_REPORT_CODEBOOK_01",
      procID: "ADCINFOLIST01",
      parm01: "%",
      parm02: dbVersionNumber,
      //parm02: "230116.1",
      //parm02: "230130.1",
    );
    var encryptedADCData = CodeUtil.convertToBase64(_dataAccessParam!);
    ApiResponse apiResponse = await authRepo.apiProcess(data1: encryptedADCData);
    _isLoading = false;

    if (apiResponse.response != null && (apiResponse.response!.statusCode == 200 || apiResponse.response!.statusCode == 201)) {
      _adcList = [];
      _adcBranchList = [];
      _subBrnchListInfoList = [];
      String decompressedJson = CodeUtil.decompr(apiResponse.response!.data.toString());

      Map<String, dynamic> jsonAdc = jsonDecode(decompressedJson.toString());
      if (jsonAdc.containsKey("ErrorTable")) {
        for (var element in jsonAdc["ErrorTable"]) {
          _errorMessage = element["errormessage"];
          // if (!context.mounted) return;

          showCustomSnackBar(errorMessage!, context);
        }
      } else {
        for (var element in jsonAdc['Table']) {
          _adcList.add(AdcModel.fromJson(element));
        }
        for (var element in jsonAdc['Table1']) {
          _adcBranchList.add(AdcModel.fromJson(element));
        }
        for (var element in jsonAdc['Table2']) {
          _subBrnchListInfoList.add(SubBranchDetails.fromJson(element));
        }
        _tempAdcList = adcList;
      }

      //var tmpBranch = _adcBranchList.where((item) => ).toList();

      // log(json);
    } else {
      if (!context.mounted) return;

      showCustomSnackBar('Failed to load data', context, isError: true);
    }
    notifyListeners();
  }

  bool isadcSearch = false;
  //Search ADC Data
  searchAdcData(String query) {
    if (query.isEmpty) {
      _adcList.clear();
      _adcList = tempAdcList;

      isadcSearch = false;
      notifyListeners();
    } else {
      _adcList = [];
      isadcSearch = true;
      tempAdcList.forEach((item) async {
        if ((item.adcid!.toLowerCase().contains(query.toLowerCase())) ||
            (item.aName!.toLowerCase().contains(query.toLowerCase())) ||
            (item.aThana!.toLowerCase().contains(query.toLowerCase()))) {
          _adcList.add(item);
        }
      });
      notifyListeners();
    }
  }

  // List<BankInformation> _allBankList = [];
  // List<BankInformation> get bankList => _allBankList;

  // List<BankInformation> _mainHeadbankList = [];
  // List<BankInformation> get mainHeadBankList => _mainHeadbankList;

  // List<BankInformation> _subHeadBankList = [];
  // List<BankInformation> get bankBranchList => _subHeadBankList;

  // List<BankInformation> _tempBank = [];

  // Future bankListInfoProvider(BuildContext context) async {
  //   _dataAccessParam = null;
  //   _allBankList = [];
  //   _mainHeadbankList = [];
  //   _tempBank = [];

  //   _isLoading = true;
  //   //notifyListeners();
  //   _dataAccessParam = DataAccessParam(
  //     comCod: "2501",
  //     procName: "dbo.SP_MICR_REPORT_ACCOUNTS_01",
  //     procID: "BANKNAMELIST01",
  //   );
  //   var encryptedADCData = CodeUtil.convertToBase64(_dataAccessParam!);
  //   ApiResponse apiResponse = await authRepo!.apiProcess(data1: encryptedADCData);
  //   _isLoading = false;

  //   if (apiResponse.response != null && (apiResponse.response!.statusCode == 200 || apiResponse.response!.statusCode == 201)) {
  //     _allBankList = [];
  //     _mainHeadbankList = [];
  //     _tempBank = [];
  //     String decompressedJson = CodeUtil.decompress(apiResponse.response!.data.toString());

  //     var jsonAdc = jsonDecode(decompressedJson.toString());

  //     for (var element in jsonAdc['Table']) {
  //       _allBankList.add(BankInformation.fromJson(element));
  //     }
  //     _mainHeadbankList = _allBankList.where((element) => element.bankid!.endsWith('000')).toList();
  //     // _subHeadBankList =
  //     _tempBank = mainHeadBankList;
  //     // log(json);
  //   } else {
  //     if (!context.mounted) return;
  //     showCustomSnackBar('Failed to load data', context, isError: true);
  //   }
  //   notifyListeners();
  // }

  // List<ChofAccTypeModel> _chartOfAaccTypeList = [];
  // List<ChofAccTypeModel> get chartOfAccTypeList => _chartOfAaccTypeList;

  // List<ChofAccModel> _chartOfAaccList = [];
  // List<ChofAccModel> get chartOfAccList => _chartOfAaccList;

  // List<ChofAccModel> _tempchartOfAaccList = [];
  // List<ChofAccModel> get tempchartOfAaccList => _tempchartOfAaccList;

  // Future chartsOfAccountsProvider(BuildContext context) async {
  //   _dataAccessParam = null;
  //   _chartOfAaccTypeList = [];
  //   _chartOfAaccList = [];
  //   _isLoading = true;
  //   //notifyListeners();
  //   _dataAccessParam = DataAccessParam(
  //     comCod: "2501",
  //     procName: "dbo.SP_MICR_REPORT_CODEBOOK_01",
  //     procID: "CHARTOFACCLIST01",
  //   );
  //   var encryptedADCData = CodeUtil.convertToBase64(_dataAccessParam!);
  //   ApiResponse apiResponse = await authRepo!.apiProcess(data1: encryptedADCData);
  //   _isLoading = false;

  //   if (apiResponse.response != null && (apiResponse.response!.statusCode == 200 || apiResponse.response!.statusCode == 201)) {
  //     _chartOfAaccTypeList = [];
  //     _chartOfAaccList = [];
  //     String decompressedJson = CodeUtil.decompress(apiResponse.response!.data.toString());

  //     var jsonAdc = jsonDecode(decompressedJson.toString());

  //     for (var element in jsonAdc['Table']) {
  //       _chartOfAaccTypeList.add(ChofAccTypeModel.fromJson(element));
  //     }
  //     for (var element in jsonAdc['Table1']) {
  //       _chartOfAaccList.add(ChofAccModel.fromJson(element));
  //     }
  //     _tempchartOfAaccList = chartOfAccList;

  //     // log(json);
  //   } else {
  //     if (!context.mounted) return;
  //     showCustomSnackBar('Failed to load data', context, isError: true);
  //   }
  //   notifyListeners();
  // }

  // //chart of accounts search
  // searchChartofAccount(String query) {
  //   if (query.isEmpty) {
  //     _chartOfAaccList.clear();
  //     _chartOfAaccList = tempchartOfAaccList;
  //     isadcSearch = false;

  //     notifyListeners();
  //   } else {
  //     _chartOfAaccList = [];
  //     isadcSearch = true;
  //     for (var element in tempchartOfAaccList) {
  //       if (element.acctitle!.toLowerCase().contains(query.toLowerCase()) ||
  //           element.acctype!.toLowerCase().contains(query.toLowerCase())) {
  //         _chartOfAaccList.add(element);
  //       }
  //     }
  //   }
  //   notifyListeners();
  // }

  // int chIndex = -1;
  // bool isMainchOAc = false;

  // selectChOfAccnt({required int index}) {
  //   chIndex = index;
  //   if (chIndex == index) {
  //     isMainchOAc = !isMainchOAc;
  //     notifyListeners();
  //   }
  // }

  // List<BankInformation> banksubBranchList(String id) {
  //   var bankList = [];
  //   bankList = _allBankList
  //       .where((element) =>
  //           element.bankid!.substring(0, 3) == id.substring(0, 3) &&
  //           element.bankid!.endsWith('00') &&
  //           !element.bankid!.endsWith('000'))
  //       .toList();
  //   return [...bankList];
  // }

  // List<BankInformation> banksubBranchAccountsList(String id) {
  //   var bankList = [];
  //   bankList = _allBankList
  //       .where((element) => element.bankid!.substring(0, 6) == id.substring(0, 6) && !element.bankid!.endsWith('00'))
  //       .toList();
  //   return [...bankList];
  // }

  // List<ChofAccModel> chartOfaccList(
  //   String accType,
  // ) {
  //   var bankList = [];

  //   bankList = chartOfAccList.where((element) => element.acctype!.trim() == accType.trim()).toList();

  //   return [...bankList];
  // }

  // List<ChofAccModel> cdetOfaccList(
  //   String id,
  // ) {
  //   var bankList = [];

  //   bankList = chartOfAccList
  //       .where((element) =>
  //           element.accid!.substring(0, 3) == id && element.accid!.endsWith('000') && !element.accid!.endsWith('000000'))
  //       .toList();

  //   return [...bankList];
  // }

  // List<ChofAccModel> subchoAcList(
  //   String accID,
  // ) {
  //   var bankList = [];

  //   bankList = chartOfAccList
  //       .where(
  //           (element) => element.accid!.substring(0, 5).trim() == accID.substring(0, 5).trim() && !element.accid!.endsWith('000'))
  //       .toList();

  //   return [...bankList];
  // }

//-------------------------------PDF GENERATOR METHODS--------------------------------------/
//   String? simpleMethod() {
//     String? sampleString;
//     var a = """<tr>
// <td>Hello</td><td>World</td>
// </tr>""";
//     for (var i = 0; i < thanaList.length; i++) {
//       log('simple $a');
//       sampleString = a;
//     }
//     return sampleString;
//   }

  String adchtmlGenerator({
    required String sl,
    required String param1,
    required String param2,
    String? param3,
    required String? param4,
  }) {
    return '''<tr style="height:50px">
<td style="border:1px solid black;text-align:center">$sl.</td>
<td style="border:1px solid black;">$param1&nbsp$param2</td>
<td style="border:1px solid black;padding-left:10px">$param3</td>
<td style="border:1px solid black;">$param4</td>
</tr>''';
  }

  String? adcTable() {
    var headerString = '''${HtmlCode.headerStyle}
</head><h2 align="center">Proshika Manobik Unnayan Kendra</h2><table style="width:100%;border:none;background:none;border-collapse:collapse;"><h2 style="text-align:center;">ADC Information List</h2><tr style="height:50px">
<th style="border:1px solid black;background-color:#C0C0C0;width:10%">#Sl.</th>
<th style="border:1px solid black;background-color:#C0C0C0;text-align:left;padding-left: 10px">ADC/Branch Name</th>

<th style="border:1px solid black;background-color:#C0C0C0">Bangla Name</th>
<th style="border:1px solid black;background-color:#C0C0C0">Thana Name</th>
</tr>''';
    String multiStr = '';
    for (var i = 0; i < adcList.length; i++) {
      multiStr += adchtmlGenerator(
        sl: (i + 1).toString(),
        param1: adcList[i].adcid!,
        param2: adcList[i].aName!,
        param3: adcList[i].aNamb ?? '',
        param4: adcList[i].thname,
      );
    }
    String endTag = '''
<tfoot>
        <tr>
          <th colspan="8" style="font-weight: normal;padding-top: 20px; text-align:right; font-size: 8px;">Generated by ${userInfoModel!.lName},USER ID:${userInfoModel!.stafid},date:${DateConverter.formatDate(DateTime.now())} </th>
        </tr>
      </tfoot>
 
  
</table></html>''';

    // String? sampleString;

    return (headerString + multiStr + endTag);
  }

//   String htmlGenerator({
//     required String sl,
//     required String kormiID,
//     required String kormiName,
//     String? kormiNameB,
//     required String? gender,
//   }) {
//     return '''<tr style="height:50px">
// <td style="border:1px solid black;">$sl</td>
// <td style="border:1px solid black;width:30px">$kormiID</td>
// <td style="border:1px solid black;padding-left: 10px">$kormiName</td>
// <td style="border:1px solid black;padding-left: 10px">$kormiNameB</td>
// <td style="border:1px solid black;width:30px;padding-left: 10px">$gender</td>
// </tr>''';
//   }

//   String? staffTable() {
//     var headerString = '''${HtmlCode.headerStyle}
// </head><h2 align="center">Proshika Manobik Unnayan Kendra</h2><table style="width:auto;border:none;background:none;border-collapse:collapse;"><h2 style="text-align:center;">Kormi Information List</h2><tr>
// <th style="border:1px solid black;">#sl</th>
// <th style="border:1px solid black;width:14%;text-align:left;padding-left: 10px">Kormi ID</th>
// <th style="border:1px solid black;text-align:left;padding-left: 10px">Kormi Name</th>
// <th style="border:1px solid black;text-align:left;padding-left: 10px">Kormi Name(Bangla)</th>
// <th style="border:1px solid black;">gender</th>
// </tr>''';
//     String multiStr = '';
//     for (var i = 0; i < staffInformationModel.length; i++) {
//       multiStr += htmlGenerator(
//         sl: (i + 1).toString(),
//         kormiID: staffInformationModel[i].stafid!,
//         kormiName: staffInformationModel[i].lName!,
//         kormiNameB: staffInformationModel[i].lNameB ?? '',
//         gender: staffInformationModel[i].gender,
//       );
//     }
//     String endTag = '''<tfoot>
//      <tr style="font-size:10">
//      <td></td>
//      <td >Generated by ${userInfoModel!.lName},user ID:${userInfoModel!.stafid},date:${DateConverter.formatDate(DateTime.now())} </td></tr>
//   </tfoot></table></html>''';

//     // String? sampleString;

//     return (headerString + multiStr + endTag);
//   }

//   String unionhtmlGenerator({
//     required String sl,
//     required String param1,
//     required String param2,
//     String? param3,
//     required String? param4,
//     String? param5,
//   }) {
//     return '''<tr style="height:50px;">
// <td style="border:1px solid black;padding-left: 20px">$sl</td>
// ${boldCond(param1, param2)}
// <td style="border:1px solid black;padding-left: 20px">$param3</td>
// <td style="border:1px solid black;">$param4</td>
// <td style="border:1px solid black;">$param5</td>
// </tr>''';
//   }

//   String boldCond(String param1, String param2) {
//     return param1.endsWith('00')
//         ? '''<td style="border:1px solid black;font-weight:bold;padding-left: 10px">$param1&nbsp$param2</td>'''
//         : '''<td style="border:1px solid black;padding-left: 10px;">$param1&nbsp$param2</td>''';
//   }

//   String? unionVillagePdf(String district, String upThana) {
//     var headerString = '''${HtmlCode.headerStyle}
// </head><h2 align="center">Proshika Manobik Unnayan Kendra</h2>
// <table style="width:100%;border:none;background:none;border-collapse:collapse;">
// <h2 style="text-align:center;">Union and Village List</h2>
// <p align="center">District:$district, Upazila/Thana:$upThana</p>

// <tr style="height:50px">
// <th style="border:1px solid black;background-color:#C0C0C0;width:10%;">#Sl</th>
// <th style="border:1px solid black;background-color:#C0C0C0;text-align:left;padding-left: 10px">Union and Village Name</th>
// <th style="border:1px solid black;background-color:#C0C0C0;padding-left: 10px">Union and Village</th>

// <th style="border:1px solid black;background-color:#C0C0C0">Latitude</th>
// <th style="border:1px solid black;background-color:#C0C0C0">Longitude</th>

// </tr>''';
//     String multiStr = '';
//     for (var i = 0; i < unionList.length; i++) {
//       multiStr += unionhtmlGenerator(
//         sl: (i + 1).toString(),
//         param1: '${unionList[i].uvcode}',
//         param2: unionList[i].uvname!,
//         param3: unionList[i].uvnamb,
//         param4: unionList[i].geoLat.toString(),
//         param5: unionList[i].geoLong.toString(),
//       );
//     }
//     String endTag = '''
//   <tfoot >

//       <tr style="font-size:10">
//       <td>''</td>
//       <td style="padding-top: 40px">Generated by ${userInfoModel!.lName},user ID:${userInfoModel!.stafid},date:${DateConverter.formatDate(DateTime.now())} </td></tr>

//   </tfoot>

// </table></html>''';

//     // String? sampleString;

//     return (headerString + multiStr + endTag);
//   }

//   String shomitinameGen({
//     required String sl,
//     required String param1,
//     required String param2,
//     String? param3,
//     String? param8,
//     String? kormiName,
//     required String? param4,
//     String? param5,
//     String? param6,
//     String? param7,
//   }) {
//     return '''<tr style="height:50px;">
// <td style="border:1px solid black;padding-left: 30px">$sl</td>
// <td style="border:1px solid black;padding-left: 30px">$param1</td>
// <td style="border:1px solid black;padding-left: 30px">$param2</td>
// <td style="border:1px solid black;padding-left: 30px">$param3</td>
// <td style="border:1px solid black;padding-left: 20px">$param4</td>
// <td style="border:1px solid black;padding-left: 30px">$param5</td>
// <td style="border:1px solid black;">$param6</td>
// <td style="border:1px solid black;">$param7</td>
// </tr>''';
//   }

//   String? kormiwisegrpLstPdf(String adc, String branch, String kormiID, String kormiName) {
//     var headerString = '''${HtmlCode.headerStyle}
// </head><h2 align="center">Proshika Manobik Unnayan Kendra</h2>
// <table style="width:1000px;border:none;background:none;border-collapse:collapse;">
// <h2 style="text-align:center;">Kormi Wise Group List</h2>
// <p align="center">ADC:$adc, Branch Name:$branch</p>
// <p align="center">Kormi No:$kormiID, Kormi Name:$kormiName</p>

// <tr style="height:50px">
// <th style="border:1px solid black;background-color:#C0C0C0;">#Sl</th>
// <th style="border:1px solid black;background-color:#C0C0C0;width:1px;">Grp.ID</th>
// <th style="border:1px solid black;background-color:#C0C0C0;width:200px;padding-right:200px">Group Name</th>

// <th style="border:1px solid black;background-color:#C0C0C0">gender</th>
// <th style="border:1px solid black;background-color:#C0C0C0">M.Qty</th>
// <th style="border:1px solid black;background-color:#C0C0C0">Met.day</th>
// <th style="border:1px solid black;background-color:#C0C0C0">Deposit</th>
// <th style="border:1px solid black;background-color:#C0C0C0">Withdraw</th>

// </tr>''';
//     String multiStr = '';
//     for (var i = 0; i < kormiWiseShomiti.length; i++) {
//       multiStr += shomitinameGen(
//         sl: (i + 1).toString(),
//         kormiName: kormiWiseShomiti[i].lName,
//         param1: '${kormiWiseShomiti[i].sgGroup}',
//         param2: kormiWiseShomiti[i].sgName!,
//         param3: kormiWiseShomiti[i].gender,
//         param4: kormiWiseShomiti[i].sgMember.toString(),
//         param5: kormiWiseShomiti[i].meetday.toString(),
//         param6: kormiWiseShomiti[i].sgDeposit.toString(),
//         param7: kormiWiseShomiti[i].sgWithdra.toString(),
//       );
//     }
//     String endTag = '''
//   <tfoot >

//       <tr style="font-size:10">
//       <td>''</td>
//       <td style="padding-top: 40px">Generated by ${userInfoModel!.lName},user ID:${userInfoModel!.stafid},date:${DateConverter.formatDate(DateTime.now())} </td></tr>

//   </tfoot>

// </table></html>''';

//     // String? sampleString;

//     return (headerString + multiStr + endTag);
//   }

  bool _isPdf = false;
  bool get isPdf => _isPdf;
  pdfset(bool pdfcond) {
    _isPdf = pdfcond;
    notifyListeners();
  }

  List<AdcModel> findADCwiseBranch(String madcid) {
    List findBrnchList = adcBranchList.where((element) => element.madcid!.contains(madcid)).toList();
    return [...findBrnchList];
  }

  List<SubBranchDetails> findBrancwiseDetails(String adcid) {
    List findBrnchList = [];
    findBrnchList = subBrnchListInfoList.where((element) => element.adcid!.contains(adcid)).toList();
    return [...findBrnchList];
  }

  // searchStaffData(String query) {
  //   if (query.isEmpty) {
  //     _staffInformationModel.clear();
  //     _staffInformationModel = _tempStaffList;

  //     isadcSearch = false;
  //     notifyListeners();
  //   } else {
  //     _staffInformationModel = [];
  //     isadcSearch = true;
  //     _tempStaffList.forEach((item) async {
  //       if ((item.lName!.toLowerCase().contains(query.toLowerCase())) ||
  //           (item.stafid!.toLowerCase().contains(query.toLowerCase()))) {
  //         _staffInformationModel.add(item);
  //       }
  //     });
  //     notifyListeners();
  //   }
  // }

  // searchThAreaData(String query) {
  //   if (query.isEmpty) {
  //     _thanaList.clear();
  //     _thanaList = _tempthanaList;

  //     isadcSearch = false;
  //     notifyListeners();
  //   } else {
  //     _thanaList = [];
  //     isadcSearch = true;
  //     _tempthanaList.forEach((item) async {
  //       if ((item.thname!.toLowerCase().contains(query.toLowerCase())) ||
  //           (item.divname!.toLowerCase().contains(query.toLowerCase())) ||
  //           (item.distname!.toLowerCase().contains(query.toLowerCase())) ||
  //           (item.aDivid!.toLowerCase().contains(query.toLowerCase()))) {
  //         _thanaList.add(item);
  //       }
  //     });
  //     notifyListeners();
  //   }
  // }

  // searchBank(String query) {
  //   if (query.isEmpty) {
  //     _mainHeadbankList.clear();
  //     _mainHeadbankList = _tempBank;

  //     isadcSearch = false;
  //     notifyListeners();
  //   } else {
  //     _mainHeadbankList = [];
  //     isadcSearch = true;
  //     _tempBank.forEach(
  //       (element) async {
  //         if ((element.bankname!.toLowerCase().contains(query.toLowerCase())) ||
  //             (element.bankname!.toLowerCase().contains(query.toLowerCase()))) {
  //           _mainHeadbankList.add(element);
  //         }
  //       },
  //     );
  //     notifyListeners();
  //   }
  // }

  bool _isAdcSearchEnable = false;
  bool get isAdcSearch => _isAdcSearchEnable;
  setSearch() {
    _isAdcSearchEnable = !_isAdcSearchEnable;
    notifyListeners();
  }

  unsetSearch() {
    _isAdcSearchEnable = false;
    notifyListeners();
  }

  bool ismemberTable = false;
  showMemberTableView() {
    ismemberTable = !ismemberTable;
    notifyListeners();
  }

  final List<MenuModel> _menuList = [
    MenuModel(
      menuName: 'General Reports',
      icon: Images.reportImg,
      color: const Color.fromARGB(255, 128, 130, 222),
      //routeName: const MisReports(),
    ),
    MenuModel(
      menuName: 'Saving Reports',
      color: const Color.fromARGB(255, 142, 220, 145),
      icon: Images.newsavingrp,
      // routeName: const PssReportsScreen(),
    ),
    MenuModel(
      menuName: 'Loan Reports',
      icon: Images.loanImg,
      color: const Color.fromARGB(255, 217, 223, 90),
      //routeName: LoanReportScreen(),
    ),
    MenuModel(
      menuName: 'Accounting Reports',
      icon: Images.accountingImg,
      color: const Color.fromARGB(255, 75, 195, 187),
    ),
    MenuModel(
      menuName: 'MIS Reports',
      icon: Images.misReportImg,
      color: const Color.fromARGB(255, 144, 170, 221),
      //routeName: MisReports(),
    ),
    MenuModel(
      menuName: 'Setup Utility',
      icon: Images.newsettings,
      color: const Color.fromARGB(255, 234, 175, 57),
    ),
    MenuModel(
      menuName: 'Data Entry',
      color: const Color.fromARGB(255, 192, 184, 222),
      icon: Images.dataEntryLogo,
    ),
  ];
  List<MenuModel> get menuList => _menuList;

  bool _isActiveRememberMe = false;

  bool get isActiveRememberMe => _isActiveRememberMe;

  toggleRememberMe() {
    _isActiveRememberMe = !_isActiveRememberMe;
    notifyListeners();
  }

  void saveUserNumberAndPassword(String username, String password) {
    authRepo!.saveUserNumberAndPassword(username: username, password: password);
  }

  String getUserEmail() {
    return authRepo!.getUserName();
  }

  String getUserPassword() {
    return authRepo!.getUserPassword();
  }

  void clearToken() async {
    await authRepo!.cleanBarearToken();
  }

  Future<bool> clearUserEmailAndPassword() async {
    return authRepo!.clearUserNumberAndPassword();
  }

  final adcSearchController = TextEditingController();
  clearcontr() {
    adcSearchController.clear();
  }
}
