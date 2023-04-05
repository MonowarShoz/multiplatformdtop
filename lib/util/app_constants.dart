// ignore_for_file: constant_identifier_names

import 'package:flutter/cupertino.dart';

class AppConstants {
  //global api
  //static const String baseUrl = 'http://103.110.218.55:3200/api/';

  //static const String baseUrl = 'http://202.40.189.4:8085/api/'; //Trial link
  // static const String baseUrl = 'http://103.110.218.55:1092/api/';
  // static const String baseUrl = 'http://192.168.0.249:1092/api/'; //final live Db
  //static const String baseUrl = 'http://192.168.0.249:6081/api/';
  static const String baseUrl = 'http://202.40.189.4:8096/api/';
  //ADMIN PASSWORD:753159 for 95
  //local ApI
  //static const String baseUrl = 'http://192.168.134.120:5600/api/';
  // static const String baseUrl = 'http://192.168.31.204:30/api/';
  //static const String baseUrl ='http://192.168.1.92:88/api/';

  // static const String baseUrl = 'http://192.168.1.11:1004/api/';

  //app download link
  // static const String appDownlinkUrl = 'http://103.110.218.56/apkbuild/';

  static const String loginUri = 'Userinfs/';

  //API routing
  static const String jwtTokenUri = 'Jwt';
  static const String hmsMblQuery = 'HmsMblQuery';
  //static const String jwtTokenUri = 'Jwt';

  //userinf
  static const String lfbdEhsHccode = '950100101001';
  static const String lfbdRfsHccode = '950100401006';
  static const String adminHccode = '950600801003';
  static const String superAdminHccode = '950600801002';
  static const String monowarHccode = '950600801006';

  //Post data parameter
  static const String productParam = "SetParamRetSaleItemList";
  static const String comCode = "6535";
  static const String customerParam = "SetParamSirInfCodeBook";
  static const String categoryParam = "SetParamSirInfCodeBookItemListParam";
  static const String orderParam = "SetParamUpdateMSalesInvoiceXml";
  static const String customerProc = "GetClientSirInfCodeBook";
  static const String orderHistoryParam = "SetParamSalesTransList";
  static const String editOrderDetailsParam = 'SetParamSalesInvoiceXml';
  static const String hmsVersion = "220513.1";
  static const String branchParam = "SetParamCompBrnSecCodeBook";

  static const String nullTime = "1900-01-01T00:00:00";

  // sharePreference

  static const String TOKEN = 'tokenstr';
  static const String USER = 'user';
  static const String USER_EMAIL = 'user_email';
  static const String USER_PASSWORD = 'user_password';
  static const String HOME_ADDRESS = 'home_address';
  static const String SEARCH_ADDRESS = 'search_address';
  static const String OFFICE_ADDRESS = 'office_address';
  static const String CART_LIST = 'cart_list';
  static const String CONFIG = 'config';
  static const String GUEST_MODE = 'guest_mode';
  static const String CURRENCY = 'currency';

  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';
  static const String THEME = 'theme';
  static const String SELECT_LANGUAGE_STATUS = 'select_language_status';

  //   LanguageModel(imageUrl: '', languageName: 'English', countryCode: 'US', languageCode: 'en'),
  //   LanguageModel(imageUrl: '', languageName: 'Bangla', countryCode: 'BD', languageCode: 'bn'),
  // ];

  static void logPrint(Object? object) async {
    int defaultPrintLength = 1020;
    if (object == null || object.toString().length <= defaultPrintLength) {
      print(object);
    } else {
      String log = object.toString();
      int start = 0;
      int endIndex = defaultPrintLength;
      int logLength = log.length;
      int tmpLogLength = log.length;
      while (endIndex < logLength) {
        print(log.substring(start, endIndex));
        endIndex += defaultPrintLength;
        start += defaultPrintLength;
        tmpLogLength -= defaultPrintLength;
      }
      if (tmpLogLength > 0) {
        print(log.substring(start, logLength));
      }
    }
  }
}
