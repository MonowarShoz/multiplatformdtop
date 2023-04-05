import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';

Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String), width: 150, height: 150);
}

Uint8List dataFromBase64String(String base64String) {
  return base64Decode(base64String);
}

String base64String(Uint8List data) {
  return base64Encode(data);
}

String convertStringToBase64(String data) {
  // String EncodedJson = jsonEncode(data);
  var jsonEncodedByte = utf8.encode(data);
  return base64Encode(jsonEncodedByte);
}

String convertToBase(List<int> byte) {
  return base64Encode(byte);
}
