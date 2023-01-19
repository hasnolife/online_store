import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:online_store/domain/api_client/home_store_api_client.dart';
import 'package:online_store/domain/entity/best_seller_entity.dart';
import 'package:online_store/domain/entity/home_store_data.dart';
import 'package:online_store/domain/entity/hot_sales_entity.dart';
import 'package:online_store/domain/local_entity/category.dart';
import 'package:online_store/theme/app_colors.dart';
import 'package:online_store/theme/text-styles.dart';
import 'package:online_store/ui/widgets/home_store/home_store_model.dart';
import 'package:online_store/ui/widgets/splash_widget.dart';
import 'package:provider/provider.dart';

class HomeStoreWidget extends StatefulWidget {
  const HomeStoreWidget({Key? key}) : super(key: key);

  @override
  State<HomeStoreWidget> createState() => _HomeStoreWidgetState();
}

class _HomeStoreWidgetState extends State<HomeStoreWidget> {
  @override
  void initState() {
    // HomeStoreApiClient().getHomeStoreData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.read<HomeStoreModel>();
    final data = model.futureData;
    return Scaffold(
      body: FutureBuilder(
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
        Text('Something is wrong'),
        Text('Please try again'),
        ElevatedButton(
          onPressed: () {},
          child: Text('Restart'),
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
        _HomeStoreTitleWidget(
          headerText: 'Select Category',
          leadingText: 'view all',
        ),
        _HomeStoreCategoryWidget(),
        _HomeStoreTitleWidget(
          headerText: 'Hot sales',
          leadingText: 'see more',
        ),
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: _HomeStoreBannerWidget(),
        ),
        _HomeStoreTitleWidget(
          headerText: 'Best Seller',
          leadingText: 'see more',
        ),
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: _HomeStoreBestSellerWidget(),
        ),
      ],
    );
  }
}

class _HomeStoreCategoryWidget extends StatelessWidget {
  const _HomeStoreCategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryList = [
      CategoryEntity(
          id: 0, title: 'Phones', icon: 'assets/images/Vector-0.png'),
      CategoryEntity(
          id: 1, title: 'Computers', icon: 'assets/images/Vector-1.png'),
      CategoryEntity(
          id: 2, title: 'Health', icon: 'assets/images/Vector-2.png'),
      CategoryEntity(id: 3, title: 'Books', icon: 'assets/images/Vector-3.png'),
      CategoryEntity(id: 4, title: 'Other', icon: 'assets/images/Vector-4.png'),
    ];
    return SizedBox(
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
    return CarouselSlider.builder(
      itemCount: products?.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
          _HomeStoreBannerImageWidget(
        productIndex: itemIndex,
      ),
      options: CarouselOptions(
        autoPlay: true,
        height: 175,
        viewportFraction: 1,
      ),
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
                primary: Colors.white,
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
    return GridView.builder(

      primary: false,
      shrinkWrap: true,
      itemCount: bestSellers?.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return _ProductCardWidget();
        return _HomeStoreBestSellerCardWidget(
          product: bestSellers![index],
        );
      },
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
      margin: EdgeInsets.all(0),
      elevation: 1,
      child: Container(
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
                  Text('\$1,047'),
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
  const _ProductCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      height: 227,
      child: Column(
        children: [
          Container(
            height: 168,
            width: double.infinity,
            color: Colors.green,
            child: IconButton(
              alignment: Alignment.topRight,
              onPressed: () {},
              icon: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(Icons.wb_sunny_sharp),
              ),
            ),
          ),
          Column(
            children: [
              Row(
            children: [
              Text('Text'),
              Text('Text'),
            ],
              ),
              Text('Text'),

            ],
          ),
        ],
      ),
    );
  }
}
