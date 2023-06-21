import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gocar/constants/firbase_constant.dart';
import 'package:gocar/widgets/loader_widget.dart';
import 'package:heroicons/heroicons.dart';

import 'package:gocar/models/overview.dart';
import 'package:gocar/utils/themes/app_color.dart';
import 'package:gocar/widgets/h.dart';
import 'package:gocar/widgets/v.dart';

class RentalDashBoardCard extends StatefulWidget {
  final Overview overview;
  const RentalDashBoardCard({
    Key? key,
    required this.overview,
  }) : super(key: key);
  @override
  State<RentalDashBoardCard> createState() => _RentalDashBoardCardState();
}

class _RentalDashBoardCardState extends State<RentalDashBoardCard> {

  
  bool isLoading = false;
  int total = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() {
    if (widget.overview.type == 'rented-car') {
      totalRentedCar();
    }
    if (widget.overview.type == 'for-review') {
      totalForReviewCar();
    }
    if (widget.overview.type == 'for-rent') {
      totalForRentCar();
    }
  }

  Future<void> totalRentedCar() async {
    setState(() => isLoading = true);


    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('vehicles')
        .where('uid', isEqualTo: auth.currentUser!.uid)
        .where('status', isEqualTo: 'Approved')
        .where('isSold', isEqualTo: true)
        .get();
    setState(() {
      total = snapshot.size;
    });
    setState(() => isLoading = false);
  }

  Future<void> totalForReviewCar() async {
    setState(() => isLoading = true);
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('vehicles')
        .where('uid', isEqualTo: auth.currentUser!.uid)
        .where('status', isEqualTo: 'For Review')
        .get();
    setState(() {
      total = snapshot.size;
    });
    setState(() => isLoading = false);
  }

  Future<void> totalForRentCar() async {
    setState(() => isLoading = true);
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('vehicles')
        .where('uid', isEqualTo: auth.currentUser!.uid)
        .where('isSold', isEqualTo: false)
         .where('status', isEqualTo: 'Approved')
        .get();
    setState(() {
      total = snapshot.size;
    });
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 140,
      ),
      decoration: BoxDecoration(
        // border: Border.all(
        //   color: AppColor.greyBackground,
        //   width: 0.5,
        // ),
        boxShadow: [
          // BoxShadow(
          //   offset: Offset(0,1),
          //   blurRadius: 12,
          //   spreadRadius: 1,
          //   color: Colors.black.withOpacity(0.03)
          // )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.only(top: 14, right: 16, left: 16, bottom: 14),
      child: isLoading
          ? Center(
              child: LoaderWidget(
              width: 20,
              height: 20,
            ))
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.overview.header}',
                  style: const TextStyle(
                    fontSize: 14,
                    height: 0,
                  ),
                  textAlign: TextAlign.center,
                ),
                const V(10),
                Text(
                  '${total}',
                  style: const TextStyle(
                      fontSize: 26,
                      height: 1,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const V(14),
                Row(
                  children: [
                    ClipOval(
                      child: Container(
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                          color: AppColor.purple1.withOpacity(0.2),
                        ),
                        child: HeroIcon(
                          widget.overview.icon,
                          size: 18,
                          color: AppColor.primary,
                          style: HeroIconStyle.solid,
                        ),
                      ),
                    ),
                    Container(
                      width: 10,
                    ),
                    Text(
                      '${widget.overview.subheader}',
                      style: TextStyle(
                        color: AppColor.purple1,
                      ),
                    ),
                  ],
                ),
                Container(),

//  const V(8),
//                 Text('1 months', style: AppTheme.bodytext.copyWith(
//                   fontSize: 12,
//                   color: Colors.black.withOpacity(0.40),
//                 ),),

                // SizedBox(height: 10),
                //   Text(
                //     'Small Text lorem ' * 20,
                //     style: TextStyle(
                //       fontSize: 12,
                //     ),
                //   ),
                // const V(10),
                // Text(
                //   'Total Shares',
                //   style: TextStyle(
                //     fontSize: 14,
                //   ),
                // ),
                // Text(
                //   'Php 100,000.00',
                //   style: TextStyle(
                //       fontSize: 18,
                //       color: AppColor.purple,
                //       fontWeight: FontWeight.bold),
                // ),
                // const V(4),
                // Center(
                //   child: HeroIcon(
                //     style: HeroIconStyle.solid,
                //     HeroIcons.globeEuropeAfrica,
                //     color: AppColor.greyBackground,
                //     size: 60,
                //   ),
                // ),
                // Text(
                //   'Small Text lorem ' * 4,
                //   style: TextStyle(
                //     fontSize: 12,
                //   ),
                // ),
              ],
            ),
    );
  }
}
