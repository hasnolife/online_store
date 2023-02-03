import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:online_store/domain/entity/product_details.dart';
import 'package:online_store/domain/resourses/images.dart';
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
        bottom: false,
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
    return Column(
      children: const [
        _ProductsDetailsRowHeaderWidget(),
        _ProductDetailsCarouselImageWidget(),
        _ProductDetailsInfoWidget(),
      ],
    );
  }
}

class _ProductDetailsInfoHardwareCategoryWidget extends StatelessWidget {
  const _ProductDetailsInfoHardwareCategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildCategoryHeaders('Shop', true),
        buildCategoryHeaders('Details', false),
        buildCategoryHeaders('Features', false),
      ],
    );
  }

  Container buildCategoryHeaders(String text, bool selected) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: selected
            ? const Border(
                bottom: BorderSide(
                  color: AppColors.orange,
                  width: 3,
                ),
              )
            : null,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          color: selected ? AppColors.dark : AppColors.grey,
        ),
      ),
    );
  }
}

class _ProductDetailsHardwareWidget extends StatelessWidget {
  const _ProductDetailsHardwareWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<ProductDetailsScreenModel>();
    final product = model.productDetails;
    return Padding(
      // padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30),
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 00),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildHardwareDetails(AppImages.processor, product!.cpu),
              buildHardwareDetails(AppImages.camera, product.camera),
              buildHardwareDetails(AppImages.ozu, product.ssd),
              buildHardwareDetails(AppImages.ssd, product.sd),
            ],
          ),
        ],
      ),
    );
  }

  Container buildHardwareDetails(imageName, description) {
    return Container(

      child: Column(
        children: [
          Container(
            height: 28,
            width: 28,
            child: Image.asset(imageName),
          ),
          const SizedBox(height: 7),
          Text(
            description,
            style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: AppColors.grey),
          ),
        ],
      ),
    );
  }
}

class _ProductDetailsInfoWidget extends StatelessWidget {
  const _ProductDetailsInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _ProductDetailsInfoHeaderWidget(),
              _ProductDetailsInfoHardwareCategoryWidget(),
              _ProductDetailsHardwareWidget(),
              _ProductDetailsColorCapacityWidget(),
              _ProductDetailsInfoCartWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductDetailsInfoHeaderWidget extends StatelessWidget {
  const _ProductDetailsInfoHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<ProductDetailsScreenModel>();
    final product = model.productDetails;
    return Column(
      children: [
        buildHeaderRow(product),
        RatingStarsBuilderWidget(
          rating: product!.rating,
          color: AppColors.yellow,
          size: 18,
        ),
      ],
    );
  }

  Row buildHeaderRow(ProductDetails? product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          product!.title,
          style: AppTextStyles.DetailsProductNameTextStyle,
        ),
        const IconWidget(
            backgroundColor: AppColors.dark,
            icon: Icons.favorite_border,
            size: 37)
      ],
    );
  }
}

class _ProductDetailsInfoCartWidget extends StatelessWidget {
  const _ProductDetailsInfoCartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<ProductDetailsScreenModel>();
    final product = model.productDetails;
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.orange,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Container(
        height: 54,
        width: double.infinity,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildCartText('Add to Cart'),
              buildCartText(model.intToPrice(product!.price)),
            ],
          ),
        ),
      ),
    );
  }

  Text buildCartText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    );
  }
}

class _ProductDetailsColorCapacityWidget extends StatelessWidget {
  const _ProductDetailsColorCapacityWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<ProductDetailsScreenModel>();
    final product = model.productDetails;
    final int selectedColor = 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select color and capacity',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.dark),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: product!.color.map((color) {
                final isSelected =
                    product.color.elementAt(selectedColor) == color;
                return buildColorChoose(model.convertColor(color), isSelected);
              }).toList(),
            ),
            Row(
              children: product.capacity.map((capacity) {
                final isSelected =
                    product.capacity.elementAt(selectedColor) == capacity;
                return buildCapacityChoose(capacity, isSelected);
              }).toList(),
            ),
          ],
        ),
      ],
    );
  }

  Padding buildCapacityChoose(String capacity, bool isSelect) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: isSelect ? AppColors.orange : Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
        onPressed: () {},
        child: Text(
          isSelect ? '$capacity gb'.toUpperCase() : '$capacity gb',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: isSelect ? Colors.white : AppColors.darkGrey,
          ),
        ),
      ),
    );
  }

  Padding buildColorChoose(int color, bool selected) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(color),
        ),
        child: IconButton(
          onPressed: () {},
          icon: selected
              ? const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}

class _ProductDetailsCarouselImageWidget extends StatelessWidget {
  const _ProductDetailsCarouselImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<ProductDetailsScreenModel>();
    final product = model.productDetails;
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: CarouselSlider.builder(
        itemCount: product?.images.length,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.network(product!.images[itemIndex]),
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
