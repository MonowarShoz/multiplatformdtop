import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mt;
//import 'package:multiplatformdtop/Data/Provider/user_config_provider.dart';
import 'package:multiplatformdtop/view/desktop_view/dt_home_page.dart';
import 'package:first_package/first_package.dart';
import 'package:pfmscodepack/pfmscodepack.dart';
import 'package:provider/provider.dart';
import 'package:first_package/first_package.dart';
import '../../util/dimensions.dart';
import '../../util/show_custom_snakbar.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  login(UserConfigProvider up) async {
    if (userNameController.text.isEmpty || passwordController.text.isEmpty) {
      showInfoBar(context, 'Error', 'UserName or password mustnot be empty');
    } else {
      await up
          .loginAccess(
        context,
        loginName: userNameController.text,
        password: passwordController.text,
      )
          .then((value) {
        if (value.isSuccess) {
          if (!mounted) return;
          Navigator.of(context).push(mt.MaterialPageRoute(
            builder: (context) => DesktopHome(),
          ));
        } else {
          showInfoBar(context, 'Error', 'Login Failed');
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Provider.of<UserConfigProvider>(context, listen: false).login(context);
  }

  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.height;
    debugPrint('height $size');

    return SafeArea(
      child: ScaffoldPage(
        content: LayoutBuilder(builder: (context, constraints) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    height: constraints.maxHeight < 400 ? Dimensions.fullHeight(context) : Dimensions.fullHeight(context) / 2,
                    width: constraints.maxWidth > 600 ? Dimensions.fullWidth(context) / 3 : Dimensions.fullWidth(context),
                    decoration: BoxDecoration(
                      color: mt.Colors.grey[300]!.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: mt.Colors.white,

                          blurRadius: 2,
                          offset: Offset(5, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sign In ',
                          style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
                        ),
                        Divider(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
                              child: Text(
                                'User Name',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: TextBox(
                                controller: userNameController,
                                keyboardType: TextInputType.text,
                                textCapitalization: mt.TextCapitalization.characters,
                                textInputAction: TextInputAction.next,
                                // decoration: InputDecoration(
                                //   isDense: true,
                                //   contentPadding: EdgeInsets.all(12),
                                //   border: mt.OutlineInputBorder(
                                //       // borderRadius: BorderRadius.circular(20),
                                //       ),
                                //   filled: true,
                                //   fillColor: Colors.white,
                                //   focusColor: Colors.red,
                                //   focusedBorder: mt.OutlineInputBorder(),
                                // ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
                              child: Text(
                                'Password',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: TextBox(
                                controller: passwordController,
                                obscureText: true,
                              ),
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  // fillColor: mt.MaterialStateProperty.resolveWith<Color>((Set<mt.MaterialState> states) {
                                  //   if (states.contains(mt.MaterialState.disabled)) {
                                  //     return Colors.black.withOpacity(.32);
                                  //   }
                                  //   return Colors.black;
                                  // }),
                                  checked: isCheck,
                                  onChanged: (v) {
                                    setState(() {
                                      isCheck = v!;
                                    });
                                  },
                                ),
                                Text(
                                  'Remember Me ',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Consumer<UserConfigProvider>(builder: (context, up, child) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            child: SizedBox(
                              width: 250,
                              //height: 40,
                              child: Button(
                                onPressed: () async {
                                  await login(up);
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(color: Colors.black),
                                ),
                                style: ButtonStyle(),
                              ),
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
