import 'package:flutter/material.dart';
import 'package:online_store/theme/app_colors.dart';
import 'package:online_store/theme/text_consts.dart';
import 'package:online_store/theme/text_styles.dart';
import 'package:online_store/ui/widgets/elements/ecommerce_logo_widget.dart';
import 'package:online_store/ui/widgets/elements/methods.dart';

class IconWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color? iconColor;
  final IconData icon;
  final double size;
  final double? radius;

  final void Function()? onPressed;

  const IconWidget({
    Key? key,
    required this.backgroundColor,
    required this.icon,
    required this.size,
    this.onPressed,
    this.radius,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 0),
        color: backgroundColor,
      ),
      width: size,
      height: size,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: size / 2,
          color: iconColor ?? Colors.white,
        ),
      ),
    );
  }
}

class RatingStarsBuilderWidget extends StatelessWidget {
  final double rating;
  final double size;
  final Color color;

  const RatingStarsBuilderWidget(
      {Key? key, required this.rating, required this.color, required this.size})
      : super(key: key);

  IconData _starIcon(int index) {
    if (rating > index) {
      return Icons.star;
    } else if (rating < index && rating > index - 1) {
      return Icons.star_half;
    } else {
      return Icons.star_border;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Padding> starList = List.generate(5, (index) {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Icon(
          _starIcon(index + 1),
          color: color,
          size: size,
        ),
      );
    });
    return Row(children: starList);
  }
}

class AppElevatedButtonWidget extends StatelessWidget {
  final Color backgroundColor;
  final Widget title;
  final double? width;
  final double? height;
  final double? radius;
  final void Function()? onPressed;

  const AppElevatedButtonWidget(
      {Key? key,
      required this.backgroundColor,
      required this.title,
      this.width,
      this.height,
      this.radius,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 0))),
      child: SizedBox(
        height: height,
        width: width,
        child: title,
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
      ),
    );
  }
}

class MyErrorWidget extends StatelessWidget {
  final Object? error;

  const MyErrorWidget({Key? key, this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myMethods = MyMethods();
    return Scaffold(
      backgroundColor: AppColors.dark,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Icon(
              kErrorWidgetIcon,
              size: 120,
              color: AppColors.orange,
            ),
            TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: AppColors.dark,
                        title: Text(
                          (error ?? kErrorWidgetNoDescription).toString(),
                          style: AppTextStyles.headerTextStyle
                              .copyWith(fontSize: 15, color: AppColors.white),
                        ),
                      );
                    });
              },
              child: Text(
                (kErrorWidgetHeader),
                style: AppTextStyles.headerCategoryTextStyle
                    .copyWith(fontSize: 20, color: AppColors.white)
                    .copyWith(color: AppColors.red),
              ),
            ),
            Text(
              kErrorWidgetDescription,
              style: AppTextStyles.headerTextStyle
                  .copyWith(fontSize: 15, color: AppColors.white),
            ),
            AppElevatedButtonWidget(
              onPressed: () => myMethods.restartRouteOnError(context),
              title: Center(
                  child: Text(kErrorWidgetButtonText,
                      style: AppTextStyles.headerTextStyle
                          .copyWith(fontSize: 20, color: AppColors.white))),
              backgroundColor: AppColors.orange,
              radius: 10,
              width: 130,
            )
          ],
        ),
      ),
    );
  }
}
