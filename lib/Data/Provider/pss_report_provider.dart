import 'dart:convert';
import 'dart:math';

import 'package:dartx/dartx.dart';
import 'package:first_package/first_package.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:multiplatformdtop/util/show_custom_snakbar.dart';

import '../../helper/date_converter.dart';
import '../Api Services/responseApi/api_response.dart';
import '../Model/branch_wise_pss_model.dart';
import '../Model/data_access_param.dart';
import '../Model/group_wise_collection_model.dart';
import '../Model/grp_mem_wise_model.dart';
import '../Model/k_w_Loan_rlz._sum.dart';
import '../Model/kormi_wise_collection.dart';
import '../Model/kormi_wise_ln_disb.dart';
import '../Model/kwlaonRlzDetails.dart';
import '../Model/loan_disb_model.dart';
import '../Model/pss_report_model.dart';
import '../Model/total_kwc_model.dart';
import '../Repository/auth_repo.dart';

class PssReportProvider with ChangeNotifier {
  final AuthRepo? authRepo;

  PssReportProvider(this.authRepo);

  DataAccessParam? _dataAccessParam;
  DataAccessParam? get dataAccessParam => _dataAccessParam;

  List<PSSReportModel> _pssReportList = [];
  List<PSSReportModel> get pssReportsList => _pssReportList;

  List<BranchWisePssModel> _brnchWisepssReportList = [];
  List<BranchWisePssModel> get brnchWisePssList => _brnchWisepssReportList;

  List<GrpMemWiseModel> _grpMemwiseModelList = [];
  List<GrpMemWiseModel> get grpMemwiseModelList => _grpMemwiseModelList;

  bool _ispsRLoading = false;
  bool get isPsrLoading => _ispsRLoading;

  Future pssReprtProvider(
      {required String brnchName, String? kormiID, bool isBrnchRep = false, bool isMem = false, int? gID}) async {
    _dataAccessParam = null;
    _pssReportList = [];
    _grpMemwiseModelList = [];
    _brnchWisepssReportList = [];
    _ispsRLoading = true;
    _dataAccessParam = DataAccessParam(
      comCod: "2501",
      procName: "dbo.SP_MICR_REPORT_SUMMARY_01",
      procID: "SAVINGSPSSSUM01",
      parm01: brnchName,
      parm02: fromDate,
      parm03: toDate,
      //       "parm02": "04-Dec-2022",
      // "parm03": "04-Jan-2023",
      parm04: isMem ? gID.toString() : "",
      parm05: isBrnchRep ? "" : kormiID,
    );

    var encryptedKormiData = CodeUtil.convertToBase64(_dataAccessParam!);
    ApiResponse apiResponse = await authRepo!.apiProcess(data1: encryptedKormiData);
    _ispsRLoading = false;
    if (apiResponse.response != null && (apiResponse.response!.statusCode == 200 || apiResponse.response!.statusCode == 201)) {
      _pssReportList = [];
      _brnchWisepssReportList = [];
      _grpMemwiseModelList = [];

      String decompressedJson = CodeUtil.decompr(apiResponse.response!.data.toString());

      var pssJson = jsonDecode(decompressedJson.toString());
      for (var element in pssJson['Table']) {
        _grpMemwiseModelList.add(GrpMemWiseModel.fromJson(element));
      }
      for (var element in pssJson['Table1']) {
        _pssReportList.add(PSSReportModel.fromJson(element));
      }
      for (var element in pssJson['Table2']) {
        _brnchWisepssReportList.add(BranchWisePssModel.fromJson(element));
      }
    }
    notifyListeners();
  }

  double calcgwisRiRfi() {
    var total = 0.0;
    for (var i = 0; i < pssReportsList.length; i++) {
      total += pssReportsList[i].totmem!.toDouble();
    }
    return total;
  }

  double calculatePSSTargetTotal({double? value, required List<GrpMemWiseModel> kormiWisegrpMemberList}) {
    var total = 0.0;
    for (var i = 0; i < kormiWisegrpMemberList.length; i++) {
      total += kormiWisegrpMemberList[i].scham!.toDouble();
    }
    return total;
  }

  double calculatePSSachTotal({required List<GrpMemWiseModel> kormiWisegrpMemberList}) {
    var total = 0.0;
    for (var i = 0; i < kormiWisegrpMemberList.length; i++) {
      total += kormiWisegrpMemberList[i].achivam!;
    }
    return total;
  }

  double calculatePSbalTotal({double? value, required List<GrpMemWiseModel> kormiWisegrpMemberList}) {
    var total = 0.0;
    for (var i = 0; i < kormiWisegrpMemberList.length; i++) {
      total += kormiWisegrpMemberList[i].closam!;
    }
    return total;
  }

  List<GrpMemWiseModel> _kormiWisegrpMemberList = [];
  List<GrpMemWiseModel> get kormiWisegrpMemberList => _kormiWisegrpMemberList;

  List<GrpMemWiseModel> _kwiseshomitiList = [];
  List<GrpMemWiseModel> get kwiseshomitiList => _kwiseshomitiList.distinctBy((element) => element.sgName).toList();
  //List<GrpMemWiseModel> get kwiseshomitiList => _kwiseshomitiList;

  List<GrpMemWiseModel> getShomitiList(String kormiID) {
    List shomitiList = _grpMemwiseModelList.where((element) => element.kormi == kormiID).toList();
    return [...shomitiList];
  }

  findkormiWisegrpList(String kormiID) {
    _kwiseshomitiList = [];

    _kwiseshomitiList = grpMemwiseModelList.where((element) => element.kormi == kormiID).toList();

    notifyListeners();
  }

  findkormiWisegrpMemberList(String kormiID) {
    _kormiWisegrpMemberList = [];

    _kormiWisegrpMemberList = grpMemwiseModelList.where((element) => element.kormi == kormiID).toList();

    notifyListeners();
  }

  List<KormiWiseCollection> _kormiWiseCollectionList = [];
  List<KormiWiseCollection> get kormiWiseCollectionList => _kormiWiseCollectionList;
  TotalkwCModel? _totalkwCModel;
  TotalkwCModel? get totalkwCModel => _totalkwCModel;

  Future kormiWiseCollectionProvider({required String branchID, bool isBrnchRep = false}) async {
    _dataAccessParam = null;
    _totalkwCModel = TotalkwCModel();
    _kormiWiseCollectionList = [];
    _dataAccessParam = DataAccessParam(
      comCod: "2501",
      procName: "dbo.SP_MICR_REPORT_LOAN_SUM_01",
      procID: "KORMICOLL01",
      parm01: branchID,
      parm02: fromDate,
      parm03: toDate,
    );
    _ispsRLoading = true;
    var encryptedKormiData = CodeUtil.convertToBase64(_dataAccessParam!);
    ApiResponse apiResponse = await authRepo!.apiProcess(data1: encryptedKormiData);
    _ispsRLoading = false;
    if (apiResponse.response != null && (apiResponse.response!.statusCode == 200 || apiResponse.response!.statusCode == 201)) {
      _kormiWiseCollectionList = [];
      _totalkwCModel = TotalkwCModel();
      String decompressedJson = CodeUtil.decompr(apiResponse.response!.data.toString());

      var kwCsJson = jsonDecode(decompressedJson.toString());
      for (var element in kwCsJson['Table2']) {
        _kormiWiseCollectionList.add(KormiWiseCollection.fromJson(element));
      }
      for (var element in kwCsJson['Table3']) {
        _totalkwCModel = TotalkwCModel.fromJson(element);
      }
    }
    notifyListeners();
  }

  List<GrpAndMembWiseColModel> _groupMembWiseColList = [];
  List<GrpAndMembWiseColModel> get groupWiseCollectionList => _groupMembWiseColList;
  List<GrpAndMembWiseColModel> _groupwiseColList = [];
  List<GrpAndMembWiseColModel> get groupWiseColList => _groupwiseColList;

  Future groupWiseCollectionProvider({
    required String branchID,
    bool isBrnchRep = false,
    required int groupId,
    required String kormiId,
  }) async {
    _dataAccessParam = null;
    _groupMembWiseColList = [];
    _groupwiseColList = [];
    _dataAccessParam = DataAccessParam(
        comCod: "2501",
        procName: "dbo.SP_MICR_REPORT_LOAN_SUM_01",
        procID: "KORMICOLL01",
        parm01: branchID,
        parm02: fromDate,
        parm03: toDate,
        parm04: groupId.toString(),
        parm05: kormiId.toString());
    _ispsRLoading = true;
    var encryptedKormiData = CodeUtil.convertToBase64(_dataAccessParam!);
    ApiResponse apiResponse = await authRepo!.apiProcess(data1: encryptedKormiData);
    _ispsRLoading = false;
    if (apiResponse.response != null && (apiResponse.response!.statusCode == 200 || apiResponse.response!.statusCode == 201)) {
      _groupMembWiseColList = [];
      _groupwiseColList = [];
      String decompressedJson = CodeUtil.decompr(apiResponse.response!.data.toString());

      var groupMembWiseCol = jsonDecode(decompressedJson.toString());
      for (var element in groupMembWiseCol['Table']) {
        _groupMembWiseColList.add(GrpAndMembWiseColModel.fromJson(element));
      }
      for (var element in groupMembWiseCol['Table1']) {
        _groupwiseColList.add(GrpAndMembWiseColModel.fromJson(element));
      }
    }
    notifyListeners();
  }

  // {
//   "ComCod": "2501",
//   "ProcName": "dbo.SP_MICR_REPORT_LOAN_SUM_01",
//   "ProcID": "KORMIOTRLOAN01",
//   "parmJson1": null,
//   "parmJson2": null,
//   "parmBin01": null,
//   "parm01": "10034201",
//   "parm02": "31-Oct-2022",
//   "parm03": "05-Feb-2023",
//   "parm04": null,
//   "parm05": null,
//   "parm06": null,
//   "parm07": null,
//   "parm08": null,
//   "parm09": null,
//   "parm10": null
// }
  List<KwLoanRlzSum> _kwLoanRlzSumList = [];
  List<KwLoanRlzSum> get kwLoanRlzSumList => _kwLoanRlzSumList;
  List<KwLoanRlzDetails> _kwLoanRlzDetList = [];
  List<KwLoanRlzDetails> get kwLoanRlzDetList => _kwLoanRlzDetList;

  List<KwLoanRlzDetails> _idWisekLoanRlzDetList = [];
  List<KwLoanRlzDetails> get idWisekLoanRlzDetList => _idWisekLoanRlzDetList;

  List<KwLoanRlzDetails> _specifickwLoanRlzDetList = [];
  List<KwLoanRlzDetails> get specifickwLoanRlzDetList => _specifickwLoanRlzDetList;

  List<KwLoanRlzDetails> _kwotrRepDetList = [];
  List<KwLoanRlzDetails> get kwotrRepDetList => _kwotrRepDetList;

  Future kwLoanRlzSummaryProvider({
    required String brnchName,
    // String? kormiID,
    bool isBrnchRep = false,
  }) async {
    _dataAccessParam = null;
    _kwLoanRlzSumList = [];
    _kwLoanRlzDetList = [];
    _dataAccessParam = DataAccessParam(
      comCod: "2501",
      procName: "dbo.SP_MICR_REPORT_LOAN_SUM_01",
      procID: "KORMIOTRLOAN01",
      parm01: brnchName,
      parm02: fromDate,
      parm03: toDate,
      //       "parm02": "04-Dec-2022",
      // "parm03": "04-Jan-2023",
      // parm04: "",
      // parm05: isBrnchRep ? "" : kormiID,
    );
    _ispsRLoading = true;
    var encryptedKormiwlRsummData = CodeUtil.convertToBase64(_dataAccessParam!);
    ApiResponse apiResponse = await authRepo!.apiProcess(data1: encryptedKormiwlRsummData);
    _ispsRLoading = false;
    if (apiResponse.response != null && (apiResponse.response!.statusCode == 200 || apiResponse.response!.statusCode == 201)) {
      _kwLoanRlzSumList = [];
      _kwLoanRlzDetList = [];
      String decompressedJson = CodeUtil.decompr(apiResponse.response!.data.toString());

      var pssJson = jsonDecode(decompressedJson.toString());
      for (var element in pssJson['Table']) {
        _kwLoanRlzDetList.add(KwLoanRlzDetails.fromJson(element));
      }
      for (var element in pssJson['Table1']) {
        _kwLoanRlzSumList.add(KwLoanRlzSum.fromJson(element));
      }
    }
    notifyListeners();
  }

  findKormiwiseLrlzDet(String kormiID) {
    _idWisekLoanRlzDetList = [];
    if (kormiID == "ALL KORMI") {
      _kwLoanRlzDetList;
    } else {
      _idWisekLoanRlzDetList = _kwLoanRlzDetList.where((element) => element.kormi == kormiID).toList();
    }
    notifyListeners();
  }

  findKormiwiseOtrRepDet(String kormiID) {
    _kwotrRepDetList = [];

    _kwotrRepDetList = _kwLoanRlzDetList.where((element) => element.kormi == kormiID).toList();

    notifyListeners();
  }

  List<LoanDisbModel> _loanDisbList = [];
  List<LoanDisbModel> get loanDisbList => _loanDisbList;

  List<LoanDisbModel> _memWiseloanDisbList = [];
  List<LoanDisbModel> get memWiseloanDisbList => _memWiseloanDisbList;

  List<KormiWiseLnDisb> _kormiWiseLnDisbList = [];
  List<KormiWiseLnDisb> get kormiWiseLnDisbList => _kormiWiseLnDisbList;

  Future loanDisbProvider({
    required String brnchName,
    // String? kormiID,
    bool isBrnchRep = false,
    BuildContext? context,
  }) async {
    _dataAccessParam = null;
    _loanDisbList = [];
    _kormiWiseLnDisbList = [];
    _dataAccessParam = DataAccessParam(
      comCod: "2501",
      procName: "dbo.SP_MICR_REPORT_LOAN_SUM_01",
      procID: "KORMILOANDISB01",
      parm01: brnchName,
      parm02: fromDate,
      parm03: toDate,
      //       "parm02": "04-Dec-2022",
      // "parm03": "04-Jan-2023",
      // parm04: "",
      // parm05: isBrnchRep ? "" : kormiID,
    );
    _ispsRLoading = true;
    var encryptedKormiwlRsummData = CodeUtil.convertToBase64(_dataAccessParam!);
    ApiResponse apiResponse = await authRepo!.apiProcess(data1: encryptedKormiwlRsummData);
    _ispsRLoading = false;
    if (apiResponse.response != null && (apiResponse.response!.statusCode == 200 || apiResponse.response!.statusCode == 201)) {
      _loanDisbList = [];
      _kormiWiseLnDisbList = [];
      String decompressedJson = CodeUtil.decompr(apiResponse.response!.data.toString());

      var pssJson = jsonDecode(decompressedJson.toString());
      for (var element in pssJson['Table']) {
        _loanDisbList.add(LoanDisbModel.fromJson(element));
      }
      for (var element in pssJson['Table1']) {
        _kormiWiseLnDisbList.add(KormiWiseLnDisb.fromJson(element));
      }
    } else {
      showInfoBar(context!, 'message', 'Network Error');
    }
    notifyListeners();
  }

  findMemwiseLoanDisb(String kormiID) {
    _memWiseloanDisbList = [];

    _memWiseloanDisbList = _loanDisbList.where((element) => element.kormi == kormiID).toList();

    notifyListeners();
  }

  // getTotal(List<KormiWiseCollection> list) {
  //   var total = 0.0;
  //   for (var i = 0; i < list.length; i++) {
  //     total += list[i].

  //   }
  // }

  DateTime currentDate = DateTime.now();

  String fromDate = DateConverter.dateFormatStyle2(DateTime.now().subtract(Duration(days: 31)));
  String toDate = DateConverter.dateFormatStyle2(DateTime.now());
  String _fromDateTemp = DateConverter.dateFormatStyle2(DateTime.now().subtract(Duration(days: 31)));
  String _toDateTemp = DateConverter.dateFormatStyle2(DateTime.now());
  DateTime? toDateTime;
  DateTime? fromDateTime;
  DateTime? currentDateTime;

  updateDates(DateTime dateTime, {bool isFromDate = false}) {
    if (isFromDate) {
      _fromDateTemp = DateConverter.dateFormatStyle2(dateTime);
    } else {
      _toDateTemp = DateConverter.dateFormatStyle2(dateTime);
    }
  }

  onSavedDates(BuildContext context, {bool isFromDate = false}) {
    DateTime fromD = DateConverter.convertStringToDateFormat2(_fromDateTemp);
    DateTime toD = DateConverter.convertStringToDateFormat2(_toDateTemp);
    if (isFromDate) {
      if (fromD.isBefore(toD) || fromD == toD) {
        fromDate = _fromDateTemp;
      } else {
        showCustomSnackBar('From Date Should before or equal for To Date', context);
      }
    } else {
      if (toD.isAfter(fromD) || fromD == toD) {
        toDate = _toDateTemp;
      } else {
        showCustomSnackBar('To Date Should After or equal for From Date', context);
      }
    }
    notifyListeners();
  }

  String? _getShomitiName;
  String? get getShomitiName => _getShomitiName;
  clearShomitiName() {
    _getShomitiName = '';
    notifyListeners();
  }

  String _getShomitiID = '';
  String get getShomitiID => _getShomitiID;
  getShomitiNamefogGrpMemList({
    String? selval,
  }) {
    _getShomitiName = selval ?? '';

    notifyListeners();
  }

  final List<PssReportCategory> _pssCategoryList = [
    PssReportCategory(
      name: 'Kormi wise RAI and RFI',
      id: 1,
    ),
    PssReportCategory(
      name: 'Group wise RAI and RFI',
      id: 2,
    ),
    PssReportCategory(
      name: 'Kormi wise Collection Report',
      id: 3,
    ),
    PssReportCategory(
      name: 'Group Member wise RAI and RFI',
      id: 4,
    ),
    PssReportCategory(
      name: 'Member Wise Collection Report',
      id: 5,
    ),
    PssReportCategory(
      name: 'Group Wise Collection Report',
      id: 6,
    ),
  ];
  List<PssReportCategory> get pssCategoryList => _pssCategoryList;

  final List<LoanReportCategory> _loanReportsCategory = [
    LoanReportCategory(
      name: 'Kormi wise Loan Realization Summary',
      id: 1,
    ),
    LoanReportCategory(
      name: 'Kormi wise Loan Realization Details',
      id: 2,
    ),
    LoanReportCategory(
      name: 'Member wise OTR Report',
      id: 3,
    ),
    LoanReportCategory(
      name: 'Member wise OTR Summary',
      id: 4,
    ),
    LoanReportCategory(
      name: 'Member wise Loan Disbursement Report',
      id: 5,
    ),
    LoanReportCategory(
      name: 'Kormi wise Loan Disbursement Report',
      id: 6,
    ),
  ];
  List<LoanReportCategory> get loanReportCategory => _loanReportsCategory;
}

class PssReportCategory {
  final String? name;
  final int? id;

  PssReportCategory({this.name, this.id});
}

class LoanReportCategory {
  final String? name;
  final int? id;

  LoanReportCategory({this.name, this.id});
}


// {
//       "adcid": "10034201",
//       "kormi": "114379",
//       "l_name": "Animesh Chandra Mondal",
//       "sg_group": 125,
//       "sg_name": "শিউলী মহিলা সমিতি",
//       "sm_member": 117,
//       "sm_name": "স্বপ্না আক্তার রিমা                         ",
//       "p_no": "P2301070",
//       "disbdate": "2023-01-30T00:00:00",
//       "disbamount": 180000.000000,
//       "startdate": "2023-02-12T00:00:00"
//     },
// "Table2": [
//     {
//       "adcid": "10034201",
//       "kormi": "114379",
//       "l_name": "Animesh Chandra Mondal",
//       "sg_group": 455,
//       "sg_name": "প্রভাতী ম/স",
//       "p_no": "P2301066",
//       "disbdate": "2023-01-31T00:00:00",
//       "disbamount": 50000.000000,
//       "startdate": "2023-02-13T00:00:00"
//     },

//  "Table1": [
//     {
//       "adcid": "10034201",
//       "kormi": "114379",
//       "l_name": "Animesh Chandra Mondal",
//       "memno": 5,
//       "disbamount": 570000.000000
//     },

//  "Table1": [
//     {
//       "adcid": "10034201",
//       "kormi": "114379",
//       "l_name": "Animesh Chandra Mondal",
//       "memno": 5,
//       "disbamount": 570000.000000
//     },
// {
//                 ComCod = McAppGenInfo.ComCode,
//                 ProcName = "dbo.SP_MICR_REPORT_LOAN_SUM_01",
//                 ProcID = "KORMILOANDISB01",
//                 parm01 = adcid1,
//                 parm02 = frmdat1,
//                 parm03 = todat1
//             };