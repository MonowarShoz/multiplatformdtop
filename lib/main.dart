import 'package:fluent_ui/fluent_ui.dart' as ft;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:multiplatformdtop/util/custom_themes.dart';
import 'package:multiplatformdtop/view/desktop_view/auth.dart';
import 'package:multiplatformdtop/view/desktop_view/dt_home_page.dart';
import 'package:multiplatformdtop/view/mobile_view/mb_home_page.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:system_theme/system_theme.dart';
import 'Data/Provider/pss_report_provider.dart';
import 'di_container.dart' as di;
import 'Data/Provider/kormi_information_provider.dart';
import 'Data/Provider/user_config_provider.dart';

bool get isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  if (!kIsWeb &&
      [
        TargetPlatform.windows,
        TargetPlatform.android,
      ].contains(defaultTargetPlatform)) {
    SystemTheme.accentColor.load();
  }
  if (isDesktop) {
    await flutter_acrylic.Window.initialize();

    // windowManager.waitUntilReadyToShow().then((_) async {
    //   await windowManager.setTitle('Sample APP');
    //   await windowManager.setTitleBarStyle(TitleBarStyle.normal);
    //   await windowManager.setBackgroundColor(Colors.black);
    //   await windowManager.setSize(const Size(755, 545));
    //   await windowManager.setMinimumSize(const Size(755, 545));
    //   await windowManager.center();
    //   await windowManager.show();
    //   await windowManager.setSkipTaskbar(false);
    // });

    // WindowOptions windowOptions = const WindowOptions(
    //   size: Size(800, 600),
    //   center: true,
    //   backgroundColor: Colors.white,
    //   skipTaskbar: false,
    //   titleBarStyle: TitleBarStyle.hidden,
    // );
    // // await flutter_acrylic.Window.h();
    // await WindowManager.instance.ensureInitialized();
    // windowManager.waitUntilReadyToShow().then((_) async {
    //   await windowManager.setTitleBarStyle(
    //     TitleBarStyle.hidden,
    //     windowButtonVisibility: false,
    //   );
    //   await windowManager.setSize(const Size(800, 400));
    //   await windowManager.setMinimumSize(const Size(350, 600));
    //   await windowManager.center();
    //   await windowManager.show();
    //   await windowManager.isFullScreen();
    //   await windowManager.setPreventClose(true);
    //   await windowManager.setSkipTaskbar(false);
    // });
  }

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => di.sl<UserConfigProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<KormiInformationProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<PssReportProvider>()),
    // ChangeNotifierProvider(create: (context) => di.sl<AdcInformationProvider>()),
    // ChangeNotifierProvider(create: (context) => di.sl<AreaInformationProvider>()),
    // ChangeNotifierProvider(
    //   create: (context) => di.sl<ChBankAccountProvider>(),

    // ChangeNotifierProvider(create: (context) => di.sl<PssReportProvider>()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (isDesktop || kIsWeb) {
      return ChangeNotifierProvider(
          create: (_) => AppTheme(),
          builder: (context, _) {
            final appTheme = context.watch<AppTheme>();
            return ft.FluentApp(
              debugShowCheckedModeBanner: false,
              themeMode: appTheme.mode,
              color: appTheme.color,
              darkTheme: ft.FluentThemeData(
                brightness: Brightness.dark,
                accentColor: appTheme.color,
                visualDensity: VisualDensity.standard,
                focusTheme: ft.FocusThemeData(
                  glowFactor: ft.is10footScreen() ? 2.0 : 0.0,
                ),
              ),
              theme: ft.FluentThemeData(
                  accentColor: appTheme.color,
                  cardColor: Colors.black,
                  navigationPaneTheme: ft.NavigationPaneThemeData(
                      backgroundColor: ft.Color.fromARGB(255, 44, 66, 113),
                      unselectedTextStyle: ft.ButtonState.all<TextStyle>(TextStyle(color: Colors.white)),
                      selectedTextStyle: ft.ButtonState.all<TextStyle>(TextStyle(color: ft.Color.fromARGB(255, 231, 229, 229))),
                      highlightColor: Colors.white

                      //  tileColor: ft.ButtonState.all<Color>(Colors.blue),
                      ),
                  visualDensity: VisualDensity.standard,
                  focusTheme: ft.FocusThemeData(glowFactor: ft.is10footScreen() ? 2.0 : 0.0)),
              home: AuthPage(),
            );
          });
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MobileHomeSCreen(),
      );
    }
  }
}
