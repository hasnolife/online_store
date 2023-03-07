import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:online_store/domain/entity/product_details.dart';
import 'package:online_store/domain/resources/images.dart';
import 'package:online_store/theme/app_colors.dart';
import 'package:online_store/theme/text_consts.dart';
import 'package:online_store/theme/text_styles.dart';
import 'package:online_store/ui/widgets/details_screen/details_screen_model.dart';
import 'package:online_store/ui/widgets/elements/methods.dart';
import 'package:online_store/ui/widgets/elements/small_widgets.dart';
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
                return const MyErrorWidget();
              } else {
                return const LoadWidget();
              }
            }),
      ),
    );
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
        buildCategoryHeaders(kShop, context),
        buildCategoryHeaders(kDetails, context),
        buildCategoryHeaders(kFeatures, context),
      ],
    );
  }

  Container buildCategoryHeaders(String text, BuildContext context) {
    final model = context.watch<ProductDetailsScreenModel>();
    final selected = model.selectedCategory == text;
    return Container(
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
      child: TextButton(
        onPressed: () => model.changeSelectedCategory(text),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            color: selected ? AppColors.dark : AppColors.grey,
          ),
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

  Widget buildHardwareDetails(imageName, description) {
    return Column(
      children: [
        SizedBox(
          height: 28,
          width: 28,
          child: Image.asset(imageName),
        ),
        const SizedBox(height: 7),
        Text(
          description,
          style: const TextStyle(
              fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.grey),
        ),
      ],
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
        buildHeaderRow(product, context),
        RatingStarsBuilderWidget(
          rating: product!.rating,
          color: AppColors.yellow,
          size: 18,
        ),
      ],
    );
  }

  Row buildHeaderRow(ProductDetails? product, BuildContext context) {
    final model = context.watch<ProductDetailsScreenModel>();
    const favoriteIcon = Icons.favorite_border;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          product!.title,
          style: AppTextStyles.headerCategoryTextStyle.copyWith(fontSize: 24),
        ),
        IconWidget(
          // backgroundColor: AppColors.dark,
          backgroundColor:
              product.isFavorites ? AppColors.orange : AppColors.dark,
          icon: favoriteIcon,
          size: 37,
          radius: 10,
          onPressed: () => model.favoriteToggle(),
          // iconColor: product.isFavorites ? AppColors.orange : null,
        ),
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
    final myMethods = MyMethods();
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.orange,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: SizedBox(
        height: 54,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildCartText(kAddToCart),
            buildCartText(myMethods.intToPrice(product!.price, true)),
          ],
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          kSelectColorAndCapacity,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.dark),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: product!.color.map((color) {
                return buildColorChoose(color, context);
              }).toList(),
            ),
            Row(
              children: product.capacity.map((capacity) {
                return buildCapacityChoose(capacity, context);
              }).toList(),
            ),
          ],
        ),
      ],
    );
  }

  Padding buildCapacityChoose(String capacity, BuildContext context) {
    final model = context.read<ProductDetailsScreenModel>();
    final isSelect =
        capacity == model.productDetails!.capacity[model.selectedCapacityIndex];
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: AppElevatedButtonWidget(
        backgroundColor: isSelect ? AppColors.orange : Colors.transparent,
        radius: 10,
        title: Text(
          isSelect ? '$capacity $kGb'.toUpperCase() : '$capacity $kGb',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: isSelect ? Colors.white : AppColors.darkGrey,
          ),
        ),
        onPressed: () => model.changeCapacity(capacity),
      ),
    );
  }

  Padding buildColorChoose(String color, BuildContext context) {
    final model = context.watch<ProductDetailsScreenModel>();
    final bool selected =
        model.productDetails?.color[model.selectedColorIndex] == color;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(model.convertColor(color)),
        ),
        child: IconButton(
          onPressed: () => model.changeColor(color),
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
    final myMethods = MyMethods();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconWidget(
          backgroundColor: AppColors.dark,
          icon: Icons.arrow_back_ios_new,
          size: 37,
          radius: 10,
          onPressed: () => myMethods.closeRoute(context),
        ),
        Text(kProductDetails,
            style: AppTextStyles.headerCategoryTextStyle.copyWith(fontSize: 18)),
        IconWidget(
          backgroundColor: AppColors.orange,
          icon: Icons.shopping_bag_outlined,
          size: 37,
          radius: 10,
          onPressed: () => myMethods.showCart(context),
        ),
      ],
    );
  }
}
