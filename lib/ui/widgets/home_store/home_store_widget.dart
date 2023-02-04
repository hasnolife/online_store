import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:online_store/domain/entity/best_seller_entity.dart';
import 'package:online_store/domain/entity/hot_sales_entity.dart';
import 'package:online_store/domain/local_entity/category.dart';
import 'package:online_store/domain/resourses/images.dart';
import 'package:online_store/theme/app_colors.dart';
import 'package:online_store/theme/text-styles.dart';
import 'package:online_store/ui/widgets/elements/small_widgets.dart';
import 'package:online_store/ui/widgets/home_store/home_store_model.dart';
import 'package:online_store/ui/widgets/splash_widget.dart';
import 'package:provider/provider.dart';

class HomeStoreWidget extends StatelessWidget {
  const HomeStoreWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<HomeStoreModel>();
    final data = model.futureData;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: FutureBuilder(
            future: data,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const _HomeStoreColumnWidget();
              } else if (snapshot.hasError) {
                return const _ErrorWidget();
              } else {
                return const SplashScreenWidget();
              }
              // } else return CircularProgressIndicator(

              // );
            }),
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Something is wrong'),
        const Text('Please try again'),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Restart'),
        )
      ],
    );
  }
}

class _HomeStoreColumnWidget extends StatelessWidget {
  const _HomeStoreColumnWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: const [
        _HomeStoreLocationWidget(),
        _HomeStoreCategoryWidget(),
        _HomeStoreSearchWidget(),
        _HomeStoreBannerWidget(),
        _HomeStoreBestSellerWidget(),
      ],
    );
  }
}

class _HomeStoreLocationWidget extends StatelessWidget {
  const _HomeStoreLocationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 50,
          ),
          Row(
            children: const [
              Icon(
                Icons.location_on_outlined,
                color: AppColors.orange,
                size: 17,
              ),
              Text(
                'Your location',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.dark,
                ),
              ),
              Icon(
                Icons.expand_more_rounded,
                color: AppColors.grey,
                size: 18,
              )
            ],
          ),
          SizedBox(
            width: 50,
            child: IconButton(
              icon: const Icon(Icons.filter_alt_outlined),
              onPressed: () => buildShowBottomSheet(context),
            ),
          ),
        ],
      ),
    );
  }

  PersistentBottomSheetController<dynamic> buildShowBottomSheet(
      BuildContext context) {
    return showBottomSheet(
        backgroundColor: AppColors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        enableDrag: false,
        context: context,
        builder: (BuildContext context) {
          return const _HomeStoreFilterContentWidget();
        });
  }
}

class _HomeStoreFilterContentWidget extends StatelessWidget {
  const _HomeStoreFilterContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      height: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildHeader(context),
          buildDropdownMenu(
            'Brand',
            'Samsung',
            generateMenuItem(
              [
                'Samsung',
                'Xiaomi',
                'Apple',
              ],
            ),
          ),
          buildDropdownMenu(
            'Prise',
            '\$300 - \$500',
            generateMenuItem(
              [
                '\$100 - \$300',
                '\$300 - \$500',
                '\$500 - \$700',
                '\$700 - \$1000',
              ],
            ),
          ),
          buildDropdownMenu(
            'Size',
            '4.5 to 5.5 inches',
            generateMenuItem(
              [
                '4.5 to 5.5 inches',
                '5.5 to 6.5 inches',
                '6.5+ inches',
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> generateMenuItem(List<String> menuNames) {
    return List.generate(
      menuNames.length,
      (index) => DropdownMenuItem(
          value: menuNames[index],
          child: Text(
            menuNames[index],
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColors.dark,
            ),
          )),
    );
  }

  Widget buildDropdownMenu(
      String title, String initial, List<DropdownMenuItem<String>> menuItems) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.dark,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: AppColors.grey),
          ),
          height: 37,
          width: double.infinity,
          child: DropdownButton(
            borderRadius: BorderRadius.circular(5),
            icon: const Icon(Icons.expand_more_rounded),
            underline: Container(color: Colors.transparent),
            isExpanded: true,
            items: menuItems,
            onChanged: (value) {},
            value: initial,
          ),
        ),
      ],
    );
  }

  Row buildHeader(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.topLeft,
            child: IconWidget(
              backgroundColor: AppColors.dark,
              icon: Icons.close,
              size: 37,
              radius: 10,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.center,
            child: const Text('Filter options',
                style: AppTextStyles.DetailsHeaderTextStyle),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.topRight,
            child: AppElevatedButtonWidget(
              backgroundColor: AppColors.orange,
              title: const Center(
                  child: Text(
                'Done',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              )),
              width: MediaQuery.of(context).size.width / 7,
              height: 37,
              radius: 10,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _HomeStoreSearchWidget extends StatelessWidget {
  const _HomeStoreSearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(17)),
            height: 34,
            width: MediaQuery.of(context).size.width * 0.75,
            child: TextFormField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
                hintStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.darkGrey,
                ),
                icon: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Icon(
                    Icons.search,
                    color: AppColors.orange,
                    size: 25,
                  ),
                ),
                iconColor: AppColors.orange,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 11),
            child: IconWidget(
              backgroundColor: AppColors.orange,
              icon: Icons.dashboard_customize_outlined,
              size: 34,
              radius: 17,
            ),
          )
        ],
      ),
    );
  }
}

class _HomeStoreCategoryWidget extends StatelessWidget {
  const _HomeStoreCategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryList = [
      CategoryEntity(id: 0, title: 'Phones', icon: AppImages.phonesCategory),
      CategoryEntity(
          id: 1, title: 'Computers', icon: AppImages.computersCategory),
      CategoryEntity(id: 2, title: 'Health', icon: AppImages.healthCategory),
      CategoryEntity(id: 3, title: 'Books', icon: AppImages.booksCategory),
      CategoryEntity(id: 4, title: 'Other', icon: AppImages.otherCategory),
    ];
    return Column(
      children: [
        const _HomeStoreTitleWidget(
          headerText: 'Select Category',
          leadingText: 'view all',
        ),
        SizedBox(
          height: 130,
          child: Padding(
            padding: const EdgeInsets.only(left: 8, top: 8, right: 8),
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                primary: true,
                itemCount: categoryList.length,
                itemBuilder: (context, index) {
                  return _HomeStoreCategoryIconWidget(
                      category: categoryList[index]);
                }),
          ),
        ),
      ],
    );
  }
}

class _HomeStoreTitleWidget extends StatelessWidget {
  final String headerText;
  final String leadingText;

  const _HomeStoreTitleWidget({
    Key? key,
    required this.headerText,
    required this.leadingText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 17, right: 33, top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            headerText,
            style: AppTextStyles.HeaderTextStyle,
          ),
          Text(
            leadingText,
            style: AppTextStyles.LinkedHeaderTextStyle,
          ),
        ],
      ),
    );
  }
}

class _HomeStoreCategoryIconWidget extends StatelessWidget {
  final CategoryEntity category;

  const _HomeStoreCategoryIconWidget({Key? key, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int selectedCategory = 0;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 11),
          child: Container(
            width: 71,
            height: 71,
            decoration: BoxDecoration(
              color: selectedCategory == category.id
                  ? AppColors.orange
                  : Colors.white,
              borderRadius: BorderRadius.circular(35),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(35),
                onTap: selectedCategory == category.id
                    ? null
                    : () {
                        selectedCategory = category.id;
                      },
                child: Image.asset(
                  category.icon,
                  color: selectedCategory == category.id
                      ? Colors.white
                      : const Color(0xffb3b3c3),
                ),
              ),
            ),
          ),
        ),
        Text(
          category.title,
          style: selectedCategory == category.id
              ? AppTextStyles.SelectedHeaderCategoryTextStyle
              : AppTextStyles.HeaderCategoryTextStyle,
        ),
      ],
    );
  }
}

class _HomeStoreBannerWidget extends StatelessWidget {
  const _HomeStoreBannerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<HomeStoreModel>();
    final products = model.data?.hotSales;
    return Column(
      children: [
        const _HomeStoreTitleWidget(
          headerText: 'Hot sales',
          leadingText: 'see more',
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: CarouselSlider.builder(
            itemCount: products?.length,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) =>
                    _HomeStoreBannerImageWidget(
              productIndex: itemIndex,
            ),
            options: CarouselOptions(
              autoPlay: true,
              height: 175,
              viewportFraction: 1,
            ),
          ),
        ),
      ],
    );
  }
}

class _HomeStoreBannerImageWidget extends StatelessWidget {
  final int productIndex;

  const _HomeStoreBannerImageWidget({Key? key, required this.productIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<HomeStoreModel>();
    final products = model.data?.hotSales;
    final product = products?[productIndex];

    return Container(
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              image: NetworkImage(
                product!.picture.toString(),
              ),
              fit: BoxFit.fitHeight),
          borderRadius: BorderRadius.circular(10),
        ),
        // margin: EdgeInsets.all(10),
        height: 175,
        width: double.infinity,
        child: _HomeStoreBannerInfoWidget(
          product: product,
        ));
  }
}

class _HomeStoreBannerInfoWidget extends StatelessWidget {
  final HotSalesEntity product;

  const _HomeStoreBannerInfoWidget({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          product.isNew == true
              ? Container(
                  width: 27,
                  height: 27,
                  decoration: BoxDecoration(
                    color: AppColors.orange,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Center(
                    child: Text(
                      'New',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.title,
                style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                    color: Colors.white),
              ),
              Text(
                product.subtitle,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11,
                    color: Colors.white),
              ),
            ],
          ),
          SizedBox(
            width: 98,
            height: 23,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () {},
              child: const Text(
                'Buy now!',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                    color: AppColors.dark),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeStoreBestSellerWidget extends StatelessWidget {
  const _HomeStoreBestSellerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<HomeStoreModel>();
    final bestSellers = model.data?.bestSeller;
    return Column(
      children: [
        const _HomeStoreTitleWidget(
          headerText: 'Best Seller',
          leadingText: 'see more',
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: bestSellers!.length ~/ 2,
            itemBuilder: (context, index) {
              //return _ProductCardWidget();
              return _HomeStoreBestSellerRowCardWidget(
                index: index * 2,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _HomeStoreBestSellerRowCardWidget extends StatelessWidget {
  final int index;

  const _HomeStoreBestSellerRowCardWidget({Key? key, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _ProductCardWidget(index: index)),
        Expanded(child: _ProductCardWidget(index: index + 1)),
      ],
    );
  }
}

class _HomeStoreBestSellerCardWidget extends StatelessWidget {
  final BestSellerEntity product;

  const _HomeStoreBestSellerCardWidget({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      elevation: 1,
      child: SizedBox(
        height: 227,
        child: ListTile(
          title: Container(
            // padding: EdgeInsets.all(0),
            color: Colors.grey,
            height: 168,
            child: Image.network(
              product.picture,
              fit: BoxFit.cover,
            ),
          ),
          subtitle: Column(
            children: [
              Row(
                children: [
                  Text('\$${product.discountPrice}'),
                  Text('\$${product.priceWithoutDiscount}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductCardWidget extends StatelessWidget {
  final int index;

  const _ProductCardWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<HomeStoreModel>();
    final product =
        context.select((HomeStoreModel model) => model.data?.bestSeller[index]);
    final isFavoriteIcon = product!.isFavorites
        ? Image.asset('assets/images/Favorite.png')
        : Image.asset('assets/images/notFavorite.png');
    // final productImage = model.imageLoader(product.picture);
    // final productImage = buildDecorationImage(product);
    return Stack(
      children: [
        Container(
          color: Colors.white,
          height: 227,
          child: Column(
            children: [
              Container(
                height: 168,
                decoration: BoxDecoration(
                  image: buildDecorationImage(product.picture),
                  // color: AppColors.dark,
                ),
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 21.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('\$${product.discountPrice}',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.dark)),
                        const SizedBox(width: 7),
                        Text('\$${product.priceWithoutDiscount}',
                            style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: AppColors.grey,
                                decoration: TextDecoration.lineThrough)),
                      ],
                    ),
                    Text(product.title,
                        style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: AppColors.dark)),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          // color: Colors.transparent,
          height: 227,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => model.showDetails(context),
              // buildShowSnackBar(context, 'All card'),
            ),
          ),
        ),
        Positioned(
          top: 5,
          right: 5,
          child: IconButton(
            alignment: Alignment.topRight,
            onPressed: () => buildShowSnackBar(context, 'Favorite icon'),
            icon: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(13),
              ),
              child: isFavoriteIcon,
            ),
          ),
        ),
      ],
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> buildShowSnackBar(
      BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  DecorationImage buildDecorationImage(String productImage) {
    return DecorationImage(
        image: NetworkImage(productImage), fit: BoxFit.fitHeight);
  }
}
