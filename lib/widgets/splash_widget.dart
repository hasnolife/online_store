import 'package:flutter/material.dart';
import 'package:online_store/theme/app_colors.dart';

class SplashScreenWidget extends StatelessWidget {
  const SplashScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        decoration: const BoxDecoration(
          color: AppColors.dark,
        ),
        child: const Center(
          child: SplashScreenLogoWidget(),
        ),
      ),
    );
  }
}

class SplashScreenLogoWidget extends StatelessWidget {
  const SplashScreenLogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final circleRadius = screenWidth / 3;
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
