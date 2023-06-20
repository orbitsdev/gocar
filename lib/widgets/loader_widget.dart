

import 'package:flutter/material.dart';
import 'package:gocar/utils/themes/app_color.dart';


class LoaderWidget extends StatelessWidget {

double? width; 
double? height; 
double? stroke; 
Color? color;
 LoaderWidget({
    Key? key,
    this.width,
    this.height,
    this.stroke,
    this.color,
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context){
    return SizedBox(
      width: width  = 20,
      height: width =20,
      child: CircularProgressIndicator(
                  strokeWidth: stroke ?? 2.5 ,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    color??AppColor.primary,
                  ),
                ),
    );
  }
}