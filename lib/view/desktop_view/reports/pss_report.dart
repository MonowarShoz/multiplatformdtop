import 'package:chicago/chicago.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mt;
import 'package:multiplatformdtop/Data/Provider/pss_report_provider.dart';
import 'package:multiplatformdtop/Data/Provider/user_config_provider.dart';
import 'package:multiplatformdtop/util/dimensions.dart';
import 'package:provider/provider.dart';

import '../../base_widget/chicago_calender.dart';

class PssReporScreen extends StatefulWidget {
  const PssReporScreen({super.key});

  @override
  State<PssReporScreen> createState() => _PssReporScreenState();
}

class _PssReporScreenState extends State<PssReporScreen> {
  String selectedText = '';
  @override
  Widget build(BuildContext context) {
    return Consumer2<PssReportProvider, UserConfigProvider>(builder: (context, rep, up, child) {
      return ScaffoldPage(
        content: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              height: Dimensions.fullHeight(context) / 6,
              width: Dimensions.fullWidth(context),
              decoration: BoxDecoration(color: Color.fromARGB(255, 253, 248, 248), boxShadow: [
                BoxShadow(color: mt.Colors.grey[300]!, blurRadius: 0.5),
                BoxShadow(color: mt.Colors.grey, blurRadius: 0.5),
                BoxShadow(color: mt.Colors.grey[200]!, blurRadius: 0.5),
              ]),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                        child: SizedBox(
                          width: 200,
                          child: AutoSuggestBox(
                            placeholder: 'Select Branch',
                            items: [],
                            decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black)),
                            trailingIcon: mt.Icon(mt.Icons.arrow_drop_down),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                        child: SizedBox(
                          width: 200,
                          child: AutoSuggestBox(
                            placeholder: 'Select Member',
                            items: [],
                            decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black)),
                            trailingIcon: mt.Icon(mt.Icons.arrow_drop_down),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                        child: Row(
                          children: [
                            Text('From '),
                            SizedBox(
                              width: 100,
                              height: 30,
                              child: CalendarButton(
                                initialSelectedDate: CalendarDate.today(),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('To '),
                            SizedBox(
                              width: 100,
                              height: 30,
                              child: CalendarButton(
                                initialSelectedDate: CalendarDate.today(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                        child: ComboBox(
                          value: selectedText,
                          items: rep.pssCategoryList.map((e) => ComboBoxItem(value: e.name, child: Text(e.name!))).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedText = value as String;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
