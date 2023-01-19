import 'package:flutter/material.dart';
import 'package:online_store/theme/app_colors.dart';
import 'package:online_store/ui/widgets/elements/ecommerce_logo_widget.dart';

class SplashScreenWidget extends StatelessWidget {
  const SplashScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        decoration: const BoxDecoration(
          color: AppColors.dark,
        ),
        child:  Center(
          child: EcommerceLogoWidget(logoSize: MediaQuery.of(context).size.width / 1.5),
        ),
      ),
    );
  }
}

