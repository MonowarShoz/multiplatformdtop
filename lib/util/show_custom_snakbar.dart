import 'package:fluent_ui/fluent_ui.dart' as ft;
import 'package:flutter/material.dart';

void showCustomSnackBar(String message, BuildContext context, {bool isError = true}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 5000),
      content: Text(message, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w400)),
      backgroundColor: isError ? Colors.red.shade700 : Colors.green,
      elevation: 6.0,
      margin: const EdgeInsets.only(bottom: 70, left: 20, right: 20),
      behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(40),
        ),
      ),
    ),
  );
}

showInfoBar(BuildContext context, String message, String det) {
  ft.displayInfoBar(context, builder: (context, close) {
    return ft.InfoBar(
      title: Text('$message'),
      content: Text('$det'),
      action: ft.IconButton(
        icon: const Icon(ft.FluentIcons.clear),
        onPressed: close,
      ),
      severity: ft.InfoBarSeverity.error,
    );
  });
}
