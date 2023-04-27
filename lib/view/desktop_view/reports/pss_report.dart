import 'dart:io';

import 'package:chicago/chicago.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mt;

import 'package:multiplatformdtop/util/dimensions.dart';
import 'package:pfmscodepack/pfmscodepack.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

import '../../base_widget/chicago_calender.dart';
import '../../base_widget/pdf_preview.dart';
import 'kormiwiserairfipdf.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PssReporScreen extends StatefulWidget {
  const PssReporScreen({super.key});

  @override
  State<PssReporScreen> createState() => _PssReporScreenState();
}

class _PssReporScreenState extends State<PssReporScreen> {
  String selectedText = '';

  String? giD;

  String? kName;
  KormiWiseRAIRFISource? kormiWiseRAIRFISource;
  String? selOption = "Print Preview";
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

  bool isKormiWiseRaiRfi = false;
  bool isgrpwiserairfi = false;
  bool isCollSheet = false;
  bool isgrpMemWise = false;
  bool isgrpMemWiseCoReport = false;
  bool isgrpWiseCReport = false;
  bool isRepClick = false;
  String? selectedReportTitle;
  String? kormiID;
  String? branchID;
  String? groupId;
  String? kormiId;
  String? getShomitiName;
  final _controller = TextEditingController();

  List outputOptions = ["Print Preview", "On-Screen Preview", "Save as PDF"];

  Map<String, double> columnWidths = {
    'Kormi No': double.nan,
    'Kormi Name': double.nan,
    'Total grp': double.nan,
    'Total Member': double.nan,
    'Dep grp': double.nan,
    'Dep Mem': double.nan,
    'Opening Bal': double.nan,
    'Pss Target': double.nan,
    'Pss Achieve': double.nan,
    'RAI': double.nan,
    'RFI': double.nan,
    'Closing Balance': double.nan,
  };

  @override
  Widget build(BuildContext context) {
    return Consumer2<PssReportProvider, UserConfigProvider>(builder: (context, psR, up, child) {
      return ScaffoldPage(
        padding: EdgeInsets.zero,
        header: Column(
          children: [
            Container(
              color: const Color.fromARGB(255, 27, 72, 31),
              height: 25,
              child: Center(
                child: Text(
                  'Proshika Savings Scheme',
                  style: TextStyle(fontWeight: FontWeight.w600, color: Colors.yellow),
                ),
              ),
            ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Text('Report Title'),
            //   ],
            // ),
          ],
        ),
        content: Column(
          children: [
            Container(
              height: 40,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40,
                        color: const Color.fromARGB(255, 225, 238, 177),
                        child: Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                'Report Title :',
                                style: TextStyle(color: mt.Colors.red, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 18),
                              child: Text(
                                'Proshika Savings Scheme Reports',
                                style: TextStyle(color: mt.Colors.purple, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          child: Row(
                            children: [
                              const Text('Date From '),
                              SizedBox(
                                width: 120,
                                // height: 50,
                                child: pickDate(provider: psR, isFromDate: true),
                                // child: CalendarButton(
                                //   initialSelectedDate: CalendarDate.today(),
                                //   onDateChanged: (value) {},
                                // ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text('To '),
                              SizedBox(
                                width: 120,
                                // height: 30,
                                child: pickDate(provider: psR, isFromDate: false),
                                // child: CalendarButton(
                                //   initialSelectedDate: CalendarDate.today(),
                                // ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Output Options'),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ColoredBox(
                          color: Color.fromARGB(255, 131, 130, 129),
                          child: ComboBox(
                            value: selOption,
                            focusColor: Color.fromARGB(255, 123, 122, 122),
                            items: outputOptions
                                .map(
                                  (e) => ComboBoxItem(
                                    value: e,
                                    child: Text(
                                      e,
                                    ),
                                    onTap: () async {},
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selOption = value as String;
                              });
                            },
                            popupColor: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: FilledButton(
                          child: Text('Generate'),
                          onPressed: () async {
                            if (isKormiWiseRaiRfi) {
                              await psR.pssReprtProvider(brnchName: up.getbrnchID, isBrnchRep: true);
                              setState(() {
                                kormiWiseRAIRFISource = KormiWiseRAIRFISource(psR: psR);
                              });
                            }
                            // isKormiWiseRaiRfi
                            //     ? await psR.pssReprtProvider(brnchName: up.getbrnchID, isBrnchRep: true)
                            //     :
                            isgrpwiserairfi
                                ? await psR.pssReprtProvider(brnchName: up.getbrnchID, kormiID: kormiID!)
                                : isCollSheet
                                    ? await psR.kormiWiseCollectionProvider(branchID: up.getbrnchID)
                                    : isgrpMemWiseCoReport
                                        ? await psR.groupWiseCollectionProvider(
                                            branchID: up.getbrnchID,
                                            groupId: giD!,
                                            kormiId: kormiID!,
                                          )
                                        : isgrpWiseCReport
                                            ? await psR.groupWiseCollectionProvider(
                                                branchID: up.getbrnchID,
                                                groupId: giD!,
                                                kormiId: kormiID!,
                                              )
                                            : isgrpMemWise
                                                ? await psR.pssReprtProvider(
                                                    brnchName: up.getbrnchID,
                                                    kormiID: kormiID!,
                                                    gID: giD!,
                                                  )
                                                : () {};
                          },
                          style: ButtonStyle(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              //padding: const EdgeInsets.all(4),
              height: Dimensions.fullHeight(context) / 4,
              width: Dimensions.fullWidth(context),
              decoration: BoxDecoration(color: const Color.fromARGB(255, 253, 248, 248), boxShadow: [
                BoxShadow(color: mt.Colors.grey[300]!, blurRadius: 0.5),
                const BoxShadow(color: mt.Colors.grey, blurRadius: 0.5),
                BoxShadow(color: mt.Colors.grey[200]!, blurRadius: 0.5),
              ]),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 300,
                        // color: Colors.yellow,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text('ADC Name'),
                            ),
                            SizedBox(
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
                                decoration: BoxDecoration(
                                    color: Colors.white, border: Border.all(color: Color.fromARGB(255, 156, 154, 152))),
                                trailingIcon: const mt.Icon(mt.Icons.arrow_drop_down),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 300,
                        //color: Colors.yellow,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text('Branch Name '),
                            ),
                            SizedBox(
                              width: 200,
                              child: AutoSuggestBox(
                                placeholder: 'Select Branch',
                                style: const TextStyle(fontSize: 10),
                                items: up
                                    .findADCwiseBranch(up.selectAdcIdforBrnch)
                                    .map((e) => AutoSuggestBoxItem(
                                          value: e.aName,
                                          onSelected: () {
                                            up.getbrnchIDforMember(gID: e.adcid);
                                            up.findkormiFromBranchList(e.adcid!);
                                            up.groupWiseKormiProvider(context, e.adcid!);
                                          },
                                          label: e.aName!,
                                        ))
                                    .toList(),
                                decoration: BoxDecoration(
                                    color: Colors.white, border: Border.all(color: Color.fromARGB(255, 156, 154, 152))),
                                trailingIcon: const mt.Icon(mt.Icons.arrow_drop_down),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 300,
                        //  color: Colors.yellow,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text('Kormi Name '),
                            ),
                            SizedBox(
                              width: 200,
                              child: AutoSuggestBox(
                                placeholder: 'Select Member',
                                items: up.kormiFromBrnch
                                    .map((e) => AutoSuggestBoxItem(
                                          value: e.lName!,
                                          label: e.lName!,
                                          onSelected: () async {
                                            debugPrint('is it clear ${psR.kwiseshomitiList}');
                                            setState(() {
                                              psR.kwiseshomitiList.clear();
                                              kormiID = e.stafid;
                                              kName = e.lName!;
                                              getShomitiName = null;
                                            });
                                            up.findShomitiofKormi(kormiID!);
                                          },
                                        ))
                                    .toList(),
                                decoration: BoxDecoration(
                                    color: Colors.white, border: Border.all(color: Color.fromARGB(255, 156, 154, 152))),
                                trailingIcon: const mt.Icon(mt.Icons.arrow_drop_down),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 360,
                        // color: Colors.yellow,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text('Report Title'),
                            ),
                            Container(
                              width: 260,
                              // height: 32,
                              decoration: BoxDecoration(border: Border.all(color: Color.fromARGB(255, 156, 154, 152))),
                              child: ComboBox(
                                value: selectedText,
                                items: psR.pssCategoryList
                                    .map<ComboBoxItem<String>>(
                                      (e) => ComboBoxItem(
                                        value: e.name,
                                        onTap: () {
                                          debugPrint('print ${e.id}');
                                          // up.clearName();
                                          switch (e.id) {
                                            case 1:
                                              setState(() {
                                                isgrpMemWise = true; //group member wise rai rfi report
                                                isKormiWiseRaiRfi = false;
                                                isgrpwiserairfi = false;
                                                isCollSheet = false;
                                                isgrpMemWiseCoReport = false;
                                                isgrpWiseCReport = false;
                                              });
                                              if (isgrpMemWise) {
                                                up.clearKormiName();
                                                psR.brnchWisePssList.clear();
                                                psR.pssReportsList.clear();
                                                psR.kormiWiseCollectionList.clear();
                                                psR.grpMemwiseModelList.clear();
                                                psR.kormiWisegrpMemberList.clear();
                                                psR.kwiseshomitiList.clear();
                                              }
                                              break;

                                            case 2:
                                              setState(() {
                                                isgrpwiserairfi = true; //Group wise rai rfi
                                                isKormiWiseRaiRfi = false;
                                                isCollSheet = false;
                                                isgrpMemWise = false;
                                                isgrpMemWiseCoReport = false;
                                                isgrpWiseCReport = false;
                                              });
                                              if (isgrpwiserairfi) {
                                                up.clearKormiName();
                                                psR.brnchWisePssList.clear();
                                                psR.pssReportsList.clear();
                                                psR.kormiWiseCollectionList.clear();
                                                psR.grpMemwiseModelList.clear();
                                                psR.kormiWisegrpMemberList.clear();
                                                psR.kwiseshomitiList.clear();
                                              }

                                              break;
                                            case 3:
                                              setState(() {
                                                isKormiWiseRaiRfi = true; //kormi wise rai rfi
                                                isgrpwiserairfi = false;
                                                isCollSheet = false;
                                                isgrpMemWise = false;
                                                isgrpMemWiseCoReport = false;
                                                isgrpWiseCReport = false;
                                              });
                                              if (isKormiWiseRaiRfi) {
                                                up.clearKormiName();
                                                psR.brnchWisePssList.clear();
                                                psR.pssReportsList.clear();
                                                psR.kormiWiseCollectionList.clear();
                                                psR.grpMemwiseModelList.clear();
                                                psR.kormiWisegrpMemberList.clear();
                                                psR.kwiseshomitiList.clear();
                                              }
                                              break;

                                            case 4:
                                              setState(() {
                                                isgrpMemWiseCoReport = true; //grp member wise collection report
                                                isKormiWiseRaiRfi = false;
                                                isgrpwiserairfi = false;
                                                isCollSheet = false;
                                                isgrpWiseCReport = false;
                                                isgrpMemWise = false;
                                              });
                                              if (isgrpMemWiseCoReport) {
                                                up.clearKormiName();
                                                psR.brnchWisePssList.clear();
                                                psR.pssReportsList.clear();
                                                psR.kormiWiseCollectionList.clear();
                                                psR.grpMemwiseModelList.clear();
                                                psR.kormiWisegrpMemberList.clear();
                                                psR.kwiseshomitiList.clear();
                                                psR.groupWiseCollectionList.clear();
                                              }
                                              break;
                                            // setState(() {
                                            //   isgrpMemWise = true; //group member wise rai rfi report
                                            //   isKormiWiseRaiRfi = false;
                                            //   isgrpwiserairfi = false;
                                            //   isCollSheet = false;
                                            //   isgrpMemWiseCoReport = false;
                                            //   isgrpWiseCReport = false;
                                            // });
                                            // if (isgrpMemWise) {
                                            //   up.clearKormiName();
                                            //   psR.brnchWisePssList.clear();
                                            //   psR.pssReportsList.clear();
                                            //   psR.kormiWiseCollectionList.clear();
                                            //   psR.grpMemwiseModelList.clear();
                                            //   psR.kormiWisegrpMemberList.clear();
                                            //   psR.kwiseshomitiList.clear();
                                            // }
                                            // break;

                                            case 5:
                                              setState(() {
                                                isgrpWiseCReport = true; //group wise collection report
                                                isgrpMemWiseCoReport = false;
                                                isKormiWiseRaiRfi = false;
                                                isgrpwiserairfi = false;
                                                isCollSheet = false;
                                                isgrpMemWise = false;
                                              });
                                              if (isgrpWiseCReport) {
                                                up.clearKormiName();
                                                psR.groupWiseColList.clear();
                                                psR.brnchWisePssList.clear();
                                                psR.pssReportsList.clear();
                                                psR.kormiWiseCollectionList.clear();
                                                psR.grpMemwiseModelList.clear();
                                                psR.kormiWisegrpMemberList.clear();
                                                psR.kwiseshomitiList.clear();
                                              }
                                              break;

                                            case 6:
                                              setState(() {
                                                isCollSheet = true; //kormi wise collection report
                                                isKormiWiseRaiRfi = false;
                                                isgrpwiserairfi = false;
                                                isgrpMemWise = false;
                                                isgrpMemWiseCoReport = false;
                                                isgrpWiseCReport = false;
                                              });
                                              if (isCollSheet) {
                                                up.clearKormiName();
                                                psR.brnchWisePssList.clear();
                                                psR.pssReportsList.clear();
                                                psR.kormiWiseCollectionList.clear();
                                                psR.grpMemwiseModelList.clear();
                                                psR.kormiWisegrpMemberList.clear();
                                                psR.kwiseshomitiList.clear();
                                              }
                                              break;

                                            default:
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: FittedBox(
                                              child: Text(
                                            e.name!,
                                          )),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedText = value as String;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 360,
                        // color: Colors.yellow,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text('Report Option'),
                            ),
                            Container(
                              width: 260,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 151, 151, 149),
                                  border: Border.all(color: Color.fromARGB(255, 156, 154, 152))),
                              child: ComboBox(
                                placeholder: Text('Report Options'),
                                items: [
                                  ComboBoxItem(
                                    child: Text('Type 1'),
                                  ),
                                  ComboBoxItem(
                                    child: Text('Type 2'),
                                  ),
                                  ComboBoxItem(
                                    child: Text('Type 3'),
                                  ),
                                  ComboBoxItem(
                                    child: Text('Type 4'),
                                  ),
                                ],
                                onChanged: (value) {},
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 360,
                        //  color: Colors.yellow,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text('Group Name '),
                            ),
                            SizedBox(
                              width: 260,
                              child: AutoSuggestBox(
                                placeholder: 'Select Shomiti',
                                items: up.kormiwiseshomitiList.map((e) {
                                  return AutoSuggestBoxItem(
                                    value: e.sgName,
                                    onSelected: () async {
                                      // psR.kormiWisegrpMemberList.clear();
                                      setState(() {
                                        giD = e.sgGroup as String?;
                                        isRepClick = false;
                                      });
                                      // await psR.pssReprtProvider(
                                      //     brnchName: up.getbrnchID, kormiID: kormiID!, gID: giD, isMem: true);
                                    },
                                    label: e.sgName!,
                                  );
                                }).toList(),
                                onSelected: (value) {
                                  setState(() {
                                    getShomitiName = value as String;
                                  });
                                },
                                decoration: BoxDecoration(
                                    color: Colors.white, border: Border.all(color: Color.fromARGB(255, 156, 154, 152))),
                                trailingIcon: const mt.Icon(mt.Icons.arrow_drop_down),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            (isKormiWiseRaiRfi && kormiWiseRAIRFISource != null)
                ? Expanded(
                    child: SfDataGrid(
                      source: kormiWiseRAIRFISource!,
                      columnWidthMode: ColumnWidthMode.fill,
                      allowColumnsResizing: true,
                      columnResizeMode: ColumnResizeMode.onResize,
                      rowHeight: 80,

                      //columnResizeMode: ColumnResizeMode.onResizeEnd,
                      //columnWidthMode: ColumnWidthMode.auto,
                      onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
                        setState(() {
                          columnWidths[details.column.columnName] = details.width;
                        });
                        //psR.setColumWidth(details);

                        return true;
                      },
                      onColumnResizeStart: (ColumnResizeStartDetails details) {
                        return true;
                      },
                      // columnWidthCalculationRange: ColumnWidthCalculationRange.allRows,

                      columns: <GridColumn>[
                        GridColumn(
                            width: columnWidths['Kormi No']!,
                            columnName: 'Kormi No',
                            label: Container(
                                padding: EdgeInsets.all(16.0),
                                alignment: Alignment.center,
                                child: Text(
                                  'Kormi No',
                                ))),
                        GridColumn(
                            width: columnWidths['Kormi Name']!,
                            columnName: 'Kormi Name',
                            label:
                                Container(padding: EdgeInsets.all(8.0), alignment: Alignment.center, child: Text('Kormi Name'))),
                        GridColumn(
                            width: columnWidths['Total grp']!,
                            columnName: 'Total grp',
                            label: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text(
                                  'Total grp',
                                  overflow: TextOverflow.ellipsis,
                                ))),
                        GridColumn(
                          columnName: 'Total Mem',
                          label: Container(
                            padding: EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: Text('Total Member'),
                          ),
                        ),
                        GridColumn(
                          columnName: 'Dep grp',
                          label: Container(
                            padding: EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: Text('Dep grp'),
                          ),
                        ),
                        GridColumn(
                          columnName: 'Dep Mem',
                          label: Container(
                            padding: EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: Text('Dep Mem'),
                          ),
                        ),
                        GridColumn(
                          columnName: 'Opening Bal',
                          label: Container(
                            padding: EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: Text('Opening Bal'),
                          ),
                        ),
                        GridColumn(
                          columnName: 'Pss Target',
                          label: Container(
                            padding: EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: Text('Pss Target'),
                          ),
                        ),
                        GridColumn(
                          columnName: 'Pss Achieve',
                          label: Container(
                            padding: EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: Text('Pss Achieve'),
                          ),
                        ),
                        GridColumn(
                          columnName: 'RAI',
                          label: Container(
                            padding: EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: Text('RAI'),
                          ),
                        ),
                        GridColumn(
                          columnName: 'RFI',
                          label: Container(
                            padding: EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: Text('RFI'),
                          ),
                        ),
                        GridColumn(
                          columnName: 'Closing Balance',
                          label: Container(
                            padding: EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: Text('Closing Balance'),
                          ),
                        ),
                      ],
                    ),
                  )
                // Expanded(
                //     child: mt.ListView.builder(
                //       itemCount: psR.brnchWisePssList.length,
                //       itemBuilder: (context, index) {
                //         return mt.Material(
                //           elevation: 5,
                //           child: Container(
                //             margin: const EdgeInsets.symmetric(vertical: 8),

                //             //height: 200,
                //             decoration: BoxDecoration(
                //               color: Colors.white,
                //               borderRadius: BorderRadius.circular(10),
                //               border: Border.all(color: Color.fromARGB(255, 156, 154, 152)),
                //             ),

                //             child: Column(
                //               children: [
                //                 reportTile(title: 'Sl. No', value: (index + 1).toString()),
                //                 reportTile(title: 'Kormi No', value: psR.brnchWisePssList[index].kormi ?? ''),
                //                 reportTile(title: 'Kormi Name', value: psR.brnchWisePssList[index].korminam ?? ''),
                //                 reportTile(title: 'Total grp', value: psR.brnchWisePssList[index].totgroup.toString()),
                //                 reportTile(title: 'Total Member', value: psR.brnchWisePssList[index].totmem.toString()),
                //                 reportTile(title: 'Dep grp', value: psR.brnchWisePssList[index].depgroup.toString()),
                //                 reportTile(title: 'Dep Mem', value: psR.brnchWisePssList[index].depmem.toString()),
                //                 reportTile(
                //                     title: 'OPening Balance', value: psR.brnchWisePssList[index].openam!.toStringAsFixed(0)),
                //                 reportTile(title: 'Pss Target', value: psR.brnchWisePssList[index].scham!.toStringAsFixed(0)),
                //                 reportTile(title: 'Pss Achieve', value: psR.brnchWisePssList[index].achivam!.toStringAsFixed(0)),
                //                 reportTile(title: 'RAI', value: psR.brnchWisePssList[index].regamp!.toStringAsFixed(0)),
                //                 reportTile(title: 'RFI', value: psR.brnchWisePssList[index].regfqp!.toStringAsFixed(0)),
                //                 reportTile(
                //                     title: 'Closing Balance', value: psR.brnchWisePssList[index].closam!.toStringAsFixed(0)),
                //               ],
                //             ),
                //           ),
                //         );
                //       },
                //     ),
                //   )
                : isgrpwiserairfi
                    ? Expanded(
                        child: mt.ListView.builder(
                            itemCount: psR.pssReportsList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),

                                //height: 200,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Column(
                                  children: [
                                    reportTile(
                                      title: 'G. No',
                                      value: psR.pssReportsList[index].groupid.toString(),
                                    ),
                                    reportTile(
                                      title: 'Group Name',
                                      value: psR.pssReportsList[index].sgName!,
                                    ),
                                    reportTile(
                                      title: 'Total Member',
                                      value: psR.pssReportsList[index].totmem.toString(),
                                    ),
                                    reportTile(
                                      title: 'Depo Member',
                                      value: psR.pssReportsList[index].depmem!.toStringAsFixed(0),
                                    ),
                                    reportTile(
                                      title: 'PSS Target',
                                      value: psR.pssReportsList[index].scham!.toStringAsFixed(0),
                                    ),
                                    reportTile(
                                      title: 'PSS Achieve',
                                      value: psR.pssReportsList[index].achivam!.toStringAsFixed(0),
                                    ),
                                    reportTile(
                                      title: 'RAI',
                                      value: psR.pssReportsList[index].regamp!.toStringAsFixed(0),
                                    ),
                                    reportTile(
                                      title: 'RFI',
                                      value: psR.pssReportsList[index].regfqp!.toStringAsFixed(0),
                                    ),
                                    reportTile(
                                      title: 'Pss Balance',
                                      value: psR.pssReportsList[index].closam!.toStringAsFixed(0),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      )
                    : isCollSheet
                        ? Expanded(
                            child: mt.ListView.builder(
                                itemCount: psR.kormiWiseCollectionList.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(vertical: 8),

                                    //height: 200,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 250, 255, 243),
                                      // borderRadius: BorderRadius.circular(10),
                                      //border: Border.all(color: Colors.black),
                                    ),
                                    child: Column(
                                      children: [
                                        reportTile(title: 'Sl. No', value: (index + 1).toString()),
                                        reportTile(title: 'K. ID', value: psR.kormiWiseCollectionList[index].kormi!),
                                        reportTile(
                                            title: 'Kormi Name', value: psR.kormiWiseCollectionList[index].lName.toString()),
                                        reportTile(
                                            title: 'PSS Collection',
                                            value: psR.kormiWiseCollectionList[index].psscoll!.toStringAsFixed(0)),
                                        reportTile(
                                            title: 'ESSP Collection',
                                            value: psR.kormiWiseCollectionList[index].esspcoll!.toStringAsFixed(0)),
                                        reportTile(
                                            title: 'PLSS Collection',
                                            value: psR.kormiWiseCollectionList[index].plsscoll!.toStringAsFixed(0)),
                                        reportTile(
                                            title: 'PSSS Collection',
                                            value: psR.kormiWiseCollectionList[index].pssscoll!.toStringAsFixed(0)),
                                        reportTile(
                                            title: 'DBSS Collection',
                                            value: psR.kormiWiseCollectionList[index].dbsscoll!.toStringAsFixed(0)),
                                        reportTile(
                                            title: 'Realization(prm+Sch)',
                                            value: psR.kormiWiseCollectionList[index].realamt!.toStringAsFixed(0)),
                                        // reportTile(
                                        //     title: 'Total',
                                        //     value: psR
                                        //         .kormiWiseCollectionList[
                                        //             index]
                                        //         .totamt
                                        //         .toString()),
                                      ],
                                    ),
                                  );
                                }),
                          )
                        : isgrpMemWiseCoReport
                            ? Expanded(
                                child: mt.ListView.builder(
                                    itemCount: psR.groupWiseCollectionList.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: const EdgeInsets.symmetric(vertical: 8),

                                        //height: 200,
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(255, 250, 255, 243),
                                          // borderRadius: BorderRadius.circular(10),
                                          //border: Border.all(color: Colors.black),
                                        ),
                                        child: Column(
                                          children: [
                                            reportTile(title: 'Sl. No', value: (index + 1).toString()),
                                            reportTile(title: 'Member Name', value: psR.groupWiseCollectionList[index].smName!),
                                            reportTile(
                                                title: 'Pss',
                                                value: psR.groupWiseCollectionList[index].psscoll!.toStringAsFixed(0)),
                                            reportTile(
                                                title: 'ESSP',
                                                value: psR.groupWiseCollectionList[index].esspcoll!.toStringAsFixed(0)),
                                            reportTile(
                                                title: 'PSSS',
                                                value: psR.groupWiseCollectionList[index].pssscoll!.toStringAsFixed(0)),
                                            reportTile(
                                                title: 'DBSS',
                                                value: psR.groupWiseCollectionList[index].dbsscoll!.toStringAsFixed(0)),
                                            reportTile(
                                                title: 'PLSS',
                                                value: psR.groupWiseCollectionList[index].plsscoll!.toStringAsFixed(0)),
                                            reportTile(
                                                title: 'LOAN REAL',
                                                value: psR.groupWiseCollectionList[index].realamt!.toStringAsFixed(0)),
                                            reportTile(
                                                title: 'TOTAL AMT',
                                                value: psR.groupWiseCollectionList[index].realamt!.toStringAsFixed(0)),
                                            // reportTile(
                                            //     title: 'Total',
                                            //     value: psR
                                            //         .kormiWiseCollectionList[
                                            //             index]
                                            //         .totamt
                                            //         .toString()),
                                          ],
                                        ),
                                      );
                                    }),
                              )
                            : isgrpWiseCReport
                                ? Expanded(
                                    child: mt.ListView.builder(
                                        itemCount: psR.groupWiseColList.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: const EdgeInsets.symmetric(vertical: 8),

                                            //height: 200,
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(255, 250, 255, 243),
                                              // borderRadius: BorderRadius.circular(10),
                                              //border: Border.all(color: Colors.black),
                                            ),
                                            child: Column(
                                              children: [
                                                reportTile(title: 'Sl. No', value: (index + 1).toString()),
                                                reportTile(title: 'Group Name', value: psR.groupWiseColList[index].sgName!),
                                                reportTile(
                                                    title: 'Pss', value: psR.groupWiseColList[index].psscoll!.toStringAsFixed(0)),
                                                reportTile(
                                                    title: 'ESSP',
                                                    value: psR.groupWiseColList[index].esspcoll!.toStringAsFixed(0)),
                                                reportTile(
                                                    title: 'PSSS',
                                                    value: psR.groupWiseColList[index].pssscoll!.toStringAsFixed(0)),
                                                reportTile(
                                                    title: 'DBSS',
                                                    value: psR.groupWiseColList[index].dbsscoll!.toStringAsFixed(0)),
                                                reportTile(
                                                    title: 'PLSS',
                                                    value: psR.groupWiseColList[index].plsscoll!.toStringAsFixed(0)),
                                                reportTile(
                                                    title: 'LOAN REAL',
                                                    value: psR.groupWiseColList[index].realamt!.toStringAsFixed(0)),
                                                reportTile(
                                                    title: 'TOTAL AMT',
                                                    value: psR.groupWiseColList[index].realamt!.toStringAsFixed(0)),
                                                // reportTile(
                                                //     title: 'Total',
                                                //     value: psR
                                                //         .kormiWiseCollectionList[
                                                //             index]
                                                //         .totamt
                                                //         .toString()),
                                              ],
                                            ),
                                          );
                                        }),
                                  )
                                : isgrpMemWise
                                    ? Expanded(
                                        child: mt.ListView.builder(
                                          itemCount: psR.grpMemwiseModelList.length,
                                          itemBuilder: (context, index) {
                                            return mt.Material(
                                              elevation: 5,
                                              child: Container(
                                                margin: const EdgeInsets.symmetric(vertical: 8),

                                                //height: 200,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border.all(color: Colors.black),
                                                ),

                                                child: Column(
                                                  children: [
                                                    reportTile(title: 'Sl. No', value: (index + 1).toString()),
                                                    reportTile(
                                                        title: 'group Name', value: psR.grpMemwiseModelList[index].sgName ?? ''),
                                                    reportTile(
                                                        title: 'Member Name', value: psR.grpMemwiseModelList[index].smName ?? ''),
                                                    reportTile(
                                                        title: 'Pss Target',
                                                        value: psR.grpMemwiseModelList[index].scham.toString()),
                                                    reportTile(
                                                        title: 'Pss Achieve',
                                                        value: psR.grpMemwiseModelList[index].achivam.toString()),
                                                    reportTile(
                                                        title: 'RAI', value: psR.grpMemwiseModelList[index].regamp.toString()),
                                                    reportTile(
                                                        title: 'RFI', value: psR.grpMemwiseModelList[index].regfqp.toString()),
                                                    reportTile(
                                                        title: 'PSS Balance',
                                                        value: psR.grpMemwiseModelList[index].closam.toString()),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    : SizedBox.shrink(),
            // mt.Material(
            //   child: SingleChildScrollView(
            //     child: Container(
            //       color: Colors.white,
            //       padding: const EdgeInsets.all(8),
            //       // width: Dimensions.fullWidth(context),
            //       // height: Dimensions.fullHeight(context),
            //       child: Column(
            //         children: [
            //           // isKormiWiseRaiRfi
            //           //   ? Expanded(
            //           //       child: ListView.builder(
            //           //         itemCount: psR.brnchWisePssList.length,
            //           //         itemBuilder: (context, index) {
            //           //           return Material(
            //           //             elevation: 5,
            //           //             child: Container(
            //           //               margin: const EdgeInsets.symmetric(vertical: 8),

            //           //               //height: 200,
            //           //               decoration: BoxDecoration(
            //           //                 color: Colors.white,
            //           //                 borderRadius: BorderRadius.circular(10),
            //           //                 border: Border.all(color: Colors.black),
            //           //               ),

            //           //               child: Column(
            //           //                 children: [
            //           //                   reportTile(title: 'Sl. No', value: (index + 1).toString()),
            //           //                   reportTile(title: 'Kormi No', value: psR.brnchWisePssList[index].kormi ?? ''),
            //           //                   reportTile(title: 'Kormi Name', value: psR.brnchWisePssList[index].korminam ?? ''),
            //           //                   reportTile(title: 'Total grp', value: psR.brnchWisePssList[index].totgroup.toString()),
            //           //                   reportTile(title: 'Total Member', value: psR.brnchWisePssList[index].totmem.toString()),
            //           //                   reportTile(title: 'Dep grp', value: psR.brnchWisePssList[index].depgroup.toString()),
            //           //                   reportTile(title: 'Dep Mem', value: psR.brnchWisePssList[index].depmem.toString()),
            //           //                   reportTile(
            //           //                       title: 'OPening Balance',
            //           //                       value: psR.brnchWisePssList[index].openam!.toStringAsFixed(0)),
            //           //                   reportTile(
            //           //                       title: 'Pss Target', value: psR.brnchWisePssList[index].scham!.toStringAsFixed(0)),
            //           //                   reportTile(
            //           //                       title: 'Pss Achieve', value: psR.brnchWisePssList[index].achivam!.toStringAsFixed(0)),
            //           //                   reportTile(title: 'RAI', value: psR.brnchWisePssList[index].regamp!.toStringAsFixed(0)),
            //           //                   reportTile(title: 'RFI', value: psR.brnchWisePssList[index].regfqp!.toStringAsFixed(0)),
            //           //                   reportTile(
            //           //                       title: 'Closing Balance',
            //           //                       value: psR.brnchWisePssList[index].closam!.toStringAsFixed(0)),
            //           //                 ],
            //           //               ),
            //           //             ),
            //           //           );
            //           //         },
            //           //       ),
            //           //     )

            //           isCollSheet
            //               ? Expanded(
            //                   child: PlutoGrid(
            //                     mode: PlutoGridMode.readOnly,
            //                     onLoaded: (PlutoGridOnLoadedEvent event) {
            //                       event.stateManager.setShowColumnFilter(false);
            //                     },
            //                     columns: [
            //                       PlutoColumn(
            //                         title: 'K.ID',
            //                         field: 'id',
            //                         readOnly: true,
            //                         type: PlutoColumnType.text(),
            //                       ),
            //                       PlutoColumn(
            //                         title: 'Kormi Name',
            //                         field: 'name',
            //                         readOnly: true,
            //                         type: PlutoColumnType.text(),
            //                       ),
            //                       PlutoColumn(
            //                         title: 'PSS',
            //                         field: 'pss',
            //                         readOnly: true,
            //                         type: PlutoColumnType.text(),
            //                       ),
            //                       PlutoColumn(
            //                         title: 'ESSP',
            //                         field: 'essp',
            //                         readOnly: true,
            //                         type: PlutoColumnType.text(),
            //                       ),
            //                       PlutoColumn(
            //                         title: 'PLSS',
            //                         field: 'plss',
            //                         readOnly: true,
            //                         type: PlutoColumnType.text(),
            //                       ),
            //                       PlutoColumn(
            //                         title: 'PSSS',
            //                         field: 'psss',
            //                         readOnly: true,
            //                         type: PlutoColumnType.text(),
            //                       ),
            //                       PlutoColumn(
            //                         title: 'DBSS',
            //                         field: 'dbss',
            //                         readOnly: true,
            //                         type: PlutoColumnType.text(),
            //                       ),
            //                     ],
            //                     rows: psR.kormiWiseCollectionList
            //                         .map((e) => PlutoRow(
            //                               cells: {
            //                                 'id': PlutoCell(value: '${e.kormi}'),
            //                                 'name': PlutoCell(value: '${e.lName}'),
            //                                 'pss': PlutoCell(value: '${e.psscoll}'),
            //                                 'essp': PlutoCell(value: '${e.esspcoll}'),
            //                                 'plss': PlutoCell(value: '${e.plsscoll}'),
            //                                 'psss': PlutoCell(value: '${e.pssscoll}'),
            //                                 'dbss': PlutoCell(value: '${e.dbsscoll}')
            //                               },
            //                               type: PlutoRowType.normal(),
            //                             ))
            //                         .toList(),
            //                     configuration: PlutoGridConfiguration(
            //                       style: PlutoGridStyleConfig.dark(
            //                         activatedBorderColor: Colors.transparent,
            //                         borderColor: mt.Colors.black26,
            //                         gridBorderColor: mt.Colors.black54,
            //                         activatedColor: mt.Colors.black26,
            //                         gridBackgroundColor: Color.fromRGBO(40, 46, 58, 1),
            //                         rowColor: Color.fromRGBO(49, 56, 72, 1),
            //                         checkedColor: mt.Colors.blueGrey,
            //                       ),
            //                       // columnFilter: PlutoGridColumnFilterConfig(
            //                       //   filters: const [
            //                       //     ...FilterHelper.defaultFilters,
            //                       //     // custom filter
            //                       //     //ClassYouImplemented(),
            //                       //   ],
            //                       //   resolveDefaultColumnFilter: (column, resolver) {
            //                       //     if (column.field == 'text') {
            //                       //       return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            //                       //     } else if (column.field == 'number') {
            //                       //       return resolver<PlutoFilterTypeGreaterThan>() as PlutoFilterType;
            //                       //     } else if (column.field == 'date') {
            //                       //       return resolver<PlutoFilterTypeLessThan>() as PlutoFilterType;
            //                       //     } else if (column.field == 'select') {
            //                       //       // return resolver<ClassYouImplemented>() as PlutoFilterType;
            //                       //     }

            //                       //     return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            //                       //   },
            //                       // ),
            //                       columnSize: PlutoGridColumnSizeConfig(
            //                         autoSizeMode: PlutoAutoSizeMode.equal,
            //                         resizeMode: PlutoResizeMode.none,
            //                       ),
            //                     ),

            //                     onChanged: null,
            //                     //  configuration: const PlutoGridConfiguration(),
            //                   ),
            //                 )
            //               : SizedBox.shrink(),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      );
    });
  }

  reportTile({String? title, String? value}) {
    return Container(
      height: 32,
      // margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 223, 247, 223),
        border: Border.all(color: mt.Colors.grey.shade400, width: 0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: Dimensions.fullWidth(context) / 2.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      title!,
                    ),
                  ),
                ),
                Text(
                  ':',
                  style: TextStyle(
                    fontSize: 15,
                    // color: Color.fromARGB(255, 52, 124, 54),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(value!),
            ),
          ),
        ],
      ),
    );
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

class KormiWiseRAIRFISource extends DataGridSource {
  /// Creates the employee data source class with required details.
  KormiWiseRAIRFISource({required PssReportProvider psR}) {
    _employeeData = psR.brnchWisePssList
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'Kormi No', value: e.kormi),
              DataGridCell<String>(columnName: 'Kormi name', value: e.korminam),
              DataGridCell<int>(columnName: 'Total grp', value: e.totgroup),
              DataGridCell<int>(columnName: 'Total Member', value: e.totmem),
              DataGridCell<int>(columnName: 'Dep grp', value: e.depgroup),
              DataGridCell<int>(columnName: 'Dep Mem', value: e.depmem),
              DataGridCell<String>(columnName: 'Opening Bal', value: e.openam!.toStringAsFixed(0)),
              DataGridCell<String>(columnName: 'Pss target', value: e.scham!.toStringAsFixed(0)),
              DataGridCell<String>(columnName: 'Pss Achieve', value: e.achivam!.toStringAsFixed(0)),
              DataGridCell<String>(columnName: 'RAI', value: e.regamp!.toStringAsFixed(0)),
              DataGridCell<String>(columnName: 'RFI', value: e.regfqp!.toStringAsFixed(0)),
              DataGridCell<String>(columnName: 'Closing Balance', value: e.closam!.toStringAsFixed(0)),
            ]))
        .toList();
  }
  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
