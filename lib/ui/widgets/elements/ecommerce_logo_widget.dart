
import 'package:flutter/material.dart';
import 'package:online_store/theme/app_colors.dart';

class EcommerceLogoWidget extends StatelessWidget {
  const EcommerceLogoWidget({Key? key, required this.logoSize}) : super(key: key);
  final logoSize;

  @override
  Widget build(BuildContext context) {
    final circleRadius = logoSize / 2;
    final fontStyle = TextStyle(fontSize: circleRadius/4, color: Colors.white, fontWeight: FontWeight.bold);
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: circleRadius,
          height: circleRadius,

          // color: AppColors.orange,
          decoration: BoxDecoration(
              color: AppColors.orange,
              borderRadius: BorderRadius.circular(circleRadius/2)
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: circleRadius * 0.80),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Ecommerce', style: fontStyle,),
              Text('Concept',style: fontStyle,),
            ],
          ),
        ),
      ],
    );
  }
}