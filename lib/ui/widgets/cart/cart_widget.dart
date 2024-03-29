import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_store/domain/blocs/cart_bloc/cart_bloc.dart';
import 'package:online_store/domain/entity/cart.dart';
import 'package:online_store/domain/resources/images.dart';
import 'package:online_store/theme/app_colors.dart';
import 'package:online_store/theme/text_consts.dart';
import 'package:online_store/theme/text_styles.dart';
import 'package:online_store/ui/widgets/elements/methods.dart';
import 'package:online_store/ui/widgets/elements/small_widgets.dart';


class CartWidget extends StatelessWidget {
  const CartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CartBloc, CartState>(
        builder: (BuildContext context, CartState state) {
          if (state is CartLoadedState) {
            return const CartScaffoldWidget();
          } else if (state is CartLoadingErrorState) {
            return MyErrorWidget(error: state.error);
          }
          return const LoadWidget();
        },
      ),
    );
  }
}

class CartScaffoldWidget extends StatelessWidget {
  const CartScaffoldWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
          Text(kAddAddress,
              style:
                  AppTextStyles.headerCategoryTextStyle.copyWith(fontSize: 15)),
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
    return Padding(
      padding: const EdgeInsets.only(left: 42),
      child: Text(kMyCart,
          style: AppTextStyles.headerTextStyle.copyWith(fontSize: 35)),
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
    final bloc = context.read<CartBloc>();
    final state = bloc.state as CartLoadedState;
    final basket = state.cart.basket;

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
          buildCount(context),
          buildTrashIcon(context),
        ],
      ),
    );
  }

  Widget buildTrashIcon(BuildContext context) {
    final bloc = context.read<CartBloc>();
    return Container(
      margin: const EdgeInsets.only(left: 5),
      width: 30,
      child: IconButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
        ),
        onPressed: () => bloc.add(CartDeleteCountEvent()),
        icon: Image.asset(AppImages.trash),
        color: AppColors.deleteCartIcon,
      ),
    );
  }

  Container buildCount(BuildContext context) {
    final bloc = context.read<CartBloc>();
    return Container(
      width: 26,
      height: 68,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: AppColors.cartCount,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            child: Text(
              '1',
              style: AppTextStyles.headerCategoryTextStyle
                  .copyWith(fontSize: 20, color: AppColors.white),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildCountButton('-', () => bloc.add(CartDecrementCountEvent())),
              buildCountButton('+', () => bloc.add(CartIncrementCountEvent())),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCountButton(String title, Function()? onTap) {
    return InkWell(
      borderRadius: BorderRadius.circular(26),
      onTap: onTap,
      child: Container(
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
        ),
        height: 28,
        width: 26,
        child: Text(
          title,
          style: AppTextStyles.headerCategoryTextStyle
              .copyWith(fontSize: 20, color: AppColors.white),
        ),
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
              style: AppTextStyles.headerCategoryTextStyle
                  .copyWith(fontSize: 20, color: AppColors.white),
            ),
            Text(
              '\$${cartProduct.price}.00',
              style: AppTextStyles.headerCategoryTextStyle
                  .copyWith(fontSize: 20, color: AppColors.red),
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
    final bloc = context.read<CartBloc>();
    final state = bloc.state as CartLoadedState;

    final cartData = state.cart;
    final myMethods = MyMethods();
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
          buildCartSummaryRow(
              kTotal, myMethods.intToPrice(cartData.total, false)),
          buildCartSummaryRow(kDelivery, cartData.delivery),
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
          child: Text(title, style: AppTextStyles.cartSummaryTitleTextStyle),
        ),
        SizedBox(
          width: 80,
          child: Text(value,
              style: AppTextStyles.headerTextStyle
                  .copyWith(fontSize: 15, color: AppColors.white)),
        ),
      ],
    );
  }
}

class _CartInfoButtonWidget extends StatelessWidget {
  const _CartInfoButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125,
      child: Center(
        child: AppElevatedButtonWidget(
          backgroundColor: AppColors.orange,
          title: Center(
              child: Text(kCheckout,
                  style: AppTextStyles.headerTextStyle
                      .copyWith(fontSize: 20, color: AppColors.white))),
          radius: 10,
          height: 54,
          width: MediaQuery.of(context).size.width * 0.75,
          onPressed: () {},
        ),
      ),
    );
  }
}
