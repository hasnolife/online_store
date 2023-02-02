import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:online_store/domain/entity/product_details.dart';
import 'package:online_store/theme/app_colors.dart';
import 'package:online_store/theme/text-styles.dart';
import 'package:online_store/ui/widgets/details_screen/details_screen_model.dart';
import 'package:online_store/ui/widgets/elements/ecommerce_logo_widget.dart';
import 'package:online_store/ui/widgets/elements/small_widgets.dart';
import 'package:online_store/ui/widgets/splash_widget.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreenWidget extends StatelessWidget {
  const ProductDetailsScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<ProductDetailsScreenModel>();
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: model.futureDetails,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const ProductDetailsWidget();
              } else if (snapshot.hasError) {
                return const Text("Error");
              } else {
                return const LoadWidget();
              }
            }),
      ),
    );
  }
}

class LoadWidget extends StatelessWidget {
  const LoadWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            color: AppColors.dark,
          ),
          width: 70,
          height: 70,
          child: const EcommerceLogoWidget(logoSize: 60),
        ),
        const CircularProgressIndicator(
          color: AppColors.orange,
          // backgroundColor: AppColors.dark,
          strokeWidth: 6,
        ),
      ],
    ));
  }
}

class ProductDetailsWidget extends StatelessWidget {
  const ProductDetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<ProductDetailsScreenModel>();
    final product = model.productDetails;
    return Column(
      children: [
        _ProductsDetailsRowHeaderWidget(),
        _ProductDetailsCarouselImageWidget(),
        Expanded(
          child: Container(

            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(product!.title, style: AppTextStyles.DetailsProductNameTextStyle,),
                      IconWidget(backgroundColor: AppColors.dark, icon: Icons.favorite_border, size: 37)
                    ],

                  ),
                ),
                RatingStarsBuilderWidget(rating: product.rating),
              ],
            ),
          ),
        ),
      ],
    );
  }
}



class _ProductDetailsCarouselImageWidget extends StatelessWidget {
  const _ProductDetailsCarouselImageWidget({
    Key? key

  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final model = context.read<ProductDetailsScreenModel>();
    final product = model.productDetails;
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: CarouselSlider.builder(
        itemCount: product?.images.length,
        itemBuilder:
            (BuildContext context, int itemIndex, int pageViewIndex) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.network(
                product!.images[itemIndex]
              ),
            ),
          );
        },
        options: CarouselOptions(
          // autoPlay: true,
          height: 266,
          viewportFraction: 0.65,
          enlargeCenterPage: true,
        ),
      ),
    );
  }
}

class _ProductsDetailsRowHeaderWidget extends StatelessWidget {
  const _ProductsDetailsRowHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 42),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconWidget(
            backgroundColor: AppColors.dark,
            icon: Icons.arrow_back_ios_new,
            size: 37,
            onPressed: () => Navigator.of(context).pop(),
          ),
          const Text('Product Details',
              style: AppTextStyles.DetailsHeaderTextStyle),
          const IconWidget(
            backgroundColor: AppColors.orange,
            icon: Icons.shopping_bag_outlined,
            size: 37,
          ),
        ],
      ),
    );
  }
}
