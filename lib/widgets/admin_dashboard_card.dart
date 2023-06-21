import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gocar/constants/firbase_constant.dart';
import 'package:gocar/widgets/loader_widget.dart';
import 'package:heroicons/heroicons.dart';

import 'package:gocar/models/overview.dart';
import 'package:gocar/utils/themes/app_color.dart';
import 'package:gocar/widgets/h.dart';
import 'package:gocar/widgets/v.dart';

class AdminDashBoardCard extends StatefulWidget {
  final Overview overview;
  const AdminDashBoardCard({
    Key? key,
    required this.overview,
  }) : super(key: key);
  @override
  State<AdminDashBoardCard> createState() => _AdminDashBoardCardState();
}

class _AdminDashBoardCardState extends State<AdminDashBoardCard> {

  
  bool isLoading = false;
  int total = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetchData();
  }

  // void fetchData() {
  //   if (widget.overview.type == 'rented-car') {
  //     totalRentedCar();
  //   }
  //   if (widget.overview.type == 'for-review') {
  //     totalForReviewCar();
  //   }
  //   if (widget.overview.type == 'for-rent') {
  //     totalForRentCar();
  //   }
  // }

  

  // Future<void> totalRentedCar() async {
  //   setState(() => isLoading = true);


  //   QuerySnapshot snapshot = await FirebaseFirestore.instance
  //       .collection('vehicles')
  //       .where('status', isEqualTo: 'Approved')
  //       .where('isSold', isEqualTo: true)
  //       .get();
  //   setState(() {
  //     total = snapshot.size;
  //   });
  //   setState(() => isLoading = false);
  // }

  // Future<void> totalForReviewCar() async {
  //   setState(() => isLoading = true);
  //   QuerySnapshot snapshot = await FirebaseFirestore.instance
  //       .collection('vehicles')
  //       .where('status', isEqualTo: 'For Review')
  //       .get();
  //   setState(() {
  //     total = snapshot.size;
  //   });
  //   setState(() => isLoading = false);
  // }

  // Future<void> totalForRentCar() async {
  //   setState(() => isLoading = true);
  //   QuerySnapshot snapshot = await FirebaseFirestore.instance
  //       .collection('vehicles')
  //       .where('isSold', isEqualTo: false)
  //        .where('status', isEqualTo: 'Approved')
  //       .get();
  //   setState(() {
  //     total = snapshot.size;
  //   });
  //   setState(() => isLoading = false);
  // }


Stream<QuerySnapshot> geTotalRentedStream() {
  return FirebaseFirestore.instance
      .collection('vehicles')
        .where('status', isEqualTo: 'Approved')
        .where('isSold', isEqualTo: true)
      .snapshots();
}

Stream<QuerySnapshot> getTotalForReviewStream() {
  return FirebaseFirestore.instance
       .collection('vehicles')
        .where('status', isEqualTo: 'For Review')
      .snapshots();
}

Stream<QuerySnapshot> getForRentStream() {
  return FirebaseFirestore.instance
      .collection('vehicles')
      .where('isSold', isEqualTo: false)
         .where('status', isEqualTo: 'Approved')
      .snapshots();
}
Stream<QuerySnapshot> getAllStream() {
  return FirebaseFirestore.instance
      .collection('vehicles')
      .snapshots();
}


Stream<QuerySnapshot> returnStream(){

     if (widget.overview.type == 'rented-car') {
        return geTotalRentedStream();
    }
    if (widget.overview.type == 'for-review') {
      return getTotalForReviewStream();
    }
    if (widget.overview.type == 'for-rent') {
        return getForRentStream();
    }
    return getAllStream();
}

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
  stream: returnStream(),
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      int total = snapshot.data!.size;

      return Container(
        constraints: const BoxConstraints(
          minHeight: 140,
        ),
        decoration: BoxDecoration(
          boxShadow: [],
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.only(top: 14, right: 16, left: 16, bottom: 14),
        child: Column(
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
            const SizedBox(height: 10),
            Text(
              '$total',
              style: const TextStyle(
                fontSize: 26,
                height: 1,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),
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
                const SizedBox(width: 10),
                Text(
                  '${widget.overview.subheader}',
                  style: TextStyle(
                    color: AppColor.purple1,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else if (snapshot.hasError) {
return      Container(
              constraints: const BoxConstraints(
                minHeight: 140,
              ),
              decoration: BoxDecoration(
                boxShadow: [],
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.only(
                  top: 14, right: 16, left: 16, bottom: 14),
              child: Center(
                child: Text('Error: ${snapshot.error}')
              ),
              );
    } else {
     return Container(
              constraints: const BoxConstraints(
                minHeight: 140,
              ),
              decoration: BoxDecoration(
                boxShadow: [],
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.only(
                  top: 14, right: 16, left: 16, bottom: 14),
              child: Center(
                child: LoaderWidget(
                  width: 20,
                  height: 20,
                ),
              ),
              );
    }
  },
);

  }
}
