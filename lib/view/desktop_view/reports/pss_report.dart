import 'package:chicago/chicago.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mt;
import 'package:multiplatformdtop/Data/Provider/pss_report_provider.dart';
import 'package:multiplatformdtop/Data/Provider/user_config_provider.dart';
import 'package:multiplatformdtop/util/dimensions.dart';
import 'package:provider/provider.dart';

import '../../../helper/date_converter.dart';
import '../../base_widget/chicago_calender.dart';

class PssReporScreen extends StatefulWidget {
  const PssReporScreen({super.key});

  @override
  State<PssReporScreen> createState() => _PssReporScreenState();
}

class _PssReporScreenState extends State<PssReporScreen> {
  String selectedText = '';

  int? giD;

  String? kName;
  getAdc() async {
    final provider = Provider.of<UserConfigProvider>(context, listen: false);
    await Provider.of<UserConfigProvider>(context, listen: false).adcInformationProvider(
      context,
      provider.versionNumber,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAdc();
  }

  String? selectedReportTitle;
  String? kormiID;
  String? branchID;
  String? groupId;
  String? kormiId;
  bool isSelectBranch = false;
  bool isSelecKormi = false;
  bool isCollSheet = false;
  bool isgrpMemWise = false;
  bool isgrpMemWiseCoReport = false;
  bool isgrpWiseCReport = false;
  bool isRepClick = false;
  String? getShomitiName;
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer2<PssReportProvider, UserConfigProvider>(builder: (context, rep, up, child) {
      return ScaffoldPage(
        content: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              height: Dimensions.fullHeight(context) / 4,
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
                            placeholder: 'Select ADC',
                            items: up.adcList
                                .map((e) => AutoSuggestBoxItem(
                                      value: e.aName,
                                      label: e.aName!,
                                      onSelected: () {
                                        up.getAdcforBrnch(e.madcid!);
                                        up.setAdcForGwkl(e.aName!);
                                      },
                                    ))
                                .toList(),
                            decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black)),
                            trailingIcon: mt.Icon(mt.Icons.arrow_drop_down),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                        child: SizedBox(
                          width: 230,
                          child: AutoSuggestBox(
                            placeholder: 'Select Branch',
                            style: TextStyle(fontSize: 10),
                            items: up
                                .findADCwiseBranch(up.selectAdcIdforBrnch)
                                .map((e) => AutoSuggestBoxItem(
                                      value: e.aName,
                                      onSelected: () {
                                        up.getbrnchIDforMember(gID: e.adcid);
                                        up.findkormiFromBranchList(e.adcid!);
                                      },
                                      label: e.aName!,
                                    ))
                                .toList(),
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
                            items: up.kormiFromBrnch
                                .map((e) => AutoSuggestBoxItem(
                                      value: e.lName!,
                                      label: e.lName!,
                                      onSelected: () async {
                                        debugPrint('is it clear ${rep.kwiseshomitiList}');
                                        setState(() {
                                          rep.kwiseshomitiList.clear();
                                          kormiID = e.stafid;
                                          kName = e.lName!;
                                          getShomitiName = null;
                                        });
                                        if (isgrpMemWise || isgrpMemWiseCoReport || isgrpWiseCReport) {
                                          await rep.pssReprtProvider(brnchName: up.getbrnchID, kormiID: e.stafid!);

                                          rep.findkormiWisegrpList(kormiID!);

                                          // setState(() {
                                          //   getShomitiName = psR.kwiseshomitiList.first.sgName;
                                          // });

                                          debugPrint('fine ${rep.kwiseshomitiList}');
                                          // psR.findkormiWisegrpList(kormiID!);
                                          //   psR.findkormiWisegrpList(kormiID!);

                                          // else {
                                          //   await psR.pssReprtProvider(
                                          //       brnchName: up.getbrnchID, kormiID: kormiID!, gID: giD, isMem: true);
                                          // }

                                          // psR.findkormiWisegrpMemberList(kormiID!);
                                        }
                                      },
                                    ))
                                .toList(),
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
                              child: pickDate(provider: rep, isFromDate: true),
                              // child: CalendarButton(
                              //   initialSelectedDate: CalendarDate.today(),
                              //   onDateChanged: (value) {},
                              // ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('To '),
                            SizedBox(
                              width: 100,
                              height: 30,
                              child: pickDate(provider: rep, isFromDate: false),
                              // child: CalendarButton(
                              //   initialSelectedDate: CalendarDate.today(),
                              // ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                        child: ComboBox(
                          value: selectedText,
                          items: rep.pssCategoryList
                              .map((e) => ComboBoxItem(
                                    value: e.name,
                                    child: Text(e.name!),
                                    onTap: () {
                                      debugPrint('print ${e.id}');
                                      // up.clearName();
                                      switch (e.id) {
                                        case 1:
                                          setState(() {
                                            isSelectBranch = true;
                                            isSelecKormi = false;
                                            isCollSheet = false;
                                            isgrpMemWise = false;
                                            isgrpMemWiseCoReport = false;
                                            isgrpWiseCReport = false;
                                          });
                                          if (isSelectBranch) {
                                            up.clearKormiName();
                                            rep.brnchWisePssList.clear();
                                            rep.pssReportsList.clear();
                                            rep.kormiWiseCollectionList.clear();
                                            rep.grpMemwiseModelList.clear();
                                            rep.kormiWisegrpMemberList.clear();
                                            rep.kwiseshomitiList.clear();
                                          }

                                          break;
                                        case 2:
                                          setState(() {
                                            isSelecKormi = true;
                                            isSelectBranch = false;
                                            isCollSheet = false;
                                            isgrpMemWise = false;
                                            isgrpMemWiseCoReport = false;
                                            isgrpWiseCReport = false;
                                          });
                                          if (isSelecKormi) {
                                            up.clearKormiName();
                                            rep.brnchWisePssList.clear();
                                            rep.pssReportsList.clear();
                                            rep.kormiWiseCollectionList.clear();
                                            rep.grpMemwiseModelList.clear();
                                            rep.kormiWisegrpMemberList.clear();
                                            rep.kwiseshomitiList.clear();
                                          }

                                          break;
                                        case 3:
                                          setState(() {
                                            isCollSheet = true;
                                            isSelectBranch = false;
                                            isSelecKormi = false;
                                            isgrpMemWise = false;
                                            isgrpMemWiseCoReport = false;
                                            isgrpWiseCReport = false;
                                          });
                                          if (isCollSheet) {
                                            up.clearKormiName();
                                            rep.brnchWisePssList.clear();
                                            rep.pssReportsList.clear();
                                            rep.kormiWiseCollectionList.clear();
                                            rep.grpMemwiseModelList.clear();
                                            rep.kormiWisegrpMemberList.clear();
                                            rep.kwiseshomitiList.clear();
                                          }
                                          break;
                                        case 4:
                                          setState(() {
                                            isgrpMemWise = true;
                                            isSelectBranch = false;
                                            isSelecKormi = false;
                                            isCollSheet = false;
                                            isgrpMemWiseCoReport = false;
                                            isgrpWiseCReport = false;
                                          });
                                          if (isgrpMemWise) {
                                            up.clearKormiName();
                                            rep.brnchWisePssList.clear();
                                            rep.pssReportsList.clear();
                                            rep.kormiWiseCollectionList.clear();
                                            rep.grpMemwiseModelList.clear();
                                            rep.kormiWisegrpMemberList.clear();
                                            rep.kwiseshomitiList.clear();
                                          }
                                          break;

                                        case 5:
                                          setState(() {
                                            isgrpMemWiseCoReport = true;
                                            isSelectBranch = false;
                                            isSelecKormi = false;
                                            isCollSheet = false;
                                            isgrpWiseCReport = false;
                                            isgrpMemWise = false;
                                          });
                                          if (isgrpMemWiseCoReport) {
                                            up.clearKormiName();
                                            rep.brnchWisePssList.clear();
                                            rep.pssReportsList.clear();
                                            rep.kormiWiseCollectionList.clear();
                                            rep.grpMemwiseModelList.clear();
                                            rep.kormiWisegrpMemberList.clear();
                                            rep.kwiseshomitiList.clear();
                                            rep.groupWiseCollectionList.clear();
                                          }
                                          break;

                                        case 6:
                                          setState(() {
                                            isgrpWiseCReport = true;
                                            isgrpMemWiseCoReport = false;
                                            isSelectBranch = false;
                                            isSelecKormi = false;
                                            isCollSheet = false;
                                            isgrpMemWise = false;
                                          });
                                          if (isgrpWiseCReport) {
                                            up.clearKormiName();
                                            rep.groupWiseColList.clear();
                                            rep.brnchWisePssList.clear();
                                            rep.pssReportsList.clear();
                                            rep.kormiWiseCollectionList.clear();
                                            rep.grpMemwiseModelList.clear();
                                            rep.kormiWisegrpMemberList.clear();
                                            rep.kwiseshomitiList.clear();
                                          }
                                          break;

                                        default:
                                      }
                                    },
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedText = value as String;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                        child: SizedBox(
                          width: 200,
                          child: AutoSuggestBox(
                            placeholder: 'Select Shomiti',
                            items: rep.kwiseshomitiList.map((e) {
                              return AutoSuggestBoxItem(
                                value: e.sgName,
                                onSelected: () async {
                                  rep.kormiWisegrpMemberList.clear();
                                  setState(() {
                                    giD = e.groupid;
                                    isRepClick = false;
                                  });
                                  // await psR.pssReprtProvider(
                                  //     brnchName: up.getbrnchID, kormiID: kormiID!, gID: giD, isMem: true);
                                },
                                label: e.sgName!,
                              );
                            }).toList(),
                            decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black)),
                            trailingIcon: mt.Icon(mt.Icons.arrow_drop_down),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Button(
                      child: Text('Generate'),
                      onPressed: () async {
                        isSelectBranch
                            ? await rep.pssReprtProvider(brnchName: up.getbrnchID, isBrnchRep: true)
                            : isSelecKormi
                                ? await rep.pssReprtProvider(brnchName: up.getbrnchID, kormiID: kormiID!)
                                : isCollSheet
                                    ? await rep.kormiWiseCollectionProvider(branchID: up.getbrnchID)
                                    : isgrpMemWiseCoReport
                                        ? await rep.groupWiseCollectionProvider(
                                            branchID: up.getbrnchID,
                                            groupId: giD!,
                                            kormiId: kormiID!,
                                          )
                                        // : isgrpMemWise
                                        //     ? await psR.findkormiWisegrpMemberList(kormiID!)
                                        : isgrpWiseCReport
                                            ? await rep.groupWiseCollectionProvider(
                                                branchID: up.getbrnchID,
                                                groupId: giD!,
                                                kormiId: kormiID!,
                                              )
                                            : () {};
                        if (isgrpMemWise) {
                          if (giD == null && getShomitiName == null) {
                            setState(() {
                              isRepClick = true;
                            });
                            await rep.pssReprtProvider(brnchName: up.getbrnchID, kormiID: kormiID!);
                            rep.findkormiWisegrpMemberList(kormiID!);
                          } else {
                            await rep.pssReprtProvider(brnchName: up.getbrnchID, kormiID: kormiID!, gID: giD, isMem: true);
                          }

                          //   // psR.findkormiWisegrpMemberList(kormiID!);
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  pickDate({required PssReportProvider provider, bool isFromDate = true}) {
    //  String format(CalendarDate date) => formatDateTime(date.toDateTime());
    return CalendarButton(
      initialSelectedDate: isFromDate
          ? CalendarDate.fromDateTime(DateConverter.convertStringToDateFormat2(provider.fromDate))
          : CalendarDate.fromDateTime(DateConverter.convertStringToDateFormat2(provider.toDate)),
      onDateChanged: (value) {
        // CalendarDateFormat? cf;
        // print(cf!.format(value!));

        print(value!.toDateTime());

        if (value != null) {
          if (isFromDate) {
            provider.updateDates(value.toDateTime(), isFromDate: true);
          } else {
            provider.updateDates(value.toDateTime());
          }
          if (isFromDate) {
            if (!mounted) return;
            provider.onSavedDates(context, isFromDate: true);
          } else {
            if (!mounted) return;
            provider.onSavedDates(
              context,
            );
          }
        }
      },
      // initialSelectedDate:  isFromDate
      //     ? DateConverter.convertStringToDateFormat2(provider.fromDate)
      //     : DateConverter.convertStringToDateFormat2(provider.toDate),
    );
  }
}
