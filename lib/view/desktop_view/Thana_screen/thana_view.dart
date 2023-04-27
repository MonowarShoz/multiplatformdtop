import 'package:flutter/material.dart' as mt;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:pfmscodepack/pfmscodepack.dart';
import 'package:provider/provider.dart';

class ThanaViewScreen extends StatefulWidget {
  const ThanaViewScreen({super.key});

  @override
  State<ThanaViewScreen> createState() => _ThanaViewScreenState();
}

class _ThanaViewScreenState extends State<ThanaViewScreen> {
  @override
  Widget build(BuildContext context) {
    var ap = Provider.of<AreaInformationProvider>(context, listen: false);
    Provider.of<AreaInformationProvider>(context, listen: false).areaInformationProvider(context);
    return ScaffoldPage(
      header: PageHeader(
        title: Text('Thana'),
      ),
      content: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: ap.thanaList.length,
                itemBuilder: (context, index) {
                  var item = ap.thanaList[index];
                  return GestureDetector(
                    onTap: () async {},
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        //  color: Color.fromARGB(255, 217, 228, 217).withOpacity(0.7),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text('${item.aDivid!} ${item.divname!} ${item.divnamb}'),
                          ),

                          //  Divider(),
                          // ThanaTileWidget(
                          //   title: 'Division Name ',
                          //   color: Color.fromARGB(255, 182, 229, 183).withOpacity(0.3),
                          //   value: '${item.divname!} ${item.divnamb}',
                          // ),
                          //  Divider(),

                          // ThanaTileWidget(
                          //   title: 'Thana Code',
                          //   value: item.aThana!,
                          // ),
                          //  Divider(),

                          // Row(
                          //   children: [
                          //     Padding(
                          //       padding: const EdgeInsets.symmetric(horizontal: 9.0),
                          //       child: Text('ADC Name :'),
                          //     ),
                          //     Text(item.aName!),
                          //   ],
                          // ),
                        ],
                      ),
                      // child: ListTile(
                      //   title: Text(item.aName!),
                      //   subtitle: Text(item.adcid!),
                      // ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // content: Container(
      //   width: 200,
      //   child: TreeView(
      //     items: [
      //       TreeViewItem(content: Text('tree'), children: [
      //         TreeViewItem(content: Text('tree 1'), children: [
      //           TreeViewItem(
      //             content: Text('tree 1'),
      //           ),
      //           TreeViewItem(
      //             content: Text('tree 1'),
      //           ),
      //         ]),
      //         TreeViewItem(
      //           content: Text('tree 2'),
      //         )
      //       ])
      //     ],
      //   ),
      // ),
    );
  }
}
