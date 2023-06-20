import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gocar/utils/helpers/asset.dart';
import 'package:gocar/utils/themes/app_color.dart';
import 'package:gocar/widgets/v.dart';

class RentalDashboard extends StatefulWidget {
  const RentalDashboard({Key? key}) : super(key: key);

  @override
  _RentalDashboardState createState() => _RentalDashboardState();
}

class _RentalDashboardState extends State<RentalDashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.bgSecondary,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const V(10),
          const Text(
            'Dashboard',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          )
              .animate()
              .moveY(
                  begin: 10,
                  end: 0,
                  curve: Curves.easeInOut,
                  duration: const Duration(
                    milliseconds: 700,
                  ))
              .fadeIn(
                duration: const Duration(
                  milliseconds: 700,
                ),
                curve: Curves.easeInOut,
              ),
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
        ],
      ),
    );
  }
}
