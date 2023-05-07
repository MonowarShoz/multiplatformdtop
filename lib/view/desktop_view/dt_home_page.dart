import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mt;
import 'package:multiplatformdtop/view/desktop_view/Thana_screen/thana_view.dart';
import 'package:multiplatformdtop/view/desktop_view/reports/pss_report.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import '../base_widget/chicago_calender.dart';
import '../base_widget/desktop_dialog.dart';
import 'image_screen.dart';
import 'kormi_screen.dart';

class DesktopHome extends StatefulWidget {
  const DesktopHome({super.key});

  @override
  State<DesktopHome> createState() => _DesktopHomeState();
}

class _DesktopHomeState extends State<DesktopHome> with WindowListener {
  @override
  void onWindowClose() async {
    bool isPreventClose = await windowManager.isPreventClose();
    if (!mounted) return;
    if (isPreventClose) {
      showContentDialog('Do yo really want to exit this app', context, () {
        Navigator.of(context).pop();
        windowManager.destroy();
      });
      // showDialog(
      //   context: context,
      //   builder: (context) => showContentDialog(
      //     "Are you sure you want to exit Brisk?",
      //     context,
      //     () {
      //       Navigator.of(context).pop();
      //       windowManager.destroy();
      //     },
      //   ),
      // );
    }
  }

  @override
  void initState() {
    // windowManager.addListener(this);
    // windowManager.setPreventClose(true);
    super.initState();
  }

  // @override
  // void dispose() {
  //   windowManager.removeListener(this);
  //   super.dispose();
  // }

  int topIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.red,
      child: NavigationView(
        appBar: const NavigationAppBar(
          title: Text('NavigationView'),
        ),
        pane: NavigationPane(
          selected: topIndex,
          onChanged: (index) => setState(() => topIndex = index),
          displayMode: PaneDisplayMode.top,
          size: NavigationPaneSize(
            openWidth: 200,
          ),
          indicator: StickyNavigationIndicator(
            color: Colors.white,
          ),
          items: [
            PaneItem(
              icon: const Icon(FluentIcons.home),
              title: const Text('Dashboard'),
              body: NavigationBodyItem(
                header: 'd',
                content: Text('d'),
              ),
              //body: ImgScreen(),
            ),

            PaneItemExpander(
              selectedTileColor: ButtonState.all<Color>(Color.fromARGB(255, 219, 223, 231)),
              // trailing: Icon(
              //   mt.Icons.arrow_back_ios,
              //   color: Colors.white,
              // ),
              icon: Icon(
                FluentIcons.account_activity,
                color: Colors.black,
              ),
              title: Text('General Information'),
              items: [
                PaneItem(
                  icon: const Icon(FluentIcons.issue_tracking),
                  title: const Text('ADC Information'),
                  // infoBadge: const InfoBadge(source: Text('8')),
                  body: NavigationBodyItem(
                    header: 'd',
                    content: Text('d'),
                  ),
                ),
                PaneItem(
                  icon: const Icon(FluentIcons.area_chart),
                  title: const Text('Thana Information'),
                  //infoBadge: const InfoBadge(source: Text('8')),
                  body: ThanaViewScreen(),
                ),
                PaneItem(
                  icon: Icon(FluentIcons.people_repeat),
                  title: const Text('Kormi Information'),

                  // infoBadge: const InfoBadge(source: Text('8')),
                  body: KormiInfoScreen(),
                ),
              ],
              body: NavigationBodyItem(
                header: 'Home',
                content: Text('home'),
              ),
            ),

            PaneItemExpander(
              selectedTileColor: ButtonState.all<Color>(Color.fromARGB(255, 107, 145, 215)),
              // trailing: Icon(
              //   mt.Icons.arrow_back_ios,
              //   color: Colors.white,
              // ),
              icon: Icon(FluentIcons.report_document),
              title: Text('Reports'),
              items: [
                PaneItem(
                  icon: const Icon(FluentIcons.issue_tracking),
                  title: const Text('Loan Reports'),
                  body: Text('Thana Information'),
                  // infoBadge: const InfoBadge(source: Text('8')),
                  // body: CalendarsDemo(),
                ),
                PaneItem(
                  icon: const Icon(FluentIcons.area_chart),
                  title: const Text('Savings Report'),

                  //infoBadge: const InfoBadge(source: Text('8')),
                  body: PssReporScreen(),
                ),
                PaneItem(
                  icon: Icon(FluentIcons.people_repeat),
                  title: const Text('Accounting Reports'),
                  // infoBadge: const InfoBadge(source: Text('8')),
                  body: Text('Thana Information'),
                  // body: KormiInfoScreen(),
                ),
              ],
              body: Text('custom'),
            ),

            // PaneItem(
            //   icon: const Icon(FluentIcons.issue_tracking),
            //   title: const Text('Track an order'),
            //   // infoBadge: const InfoBadge(source: Text('8')),
            //   body: Text('track'),
            // ),

            // PaneItem(
            //   icon: const Icon(FluentIcons.issue_tracking),
            //   title: const Text('Track an order'),
            //   //infoBadge: const InfoBadge(source: Text('8')),
            //   body: Text('track'),
            // ),
            // PaneItem(
            //   icon: const Icon(FluentIcons.issue_tracking),
            //   title: const Text('Track an order'),
            //   // infoBadge: const InfoBadge(source: Text('8')),
            //   body: Text('track'),
            // ),
            // PaneItemExpander(
            //   icon: const Icon(FluentIcons.account_management),
            //   title: const Text('Account'),
            //   body: Text('Account'),
            //   items: [
            //     PaneItem(
            //       icon: const Icon(FluentIcons.mail),
            //       title: const Text('Mail'),
            //       body: Text('Mail'),
            //     ),
            //     PaneItem(
            //       icon: const Icon(FluentIcons.calendar),
            //       title: const Text('Calendar'),
            //       body: Text('Calender'),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

class NavigationBodyItem extends StatelessWidget {
  const NavigationBodyItem({
    Key? key,
    this.header,
    this.content,
  }) : super(key: key);

  final String? header;
  final Widget? content;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
      header: PageHeader(title: Text(header ?? 'This is a header text')),
      content: content ?? const SizedBox.shrink(),
    );
  }
}
