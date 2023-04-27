// import 'dart:typed_data';

// import 'package:dartx/dartx.dart';
// import 'package:date_format/date_format.dart';

// import '../../../Data/Model/branch_wise_pss_model.dart';
// import '../../../Data/Provider/user_config_provider.dart';
// import '../../../helper/date_converter.dart';
// import '../../../util/code_util.dart';
// import '../../../util/html_code.dart';

// // Future<Uint8List> kormiWiseRAIRFIPDf(PdfPageFormat pageFormat, List<BranchWisePssModel> brnchWisePssList, String title,
// //     String fromDate, String toDate, String adc, String branch) async {
// //   final doc = pw.Document(pageMode: PdfPageMode.outlines);
// //   doc.addPage(pw.MultiPage(
// //     pageFormat: PdfPageFormat.legal,
// //     build: (context) => <pw.Widget>[
// //       pw.Column(children: [
// //         pw.Center(
// //           child: pw.Text(
// //             'Proshika Manobik Unnayan Kendra',
// //             textScaleFactor: 1,
// //             style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold, lineSpacing: 2),
// //           ),
// //         ),
// //       ]),
// //       pw.Center(
// //         child: pw.Text(
// //           'Proshika Savings Scheme(PSS)',
// //           style: pw.TextStyle(
// //             fontSize: 13,
// //             fontWeight: pw.FontWeight.bold,
// //             lineSpacing: 2,
// //           ),
// //         ),
// //       ),
// //       pw.SizedBox(height: 10),
// //       pw.Center(
// //         child: pw.Text(
// //           title,
// //           style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold, lineSpacing: 2, color: PdfColor.fromInt(0xFF468FF4)),
// //         ),
// //       ),
// //       pw.Center(
// //         child: pw.Row(
// //           mainAxisAlignment: pw.MainAxisAlignment.center,
// //           children: [
// //             pw.Text('Date Range : '),
// //             pw.Text('${fromDate} to ${toDate}'),
// //           ],
// //         ),
// //       ),
// //       pw.SizedBox(height: 10),
// //       pw.Row(
// //         // mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
// //         children: [
// //           pw.Text('Branch:'),
// //           pw.SizedBox(width: 7),
// //           pw.Text('${branch} $adc'),
// //         ],
// //       ),
// //       pw.Divider(),
// //       pw.SizedBox(height: 10),
// //       brnchWisePssList.isNotEmpty
// //           ? pw.Table.fromTextArray(
// //               cellStyle: pw.TextStyle(fontSize: 7),
// //               headerStyle: pw.TextStyle(fontSize: 6, fontWeight: pw.FontWeight.bold),
// //               // headerDecoration: pw.BoxDecoration(
// //               //   color: PdfColor.fromInt(0xFFc7c7c7),

// //               //   //color: PdfColor.fromInt(0xFFc7c7c7),
// //               // ),
// //               cellAlignments: {
// //                 0: pw.Alignment.centerLeft,
// //                 1: pw.Alignment.centerLeft,
// //                 2: pw.Alignment.centerLeft,
// //                 3: pw.Alignment.centerLeft,
// //                 4: pw.Alignment.centerLeft,
// //                 5: pw.Alignment.centerLeft,
// //                 6: pw.Alignment.centerLeft,
// //                 7: pw.Alignment.centerRight,
// //                 8: pw.Alignment.centerRight,
// //                 9: pw.Alignment.centerRight,
// //                 10: pw.Alignment.centerRight,
// //                 11: pw.Alignment.centerRight,
// //                 12: pw.Alignment.centerRight,
// //                 13: pw.Alignment.centerRight,
// //               },
// //               headerAlignments: {
// //                 0: pw.Alignment.centerLeft,
// //                 1: pw.Alignment.centerLeft,
// //                 2: pw.Alignment.centerLeft,
// //                 3: pw.Alignment.centerLeft,
// //                 4: pw.Alignment.centerLeft,
// //                 5: pw.Alignment.centerLeft,
// //                 6: pw.Alignment.centerLeft,
// //                 7: pw.Alignment.centerLeft,
// //                 8: pw.Alignment.centerLeft,
// //                 9: pw.Alignment.centerLeft,
// //                 10: pw.Alignment.centerLeft,
// //                 11: pw.Alignment.centerLeft,
// //                 12: pw.Alignment.centerLeft,
// //                 13: pw.Alignment.centerLeft,
// //               },
// //               data: <List<dynamic>>[
// //                 <String>[
// //                   'Sl. NO',
// //                   'Kormi No',
// //                   'Kormi Name',
// //                   'Total.Grp',
// //                   'Tot.Mem.',
// //                   'Dep.Grp',
// //                   'Dep.Mem.',
// //                   'Opening Balance',
// //                   'PSS Target',
// //                   'PSS Achieve',
// //                   'RAI',
// //                   'RFI',
// //                   'Closing Balance'
// //                 ],
// //                 for (var i = 0; i < brnchWisePssList.length; i++)
// //                   <String>[
// //                     (i + 1).toString(),
// //                     brnchWisePssList[i].kormi ?? '',
// //                     brnchWisePssList[i].korminam ?? '',
// //                     brnchWisePssList[i].totgroup.toString(),
// //                     brnchWisePssList[i].totmem!.toString(),
// //                     brnchWisePssList[i].depgroup.toString(),
// //                     brnchWisePssList[i].depmem.toString(),
// //                     brnchWisePssList[i].openam!.toStringAsFixed(0),
// //                     brnchWisePssList[i].scham!.toStringAsFixed(0),
// //                     brnchWisePssList[i].achivam!.toStringAsFixed(0),
// //                     brnchWisePssList[i].regamp!.toStringAsFixed(0),
// //                     brnchWisePssList[i].regfqp!.toStringAsFixed(0),
// //                     brnchWisePssList[i].closam!.toStringAsFixed(0),
// //                   ],
// //               ],
// //               columnWidths: {
// //                 0: pw.FlexColumnWidth(2),
// //                 1: pw.FlexColumnWidth(3.5),
// //                 2: pw.FlexColumnWidth(7),
// //                 3: pw.FlexColumnWidth(2.4),
// //                 4: pw.FlexColumnWidth(2.5),
// //                 5: pw.FlexColumnWidth(2.5),
// //                 6: pw.FlexColumnWidth(2.5),
// //                 7: pw.FlexColumnWidth(4),
// //                 8: pw.FlexColumnWidth(4),
// //                 9: pw.FlexColumnWidth(3),
// //                 10: pw.FlexColumnWidth(3),
// //                 11: pw.FlexColumnWidth(2.5),
// //                 12: pw.FlexColumnWidth(2.5),
// //                 13: pw.FlexColumnWidth(4)
// //               },
// //             )
// //           : pw.Center(child: pw.Text('No Data'))
// //     ],
// //   ));
// //   return await doc.save();
// // }

// class KormiWiseRAIRFI {
//   static String htmlGenerator({
//     required String sl,
//     String? kNo,
//     String? kName,
//     int? totgroup,
//     int? totmem,
//     int? depgroup,
//     int? depmem,
//     String? openam,
//     String? scham,
//     String? achivam,
//     String? regamp,
//     String? regfqp,
//     String? closam,
//   }) {
//     return '''<tr style="height:50px">
// <td style="border:1px solid black;text-align:center">$sl</td>
// <td style="border:1px solid black;">$kNo</td>
// <td style="border:1px solid black;text-align:left;padding-left:5px;">$kName</td>
// <td style="border:1px solid black;text-align:center">$totgroup</td>
// <td style="border:1px solid black;text-align:center">$totmem</td>
// <td style="border:1px solid black;text-align:center">$depgroup</td>
// <td style="border:1px solid black;text-align:center">$depmem</td>
// <td style="border:1px solid black;text-align:right;padding-right:5px;padding-left: 20px">$openam</td>
// <td style="border:1px solid black;text-align:right;padding-right:5px;padding-left: 20px">$scham</td>
// <td style="border:1px solid black;text-align:right;padding-right:5px;padding-left: 20px">$achivam</td>
// <td style="border:1px solid black;text-align:right;padding-right:5px">$regamp</td>
// <td style="border:1px solid black;text-align:right;padding-right:5px">$regfqp</td>
// <td style="border:1px solid black;text-align:right;padding-right:5px">$closam</td>
// </tr>''';
//   }

//   static String kormiwiseRRReport(
//     List<BranchWisePssModel> kormiWiseRaiRfiList,
//     UserConfigProvider up,
//     String fromDate,
//     String toDate,
//     String brnch,
//     String adc,
//   ) {
//     var headerString = '''${HtmlCode.headerStyle}
// </head><h2 align="center">Proshika Manobik Unnayan Kendra</h2><table style="width:auto;border:none;background:none;border-collapse:collapse;">
// <h3 style="text-align:center;color:black;">Proshika Savings Scheme(PSS)</h3>
// <h4 style="text-align:center;color:blue;">Kormi Wise RAI and RFI (From $fromDate To $toDate)</h4>

// <p align="center">ADC:$adc</p>
// <p align="center">Branch: $brnch</p>

// <thead>
// <tr>
// <th style="border:1px solid black;">Sl.No</th>
// <th style="border:1px solid black;text-align:left;">Kormi No</th>
// <th style="border:1px solid black;text-align:left;">Kormi Name</th>
// <th style="border:1px solid black;text-align:left;">Total.Grp</th>
// <th style="border:1px solid black;text-align:left;">Tot.Mem.</th>
// <th style="border:1px solid black;text-align:left;">Dep.Grp</th>
// <th style="border:1px solid black;text-align:left;">Dep.Mem.</th>
// <th style="border:1px solid black;text-align:left;">Opening Balance</th>
// <th style="border:1px solid black;text-align:left;">PSS Target</th>
// <th style="border:1px solid black;text-align:left;">PSS Achieve</th>
// <th style="border:1px solid black;text-align:left;">RAI</th>
// <th style="border:1px solid black;text-align:left;">RFI</th>
// <th style="border:1px solid black;text-align:left;padding-left:10px">Closing Balance</th>

// </tr></thead>''';

//     String multiStr = '';
//     int totgrp = 0;
//     int totmem = 0;
//     double depgrp = 0.0;
//     double depmem = 0.0;
//     double opbal = 0.0;
//     double psstar = 0.0;
//     double pssach = 0.0;
//     double rai = 0;
//     double rfi = 0;
//     double closba = 0.0;

//     for (var i = 0; i < kormiWiseRaiRfiList.length; i++) {
//       totgrp += kormiWiseRaiRfiList[i].totgroup!;
//       totmem += kormiWiseRaiRfiList[i].totmem!;
//       depgrp += kormiWiseRaiRfiList[i].depgroup!;
//       depmem += kormiWiseRaiRfiList[i].depmem!;
//       opbal += kormiWiseRaiRfiList[i].openam!;
//       psstar += kormiWiseRaiRfiList[i].scham!;
//       pssach += kormiWiseRaiRfiList[i].achivam!;
//       rai = kormiWiseRaiRfiList.averageBy((element) => element.regamp!.toDouble());
//       rfi = kormiWiseRaiRfiList.averageBy((element) => element.regfqp!.toDouble());
//       closba += kormiWiseRaiRfiList[i].closam!;

//       multiStr += htmlGenerator(
//         sl: (i + 1).toString(),
//         kNo: kormiWiseRaiRfiList[i].kormi,
//         kName: kormiWiseRaiRfiList[i].korminam ?? '',
//         totgroup: kormiWiseRaiRfiList[i].totgroup,
//         totmem: kormiWiseRaiRfiList[i].totmem,
//         depgroup: kormiWiseRaiRfiList[i].depgroup,
//         depmem: kormiWiseRaiRfiList[i].depmem,
//         openam: CodeUtil.numberFormatInt(kormiWiseRaiRfiList[i].openam!),
//         scham: CodeUtil.numberFormatInt(kormiWiseRaiRfiList[i].scham!),
//         achivam: CodeUtil.numberFormatInt(kormiWiseRaiRfiList[i].achivam!),
//         regamp: CodeUtil.numberFormatInt(kormiWiseRaiRfiList[i].regamp!),
//         regfqp: CodeUtil.numberFormatInt(kormiWiseRaiRfiList[i].regfqp!),
//         closam: CodeUtil.numberFormatInt(kormiWiseRaiRfiList[i].closam!),
//       );
//     }
//     String endTag = '''
// <tr>
//     <td></td>
   
//     <td style="color:blue;font-weight:bold">Total</td>
       
//         <td></td>
//         <td style="text-align:right">$totgrp</td>
//         <td style="text-align:right">$totmem</td>
//         <td style="text-align:right">${depgrp.toStringAsFixed(0)}</td>
//          <td style="text-align:right">${CodeUtil.numberFormatInt(depmem)}</td>
//           <td style="text-align:right">${CodeUtil.numberFormatInt(opbal)}</td>
//            <td style="text-align:right">${CodeUtil.numberFormatInt(psstar)}</td>
//             <td style="text-align:right">${CodeUtil.numberFormatInt(pssach)}</td>
//              <td style="text-align:right">${rai.toStringAsFixed(0)}</td>
//               <td style="text-align:right">${rfi.toStringAsFixed(0)}</td>
//              <td style="text-align:right;padding-left:20px">${CodeUtil.numberFormatInt(closba)}</td>
//             </tr>
// <tfoot>
//         <tr>
//           <th colspan="8" style="font-weight: normal;padding-top: 20px; text-align:right; font-size: 8px;">Generated by ${up.userInfoModel!.lName},USER ID:${up.userInfoModel!.stafid},Date :${DateConverter.formatDate(DateTime.now())} </th>
//         </tr>
//       </tfoot>
//   </table></html>''';

//     // String? sampleString;

//     return (headerString + multiStr + endTag);
//   }
// }
