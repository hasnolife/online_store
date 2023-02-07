import 'package:flutter/material.dart';
import 'package:online_store/domain/entity/cart.dart';
import 'package:online_store/domain/resources/images.dart';
import 'package:online_store/theme/app_colors.dart';
import 'package:online_store/theme/text-styles.dart';
import 'package:online_store/ui/widgets/cart/cart_model.dart';
import 'package:online_store/ui/widgets/elements/methods.dart';
import 'package:online_store/ui/widgets/elements/small_widgets.dart';
import 'package:provider/provider.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<CartModel>();
    return FutureBuilder(
      future: model.futureCartData,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return const CartScaffoldWidget();
        } else if (snapshot.hasError) {
          return const Text('Error');
        }
        return const LoadWidget();
      },
    );
  }
}

class CartScaffoldWidget extends StatelessWidget {
  const CartScaffoldWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _CartHeaderWidget(),
            _CartTitleWidget(),
            _CartInfoWidget(),
          ],
        ),
      ),
    );
  }
}

class _CartHeaderWidget extends StatelessWidget {
  const _CartHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myMethods = MyMethods();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 42.0),
      child: Row(
        children: [
          IconWidget(
            backgroundColor: AppColors.dark,
            icon: Icons.arrow_back_ios_new,
            size: 37,
            radius: 10,
            onPressed: () => myMethods.closeRoute(context),
          ),
          Expanded(child: Container()),
          const Text('Add address', style: AppTextStyles.CartHeaderTextStyle),
          const SizedBox(width: 9),
          const IconWidget(
            backgroundColor: AppColors.orange,
            icon: Icons.location_on_outlined,
            size: 37,
            radius: 10,
            // onPressed: () => model.showCart(context),
          ),
        ],
      ),
    );
  }
}

class _CartTitleWidget extends StatelessWidget {
  const _CartTitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 42),
      child: Text('My Cart', style: AppTextStyles.CartTitleTextStyle),
    );
  }
}

class _CartInfoWidget extends StatelessWidget {
  const _CartInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: AppColors.dark,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      child: Column(
        children: const [
          _CartInfoProductListWidget(),
          _CartInfoSummaryWidget(),
          _CartInfoButtonWidget(),
        ],
      ),
    );
  }
}

class _CartInfoProductListWidget extends StatelessWidget {
  const _CartInfoProductListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<CartModel>();
    final basket = model.cartData.basket;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: ListView.builder(
          itemCount: basket.length,
          itemBuilder: (BuildContext context, int index) {
            return _CartInfoProductCardWidget(cartProduct: basket[index]);
          },
        ),
      ),
    );
  }
}

class _CartInfoProductCardWidget extends StatelessWidget {
  final CartProduct cartProduct;

  const _CartInfoProductCardWidget({Key? key, required this.cartProduct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          buildProductImage(),
          buildTitlePrice(),
          buildCount(),
          buildTrashIcon(),
        ],
      ),
    );
  }

  Widget buildTrashIcon() {
    return Container(
      margin: EdgeInsets.only(left: 5),
      width: 30,
      child: IconButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
        ),
        onPressed: () {},
        icon: Image.asset(AppImages.trash),
        color: AppColors.deleteCartIcon,
      ),
    );
  }

  Container buildCount() {
    return Container(
      width: 26,
      height: 68,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: AppColors.cartCount,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 20,
            child: Center(
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.add,
                  color: AppColors.white,
                  size: 12,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
            child: Text(
              '1',
              style: AppTextStyles.CartProductTitleTextStyle,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 3),
            height: 20,
            child: Center(
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.horizontal_rule_rounded,
                    color: AppColors.white,
                    size: 12,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTitlePrice() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cartProduct.title,
              style: AppTextStyles.CartProductTitleTextStyle,
            ),
            Text(
              '\$${cartProduct.price}.00',
              style: AppTextStyles.CartProductPriceTextStyle,
            ),
          ],
        ),
      ),
    );
  }

  Container buildProductImage() {
    return Container(
      height: 89,
      width: 89,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(cartProduct.images),
        ),
      ),
      // child: Image.network(cartProduct.images,),
    );
  }
}

class _CartInfoSummaryWidget extends StatelessWidget {
  const _CartInfoSummaryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<CartModel>();
    final cartData = model.cartData;
    return Container(
      height: 91,
      decoration: const BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(width: 2, color: AppColors.white25),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildCartSummaryRow('Total', model.intToPrice(cartData.total, false)),
          buildCartSummaryRow('Delivery', cartData.delivery),
        ],
      ),
    );
  }

  Widget buildCartSummaryRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: 60,
          child: Text(title, style: AppTextStyles.CartSummaryTitleTextStyle),
        ),
        SizedBox(
          width: 80,
          child: Text(value, style: AppTextStyles.CartSummaryValueTextStyle),
        ),
      ],
    );
  }
}

class _CartInfoButtonWidget extends StatelessWidget {
  const _CartInfoButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      child: Center(
        child: AppElevatedButtonWidget(
          backgroundColor: AppColors.orange,
          title: const Center(
              child:
                  Text('Checkout', style: AppTextStyles.CartButtonTextStyle)),
          radius: 10,
          height: 54,
          width: MediaQuery.of(context).size.width * 0.75,
          onPressed: () {},
        ),
      ),
    );
  }
}
