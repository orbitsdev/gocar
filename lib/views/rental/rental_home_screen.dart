import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocar/constants/firbase_constant.dart';
import 'package:gocar/controllers/auth/auth_controller.dart';
import 'package:gocar/utils/helpers/asset.dart';
import 'package:gocar/utils/themes/app_color.dart';
import 'package:gocar/views/rental/rental_dashboard.dart';
import 'package:gocar/views/rental/rental_vehicle_list.dart';
import 'package:gocar/widgets/h.dart';
import 'package:gocar/widgets/profile_widget.dart';
import 'package:heroicons/heroicons.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class RentalHomeScreen extends StatefulWidget {
  const RentalHomeScreen({Key? key}) : super(key: key);

  @override
  _RentalHomeScreenState createState() => _RentalHomeScreenState();
}

class _RentalHomeScreenState extends State<RentalHomeScreen>
    with SingleTickerProviderStateMixin {
  int currentIndex = 1;
  late TabController tabController;
  late String token;

  List<Widget> pages = [
    RentalDashboard(),
    RentalVehicleList(),
  ];
  @override
  void initState() {
    tabController = TabController(length: pages.length, vsync: this);
    super.initState();
  }

  void changeTab(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void openDrawer(context) {
    Scaffold.of(context).openDrawer();
  }

  void openEndDrawer(context) {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // leading: Builder(
      //   //   builder: (context) {
      //   //     return IconButton(onPressed: ()=>openDrawer(context), icon: Icon(Icons.menu , color: AppTheme.ORANGE,));
      //   //   }
      //   // ),
      //   actions: [
      //     //   if (auth.currentUser != null)
      //     //   Builder(
      //     //       builder: (context) => IconButton(
      //     //             onPressed: () => openEndDrawer(context),
      //     //             icon: ProfileWidget(),
      //     //           )),
      //     // const H(20),
      //   ],
      // ),
      drawer: Drawer(
        child: GetBuilder<AuthController>(builder: (controller) {
          return ListView(
            children: [
              Container(
                height: 100,
                color: AppColor.primary,
                padding: EdgeInsets.all(10),
                child: Image.asset(Asset.image('logo.png')),
              ),
              H(40),
              if (auth.currentUser != null)
                ListTile(
                  onTap: () => controller.logout(context),
                  title: Text('Logout'),
                  leading: Icon(Icons.logout),
                )
            ],
          );
        }),
      ),
      body: pages[currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        selectedItemColor: AppColor.primary,
        unselectedItemColor: Colors.black.withOpacity(0.3),
        currentIndex: currentIndex,
        onTap: changeTab,
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: const HeroIcon(
              HeroIcons.squares2x2,
              style: HeroIconStyle.solid,
            ),
            title: Text(
              "Dashboard",
              style: TextStyle(fontSize: 16),
            ),
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: const HeroIcon(
              HeroIcons.truck,
              style: HeroIconStyle.solid,
            ),
            title: Text(
              "Cars",
              style: TextStyle(fontSize: 16),
            ),
          ),

          /// Search

          /// Profile
        ],
      ),
    );
  }
}
