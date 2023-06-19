import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocar/bindings/app_bindings.dart';
import 'package:gocar/utils/app_color.dart';
import 'package:gocar/views/auth/login_screen.dart';
import 'package:gocar/views/auth/register_screen.dart';
import 'package:gocar/views/auth/select_type_screen.dart';

Future<void> main() async {
  runApp(const MyApp());
    WidgetsFlutterBinding.ensureInitialized();
    AppBindings().dependencies();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget authLogic() {
    return SelectTypeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: authLogic(),
          theme: ThemeData(
            useMaterial3: true,
       colorSchemeSeed: AppColor.primary,
          ),
        getPages: [
          GetPage(name: '/login', page: () => LoginScreen()),
          GetPage(name: '/select-type', page: () => SelectTypeScreen()),
          GetPage(name: '/register', page: () => RegisterScreen()),
          ]);
  }
}
