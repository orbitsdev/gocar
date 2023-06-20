import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocar/controllers/auth/auth_controller.dart';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:gocar/utils/helpers/asset.dart';
import 'package:gocar/utils/themes/app_color.dart';

class ProfileWidget extends StatelessWidget {

  double? width;
  double? height;
  String? url;
  bool? showImage;
  ProfileWidget({
    Key? key,
    this.width = 30,
    this.height =30 ,
    this.url ,
    this.showImage = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context){


   return GetBuilder<AuthController>(
     builder: (controller) {
       return CachedNetworkImage(
       width: height,
       height: width,
       imageUrl: controller.user.value.profile_image != null ? controller.user.value.profile_image as String : url ?? Asset.avatarDefault ,
       imageBuilder: (context, imageProvider) => ClipOval(
         child: Container(
           decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
           ),
         ),
       ),
       placeholder: (context, url) => SizedBox(
         width: 40,
         height: 40,
         child: CircularProgressIndicator(
           strokeWidth: 1.5,
           color: AppColor.primary,
         ),
       ),
       errorWidget: (context, url, error) => Icon(Icons.error),
       );

     }
   ); 
  }
}