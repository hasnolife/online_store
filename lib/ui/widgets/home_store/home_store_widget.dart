import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:online_store/domain/entity/hot_sales_entity.dart';
import 'package:online_store/domain/local_entity/category.dart';
import 'package:online_store/domain/resources/images.dart';
import 'package:online_store/theme/app_colors.dart';
import 'package:online_store/theme/text-styles.dart';
import 'package:online_store/ui/widgets/elements/methods.dart';
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
    return FutureBuilder(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const _HomeStoreColumnWidget();
          } else if (snapshot.hasError) {
            return const MyErrorWidget();
          } else {
            return const SplashScreenWidget();
          }
        });
  }
}



class _HomeStoreColumnWidget extends StatelessWidget {
  const _HomeStoreColumnWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ListView(
            shrinkWrap: true,
            children: const [
              _HomeStoreLocationWidget(),
              _HomeStoreCategoryWidget(),
              _HomeStoreSearchWidget(),
              _HomeStoreBannerWidget(),
              _HomeStoreBestSellerWidget(),
              SizedBox(height: 52)
            ],
          ),
          const _HomeStoreBottomNavigationBarWidget(),
        ],
      ),
      // bottomNavigationBar: _HomeStoreBottomNavigationBarWidget(),
    );
  }
}

class _HomeStoreBottomNavigationBarWidget extends StatelessWidget {
  const _HomeStoreBottomNavigationBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myMethods = MyMethods();
    final model = context.read<HomeStoreModel>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 72,
      decoration: const BoxDecoration(
        color: AppColors.dark,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildFirstChild(),
          buildBottomBarItem(Icons.shopping_bag_outlined, model.productCount,
              () => myMethods.showCart(context)),
          buildBottomBarItem(Icons.favorite_border, 0, null),
          buildBottomBarItem(Icons.person_outline_rounded, 0, null),
        ],
      ),
    );
  }

  Widget buildFirstChild() {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: AppColors.white,
          ),
        ),
        const SizedBox(width: 7),
        const Text(
          'Explorer',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }

  Widget buildBottomBarItem(
      IconData icon, int count, void Function()? onPressed) {
    return IconButton(
      icon: Stack(
        // alignment: Alignment.topRight,
        children: [
          Icon(
            icon,
            color: AppColors.white,
          ),
          count > 0
              ? Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(),
                        color: AppColors.orange,
                      ),
                      child: FittedBox(
                        child: Text(
                          '$count',
                          style: const TextStyle(color: AppColors.white),
                        ),
                      )),
                )
              : const SizedBox(),
        ],
      ),
      onPressed: onPressed,
    );
  }
}

class _HomeStoreLocationWidget extends StatelessWidget {
  const _HomeStoreLocationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<HomeStoreModel>();
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
              onPressed: () {
                if (model.isFilterOpen == false) {
                  model.openFilterDialog(buildShowBottomSheet(context));
                }
              },
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
          _DropDownWidget(
            title: 'Brand',
            initial: 'Samsung',
            menuItems: generateMenuItem(
              [
                'Samsung',
                'Xiaomi',
                'Apple',
              ],
            ),
          ),
          _DropDownWidget(
            title: 'Prise',
            initial: '\$300 - \$500',
            menuItems: generateMenuItem(
              [
                '\$100 - \$300',
                '\$300 - \$500',
                '\$500 - \$700',
                '\$700 - \$1000',
              ],
            ),
          ),
          _DropDownWidget(
            title: 'Size',
            initial: '4.5 to 5.5 inches',
            menuItems: generateMenuItem(
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
      (index) => DropdownMenuItem<String>(
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

  Row buildHeader(BuildContext context) {
    final model = context.read<HomeStoreModel>();
    return Row(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.topLeft,
            child: IconWidget(
              backgroundColor: AppColors.dark,
              icon: Icons.close,
              size: 37,
              radius: 10,
              onPressed: () => model.closeFilterDialog(context),
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: const Text('Filter options',
              style: AppTextStyles.detailsHeaderTextStyle),
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
              width: 50,
              // width: MediaQuery.of(context).size.width / 6,
              height: 37,
              radius: 10,
              onPressed: () => model.closeFilterDialog(context),
            ),
          ),
        ),
      ],
    );
  }
}

class _DropDownWidget extends StatefulWidget {
  final String title;
  String initial;
  final List<DropdownMenuItem<String>> menuItems;

  _DropDownWidget(
      {Key? key,
      required this.title,
      required this.initial,
      required this.menuItems})
      : super(key: key);

  @override
  State<_DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<_DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
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
            items: widget.menuItems,
            onChanged: (String? value) {
              widget.initial = value!;

              setState(() {});
            },
            value: widget.initial,
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
            style: AppTextStyles.headerTextStyle,
          ),
          Text(
            leadingText,
            style: AppTextStyles.linkedHeaderTextStyle,
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
    final model = context.watch<HomeStoreModel>();
    int selectedCategory = model.selectedCategory;

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
                        model.selectedCategory = category.id;
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
              ? AppTextStyles.selectedHeaderCategoryTextStyle
              : AppTextStyles.headerCategoryTextStyle,
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
        Container(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: CarouselSlider.builder(
            itemCount: products?.length,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) =>
                    _HomeStoreBannerImageWidget(
              productIndex: itemIndex,
            ),
            options: CarouselOptions(
              autoPlay: false,
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
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              image: NetworkImage(
                product!.picture.toString(),
              ),
              fit: BoxFit.cover),
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
    final model = context.read<HomeStoreModel>();
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
              onPressed: () => model.showDetails(context),
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

class _ProductCardWidget extends StatelessWidget {
  final int index;

  const _ProductCardWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<HomeStoreModel>();
    final product =
        context.select((HomeStoreModel model) => model.data?.bestSeller[index]);

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(5),
          height: 227,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Container(
                height: 168,
                decoration: BoxDecoration(
                    image: buildDecorationImage(product!.picture),
                    borderRadius: BorderRadius.circular(10)),
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
            splashRadius: 1.0,
            alignment: Alignment.topRight,
            onPressed: () {
              model.toggleFavorite(product);
              // buildShowSnackBar(context, 'Favorite icon');
            },
            icon: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(13),
              ),
              child: buildFavoriteIcon(product.isFavorites),
            ),
          ),
        ),
      ],
    );
  }

  buildFavoriteIcon(bool isFavorite) {
    return Icon(
      isFavorite ? Icons.favorite : Icons.favorite_border_rounded,
      color: AppColors.orange,
      size: 15,
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
