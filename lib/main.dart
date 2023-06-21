import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocar/bindings/app_bindings.dart';
import 'package:gocar/controllers/auth/auth_controller.dart';
import 'package:gocar/utils/themes/app_color.dart';
import 'package:gocar/views/admin/admin_home_screen.dart';
import 'package:gocar/views/auth/login_screen.dart';
import 'package:gocar/views/auth/register_screen.dart';
import 'package:gocar/views/auth/select_type_screen.dart';
import 'package:gocar/views/client/client_home_screen.dart';
import 'package:gocar/views/rental/rental_create_record.dart';
import 'package:gocar/views/rental/rental_dashboard.dart';
import 'package:gocar/views/rental/rental_home_screen.dart';
import 'package:gocar/views/rental/rental_update_record.dart';
import 'package:gocar/views/rental/rental_vehicle_details.dart';
import 'package:gocar/views/rental/rental_vehicle_list.dart';
import 'package:gocar/widgets/loader_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AppBindings().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final authcontroller = Get.find<AuthController>();
  Widget authLogic() {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Return a loading indicator if the stream is still waiting for data
            return Center(child: LoaderWidget());
          } else {
            if (snapshot.hasData) {
              // User is signed in
              final user = snapshot.data!;
              final uid = user.uid;
              if (uid == null) {
                return LoginScreen();
              } else {
                final userRef =
                    FirebaseFirestore.instance.collection('users').doc(uid);
                return FutureBuilder<DocumentSnapshot>(
                    future: userRef.get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Return a loading indicator if the future is still waiting for data
                        return Center(child: LoaderWidget());
                      } else {
                        if (snapshot.hasData) {
                          final userData =
                              snapshot.data!.data() as Map<String, dynamic>?;
                          authcontroller.getUserDetails(uid);
                          final role = userData?['role'] as String?;
                          if (role == 'Admin') {
                            return AdminHomeScreen();
                          } else if (role == 'Car Owner') {
                            return RentalHomeScreen();
                          } else {
                            return ClientHomeScreen();
                          }
                        } else {
                          // Handle case when snapshot does not have data
                          return LoginScreen();
                        }
                      }
                    });
              }
            } else {
              // User is signed out
              return LoginScreen();
            }
          }
        },
      ),
    );

    // return LoginScreen();
    // return SelectTypeScreen();
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
          GetPage(name: '/admin', page: () => AdminHomeScreen()),
          GetPage(name: '/admin', page: () => AdminHomeScreen()),
          
          GetPage(name: '/rental', page: () => RentalHomeScreen()),
          GetPage(name: '/rental-dashboard', page: () => RentalDashboard()),
          GetPage(name: '/rental-vehicle-list', page: () => RentalVehicleList()),
          GetPage(name: '/rental-vehicle-create', page: () => RentalCreateRecord()),
          GetPage(name: '/rental-vehicle-update', page: () => RentalUpdateRecord()),
          GetPage(name: '/rental-vehicle-view', page: () => RentalVehicleDetails()),
          GetPage(name: '/client', page: () => ClientHomeScreen()),
        ]);
  }
}
