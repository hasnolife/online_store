import 'package:flutter/material.dart';
import 'package:online_store/ui/widgets/details_screen/details_screen_model.dart';
import 'package:online_store/ui/widgets/splash_widget.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreenWidget extends StatelessWidget {
  const ProductDetailsScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<ProductDetailsScreenModel>();
    return Scaffold(
      body: FutureBuilder(
        future: model.futureDetails,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ProductDetailsWidget();
          } else if (snapshot.hasError) {
            return Text("Error");
          } else {
            return SplashScreenWidget();
          }
          }),
    );
  }
}

class ProductDetailsWidget extends StatelessWidget {
  const ProductDetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

