import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mt;

import 'package:pfmscodepack/pfmscodepack.dart';
import 'package:pfmscodepack/src/Data/Model/staff_information_model.dart';
import 'package:provider/provider.dart';
// import '../../Data/Model/staff_information_model.dart';

import '../../util/dimensions.dart';
import 'package:pluto_grid/pluto_grid.dart';

class KormiInfoScreen extends StatefulWidget {
  const KormiInfoScreen({super.key});

  @override
  State<KormiInfoScreen> createState() => _KormiInfoScreenState();
}

class _KormiInfoScreenState extends State<KormiInfoScreen> {
  final scrController = ScrollController();

  final txtController = TextEditingController();

  final List<PlutoColumn> columns = <PlutoColumn>[
    PlutoColumn(
      title: 'Id',
      field: 'id',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Kormi Name',
      field: 'name',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Gender',
      field: 'gender',
      type: PlutoColumnType.text(),
    ),
    // PlutoColumn(
    //   title: 'Role',
    //   field: 'role',
    //   type: PlutoColumnType.select(<String>[
    //     'Programmer',
    //     'Designer',
    //     'Owner',
    //   ]),
    // ),
    // PlutoColumn(
    //   title: 'Joined',
    //   field: 'joined',
    //   type: PlutoColumnType.date(),
    // ),
    // PlutoColumn(
    //   title: 'Working time',
    //   field: 'working_time',
    //   type: PlutoColumnType.time(),
    // ),
  ];
  final List<PlutoRow> rows = [];

  // final List<PlutoRow> rows = [
  //   PlutoRow(
  //     cells: {
  //       'id': PlutoCell(value: 'user1'),
  //       'name': PlutoCell(value: 'Mike'),
  //       'age': PlutoCell(value: 20),
  //       'role': PlutoCell(value: 'Programmer'),
  //       'joined': PlutoCell(value: '2021-01-01'),
  //       'working_time': PlutoCell(value: '09:00'),
  //     },
  //   ),
  //   PlutoRow(
  //     cells: {
  //       'id': PlutoCell(value: 'user2'),
  //       'name': PlutoCell(value: 'Jack'),
  //       'age': PlutoCell(value: 25),
  //       'role': PlutoCell(value: 'Designer'),
  //       'joined': PlutoCell(value: '2021-02-01'),
  //       'working_time': PlutoCell(value: '10:00'),
  //     },
  //   ),
  //   PlutoRow(
  //     cells: {
  //       'id': PlutoCell(value: 'user3'),
  //       'name': PlutoCell(value: 'Suzi'),
  //       'age': PlutoCell(value: 40),
  //       'role': PlutoCell(value: 'Owner'),
  //       'joined': PlutoCell(value: '2021-03-01'),
  //       'working_time': PlutoCell(value: '11:00'),
  //     },
  //   ),
  // ];

  /// columnGroups that can group columns can be omitted.
  final List<PlutoColumnGroup> columnGroups = [
    PlutoColumnGroup(title: 'Id', fields: ['id'], expandedColumn: true),
    PlutoColumnGroup(title: 'User information', fields: ['name', 'age']),
    PlutoColumnGroup(title: 'Status', children: [
      PlutoColumnGroup(title: 'A', fields: ['role'], expandedColumn: true),
      PlutoColumnGroup(title: 'Etc.', fields: ['joined', 'working_time']),
    ]),
  ];

  /// [PlutoGridStateManager] has many methods and properties to dynamically manipulate the grid.
  /// You can manipulate the grid dynamically at runtime by passing this through the [onLoaded] callback.
  late final PlutoGridStateManager stateManager;

  Future<List<StaffInformationModel>> getkormiList() async {
    return await Provider.of<KormiInformationProvider>(context, listen: false).getKormiData(context);
  }

  // kormiList() async {
  //   await Provider.of<KormiInformationProvider>(context, listen: false).kormiData(context);
  // }

  late Future<List<StaffInformationModel>> _func;

  @override
  void initState() {
    super.initState();
    _func = getkormiList();
  }

  List<StaffInformationModel>? data = [];
  List<StaffInformationModel>? searchdata = [];

  // rowFunc() {
  //   final p = Provider.of<KormiInformationProvider>(context, listen: false);

  //   for (var item in p.staffInformationModel) {
  //     final  cells = { '${3}' PlutoCell(value: e.value)};

  //     rows.add(PlutoRow(cells: cells));
  //   }
  // }

//   List<PlutoRow>fetchedRows(){

//   }

  // getPlutoRows() {
  //   stateManager.setShowLoading(true);

  //   PlutoGridStateManager.initializeRowsAsync(
  //     columns,
  //     fetchedRows,
  //   ).then((value) {
  //     stateManager.refRows.addAll(value);

  //     /// In this example,
  //     /// the loading screen is activated in the onLoaded callback when the grid is created.
  //     /// If the loading screen is not activated
  //     /// You must update the grid state by calling the stateManager.notifyListeners() method.
  //     /// Because calling setShowLoading updates the grid state
  //     /// No need to call stateManager.notifyListeners.
  //     stateManager.setShowLoading(false);
  //   });
  // }

  double scale = 0.9;
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    //  Typography typography = FluentTheme.of(context).typography;
    return Consumer2<UserConfigProvider, KormiInformationProvider>(builder: (context, up, kp, child) {
      return ScaffoldPage(
        header: PageHeader(
          title: Text(
            'Kormi Information',
            //  style: typography.bodyLarge,
          ),
        ),
        bottomBar: Container(
          width: Dimensions.fullWidth(context),
          height: 30,
          color: mt.Colors.white54,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Desktop APP'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 100,
                  child: Semantics(
                    label: 'Scale',
                    child: Slider(
                      vertical: false,
                      value: scale,
                      onChanged: (v) => setState(() => scale = v),
                      label: scale.toStringAsFixed(2),
                      max: 1.5,
                      min: 0.5,
                      // style: SliderThemeData(useThumbBall: false),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        content: Consumer2<UserConfigProvider, KormiInformationProvider>(builder: (context, up, kp, child) {
          return mt.Material(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(8),
                width: Dimensions.fullWidth(context),
                height: Dimensions.fullHeight(context),
                child: Column(
                  children: [
                    // Container(
                    //   height: Dimensions.fullHeight(context) / 6,
                    //   width: Dimensions.fullWidth(context),
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //   ),
                    // child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.symmetric(horizontal: 8),
                    //       child: SizedBox(
                    //         width: 200,
                    //         child: TextBox(
                    //           controller: txtController,
                    //           prefix: Padding(
                    //             padding: const EdgeInsets.only(left: 8.0),
                    //             child: Icon(FluentIcons.search),
                    //           ),
                    //           decoration: BoxDecoration(
                    //             border: Border.all(color: Colors.grey),
                    //           ),
                    //           onSubmitted: (value) {
                    //             setState(() {
                    //               searchText = value;
                    //             });
                    //           },
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    //  ),
                    // FutureBuilder<List<StaffInformationModel>>(
                    //   future: _func,
                    //   builder: (context, snapshot) {
                    //     if (snapshot.hasData) {
                    //       //   data = kp.searchFutureStaffData(snapshot.data!, searchText);

                    //       var data = snapshot.data;
                    //       return Expanded(
                    //         child: mt.DataTable(columns: columns, rows: rows)
                    //       );
                    //     }
                    //     return Center(
                    //       child: Column(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: <Widget>[
                    //           ProgressRing(value: 65),
                    //           // CircularProgressIndicator(),
                    //           SizedBox(height: 20),
                    //           Text('This may take some time..')
                    //         ],
                    //       ),
                    //     );
                    //   }),
                    FutureBuilder<List<StaffInformationModel>>(
                        future: _func,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            //   data = kp.searchFutureStaffData(snapshot.data!, searchText);

                            var data = snapshot.data;
                            return Expanded(
                              child: PlutoGrid(
                                mode: PlutoGridMode.readOnly,
                                onLoaded: (PlutoGridOnLoadedEvent event) {
                                  event.stateManager.setShowColumnFilter(false);
                                },
                                columns: [
                                  PlutoColumn(
                                    title: 'ID',
                                    field: 'id',
                                    readOnly: true,
                                    type: PlutoColumnType.text(),
                                  ),
                                  PlutoColumn(
                                    title: 'Kormi Name',
                                    field: 'name',
                                    readOnly: true,
                                    type: PlutoColumnType.text(),
                                  ),
                                  PlutoColumn(
                                    title: 'Designation',
                                    field: 'desig',
                                    readOnly: true,
                                    type: PlutoColumnType.text(),
                                  ),
                                  PlutoColumn(
                                    title: 'Gender',
                                    field: 'gender',
                                    readOnly: true,
                                    type: PlutoColumnType.text(),
                                  ),
                                ],
                                rows: data!
                                    .map((e) => PlutoRow(
                                          cells: {
                                            'id': PlutoCell(value: '${e.stafid}'),
                                            'name': PlutoCell(value: '${e.lName}'),
                                            'desig': PlutoCell(value: '${e.dsgSub}'),
                                            'gender': PlutoCell(value: '${e.gender}')
                                          },
                                          type: PlutoRowType.normal(),
                                        ))
                                    .toList(),
                                configuration: PlutoGridConfiguration(
                                  style: PlutoGridStyleConfig.dark(
                                    activatedBorderColor: Colors.transparent,
                                    borderColor: mt.Colors.black26,
                                    gridBorderColor: mt.Colors.black54,
                                    activatedColor: mt.Colors.black26,
                                    gridBackgroundColor: Color.fromRGBO(40, 46, 58, 1),
                                    rowColor: Color.fromRGBO(49, 56, 72, 1),
                                    checkedColor: mt.Colors.blueGrey,
                                  ),
                                  // columnFilter: PlutoGridColumnFilterConfig(
                                  //   filters: const [
                                  //     ...FilterHelper.defaultFilters,
                                  //     // custom filter
                                  //     //ClassYouImplemented(),
                                  //   ],
                                  //   resolveDefaultColumnFilter: (column, resolver) {
                                  //     if (column.field == 'text') {
                                  //       return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                                  //     } else if (column.field == 'number') {
                                  //       return resolver<PlutoFilterTypeGreaterThan>() as PlutoFilterType;
                                  //     } else if (column.field == 'date') {
                                  //       return resolver<PlutoFilterTypeLessThan>() as PlutoFilterType;
                                  //     } else if (column.field == 'select') {
                                  //       // return resolver<ClassYouImplemented>() as PlutoFilterType;
                                  //     }

                                  //     return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                                  //   },
                                  // ),
                                  columnSize: PlutoGridColumnSizeConfig(
                                    autoSizeMode: PlutoAutoSizeMode.equal,
                                    resizeMode: PlutoResizeMode.none,
                                  ),
                                ),

                                onChanged: null,
                                //  configuration: const PlutoGridConfiguration(),
                              ),
                            );
                          }
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ProgressRing(value: 65),
                                // CircularProgressIndicator(),
                                SizedBox(height: 20),
                                Text('This may take some time..')
                              ],
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ),
          );
        }),
        // content: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     SizedBox(
        //       width: 200,
        //       child: Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: AutoSuggestBox(
        //           controller: txtController,
        //           leadingIcon: Icon(FluentIcons.search),
        //           items: kp.staffInformationModel
        //               .map((e) =>
        //                   AutoSuggestBoxItem(value: e.stafid, label: e.lNameB!))
        //               .toList(),
        //           onChanged: (text, reason) {

        //           },
        //         ),
        //       ),
        //     ),
        //     Divider(),
        //     Expanded(
        //       child: ListView.builder(
        //         itemCount: kp.staffInformationModel.length,
        //         itemBuilder: (context, index) {
        //           var item = kp.staffInformationModel[index];
        //           return ListTile(
        //             subtitle: Text(item.stafid!),
        //             title: Text(item.lNameB!),
        //           );
        //         },
        //       ),
        //     ),
        //   ],
        // ),
        //content: [

        // SingleChildScrollView(
        //   child: mt.DataTable(
        //       columns: const [
        //         mt.DataColumn(
        //           label: Text('#Sl'),
        //         ),
        //         mt.DataColumn(
        //           label: Text(
        //             'Kormi ID ',
        //             overflow: TextOverflow.visible,
        //             softWrap: true,
        //           ),
        //         ),
        //         mt.DataColumn(
        //           label: Text(
        //             'Kormi Name ',
        //             overflow: TextOverflow.visible,
        //             softWrap: true,
        //           ),
        //         ),
        //         mt.DataColumn(
        //           label: Text('Joining Date'),
        //         ),
        //       ],
        //       rows: kp.staffInformationModel
        //           .map((e) => mt.DataRow(cells: [
        //                 mt.DataCell(
        //                   Text('${kp.staffInformationModel.indexOf(e) + 1}'),
        //                 ),
        //                 mt.DataCell(
        //                   Text('${e.stafid}'),
        //                 ),
        //                 mt.DataCell(
        //                   Text('${e.lNameB}'),
        //                 ),
        //                 mt.DataCell(
        //                   Text('${DateConverter.formatDateIOS(e.lDate!)}'),
        //                 ),
        //               ]))
        //           .toList()),
        // )
        // Transform.scale(
        //   // scale: 2.5,
        //   //alignment: Alignment.center,
        //   scaleX: scale,
        //   scaleY: scale * 40,
        //   origin: Offset(1, -10),
        //   child: Container(
        //     color: Colors.white,
        //     width: scale * 10,
        //     height: Dimensions.fullHeight(context),
        //     child: Column(
        //       children: [
        //         Text(
        //           'Dasddasdasdadsadasdddddddddddddddddddddddddd',
        //           style: TextStyle(color: Colors.black),
        //         ),
        //         Text(
        //           'Dasddasdasdadsadasd',
        //           style: TextStyle(fontSize: 12, color: Colors.black),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        //],
        // content: Column(
        //   children: [

        //   ],
        // ),
      );
    });
  }
}
