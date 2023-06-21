

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocar/utils/helpers/asset.dart';
import 'package:gocar/utils/themes/app_color.dart';
import 'package:gocar/views/global/full_screen_image_viewer.dart';

class RectangleImageWidget extends StatelessWidget {

  double? width;
  double? height;
  String? url;
  bool? viewable;
  RectangleImageWidget({
    Key? key,
    this.width = 50,
    this.height =50 ,
    this.url = Asset.bannerDefault,
    this.viewable = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context){


   return CachedNetworkImage(
              width: width,
              height: height,
  imageUrl:url!,
  imageBuilder: (context, imageProvider) => GestureDetector(

    onTap: ()=> viewable == false ? null : Get.to(()=> FullScreenImageViewer(imageUrl: url,)),
    child: Container(
      
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
            
            image: imageProvider,
            fit: BoxFit.cover,
            ),
      ),
    ),
  ),
  placeholder: (context, url) => const SizedBox(width: 40, height:40, child: CircularProgressIndicator(strokeWidth: 1.5, color: AppColor.primary,)),
  errorWidget: (context, url, error) => const Icon(Icons.error),
); 
  }
}