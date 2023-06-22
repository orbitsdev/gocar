import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gocar/constants/firbase_constant.dart';
import 'package:gocar/controllers/auth/auth_controller.dart';
import 'package:gocar/models/overview.dart';
import 'package:gocar/utils/helpers/asset.dart';
import 'package:gocar/utils/themes/app_color.dart';
import 'package:gocar/views/admin/admin_for_rent_vehicle_list.dart';
import 'package:gocar/views/admin/admin_for_review_vehicle_list.dart';
import 'package:gocar/views/admin/admin_rented_vehicle_list.dart';
import 'package:gocar/widgets/admin_dashboard_card.dart';
import 'package:gocar/widgets/rental_dashboard_card.dart';
import 'package:gocar/widgets/h.dart';
import 'package:gocar/widgets/profile_widget.dart';
import 'package:gocar/widgets/v.dart';

class AdminDashBoard extends StatefulWidget {
  const AdminDashBoard({Key? key}) : super(key: key);

  @override
  _AdminDashBoardState createState() => _AdminDashBoardState();
}

class _AdminDashBoardState extends State<AdminDashBoard> {
  void openEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

 @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Builder(builder: (context) {
            return IconButton(
                onPressed: () => openEndDrawer(context), icon: ProfileWidget());
          }),
          H(
            20,
          ),
        ],
      ),
      endDrawer: Drawer(
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
      body: SafeArea(
        child: Container(
          color: AppColor.bgSecondary,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const V(10),
              // const Text(
              //   'Dashboard',
              //   style: TextStyle(
              //     fontSize: 28,
              //     fontWeight: FontWeight.bold,
              //   ),
              // )
              //     .animate()
              //     .moveY(
              //         begin: 10,
              //         end: 0,
              //         curve: Curves.easeInOut,
              //         duration: const Duration(
              //           milliseconds: 700,
              //         ))
              //     .fadeIn(
              //       duration: const Duration(
              //         milliseconds: 700,
              //       ),
              //       curve: Curves.easeInOut,
              //     ),
              const V(8),
              Container(
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColor.primary,
                          AppColor.primary2,
                        ]),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(children: [
                    Container(
                            height: MediaQuery.of(context).size.height * 0.40,
                            width: 140,
                            child: Center(
                              child: SvgPicture.asset(
                                height: 80,
                                width: 80,
                                Asset.image('computer.svg'),
                              ),
                            ))
                        .animate()
                        .moveX(
                            begin: -10,
                            end: 0,
                            curve: Curves.easeInOut,
                            duration: const Duration(
                              milliseconds: 700,
                            ))
                        .fadeIn(),
                    Flexible(
                      child: Container(
                          child: const Center(
                        child: Text('Overview Highlights',
                            style: TextStyle(
                                height: 1.2, fontSize: 28, color: Colors.white),
                            textAlign: TextAlign.center),
                      )
                              .animate()
                              .moveX(
                                  begin: 10,
                                  end: 0,
                                  curve: Curves.easeInOut,
                                  duration: const Duration(
                                    milliseconds: 700,
                                  ))
                              .fadeIn()),
                    ),
                  ])),
              const V(24),
              Expanded(
                child: MasonryGridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: admin_dashboard_oveview.length,
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  itemBuilder: (context, index) {
                    final Overview overview =
                        rental_user_dashboard_overview[index];
                    return GestureDetector(
                      onTap: () {
                        if (overview.type == 'for-review') {
                          Get.to(() => AdminForReviewVehicleList(),
                              transition: Transition.cupertino);
                        }
                        if (overview.type == 'for-rent') {
                          Get.to(() => AdminForRentVehicleList(),
                              transition: Transition.cupertino);
                        }
                        if (overview.type == 'rented-car') {
                          Get.to(() => AdminRentedVehicleList(), transition: Transition.cupertino);
                        }
                      },
                      child: AdminDashBoardCard(
                        overview: overview,
                      ),
                    );

                    // return GestureDetector(
                    //   onTap: () {

                    //   },
                    //   child: DashBoardCard(
                    //     overview: overview[index],
                    //   )
                    //       .animate()
                    //       .scale(
                    //         duration: const Duration(
                    //           milliseconds: 700,
                    //         ),
                    //         curve: Curves.easeInOut,
                    //       )
                    //       .fadeIn(
                    //         duration: const Duration(milliseconds: 700),
                    //         curve: Curves.easeInOut,
                    //       ),
                    // );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
